using Microsoft.Identity.Client;
using Microsoft.PowerBI.Api;
using Microsoft.PowerBI.Api.Models;
using Microsoft.Rest;
using Newtonsoft.Json.Linq;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Xml.Linq;

PowerBIClient Client;

try
{
    const string testVariable = "e55532a9-0e22-45c1-b704-246c02daf3dd";

    #region Power BI Embedded Auth
    IConfidentialClientApplication daemonClient;

    daemonClient = ConfidentialClientApplicationBuilder.Create(testVariable)
                .WithAuthority(Path.Combine("https://login.microsoftonline.com/", testVariable, "/v2.0"))
                .WithClientSecret(testVariable)
                .Build();

    AuthenticationResult authResult =
                await daemonClient.AcquireTokenForClient(new[] { "https://analysis.windows.net/powerbi/api/.default" }).ExecuteAsync();

    var tokenCredentials = new TokenCredentials(authResult.AccessToken, "Bearer");
    Client = new PowerBIClient(new Uri("https://api.powerbi.com/"), tokenCredentials);
    #endregion

    Guid reportId = Guid.Parse(testVariable);
    Guid groupId = Guid.Parse(testVariable);
    FileFormat format = FileFormat.PDF;

    const int c_maxNumberOfRetries = 3; /* Can be set to any desired number */
    const int c_secToMillisec = 1000;
    const int pollingtimeOutInMinutes = 5;

    Export? export = null;
    int retryAttempt = 1;
    do
    {
        var exportId = await PostExportRequest(reportId, groupId, format);
        var httpMessage = await PollExportRequest(reportId, groupId, exportId, pollingtimeOutInMinutes);
        export = httpMessage.Body;
        if (export == null)
        {
            // Error, failure in exporting the report
            //return null;
        }
        if (export.Status == ExportState.Failed)
        {
            // Some failure cases indicate that the system is currently busy. The entire export operation can be retried after a certain delay
            // In such cases the recommended waiting time before retrying the entire export operation can be found in the RetryAfter header
            var retryAfter = httpMessage.Response.Headers.RetryAfter;
            if (retryAfter == null)
            {
                // Failed state with no RetryAfter header indicates that the export failed permanently
                //return null;
            }

            var retryAfterInSec = retryAfter.Delta.Value.Seconds;
            await Task.Delay(retryAfterInSec * c_secToMillisec);
        }
    }
    while (export.Status != ExportState.Succeeded && retryAttempt++ < c_maxNumberOfRetries);

    if (export.Status != ExportState.Succeeded)
    {
        // Error, failure in exporting the report
        //return null;
    }

    var exportedFile = await GetExportedFile(reportId, groupId, export);

    using (var fileStream = await Client.Reports.GetFileOfExportToFileAsync(groupId, reportId, export.Id))
    {
        // Save the file locally
        var outputPath = @"C:\Users\PC\Downloads\" + export.ReportName + exportedFile.FileSuffix; // Or the appropriate file extension for your export (e.g., .pptx)

        // Read the file stream and write it to a file
        using (var fileStreamOutput = new FileStream(outputPath, FileMode.Create, FileAccess.Write))
        {
            await fileStream.CopyToAsync(fileStreamOutput);
        }

        Console.WriteLine($"Exported file saved to {outputPath}");
    }
}
catch (Exception ex)
{
    Console.WriteLine(ex.Message);
}

async Task<string> PostExportRequest(
    Guid reportId,
    Guid groupId,
    FileFormat format,
    IList<string> pageNames = null, /* Get the page names from the GetPages REST API */
    string urlFilter = null)
{
    var powerBIReportExportConfiguration = new PowerBIReportExportConfiguration
    {
        Settings = new ExportReportSettings
        {
            Locale = "en-us"
        }
        //Identities = new List<EffectiveIdentity>()
        //{
        //     new EffectiveIdentity
        //     {
        //         Username = "e55532a9-0e22-45c1-b704-246c02daf3dd",
        //         Roles = new List<string> { "e55532a9-0e22-45c1-b704-246c02daf3dd" },
        //         Datasets = new List<string> { "e55532a9-0e22-45c1-b704-246c02daf3dd" }
        //     }
        //}
        // Note that page names differ from the page display names
        // To get the page names use the GetPages REST API
        // Pages = pageNames?.Select(pn => new ExportReportPage(Name = pn)).ToList(),
        // ReportLevelFilters collection needs to be instantiated explicitly
        // ReportLevelFilters = !string.IsNullOrEmpty(urlFilter) ? new List<ExportFilter>() { new ExportFilter(urlFilter) } : null,
    };

    var exportRequest = new ExportReportRequest
    {
        Format = format,
        PowerBIReportConfiguration = powerBIReportExportConfiguration,
    };

    // The 'Client' object is an instance of the Power BI .NET SDK
    var export = await Client.Reports.ExportToFileInGroupAsync(groupId, reportId, exportRequest);

    // Save the export ID, you'll need it for polling and getting the exported file
    return export.Id;
}

async Task<HttpOperationResponse<Export>?> PollExportRequest(
    Guid reportId,
    Guid groupId,
    string exportId /* Get from the PostExportRequest response */,
    int timeOutInMinutes)
{
    HttpOperationResponse<Export>? httpMessage = null;
    Export? exportStatus = null;
    DateTime startTime = DateTime.UtcNow;
    const int c_secToMillisec = 1000;
    do
    {
        if (DateTime.UtcNow.Subtract(startTime).TotalMinutes > timeOutInMinutes)
        {
            // Error handling for timeout and cancellations 
            return null;
        }

        // The 'Client' object is an instance of the Power BI .NET SDK
        httpMessage = await Client.Reports.GetExportToFileStatusInGroupWithHttpMessagesAsync(groupId, reportId, exportId);
        exportStatus = httpMessage.Body;

        // You can track the export progress using the PercentComplete that's part of the response
        Console.WriteLine(string.Format("{0} (Percent Complete : {1}%)", exportStatus.Status.ToString(), exportStatus.PercentComplete));
        if (exportStatus.Status == ExportState.Running || exportStatus.Status == ExportState.NotStarted)
        {
            // The recommended waiting time between polling requests can be found in the RetryAfter header
            // Note that this header is not always populated
            var retryAfter = httpMessage.Response.Headers.RetryAfter;
            var retryAfterInSec = retryAfter.Delta.Value.Seconds;
            await Task.Delay(retryAfterInSec * c_secToMillisec);
        }
    }
    // While not in a terminal state, keep polling
    while (exportStatus.Status != ExportState.Succeeded && exportStatus.Status != ExportState.Failed);

    return httpMessage;
}

async Task<ExportedFile> GetExportedFile(
    Guid reportId,
    Guid groupId,
    Export export /* Get from the PollExportRequest response */)
{
    if (export.Status == ExportState.Succeeded)
    {
        // The 'Client' object is an instance of the Power BI .NET SDK
        var fileStream = await Client.Reports.GetFileOfExportToFileAsync(groupId, reportId, export.Id);
        return new ExportedFile
        {
            FileStream = fileStream,
            FileSuffix = export.ResourceFileExtension,
        };
    }
    return null;
}

void Test()
{
    Console.WriteLine("Ingrese el nombre del archivo:");
    string fileName = Console.ReadLine();  // Entrada sin validación

    // Vulnerable a Path Traversal o Path Injection
    string filePath = $"C:\\Files\\{fileName}";

    if (File.Exists(filePath))
    {
        string fileContent = File.ReadAllText(filePath);
        Console.WriteLine($"Contenido del archivo:\n{fileContent}");
    }
    else
    {
        Console.WriteLine("El archivo no existe.");
    }
}

public class ExportedFile
{
    public Stream FileStream;
    public string FileSuffix;
}
