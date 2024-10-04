·î
=C:\dev\PowerBIEmbeddedReport\PowerBIEmbeddedReport\Program.cs
	namespace 	!
PowerBIEmbeddedReport
 
.  
Main  $
;$ %
static 
class 
Program 
{ 
static 

async 
Task 
Main 
( 
string !
[! "
]" #
args$ (
)( )
{ 
PowerBIClient 
Client 
; 
try 
{ 	
const 
string 
testVariable %
=& '
$str( N
;N O
const 
string 
baseUrl  
=! "
$str# >
;> ?
const 
string 
powerBi  
=! "
$str# 4
;4 5*
IConfidentialClientApplication *
daemonClient+ 7
;7 8
daemonClient 
= 0
$ConfidentialClientApplicationBuilder ?
.? @
Create@ F
(F G
testVariableG S
)S T
. 
WithAuthority &
(& '
Path' +
.+ ,
Combine, 3
(3 4
$str4 >
,> ?
baseUrl@ G
,G H
$strI L
,L M
testVariableN Z
,Z [
$str\ c
)c d
)d e
. 
WithClientSecret )
() *
testVariable* 6
)6 7
.   
Build   
(   
)    
;    ! 
AuthenticationResult""  

authResult""! +
="", -
await## 
daemonClient## *
.##* +!
AcquireTokenForClient##+ @
(##@ A
new##A D
[##D E
]##E F
{##G H
$str##I |
}##} ~
)##~ 
.	## Ä
ExecuteAsync
##Ä å
(
##å ç
)
##ç é
;
##é è
var%% 
tokenCredentials%%  
=%%! "
new%%# &
TokenCredentials%%' 7
(%%7 8

authResult%%8 B
.%%B C
AccessToken%%C N
,%%N O
$str%%P X
)%%X Y
;%%Y Z
Client&& 
=&& 
new&& 
PowerBIClient&& &
(&&& '
new&&' *
Uri&&+ .
(&&. /
Path&&/ 3
.&&3 4
Combine&&4 ;
(&&; <
$str&&< F
,&&F G
powerBi&&H O
,&&O P
$str&&Q T
)&&T U
)&&U V
,&&V W
tokenCredentials&&X h
)&&h i
;&&i j
var)) 
exportService)) 
=)) 
new))  # 
PowerBIExportService))$ 8
())8 9
Client))9 ?
)))? @
;))@ A
Guid,, 
reportId,, 
=,, 
Guid,,  
.,,  !
Parse,,! &
(,,& '
testVariable,,' 3
),,3 4
;,,4 5
Guid-- 
groupId-- 
=-- 
Guid-- 
.--  
Parse--  %
(--% &
testVariable--& 2
)--2 3
;--3 4

FileFormat.. 
format.. 
=.. 

FileFormat..  *
...* +
PDF..+ .
;... /
const00 
int00  
c_maxNumberOfRetries00 *
=00+ ,
$num00- .
;00. /
const11 
int11 
c_secToMillisec11 %
=11& '
$num11( ,
;11, -
const22 
int22 #
pollingtimeOutInMinutes22 -
=22. /
$num220 1
;221 2
Export44 
?44 
export44 
=44 
null44 !
;44! "
int55 
retryAttempt55 
=55 
$num55  
;55  !
do66 
{77 
var88 
exportId88 
=88 
await88 $
exportService88% 2
.882 3
PostExportRequest883 D
(88D E
reportId88E M
,88M N
groupId88O V
,88V W
format88X ^
)88^ _
;88_ `
var99 
httpMessage99 
=99  !
await99" '
exportService99( 5
.995 6
PollExportRequest996 G
(99G H
reportId99H P
,99P Q
groupId99R Y
,99Y Z
exportId99[ c
,99c d#
pollingtimeOutInMinutes99e |
)99| }
;99} ~
export:: 
=:: 
httpMessage:: $
.::$ %
Body::% )
;::) *
if;; 
(;; 
export;; 
==;; 
null;; "
);;" #
{<< 
}>> 
if?? 
(?? 
export?? 
.?? 
Status?? !
==??" $
ExportState??% 0
.??0 1
Failed??1 7
)??7 8
{@@ 
varCC 

retryAfterCC "
=CC# $
httpMessageCC% 0
.CC0 1
ResponseCC1 9
.CC9 :
HeadersCC: A
.CCA B

RetryAfterCCB L
;CCL M
ifDD 
(DD 

retryAfterDD "
==DD# %
nullDD& *
)DD* +
{EE 
}GG 
varII 
retryAfterInSecII '
=II( )

retryAfterII* 4
.II4 5
DeltaII5 :
.II: ;
ValueII; @
.II@ A
SecondsIIA H
;IIH I
awaitJJ 
TaskJJ 
.JJ 
DelayJJ $
(JJ$ %
retryAfterInSecJJ% 4
*JJ5 6
c_secToMillisecJJ7 F
)JJF G
;JJG H
}KK 
}LL 
whileMM 
(MM 
exportMM 
.MM 
StatusMM  
!=MM! #
ExportStateMM$ /
.MM/ 0
	SucceededMM0 9
&&MM: <
retryAttemptMM= I
++MMI K
<MML M 
c_maxNumberOfRetriesMMN b
)MMb c
;MMc d
ifOO 
(OO 
exportOO 
.OO 
StatusOO 
!=OO  
ExportStateOO! ,
.OO, -
	SucceededOO- 6
)OO6 7
{PP 
}RR 
varTT 
exportedFileTT 
=TT 
awaitTT $
exportServiceTT% 2
.TT2 3
GetExportedFileTT3 B
(TTB C
reportIdTTC K
,TTK L
groupIdTTM T
,TTT U
exportTTV \
)TT\ ]
;TT] ^
usingVV 
(VV 
varVV 

fileStreamVV !
=VV" #
awaitVV$ )
ClientVV* 0
.VV0 1
ReportsVV1 8
.VV8 9&
GetFileOfExportToFileAsyncVV9 S
(VVS T
groupIdVVT [
,VV[ \
reportIdVV] e
,VVe f
exportVVg m
.VVm n
IdVVn p
)VVp q
)VVq r
{WW 
varYY 

outputPathYY 
=YY  
$strYY! :
+YY; <
exportYY= C
.YYC D

ReportNameYYD N
+YYO P
exportedFileYYQ ]
.YY] ^

FileSuffixYY^ h
;YYh i
using\\ 
(\\ 
var\\ 
fileStreamOutput\\ +
=\\, -
new\\. 1

FileStream\\2 <
(\\< =

outputPath\\= G
,\\G H
FileMode\\I Q
.\\Q R
Create\\R X
,\\X Y

FileAccess\\Z d
.\\d e
Write\\e j
)\\j k
)\\k l
{]] 
await^^ 

fileStream^^ $
.^^$ %
CopyToAsync^^% 0
(^^0 1
fileStreamOutput^^1 A
)^^A B
;^^B C
}__ 
Consoleaa 
.aa 
	WriteLineaa !
(aa! "
$"aa" $
$straa$ ;
{aa; <

outputPathaa< F
}aaF G
"aaG H
)aaH I
;aaI J
}bb 
}cc 	
catchdd 
(dd 
	Exceptiondd 
exdd 
)dd 
{ee 	
Consoleff 
.ff 
	WriteLineff 
(ff 
exff  
.ff  !
Messageff! (
)ff( )
;ff) *
}gg 	
}hh 
}ii 
publickk 
classkk  
PowerBIExportServicekk !
{ll 
privatemm 
PowerBIClientmm 
Clientmm  
;mm  !
publicoo 
 
PowerBIExportServiceoo 
(oo  
PowerBIClientoo  -
clientoo. 4
)oo4 5
{pp 
Clientqq 
=qq 
clientqq 
;qq 
}rr 
publictt 

asynctt 
Tasktt 
<tt 
stringtt 
>tt 
PostExportRequesttt /
(tt/ 0
Guiduu 
reportIduu	 
,uu 
Guidvv 
groupIdvv	 
,vv 

FileFormatww 
formatww 
,ww 
IListxx 	
<xx	 

stringxx
 
>xx 
	pageNamesxx 
=xx 
nullxx "
,xx" #
stringyy 

	urlFilteryy 
=yy 
nullyy 
)yy 
{zz 
var{{ ,
 powerBIReportExportConfiguration{{ ,
={{- .
new{{/ 2,
 PowerBIReportExportConfiguration{{3 S
{|| 	
Settings}} 
=}} 
new}}  
ExportReportSettings}} /
{~~ 
Locale 
= 
$str  
}
ÄÄ 
}
ÅÅ 	
;
ÅÅ	 

var
ÉÉ 
exportRequest
ÉÉ 
=
ÉÉ 
new
ÉÉ !
ExportReportRequest
ÉÉ  3
{
ÑÑ 	
Format
ÖÖ 
=
ÖÖ 
format
ÖÖ 
,
ÖÖ (
PowerBIReportConfiguration
ÜÜ &
=
ÜÜ' (.
 powerBIReportExportConfiguration
ÜÜ) I
,
ÜÜI J
}
áá 	
;
áá	 

var
ää 
export
ää 
=
ää 
await
ää 
Client
ää !
.
ää! "
Reports
ää" )
.
ää) *&
ExportToFileInGroupAsync
ää* B
(
ääB C
groupId
ääC J
,
ääJ K
reportId
ääL T
,
ääT U
exportRequest
ääV c
)
ääc d
;
ääd e
return
çç 
export
çç 
.
çç 
Id
çç 
;
çç 
}
éé 
public
êê 

async
êê 
Task
êê 
<
êê #
HttpOperationResponse
êê +
<
êê+ ,
Export
êê, 2
>
êê2 3
?
êê3 4
>
êê4 5
PollExportRequest
êê6 G
(
êêG H
Guid
ëë 
reportId
ëë 
,
ëë 
Guid
íí 
groupId
íí 
,
íí 
string
ìì 
exportId
ìì 
,
ììE F
int
îî 
timeOutInMinutes
îî 
)
îî 
{
ïï #
HttpOperationResponse
ññ 
<
ññ 
Export
ññ $
>
ññ$ %
?
ññ% &
httpMessage
ññ' 2
=
ññ3 4
null
ññ5 9
;
ññ9 :
Export
óó 
?
óó 
exportStatus
óó 
=
óó 
null
óó #
;
óó# $
DateTime
òò 
	startTime
òò 
=
òò 
DateTime
òò %
.
òò% &
UtcNow
òò& ,
;
òò, -
const
ôô 
int
ôô 
c_secToMillisec
ôô !
=
ôô" #
$num
ôô$ (
;
ôô( )
do
öö 

{
õõ 	
if
úú 
(
úú 
DateTime
úú 
.
úú 
UtcNow
úú 
.
úú  
Subtract
úú  (
(
úú( )
	startTime
úú) 2
)
úú2 3
.
úú3 4
TotalMinutes
úú4 @
>
úúA B
timeOutInMinutes
úúC S
)
úúS T
{
ùù 
return
üü 
null
üü 
;
üü 
}
†† 
httpMessage
££ 
=
££ 
await
££ 
Client
££  &
.
££& '
Reports
££' .
.
££. /?
1GetExportToFileStatusInGroupWithHttpMessagesAsync
££/ `
(
££` a
groupId
££a h
,
££h i
reportId
££j r
,
££r s
exportId
££t |
)
££| }
;
££} ~
exportStatus
§§ 
=
§§ 
httpMessage
§§ &
.
§§& '
Body
§§' +
;
§§+ ,
Console
ßß 
.
ßß 
	WriteLine
ßß 
(
ßß 
string
ßß $
.
ßß$ %
Format
ßß% +
(
ßß+ ,
$str
ßß, K
,
ßßK L
exportStatus
ßßM Y
.
ßßY Z
Status
ßßZ `
.
ßß` a
ToString
ßßa i
(
ßßi j
)
ßßj k
,
ßßk l
exportStatus
ßßm y
.
ßßy z
PercentCompleteßßz â
)ßßâ ä
)ßßä ã
;ßßã å
if
®® 
(
®® 
exportStatus
®® 
.
®® 
Status
®® #
==
®®$ &
ExportState
®®' 2
.
®®2 3
Running
®®3 :
||
®®; =
exportStatus
®®> J
.
®®J K
Status
®®K Q
==
®®R T
ExportState
®®U `
.
®®` a

NotStarted
®®a k
)
®®k l
{
©© 
var
¨¨ 

retryAfter
¨¨ 
=
¨¨  
httpMessage
¨¨! ,
.
¨¨, -
Response
¨¨- 5
.
¨¨5 6
Headers
¨¨6 =
.
¨¨= >

RetryAfter
¨¨> H
;
¨¨H I
var
≠≠ 
retryAfterInSec
≠≠ #
=
≠≠$ %

retryAfter
≠≠& 0
.
≠≠0 1
Delta
≠≠1 6
.
≠≠6 7
Value
≠≠7 <
.
≠≠< =
Seconds
≠≠= D
;
≠≠D E
await
ÆÆ 
Task
ÆÆ 
.
ÆÆ 
Delay
ÆÆ  
(
ÆÆ  !
retryAfterInSec
ÆÆ! 0
*
ÆÆ1 2
c_secToMillisec
ÆÆ3 B
)
ÆÆB C
;
ÆÆC D
}
ØØ 
}
∞∞ 	
while
≤≤ 
(
≤≤ 
exportStatus
≤≤ 
.
≤≤ 
Status
≤≤ "
!=
≤≤# %
ExportState
≤≤& 1
.
≤≤1 2
	Succeeded
≤≤2 ;
&&
≤≤< >
exportStatus
≤≤? K
.
≤≤K L
Status
≤≤L R
!=
≤≤S U
ExportState
≤≤V a
.
≤≤a b
Failed
≤≤b h
)
≤≤h i
;
≤≤i j
return
¥¥ 
httpMessage
¥¥ 
;
¥¥ 
}
µµ 
public
∑∑ 

async
∑∑ 
Task
∑∑ 
<
∑∑ 
ExportedFile
∑∑ "
>
∑∑" #
GetExportedFile
∑∑$ 3
(
∑∑3 4
Guid
∏∏ 
reportId
∏∏ 
,
∏∏ 
Guid
ππ 
groupId
ππ 
,
ππ 
Export
∫∫ 
export
∫∫ 
)
∫∫C D
{
ªª 
if
ºº 

(
ºº 
export
ºº 
.
ºº 
Status
ºº 
==
ºº 
ExportState
ºº (
.
ºº( )
	Succeeded
ºº) 2
)
ºº2 3
{
ΩΩ 	
var
øø 

fileStream
øø 
=
øø 
await
øø "
Client
øø# )
.
øø) *
Reports
øø* 1
.
øø1 2(
GetFileOfExportToFileAsync
øø2 L
(
øøL M
groupId
øøM T
,
øøT U
reportId
øøV ^
,
øø^ _
export
øø` f
.
øøf g
Id
øøg i
)
øøi j
;
øøj k
return
¿¿ 
new
¿¿ 
ExportedFile
¿¿ #
{
¡¡ 

FileStream
¬¬ 
=
¬¬ 

fileStream
¬¬ '
,
¬¬' (

FileSuffix
√√ 
=
√√ 
export
√√ #
.
√√# $#
ResourceFileExtension
√√$ 9
,
√√9 :
}
ƒƒ 
;
ƒƒ 
}
≈≈ 	
return
∆∆ 
null
∆∆ 
;
∆∆ 
}
«« 
public
…… 

class
…… 
FileService
…… 
{
   
public
ÀÀ 
virtual
ÀÀ 
bool
ÀÀ 

FileExists
ÀÀ &
(
ÀÀ& '
string
ÀÀ' -
filePath
ÀÀ. 6
)
ÀÀ6 7
=>
ÀÀ8 :
File
ÀÀ; ?
.
ÀÀ? @
Exists
ÀÀ@ F
(
ÀÀF G
filePath
ÀÀG O
)
ÀÀO P
;
ÀÀP Q
public
ÃÃ 
virtual
ÃÃ 
string
ÃÃ 
ReadAllText
ÃÃ )
(
ÃÃ) *
string
ÃÃ* 0
filePath
ÃÃ1 9
)
ÃÃ9 :
=>
ÃÃ; =
File
ÃÃ> B
.
ÃÃB C
ReadAllText
ÃÃC N
(
ÃÃN O
filePath
ÃÃO W
)
ÃÃW X
;
ÃÃX Y
}
ÕÕ 
}ŒŒ 
public–– 
class
–– 
ExportedFile
–– 
{—— 
public
““ 

Stream
““ 

FileStream
““ 
;
““ 
public
”” 

string
”” 

FileSuffix
”” 
;
”” 
}‘‘ 
public÷÷ 
class
÷÷ 

FileReader
÷÷ 
{◊◊ 
private
ÿÿ 
readonly
ÿÿ 
FileService
ÿÿ  
_fileService
ÿÿ! -
;
ÿÿ- .
public
⁄⁄ 


FileReader
⁄⁄ 
(
⁄⁄ 
FileService
⁄⁄ !
fileService
⁄⁄" -
)
⁄⁄- .
{
€€ 
_fileService
‹‹ 
=
‹‹ 
fileService
‹‹ "
;
‹‹" #
}
›› 
public
ﬂﬂ 

void
ﬂﬂ 
Test
ﬂﬂ 
(
ﬂﬂ 

TextReader
ﬂﬂ 
input
ﬂﬂ  %
,
ﬂﬂ% &

TextWriter
ﬂﬂ' 1
output
ﬂﬂ2 8
)
ﬂﬂ8 9
{
‡‡ 
output
·· 
.
·· 
	WriteLine
·· 
(
·· 
$str
·· 9
)
··9 :
;
··: ;
string
‚‚ 
fileName
‚‚ 
=
‚‚ 
input
‚‚ 
.
‚‚  
ReadLine
‚‚  (
(
‚‚( )
)
‚‚) *
;
‚‚* +
string
ÂÂ 
filePath
ÂÂ 
=
ÂÂ 
$"
ÂÂ 
$str
ÂÂ '
{
ÂÂ' (
fileName
ÂÂ( 0
}
ÂÂ0 1
"
ÂÂ1 2
;
ÂÂ2 3
if
ÁÁ 

(
ÁÁ 
_fileService
ÁÁ 
.
ÁÁ 

FileExists
ÁÁ #
(
ÁÁ# $
filePath
ÁÁ$ ,
)
ÁÁ, -
)
ÁÁ- .
{
ËË 	
string
ÈÈ 
fileContent
ÈÈ 
=
ÈÈ  
_fileService
ÈÈ! -
.
ÈÈ- .
ReadAllText
ÈÈ. 9
(
ÈÈ9 :
filePath
ÈÈ: B
)
ÈÈB C
;
ÈÈC D
output
ÍÍ 
.
ÍÍ 
	WriteLine
ÍÍ 
(
ÍÍ 
$"
ÍÍ 
$str
ÍÍ 7
{
ÍÍ7 8
fileContent
ÍÍ8 C
}
ÍÍC D
"
ÍÍD E
)
ÍÍE F
;
ÍÍF G
}
ÎÎ 	
else
ÏÏ 
{
ÌÌ 	
output
ÓÓ 
.
ÓÓ 
	WriteLine
ÓÓ 
(
ÓÓ 
$str
ÓÓ 4
)
ÓÓ4 5
;
ÓÓ5 6
}
ÔÔ 	
}
 
}ÒÒ 