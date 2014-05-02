  {version :1.3
  function:update files from google code or github

  using idhttp download update file

  author:ring hacker

 Compiled date:  May 2 2014}
 unit Unit1;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
Dialogs, StdCtrls, ExtActns, ComCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Menus, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,IniFiles,
  IdHTTP,System.Zip,TLhelp32,shellapi, IdAntiFreezeBase, Vcl.IdAntiFreeze;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ProgressBar1: TProgressBar;
    StatusBar1: TStatusBar;
    Button2: TButton;
    Timer2: TTimer;
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
    IdHTTP2: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL2: TIdSSLIOHandlerSocketOpenSSL;
    IdAntiFreeze1: TIdAntiFreeze;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);

    procedure N1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure IdHTTP2WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdHTTP2Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdHTTP2WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure Timer1Timer(Sender: TObject);
    type


   TOSVersion = (osUnknown, os95, os98, osME, osNT3, osNT4, os2K, osXP, os2K3);
  private
    { Private declarations }
        //---------------------------------------

    //---------------------------------------

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  i:integer;
  //----------------------------------


       //----------------------------------
a,b,s:string;
//-------------------------------��ѹĿ¼�ļ�Ŀ¼ȫ������  ��ʼ
path,StrObject,StrInfor:string;
IntLengh:integer;
   //------------------------��ѹĿ¼�ļ�Ŀ¼ȫ������ ����

     myinifile,myinifile1:Tinifile; //ini��ʽ�ļ�����

       wnd : cardinal;
  rec : TRect;
  w,h : integer;
  x,y : integer;

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

function BytesToStr(iBytes: Integer): String;
var
  iKb: Integer;
begin
  iKb := Round(iBytes / 1024);
  if iKb > 1000 then
    Result := Format('%.2f MB', [iKb / 1024])
  else
    Result := Format('%d KB', [iKb]);
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


var
  tStream: TMemoryStream;
begin
button1.Enabled:=false;
  tStream := TMemoryStream.Create;
  try
    IdHTTP1.Get('https://raw.githubusercontent.com/onionhacker/bananaproxy/4.0/update.zip', tStream);
    tStream.SaveToFile(StrObject+'update.zip');
  except
    ShowMessage('Download Fail��');
  end;
  tStream.Free;
  button2.Enabled:=false;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
halt;
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
   MyStream,tStream: TMemoryStream;
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

    //-----------------------��ȡ�����ļ�Ŀ��·��

   IntLengh:=length(path)-8;
    StrObject:=Copy(path,1,IntLengh)+'\proxy tool\';

    //-----------------------��ȡ�����ļ�Ŀ��·��




if ServerNum>LocalNum then
begin
       StatusBar1.Panels[3].Text:='�������汾';
       button2.Enabled:=false;
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
begin


            edit2.Text:=StrInfor;
                   button1.Enabled:=false;


       myinifile:=Tinifile.Create(path+'\LocalVerson.ini');

myinifile.writestring('version','info',StrInfor);

myinifile.Destroy;

 TZipFile.ExtractZipFile(StrObject+'update.zip',StrObject);

// find a handle of a tray
  wnd := FindWindow('Shell_TrayWnd', nil);
  wnd := FindWindowEx(wnd, 0, 'TrayNotifyWnd', nil);
  wnd := FindWindowEx(wnd, 0, 'SysPager', nil);
  wnd := FindWindowEx(wnd, 0, 'ToolbarWindow32', nil);
  // get client rectangle (needed for width and height of tray)
  windows.GetClientRect(wnd, rec);
  // get size of small icons
  w := GetSystemMetrics(sm_cxsmicon);
  h := GetSystemMetrics(sm_cysmicon);
  // initial y position of mouse - half of height of icon
  y := w shr 1;
  while y < rec.Bottom do
  begin // while y < height of tray
    x := h shr 1; // initial x position of mouse - half of width of icon
    while x < rec.Right do
    begin // while x < width of tray
      SendMessage(wnd, wm_mousemove, 0, y shl 16 or x); // simulate moving mouse over an icon
      x := x + w; // add width of icon to x position
    end;
    y := y + h; // add height of icon to y position
  end;

   ShellExecute(0, nil, 'goagent.exe', nil, PChar(StrObject), SW_SHOWNORMAL);
      button2.Enabled:=true;
                 StatusBar1.Panels[0].Text:='��ӭʹ�÷�Ҷ�㽶��ǽ���';
            StatusBar1.Panels[3].Text:='�汾�������';
            form1.Caption:='��Ҷ�㽶v'+ StrInfor;
       timer1.Enabled:=false;
end;

procedure TForm1.IdHTTP2Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
StatusBar1.Panels[1].text:= '�Ѿ������ļ�:'+ BytesToStr(aWorkCount);
  ProgressBar1.Position := aWorkCount;
  Update;
end;

procedure TForm1.IdHTTP2WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  ProgressBar1.Max := aWorkCountMax;
StatusBar1.Panels[0].text:= '�ܼ��ļ�:'+BytesToStr(aWorkCountMax);
StatusBar1.Panels[2].text:=   'from google code server';
  Update;
end;

procedure TForm1.IdHTTP2WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin

            //showmessage('SUCCESS') ;
              StatusBar1.Panels[3].Text:='�������';
                timer1.Enabled:=true;


end;

end.
