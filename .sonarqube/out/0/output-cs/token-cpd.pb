�
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
.	## �
ExecuteAsync
##� �
(
##� �
)
##� �
;
##� �
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
�� 
}
�� 	
;
��	 

var
�� 
exportRequest
�� 
=
�� 
new
�� !
ExportReportRequest
��  3
{
�� 	
Format
�� 
=
�� 
format
�� 
,
�� (
PowerBIReportConfiguration
�� &
=
��' (.
 powerBIReportExportConfiguration
��) I
,
��I J
}
�� 	
;
��	 

var
�� 
export
�� 
=
�� 
await
�� 
Client
�� !
.
��! "
Reports
��" )
.
��) *&
ExportToFileInGroupAsync
��* B
(
��B C
groupId
��C J
,
��J K
reportId
��L T
,
��T U
exportRequest
��V c
)
��c d
;
��d e
return
�� 
export
�� 
.
�� 
Id
�� 
;
�� 
}
�� 
public
�� 

async
�� 
Task
�� 
<
�� #
HttpOperationResponse
�� +
<
��+ ,
Export
��, 2
>
��2 3
?
��3 4
>
��4 5
PollExportRequest
��6 G
(
��G H
Guid
�� 
reportId
�� 
,
�� 
Guid
�� 
groupId
�� 
,
�� 
string
�� 
exportId
�� 
,
��E F
int
�� 
timeOutInMinutes
�� 
)
�� 
{
�� #
HttpOperationResponse
�� 
<
�� 
Export
�� $
>
��$ %
?
��% &
httpMessage
��' 2
=
��3 4
null
��5 9
;
��9 :
Export
�� 
?
�� 
exportStatus
�� 
=
�� 
null
�� #
;
��# $
DateTime
�� 
	startTime
�� 
=
�� 
DateTime
�� %
.
��% &
UtcNow
��& ,
;
��, -
const
�� 
int
�� 
c_secToMillisec
�� !
=
��" #
$num
��$ (
;
��( )
do
�� 

{
�� 	
if
�� 
(
�� 
DateTime
�� 
.
�� 
UtcNow
�� 
.
��  
Subtract
��  (
(
��( )
	startTime
��) 2
)
��2 3
.
��3 4
TotalMinutes
��4 @
>
��A B
timeOutInMinutes
��C S
)
��S T
{
�� 
return
�� 
null
�� 
;
�� 
}
�� 
httpMessage
�� 
=
�� 
await
�� 
Client
��  &
.
��& '
Reports
��' .
.
��. /?
1GetExportToFileStatusInGroupWithHttpMessagesAsync
��/ `
(
��` a
groupId
��a h
,
��h i
reportId
��j r
,
��r s
exportId
��t |
)
��| }
;
��} ~
exportStatus
�� 
=
�� 
httpMessage
�� &
.
��& '
Body
��' +
;
��+ ,
Console
�� 
.
�� 
	WriteLine
�� 
(
�� 
string
�� $
.
��$ %
Format
��% +
(
��+ ,
$str
��, K
,
��K L
exportStatus
��M Y
.
��Y Z
Status
��Z `
.
��` a
ToString
��a i
(
��i j
)
��j k
,
��k l
exportStatus
��m y
.
��y z
PercentComplete��z �
)��� �
)��� �
;��� �
if
�� 
(
�� 
exportStatus
�� 
.
�� 
Status
�� #
==
��$ &
ExportState
��' 2
.
��2 3
Running
��3 :
||
��; =
exportStatus
��> J
.
��J K
Status
��K Q
==
��R T
ExportState
��U `
.
��` a

NotStarted
��a k
)
��k l
{
�� 
var
�� 

retryAfter
�� 
=
��  
httpMessage
��! ,
.
��, -
Response
��- 5
.
��5 6
Headers
��6 =
.
��= >

RetryAfter
��> H
;
��H I
var
�� 
retryAfterInSec
�� #
=
��$ %

retryAfter
��& 0
.
��0 1
Delta
��1 6
.
��6 7
Value
��7 <
.
��< =
Seconds
��= D
;
��D E
await
�� 
Task
�� 
.
�� 
Delay
��  
(
��  !
retryAfterInSec
��! 0
*
��1 2
c_secToMillisec
��3 B
)
��B C
;
��C D
}
�� 
}
�� 	
while
�� 
(
�� 
exportStatus
�� 
.
�� 
Status
�� "
!=
��# %
ExportState
��& 1
.
��1 2
	Succeeded
��2 ;
&&
��< >
exportStatus
��? K
.
��K L
Status
��L R
!=
��S U
ExportState
��V a
.
��a b
Failed
��b h
)
��h i
;
��i j
return
�� 
httpMessage
�� 
;
�� 
}
�� 
public
�� 

async
�� 
Task
�� 
<
�� 
ExportedFile
�� "
>
��" #
GetExportedFile
��$ 3
(
��3 4
Guid
�� 
reportId
�� 
,
�� 
Guid
�� 
groupId
�� 
,
�� 
Export
�� 
export
�� 
)
��C D
{
�� 
if
�� 

(
�� 
export
�� 
.
�� 
Status
�� 
==
�� 
ExportState
�� (
.
��( )
	Succeeded
��) 2
)
��2 3
{
�� 	
var
�� 

fileStream
�� 
=
�� 
await
�� "
Client
��# )
.
��) *
Reports
��* 1
.
��1 2(
GetFileOfExportToFileAsync
��2 L
(
��L M
groupId
��M T
,
��T U
reportId
��V ^
,
��^ _
export
��` f
.
��f g
Id
��g i
)
��i j
;
��j k
return
�� 
new
�� 
ExportedFile
�� #
{
�� 

FileStream
�� 
=
�� 

fileStream
�� '
,
��' (

FileSuffix
�� 
=
�� 
export
�� #
.
��# $#
ResourceFileExtension
��$ 9
,
��9 :
}
�� 
;
�� 
}
�� 	
return
�� 
null
�� 
;
�� 
}
�� 
public
�� 

class
�� 
FileService
�� 
{
�� 
public
�� 
virtual
�� 
bool
�� 

FileExists
�� &
(
��& '
string
��' -
filePath
��. 6
)
��6 7
=>
��8 :
File
��; ?
.
��? @
Exists
��@ F
(
��F G
filePath
��G O
)
��O P
;
��P Q
public
�� 
virtual
�� 
string
�� 
ReadAllText
�� )
(
��) *
string
��* 0
filePath
��1 9
)
��9 :
=>
��; =
File
��> B
.
��B C
ReadAllText
��C N
(
��N O
filePath
��O W
)
��W X
;
��X Y
}
�� 
}�� 
public�� 
class
�� 
ExportedFile
�� 
{�� 
public
�� 

Stream
�� 

FileStream
�� 
;
�� 
public
�� 

string
�� 

FileSuffix
�� 
;
�� 
}�� 
public�� 
class
�� 

FileReader
�� 
{�� 
private
�� 
readonly
�� 
FileService
��  
_fileService
��! -
;
��- .
public
�� 


FileReader
�� 
(
�� 
FileService
�� !
fileService
��" -
)
��- .
{
�� 
_fileService
�� 
=
�� 
fileService
�� "
;
��" #
}
�� 
public
�� 

void
�� 
Test
�� 
(
�� 

TextReader
�� 
input
��  %
,
��% &

TextWriter
��' 1
output
��2 8
)
��8 9
{
�� 
output
�� 
.
�� 
	WriteLine
�� 
(
�� 
$str
�� 9
)
��9 :
;
��: ;
string
�� 
fileName
�� 
=
�� 
input
�� 
.
��  
ReadLine
��  (
(
��( )
)
��) *
;
��* +
string
�� 
filePath
�� 
=
�� 
$"
�� 
$str
�� '
{
��' (
fileName
��( 0
}
��0 1
"
��1 2
;
��2 3
if
�� 

(
�� 
_fileService
�� 
.
�� 

FileExists
�� #
(
��# $
filePath
��$ ,
)
��, -
)
��- .
{
�� 	
string
�� 
fileContent
�� 
=
��  
_fileService
��! -
.
��- .
ReadAllText
��. 9
(
��9 :
filePath
��: B
)
��B C
;
��C D
output
�� 
.
�� 
	WriteLine
�� 
(
�� 
$"
�� 
$str
�� 7
{
��7 8
fileContent
��8 C
}
��C D
"
��D E
)
��E F
;
��F G
}
�� 	
else
�� 
{
�� 	
output
�� 
.
�� 
	WriteLine
�� 
(
�� 
$str
�� 4
)
��4 5
;
��5 6
}
�� 	
}
�� 
}�� 