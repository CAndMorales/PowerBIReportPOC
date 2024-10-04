using Microsoft.PowerBI.Api;
using Microsoft.PowerBI.Api.Models;
using Microsoft.Rest;
using Moq;
using PowerBIEmbeddedReport.Main;
using static PowerBIEmbeddedReport.Main.PowerBIExportService;

namespace PowerBIEmbeddedReport.Tests;

public class FileReaderTests
{
    [Fact]
    public void Test_FileExists_DisplaysFileContent()
    {
        // Arrange
        var mockFileService = new Mock<FileService>();
        mockFileService.Setup(x => x.FileExists(It.IsAny<string>())).Returns(true);
        mockFileService.Setup(x => x.ReadAllText(It.IsAny<string>())).Returns("Mock file content");

        var fileReader = new FileReader(mockFileService.Object);

        // Simular la entrada y la salida
        var input = new StringReader("test.txt");
        var output = new StringWriter();

        // Act
        fileReader.Test(input, output);

        // Assert
        var result = output.ToString();
        Assert.Contains("Contenido del archivo:\nMock file content", result);
    }

    [Fact]
    public void Test_FileDoesNotExist_DisplaysErrorMessage()
    {
        // Arrange
        var mockFileService = new Mock<FileService>();
        mockFileService.Setup(x => x.FileExists(It.IsAny<string>())).Returns(false);

        var fileReader = new FileReader(mockFileService.Object);

        // Simular la entrada y la salida
        var input = new StringReader("test.txt");
        var output = new StringWriter();

        // Act
        fileReader.Test(input, output);

        // Assert
        var result = output.ToString();
        Assert.Contains("El archivo no existe.", result);
    }
}