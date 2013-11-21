unit Unit1;

interface
// Maple Banana recourse ok������
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,IniFiles, StrUtils, StdCtrls, ExtCtrls,shellapi,TLhelp32, jpeg,
  OleCtrls,Registry, SHDocVw,Wininet, Menus;
const
  XorKey:array[0..7] of Byte=($B2,$09,$AA,$55,$93,$6D,$84,$47); //�ַ���������
type
  TForm1 = class(TForm)
    Timer2: TTimer;
    Image1: TImage;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Bevel1: TBevel;
    GroupBox2: TGroupBox;
    Button5: TButton;
    Label1: TLabel;
    Button6: TButton;




    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);

    procedure FormHide(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);




  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  filename:string;
  vi,ComA,ComB:integer;
  slist:TStringList; //�洢�ı��ļ�����
  pstrarray:array of string;   //����
  i,icount:integer;
  myinifile:Tinifile; //   -----------
      sel,bb:string;                      //ini�ļ���д
      createini:TiniFile; //------------
      p,dynamic,ini,pp,newday:integer;
a,delappid,b,aa,e,c,d,self1,strHideFile,strdec:string;

//--------------

  Reg:TRegistry;
  proxya:String;                   //���ܴ���ȫ������
  SEX:INTEGER;
  info: INTERNET_PROXY_INFO;

//---------------
hwd:hwnd;
hack:integer;  // ������󻯰�ť
//-------------------
implementation

uses Unit2;

{$R *.dfm}
// {$R 'hack.RES'}
//�����ļ�



  function ChangeProxy1(const Proxy, Port,ByPass: string; const bEnabled: boolean = True): boolean;
var
reg: TreGIStry;
info: INTERNET_PROXY_INFO;
Fproxy:string;
begin
Result := False;
FProxy:=Format('%s:%s',[Proxy,Port]);
reg := TreGIStry.Create;
try
reg.RootKey := HKEY_CURRENT_USER;
if reg.OpenKey('\Software\Microsoft\windows\CurrentVersion\Internet Settings', True) then
begin
reg.Writestring('AutoConfigURL', Fproxy);
info.dwaccessType := INTERNET_OPEN_TYPE_PROXY;
info.lpszProxy := pchar(proxy);
info.lpszProxyBypass := pchar(ByPass);
InternetSetOption(nil, INTERNET_OPTION_PROXY, @info, SizeOf(Info));
InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);
// InternetSetOption(nil, INTERNET_OPTION_REFRESH, nil, 0);
// Sendmessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0, 0);
Result:=True;
end
finally
reg.CloseKey;
reg.free;
end;
end;
//-------------------------------------------------------
       //  -------------------------------------------------------------------------------
                function dDisabledProxyEnable(const key: boolean = True): boolean;    //ȡ������
Var

  Reg:TRegistry;
  info: INTERNET_PROXY_INFO;
Begin
Result := False;
  Reg:=TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings',false) then
    begin

        Reg.WriteInteger('ProxyEnable',integer(key));
        InternetSetOption(nil, INTERNET_OPTION_PROXY, @info, SizeOf(Info));
InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);
      Reg.CloseKey;
    end;
  except
    Reg.Free;
  end;
end;



//------------------------------------------------  ChangeProxy

            //-----------------------------------------------------------------------------
function ChangeProxy(const Proxy, Port,ByPass: string; const bEnabled: boolean = True): boolean;
var
reg: TreGIStry;
info: INTERNET_PROXY_INFO;
Fproxy:string;
begin
Result := False;
FProxy:=Format('%s:%s',[Proxy,Port]);
reg := TreGIStry.Create;
try
reg.RootKey := HKEY_CURRENT_USER;
if reg.OpenKey('\Software\Microsoft\windows\CurrentVersion\Internet Settings', True) then
begin
reg.Writestring('ProxyServer', Fproxy);
reg.WriteInteger('ProxyEnable', integer(bEnabled));
info.dwaccessType := INTERNET_OPEN_TYPE_PROXY;
info.lpszProxy := pchar(proxy);
info.lpszProxyBypass := pchar(ByPass);
InternetSetOption(nil, INTERNET_OPTION_PROXY, @info, SizeOf(Info));
InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);
// InternetSetOption(nil, INTERNET_OPTION_REFRESH, nil, 0);
// Sendmessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0, 0);
Result:=True;
end
finally
reg.CloseKey;
reg.free;
end;
end;


    //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------


   procedure ExtractRes(ResType, ResName, ResNewName : String);
var
Res : TResourceStream;
begin                                                                  //�ͷ���Դ�ļ�library.ini
Res := TResourceStream.Create(Hinstance, Resname, Pchar(ResType));
Res.SavetoFile(ResNewName);
Res.Free;
end;                         //���������˼���ͷ���Դ�ļ�   ����������
                               //һ����Դ����   2 ��Դ����   ������Դ������
//-----------------------------------------------------

//---------------------------------------------------------

    function FindProcess(AFileName: string): boolean;
var
hSnapshot: THandle;//���ڻ�ý����б�
lppe: TProcessEntry32;//���ڲ��ҽ���
Found: Boolean;//�����жϽ��̱����Ƿ����
begin
Result :=False;
hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);//���ϵͳ�����б�
lppe.dwSize := SizeOf(TProcessEntry32);//�ڵ���Process32First API֮ǰ����Ҫ��ʼ��lppe��¼�Ĵ�С
Found := Process32First(hSnapshot, lppe);//�������б��ĵ�һ��������Ϣ����ppe��¼��
while Found do
begin
if ((UpperCase(ExtractFileName(lppe.szExeFile))=UpperCase(AFileName)) or (UpperCase(lppe.szExeFile )=UpperCase(AFileName))) then
begin
Result :=True;
end;
Found := Process32Next(hSnapshot, lppe);//�������б�����һ��������Ϣ����lppe��¼��
end;
end;
//----------------------------------------------------------------------------
procedure TForm1.FormCreate(Sender: TObject);
var
  attr:integer;

FileName:string;
   //�ı��ļ�����


begin

//--------------------
hwd:=GetSystemMenu(form1.Handle,false);               //������󻯰�ť
hack:=GetMenuItemCount(hwd);
RemoveMenu(hwd,hack-1,MF_DISABLED Or MF_BYPOSITION);
DrawMenuBar(hwd);
//-------------------------------------------------------------------------------------
form1.Caption:='������û�д�������ѡ��һ����ϲ���Ĵ������Ƽ�����ģʽ��';
  //SetForegroundWindow(Handle);
  
          //  AnimateWindow(Handle, 1000, AW_CENTER);
     //----------------------------------------------------------------------------------
     self1:=ExtractFileDir(Application.Exename);
     SetFileAttributes(PCHAR(self1+'\Library1.ini'),FILE_ATTRIBUTE_HIDDEN );
     SetFileAttributes(PCHAR(self1+'\proxy.py'),FILE_ATTRIBUTE_HIDDEN );
      SetFileAttributes(PCHAR(self1+'\proxy.ini'),FILE_ATTRIBUTE_HIDDEN );

SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
//SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);


Application.ShowMainForm := true;

    aa:='you are intensely hacker!';

e:=self1 +'\browser\';


//strHideFile:=self1+''
//SetFileAttributes('strHideFile',FILE_ATTRIBUTE_HIDDEN or FILE_ATTRIBUTE_SYSTEM);
         ShellExecute(0, nil, 'firefox.exe', nil, PChar(e), SW_SHOWNORMAL);
              b:=self1 ;

               // edit1.Text:=inttostr(newday);

slist:=TStringList.Create;
  slist.LoadFromFile( self1+'\Library1.ini');
  // showmessage('XP123');     //���ļ��������뵽�ַ��������б�
   icount:=slist.Count;
  dynamic:=icount;
// label1.Caption:=inttostr(dynamic);
    setlength(pstrarray,icount); //���ö�̬���鳤��
    for i:=0 to icount-1 do          //�����ı�����ÿ�����ݴ�������
     begin
       pstrarray[i]:=slist.Strings[i];

        end;

         slist.free;
         //--------------------------------------                        �������appid



         self1:=ExtractFileDir(Application.Exename);

  for p:=0 to 3 do
   begin

      DupeString(#32,   1);
      c:=DupeString(#32,   1);

        randomize;  //�������������
            i:=random(dynamic);
               a:=a+pstrarray[i];

   end;



  d:=copy(a,2,length(a));

         if FindProcess('goagent.exe') then
      begin

         sleep(50)

      end
      else
         begin



       //  ExtractRes('EXEFILE', 'tor', self1+'\topFox\Goagent\local\proxy.py');    //���û�з���goagent�ͷ�goagentԴ�룡



           createini:=TiniFile.Create(ExtractFilepath(paramstr(0))+'\proxy.ini');
    IF not FileExists(ExtractFilepath(paramstr(0)+ '\proxy.ini')) then
    begin

   Createini.WriteString('gae','appid',c+d);
     Createini.WriteString('gae','password',c+'ultrazero');
     sleep(1500);

        ShellExecute(0, nil, 'goagent.exe', nil, PChar(b), SW_SHOWNORMAL);
createini.Destroy;
   end;

   //----------------------------------------------------------------------------------------����






END;

end;








procedure TForm1.Timer2Timer(Sender: TObject);
begin
   createini:=TiniFile.Create(ExtractFilepath(paramstr(0))+'\proxy.ini');
    IF not FileExists(ExtractFilepath(paramstr(0)+ '\proxy.ini')) then
    begin

   Createini.WriteString('gae','password',c+'��������İ�֢��ɢ��û��');



createini.Destroy;
   end;
halt;


    end;



procedure TForm1.FormHide(Sender: TObject);
begin
   AnimateWindow(Handle, 1000, AW_hide+AW_CENTER);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
form1.Caption:='������ĵ���û���κδ�������л��ʹ�ñ���Ŀ������';

  //---------------------------------------------------ɾ��pac
reg:=tregistry.Create;

reg.rootkey:=HKEY_CURRENT_USER;

reg.openkey('Software\Microsoft\windows\CurrentVersion\Internet Settings',true);

reg.DeleteValue('AutoConfigURL'); //ɾ��ע�����
         InternetSetOption(nil, INTERNET_OPTION_PROXY, @info, SizeOf(Info));
    InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);
reg.CloseKey;

reg.Free;
SLEEP(200);
dDisabledProxyEnable(false);
//--------------------------------------------------------------
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
form1.Caption:='����ģʽ����ǽ�����Σ����������ڣ����ʡ������ģʽ';
ChangeProxy('127.0.0.1','8087','1',true);

  proxya:='http://127.0.0.1:8086/proxy.pac';
    Reg:=TRegistry.Create;                                     //����һ���¼�
    Reg.RootKey:=HKEY_CURRENT_USER;     //����������ΪHKEY_LOCAL_MACHINE
    Reg.OpenKey('Software\Microsoft\windows\CurrentVersion\Internet Settings',true);//��һ����
    Reg.WriteString('AutoConfigURL',proxya);           //��Reg�������д���������ƺ�������ֵ

        Reg.CloseKey;
           Info.dwAccessType := INTERNET_OPEN_TYPE_PROXY;
    Info.lpszProxy := PChar(proxya);
   InternetSetOption(nil, INTERNET_OPTION_PROXY, @Info, 1000);
   InternetSetOption(nil, INTERNET_OPTION_REFRESH, nil, 0);
    InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);
//----------------------------



end;

procedure TForm1.Button3Click(Sender: TObject);
begin
form1.Caption:='ȫ��ģʽ����ǽ�����Σ�������������������ڹ��ⶼ����������򲻿�ĳЩ������վ��ʹ�����ģʽ';
ChangeProxy('127.0.0.1','8087','1',true);

reg:=tregistry.Create;

reg.rootkey:=HKEY_CURRENT_USER;

reg.openkey('Software\Microsoft\windows\CurrentVersion\Internet Settings',true);

reg.DeleteValue('AutoConfigURL'); //ɾ��ע�����
         InternetSetOption(nil, INTERNET_OPTION_PROXY, @info, SizeOf(Info));
    InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);
reg.CloseKey;

reg.Free;


end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  //---------------------------------------------------ɾ��pac
reg:=tregistry.Create;

reg.rootkey:=HKEY_CURRENT_USER;

reg.openkey('Software\Microsoft\windows\CurrentVersion\Internet Settings',true);

reg.DeleteValue('AutoConfigURL'); //ɾ��ע�����
         InternetSetOption(nil, INTERNET_OPTION_PROXY, @info, SizeOf(Info));
    InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);
reg.CloseKey;

reg.Free;
SLEEP(200);
dDisabledProxyEnable(false);
//--------------------------------------------------------------
HIDE;
halt;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
FORM1.Hide;
form2.Show;
form2.timer1.Enabled:=true;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
halt;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin

    if FindProcess('zhudongfangyu.exe') or FindProcess('360tray.exe') then
      begin

Application.MessageBox('�����㰲װ��360��å����������㽶�������Σ����˳�360�����㽶��','����',MB_OKCANCEL);
   end
   else
   begin
   Application.MessageBox('û����360��Ӱ�ӣ���֤����ľ�а�װ������','��ʾ',MB_OK);

end;
end;
procedure TForm1.Button6Click(Sender: TObject);
begin
    ComA:=0;
ComB:=1;
       self1:=ExtractFileDir(Application.Exename);
    Filename:=ExtractFilePath(Paramstr(0))+'setup.ini';
          myinifile:=Tinifile.Create(filename);

  vi:=myinifile.Readinteger('browser','IsRunBrowser',SEX);

     myinifile.destroy;
           //createini:TiniFile;
          // createini.Destroy;
          IF vi = ComB then

           begin
             e:=self1 +'\onion-project\GoogleChromePortableBeta\';
             ShellExecute(0, nil, 'GoogleChromePortable.exe', nil, PChar(e), SW_SHOWNORMAL);
             end;
             IF vi =  ComA then
             begin
    SLEEP(50);

end;
end;

end.

