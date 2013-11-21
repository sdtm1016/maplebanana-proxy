unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,IniFiles, StrUtils, StdCtrls, ExtCtrls,shellapi,TLhelp32, jpeg,
  OleCtrls,Registry, SHDocVw,Wininet, Menus;
const
  XorKey:array[0..7] of Byte=($B2,$09,$AA,$55,$93,$6D,$84,$47); //字符串加密用
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
  slist:TStringList; //存储文本文件内容
  pstrarray:array of string;   //数组
  i,icount:integer;
  myinifile:Tinifile; //   -----------
      sel,bb:string;                      //ini文件读写
      createini:TiniFile; //------------
      p,dynamic,ini,pp,newday:integer;
a,delappid,b,aa,e,c,d,self1,strHideFile,strdec:string;

//--------------

  Reg:TRegistry;
  proxya:String;                   //智能代理全局申明
  SEX:INTEGER;
  info: INTERNET_PROXY_INFO;

//---------------
hwd:hwnd;
hack:integer;  // 屏蔽最大化按钮
//-------------------
implementation

uses Unit2;

{$R *.dfm}
// {$R 'hack.RES'}
//隐藏文件



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
                function dDisabledProxyEnable(const key: boolean = True): boolean;    //取消代理
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
begin                                                                  //释放资源文件library.ini
Res := TResourceStream.Create(Hinstance, Resname, Pchar(ResType));
Res.SavetoFile(ResNewName);
Res.Free;
end;                         //这个方法意思是释放资源文件   有三个参数
                               //一个资源类型   2 资源名字   生成资源的名字
//-----------------------------------------------------

//---------------------------------------------------------

    function FindProcess(AFileName: string): boolean;
var
hSnapshot: THandle;//用于获得进程列表
lppe: TProcessEntry32;//用于查找进程
Found: Boolean;//用于判断进程遍历是否完成
begin
Result :=False;
hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);//获得系统进程列表
lppe.dwSize := SizeOf(TProcessEntry32);//在调用Process32First API之前，需要初始化lppe记录的大小
Found := Process32First(hSnapshot, lppe);//将进程列表的第一个进程信息读入ppe记录中
while Found do
begin
if ((UpperCase(ExtractFileName(lppe.szExeFile))=UpperCase(AFileName)) or (UpperCase(lppe.szExeFile )=UpperCase(AFileName))) then
begin
Result :=True;
end;
Found := Process32Next(hSnapshot, lppe);//将进程列表的下一个进程信息读入lppe记录中
end;
end;
//----------------------------------------------------------------------------
procedure TForm1.FormCreate(Sender: TObject);
var
  attr:integer;

FileName:string;
   //文本文件行数


begin

//--------------------
hwd:=GetSystemMenu(form1.Handle,false);               //屏蔽最大化按钮
hack:=GetMenuItemCount(hwd);
RemoveMenu(hwd,hack-1,MF_DISABLED Or MF_BYPOSITION);
DrawMenuBar(hwd);
//-------------------------------------------------------------------------------------
form1.Caption:='你现在没有代理，请选择一个你喜欢的代理，推荐智能模式！';
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
  // showmessage('XP123');     //把文件内容载入到字符串数组列表
   icount:=slist.Count;
  dynamic:=icount;
// label1.Caption:=inttostr(dynamic);
    setlength(pstrarray,icount); //设置动态数组长度
    for i:=0 to icount-1 do          //遍历文本，把每行数据存入数组
     begin
       pstrarray[i]:=slist.Strings[i];

        end;

         slist.free;
         //--------------------------------------                        生成随机appid



         self1:=ExtractFileDir(Application.Exename);

  for p:=0 to 3 do
   begin

      DupeString(#32,   1);
      c:=DupeString(#32,   1);

        randomize;  //生成随机数种子
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



       //  ExtractRes('EXEFILE', 'tor', self1+'\topFox\Goagent\local\proxy.py');    //如果没有发现goagent释放goagent源码！



           createini:=TiniFile.Create(ExtractFilepath(paramstr(0))+'\proxy.ini');
    IF not FileExists(ExtractFilepath(paramstr(0)+ '\proxy.ini')) then
    begin

   Createini.WriteString('gae','appid',c+d);
     Createini.WriteString('gae','password',c+'ultrazero');
     sleep(1500);

        ShellExecute(0, nil, 'goagent.exe', nil, PChar(b), SW_SHOWNORMAL);
createini.Destroy;
   end;

   //----------------------------------------------------------------------------------------结束






END;

end;








procedure TForm1.Timer2Timer(Sender: TObject);
begin
   createini:=TiniFile.Create(ExtractFilepath(paramstr(0))+'\proxy.ini');
    IF not FileExists(ExtractFilepath(paramstr(0)+ '\proxy.ini')) then
    begin

   Createini.WriteString('gae','password',c+'方宾兴你的癌症扩散了没啊');



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
form1.Caption:='现在你的电脑没有任何代理！感谢你使用本项目软件！';

  //---------------------------------------------------删除pac
reg:=tregistry.Create;

reg.rootkey:=HKEY_CURRENT_USER;

reg.openkey('Software\Microsoft\windows\CurrentVersion\Internet Settings',true);

reg.DeleteValue('AutoConfigURL'); //删除注册表项
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
form1.Caption:='智能模式，穿墙于无形！不代理国内，最节省流量的模式';
ChangeProxy('127.0.0.1','8087','1',true);

  proxya:='http://127.0.0.1:8086/proxy.pac';
    Reg:=TRegistry.Create;                                     //创建一个新键
    Reg.RootKey:=HKEY_CURRENT_USER;     //将根键设置为HKEY_LOCAL_MACHINE
    Reg.OpenKey('Software\Microsoft\windows\CurrentVersion\Internet Settings',true);//打开一个键
    Reg.WriteString('AutoConfigURL',proxya);           //在Reg这个键中写入数据名称和数据数值

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
form1.Caption:='全局模式，穿墙于无形！代理所有浏览器，国内国外都代理，如果打不开某些国外网站请使用这个模式';
ChangeProxy('127.0.0.1','8087','1',true);

reg:=tregistry.Create;

reg.rootkey:=HKEY_CURRENT_USER;

reg.openkey('Software\Microsoft\windows\CurrentVersion\Internet Settings',true);

reg.DeleteValue('AutoConfigURL'); //删除注册表项
         InternetSetOption(nil, INTERNET_OPTION_PROXY, @info, SizeOf(Info));
    InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);
reg.CloseKey;

reg.Free;


end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  //---------------------------------------------------删除pac
reg:=tregistry.Create;

reg.rootkey:=HKEY_CURRENT_USER;

reg.openkey('Software\Microsoft\windows\CurrentVersion\Internet Settings',true);

reg.DeleteValue('AutoConfigURL'); //删除注册表项
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

Application.MessageBox('发现你安装了360流氓软件，请给香蕉设置信任，或退出360启动香蕉！','警告',MB_OKCANCEL);
   end
   else
   begin
   Application.MessageBox('没发现360的影子，你证书有木有安装啊？亲','提示',MB_OK);

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


