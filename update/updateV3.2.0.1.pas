 unit Unit1;
interface
//枫叶香蕉v3.2.0.1 update client resource
uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
Dialogs, StdCtrls, ExtActns, ComCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Menus, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,IniFiles,
  IdHTTP,System.Zip,TLhelp32;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    StatusBar1: TStatusBar;
    Button2: TButton;
    Timer2: TTimer;
    Timer3: TTimer;
    MainMenu1: TMainMenu;
    WENJIAN1: TMenuItem;
    N1: TMenuItem;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);

    procedure N1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
        //---------------------------------------

    //---------------------------------------
    DownLoadURL : TDownLoadURL;
procedure DownloadProgress(Sender: TDownLoadURL; Progress,ProgressMax: Cardinal; StatusCode: TURLDownloadStatus; StatusText: String;
var Cancel: Boolean);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  i:integer;
  //----------------------------------
    x:integer;    //�Ʋ�����

       //----------------------------------
a,b,s:string;
//-------------------------------��ѹĿ¼�ļ�Ŀ¼ȫ������  ��ʼ
path,StrObject,StrInfor:string;
IntLengh:integer;
   //------------------------��ѹĿ¼�ļ�Ŀ¼ȫ������ ����

     myinifile,myinifile1:Tinifile; //ini��ʽ�ļ�����

implementation

{$R *.dfm}

 function CheckTask(ExeFileName: string): Boolean;
const
PROCESS_TERMINATE=$0001;
var
ContinueLoop: BOOL;
FSnapshotHandle: THandle;
FProcessEntry32: TProcessEntry32;
begin
result := False;
FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
ContinueLoop := Process32First(FSnapshotHandle,FProcessEntry32);
while integer(ContinueLoop) <> 0 do begin
      if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =UpperCase(ExeFileName))
      or (UpperCase(FProcessEntry32.szExeFile) =UpperCase(ExeFileName))) then
        result := True;
      ContinueLoop := Process32Next(FSnapshotHandle,FProcessEntry32);
end;
end;


function KillTask(ExeFileName:string):integer;
const
PROCESS_TERMINATE = $0001;
var
ContinueLoop: BOOLean;
FSnapshotHandle: THandle;
FProcessEntry32: TProcessEntry32;
begin
Result := 0;
FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
while Integer(ContinueLoop) <> 0 do
begin
if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
UpperCase(ExeFileName))) then
Result := Integer(TerminateProcess(
OpenProcess(PROCESS_TERMINATE,
BOOL(0),
FProcessEntry32.th32ProcessID),
0));
ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
end;
CloseHandle(FSnapshotHandle);
end;

function   PosEx(const   Source,   Sub:   string;   Index:   integer):   integer;
var
   Buf  :   string;
   i,Len,C:integer;
begin
   C   :=   0;
   Result   :=   0;
   Buf   :=   Source;
   i   :=   Pos(Sub,   Source);
   Len   :=   Length(Sub);
   while   i   <>   0   do
   begin
       inc(C);
       Inc(Result,   i);
       Delete(Buf,   1,   i   +   Len   -   1);
       i   :=   Pos(Sub,   Buf);
       if   C   >=   Index   then   Break;
       if   i   >   0   then   Inc(Result,   Len   -   1);
   end;
   if   C   <   Index   then   Result   :=   0;
end;

//-------------------��ȡ�ַ�������    ��ʼ
function split(src,dec : string):TStringList;
var
  i : integer;
  str : string;
begin
  result := TStringList.Create;
  repeat
    i := pos(dec,src);
    str := copy(src,1,i-1);
    if (str='') and (i>0) then
    begin
      delete(src,1,length(dec));
      continue;
    end;
    if i>0 then
    begin
      result.Add(str);
      delete(src,1,i+length(dec)-1);
    end;
  until i<=0;
  if src<>'' then
    result.Add(src);
end;
    //-------------------��ȡ�ַ�����������
  //--------------------------------------------------------------------
  // �ж��ļ���ռ��

function IsFileInUse(fName : string) : boolean;
var
   HFileRes : HFILE;
begin
   Result := false; //����ֵΪ��(���ļ�����ʹ��)
   if not FileExists(fName) then exit; //����ļ����������˳�
   HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE,
               0 {this is the trick!}, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
   Result := (HFileRes = INVALID_HANDLE_VALUE); //���CreateFile����ʧ����ôResultΪ��(���ļ����ڱ�ʹ��)
   if not Result then //���CreateFile���������ǳɹ�
   CloseHandle(HFileRes);   //��ô�رվ��
end;
//--------------------------------------------------------------------

   procedure TForm1.Button1Click(Sender: TObject);
begin
    timer1.Enabled:=true;
  timer2.Enabled:=true;
DownLoadURL.ExecuteTarget(DownLoadURL);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
halt;
end;

procedure TForm1.DownloadProgress(Sender: TDownLoadURL; Progress,
ProgressMax: Cardinal; StatusCode: TURLDownloadStatus;
StatusText: String; var Cancel: Boolean);
begin
 Application.ProcessMessages;
    //Label1.Caption := StatusText;
      StatusBar1.Panels[2].Text:='��Դ: '+StatusText;
ProgressBar1.Max := ProgressMax;






ProgressBar1.Position := Progress;

end;



procedure TForm1.FormCreate(Sender: TObject);
var
StrIni,filename:string;
StrLocal,StrServer,hack,hack1,StrLocal1:string;

//-----------------------�汾�жϣ��ַ�����ȡ
  ss : TStringList;

  str,dec : string;
//-----------------------�汾�жϣ��ַ�����ȡ
 test:String;
  i,g:integer;
  //--------------------------------�жϱ��غͷ������汾��ֵ��С
  StrSplitLocal,StrSplitServer,hacker:string;
   t,y,g1:integer ;
    //--------------------------------decide the server with local version Number Variable
   ServerNum,LocalNum:integer;
   //================================================declare the download function Variable Code begin
   h:TIdhttp;
res : String;
MyStream:TMemoryStream;
//=========================================== Declare the download function Variable Code end
begin

//begin on reading the version information

  path := ExtractFilePath(application.ExeName);
g:=0;
  edit2.Text:='';

 myinifile:=Tinifile.Create(path+'\LocalVerson.ini');
      StrIni:=myinifile.Readstring('version','info','');//read version of client
      edit2.Text:=  StrIni;
      StrLocal:=  StrIni;
     form1.Caption:='��Ҷ�㽶v'+ StrIni;
     //=========================================== download the version information form github server code begin
 MyStream:=TMemoryStream.Create;
        h:=Tidhttp.Create(nil);
        try
                h.get('http://onionhacker.github.io/version.ini',MyStream);
        except
                showmessage('�������!');
                MyStream.Free;
                exit;
        end;
        MyStream.SaveToFile(path+'\ServerVerson.ini');
        MyStream.Free;
 //===========================================  download the version information form github server code ending

  myinifile:=Tinifile.Create(path+'\ServerVerson.ini');
      StrInfor:=myinifile.Readstring('version','info','');
      myinifile.Destroy;

           EDIT1.Text:=StrInfor;
         StrServer:= StrInfor;
         hack:= StrServer+  '|' + StrLocal+'|';


 //��ȡ�汾��Ϣ ����
 //----------------------------------�жϰ汾�Ƿ���Ҫ����
       //-----------------------------------------------------------------��ȡ���ذ汾��ֵ    begin
 //memo1.Text:='';
   for i:=0 to 6 do
   begin        //�����ı�����ÿ�����ݴ�������
 dec := '.';
  ss := split(hack,dec);
test:=ss[g];

 ss.Free;
  g:=g+1;
  StrLocal1:=StrLocal1+test;
 // memo3.Text:= StrLocal1;
    hacker:=StrLocal1;
 end ;
     //-------------------------------------------------------------��ȡ���ذ汾��ֵ  ����


  g:= PosEx( hacker, '|',1);//����5

   g1:=PosEx(hacker, '|',2);//����5

//memo1.Text:=Copy(hacker,g+1,g1-g-1);
LocalNum:=strtoint(Copy(hacker,g+1,g1-g-1));
//memo2.Text:=Copy(hacker,1,g-1);
ServerNum:=strtoint(Copy(hacker,1,g-1));



    //------------------------------      �ж��Ƿ�����


    //----------------------------------        �ж��Ƿ�����

     //-----------------------��ȡ�����ļ�Ŀ��·��

   IntLengh:=length(path)-8;
    StrObject:=Copy(path,1,IntLengh)+'\proxy tool\';

    //-----------------------��ȡ�����ļ�Ŀ��·��


         StatusBar1.Panels[0].Text:='����';

  b:=StrObject+'update.zip';

DownLoadURL := TDownLoadURL.Create(self);
with DownLoadURL do
begin
FileName := b;
URL := 'https://raw.github.com/onionhacker/bananaproxy/4.0/update.zip';
OnDownloadProgress := DownloadProgress;


end;




if ServerNum>LocalNum then
begin
       StatusBar1.Panels[3].Text:='�������汾';
       BUTTON1.Enabled:=true;

killtask('goagent.exe');
killtask('python27.exe');






end
else
begin
button1.Enabled:=FALSE;
   StatusBar1.Panels[3].Text:='���Ѿ������°�';
end;

end;

procedure TForm1.N1Click(Sender: TObject);
begin
close;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
s:string;

begin
  i:= ProgressBar1.Position;

      StatusBar1.Panels[1].Text:='�Ѿ����أ�'+inttostr(i)+'�ֽ�';




    end;

procedure TForm1.Timer2Timer(Sender: TObject);


begin

  a:=ExtractFileDir(Application.Exename);



       if      IsFileInUse(b) then
begin
         StatusBar1.Panels[0].Text:='������..';
end

  else
  begin
           StatusBar1.Panels[0].Text:='���ؽ���!!';
            timer2.Enabled:=false;

            button1.Enabled:=false;
            StatusBar1.Panels[3].Text:='�������';
            edit2.Text:=StrInfor;


       myinifile:=Tinifile.Create(path+'\LocalVerson.ini');

myinifile.writestring('version','info',StrInfor);

myinifile.Destroy;
 TZipFile.ExtractZipFile(StrObject+'update.zip',StrObject);
end;





end;

end.