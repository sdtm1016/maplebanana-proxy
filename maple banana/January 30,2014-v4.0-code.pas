  unit Unit1;

interface
//         枫叶香蕉v4系列 源码 date: January 30,2014
uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,

Dialogs,TLhelp32,shellapi, StdCtrls,Types ,ShlObj, ActiveX, ComObj,
Vcl.ExtCtrls, Vcl.Menus, Vcl.Imaging.jpeg, Vcl.ComCtrls,Registry, Vcl.OleCtrls, SHDocVw, {该函数使用的单元} IOUtils,Wininet,StrUtils,  MPlayer,
mmsystem, ToolWin,IniFiles, System.Zip, Vcl.Imaging.pngimage, Vcl.Imaging.GIFImg,
Vcl.ImgList;
const
 aimDir = 'C:\Documents and Settings\Administrator\Application Data\Mozilla';
type
  TForm1 = class(TForm)
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    WebBrowser1: TWebBrowser;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N14: TMenuItem;
    Timer1: TTimer;
    N15: TMenuItem;
    Image1: TImage;
    N9: TMenuItem;
    TrayIcon1: TTrayIcon;
    ImageList1: TImageList;
    Label1: TLabel;
    Timer2: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
     procedure N15Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    private
    { Private declarations }
    procedure SysCommand(var SysMsg: TMessage); message WM_SYSCOMMAND;
    public
    { Public declarations }
    end;
    function SetLayeredWindowAttributes(hwnd:HWND; crKey:Longint; bAlpha:byte; dwFlags:longint ):longint; stdcall; external user32;//函数声明
var
   Form1: TForm1;
   ee1, filename1:string;// 控制火狐浏览器启动
   slist:TStringList; //存储文本文件内容
   pstrarray:array of string;   //数组
   i,icount:integer;
   mytitle, mytext:string;
   createini:TiniFile; //------------
   p,dynamic,ini,pp,newday:integer;
   delappid,aa,c,d,self1,strHideFile,strdec:string;
   ai,strfox,strgo,Temfox,Temgo:string;
   icondata: tnotifyicondata;
   myinifile,myinifile1:Tinifile;
   e,b:string;
   vi,a,ComA,ComB:integer;
   filename:string;
//--------------
  Reg:TRegistry;
  proxya:String;                   //智能代理全局申明
  SEX:INTEGER;
  info: INTERNET_PROXY_INFO;
implementation
   {$R *.dfm}
   {$R hack.res}
procedure TForm1.SysCommand(var SysMsg: TMessage);                                    //最小化 隐藏到 托盘
       begin
         case SysMsg.WParam of
         SC_CLOSE:
           begin
          // 当最小化时
                SetWindowPos(Application.Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_HIDEWINDOW);
                form1.hide; // 在任务栏隐藏程序
    end;

else
    inherited;
    case SysMsg.WParam of
         SC_MINIMIZE:
             begin
     // 当最小化时
      SetWindowPos(Application.Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_HIDEWINDOW);
      form1.hide;// 在任务栏隐藏程序
                  end;
                  else
    inherited;

end;
  end;
  end;
   function certDisabledProxyEnable(const key: boolean = True): boolean;    //取消证书警告
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
        Reg.WriteInteger('WarnonBadCertRecving',integer(key));
        InternetSetOption(nil, INTERNET_OPTION_PROXY, @info, SizeOf(Info));
InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);
      Reg.CloseKey;
    end;
  except
    Reg.Free;
  end;
end;
//------------------------------------------------  取消证书警告
              procedure cryptFile(srcFile,dstFile:TFilename);    //加密函数
var
  srcf,dstf:file of byte;
  buf:byte;
begin
  assign(srcf,srcfile);
  assign(dstf,dstfile);
  reset(srcf); rewrite(dstf);
  while not eof(srcf) do
  begin
    read(srcf,buf);
    buf:=buf+21;      //这里可以修改成其他的数值
    write(dstf,buf);
  end;
  closefile(srcf);
  closefile(dstf);
end;

procedure decryptFile(srcFile,dstFile:TFilename); //解密函数
var
  srcf,dstf:file of byte;
  buf:byte;
begin
  assign(srcf,srcfile);
  assign(dstf,dstfile);
  reset(srcf); rewrite(dstf);
  while not eof(srcf) do
  begin
    read(srcf,buf);
    buf:=buf-21;      //这里可以作相应修改
    write(dstf,buf);
  end;
  closefile(srcf);
  closefile(dstf);
end;

  function CreateShortcut(Exe:string; Lnk:string = ''; Dir:string = ''; ID:Integer = -1):Boolean;
var
IObj: IUnknown;
ILnk: IShellLink;
IPFile: IPersistFile;
PIDL: PItemIDList;
InFolder: array[0..MAX_PATH] of Char;
LinkFileName: WideString;
begin
Result := False;
if not FileExists(Exe) then Exit;
if Lnk = '' then Lnk := ChangeFileExt(ExtractFileName(Exe), '');

IObj := CreateComObject(CLSID_ShellLink);
ILnk := IObj as IShellLink;
ILnk.SetPath(PChar(Exe));
ILnk.SetWorkingDirectory(PChar(ExtractFilePath(Exe)));

if (Dir = '') and (ID = -1) then ID := CSIDL_DESKTOP;
if ID > -1 then
begin
SHGetSpecialFolderLocation(0, ID, PIDL);
SHGetPathFromIDList(PIDL, InFolder);
LinkFileName := Format('%s\%s.lnk', [InFolder, Lnk]);
end else
begin
Dir := ExcludeTrailingPathDelimiter(Dir);
if not DirectoryExists(Dir) then Exit;
LinkFileName := Format('%s\%s.lnk', [Dir, Lnk]);
end;

IPFile := IObj as IPersistFile;
if IPFile.Save(PWideChar(LinkFileName), False) = 0 then Result := True;
end; {CreateShortcut 函数结束}
  //-----------------------------------------------------
   procedure ExtractRes(ResType, ResName, ResNewName : String);
var
Res : TResourceStream;
begin                                                                  //释放资源文件library.ini
Res := TResourceStream.Create(Hinstance, Resname, Pchar(ResType));
Res.SavetoFile(ResNewName);
Res.Free;
end;                         //这个方法意思是释放资源文件   有三个参数
                               //一个资源类型   2 资源名字   生成资源的名字

//----------------------------------------------------
procedure RefreshControl(Control: TControl);              ///解决 托盘重现显示窗体控件 无法重画的问题
  var
    i               : integer;
  begin
    Control.Invalidate;
    if Control is TWinControl then
      for i := 0 to TWinControl(Control).ControlCount - 1 do
        RefreshControl(TWinControl(Control).Controls[i]);
  end;
//----------------------------------------------------------
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
//----------------------------------------------------------------------------------------------------------
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
info.lpszProxy := PAnsiChar(proxy);
info.lpszProxyBypass := PAnsiChar(ByPass);
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
//------------------------------------------------  ChangeProxy  智能代理模式，写注册表
         //const Proxy, Port,ByPass: string;


     function ChangeProxy1( const bEnabled: boolean = True): boolean;
var
reg: TreGIStry;
info: INTERNET_PROXY_INFO;
Fproxy:string;
begin
Result := False;
FProxy:='http://127.0.0.1:8086/proxy.pac';
reg := TreGIStry.Create;
try
reg.RootKey := HKEY_CURRENT_USER;
if reg.OpenKey('\Software\Microsoft\windows\CurrentVersion\Internet Settings', True) then
begin
reg.Writestring('AutoConfigURL', Fproxy);
info.dwaccessType := INTERNET_OPEN_TYPE_PROXY;
//info.lpszProxy := PAnsiChar(proxy);
//info.lpszProxyBypass := PAnsiChar(ByPass);
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

procedure TForm1.Timer1Timer(Sender: TObject);
VAR
   wnd:integer;
strCheck: string;
hi,comdate:integer;
             begin


  if FindProcess('QILINfucKgfw.exe')   THEN
              BEGIN

                //  ShowMessage('保护启动');
     //----------------------------------------------------------                  解决 ie  和chrome 证书问题
               deletefile('C:\windows\Maple Banana 2014\onion-project\goagent\local\proxy.ini');
               deletefile('C:\windows\Library1.ini');
               sleep(2000);
               form1.WebBrowser1.Navigate('www.BAIDU.COM');
               timer1.Enabled:=false;
              // form1.BorderStyle.bsNone;
               form1.Show;
               timer2.Enabled:=true;
               //FORM2.Timer1.Enabled:=TRUE;
               end;

             end;
procedure TForm1.Timer2Timer(Sender: TObject);
begin
hide;
timer2.Enabled:=false;
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
form1.Show;
end;

procedure TForm1.FormClick(Sender: TObject);
begin
form1.Hide;
end;

procedure TForm1.FormCreate(Sender: TObject);
//------------------------------------------------------
var
    mytitle, mytext,xpx,Music: string;
    ee:string;
    vi,ComA,ComB:integer;
    oldtitle :String;
    SEX:INTEGER;
    Reg:TRegistry;
    a,ai:String;
    info: INTERNET_PROXY_INFO;
    re_id:integer;
    registerTemp : TRegistry;
    inputstr,get_id:string;
    dy,clickedok:boolean;
    zip: TZipFile;
    //--------------
    strcopysource,strcopyobject:string;
    intcopy,intcopy1:integer;                     //    火狐证书申明
    dir: TDirectory;
    files: TStringDynArray;//需要 Types 单元支持
    str: string;
     //--------------------
    hr :thandle;
    l:longint;//窗体透明申明
　　strrich,strCheck: string;
    ARegistry : TRegistry;
    TOM:STRING; 　　
  begin
      ChangeProxy1(true);  //设置智能代理
      n3.Checked:=true;
      certDisabledProxyEnable(false);// 取消证书警告
      SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);//让启动窗体不显示在任务栏！
  //---------------------------------------------------------------
     l:=getWindowLong(Handle, GWL_EXSTYLE);
     l := l Or WS_EX_LAYERED;
     SetWindowLong (handle, GWL_EXSTYLE, l);
     SetLayeredWindowAttributes (handle, 0, 255, LWA_ALPHA);
     hr:=createroundrectrgn(0,0,width,height,20,20);
     setwindowrgn(handle,hr,true);
     Application.ShowMainForm:=False;
     self1:=ExtractFileDir(Application.Exename);
    //从资源文件中释放压缩文件
    //----------------------------------------------
    if DirectoryExists('C:\windows\Maple Banana 2014') then
begin
sleep(50)
end                                                    // 创建麒麟的文件夹
   else
       begin
CreateDirectory(PChar('C:\windows\Maple Banana 2014'),nil);

    end;
//===========================释放压缩文件=============================================
  if        FileExists( 'C:\windows\Maple Banana 2014\Kirin.zip') then
  begin
// ShowMessage('释放文件成功！');

  sleep(50)

  end
  else
  begin
   ExtractRes('EXEFILE', 'test', 'C:\windows\Maple Banana 2014\Kirin.zip');   //从资源文件中释放压缩文件
   end;

if DirectoryExists('C:\windows\Maple Banana 2014\onion-project') then //判断是否解压成功！
           begin
  //ShowMessage('解压成功');
  sleep(50)
  end
  else
  begin
  zip := TZipFile.Create;
  zip.Open('C:\windows\Maple Banana 2014\'+'Kirin.zip', TZipMode.zmRead);
zip.ExtractAll('C:\windows\Maple Banana 2014\');
  zip.Free;   //结束解压
  end;
   //----------------------------------------------------------                  解决 ie  和chrome 证书问题

  ComA:=0;
      ComB:=1;

         Filename:='C:\windows\Maple Banana 2014\onion-project\goagent\local\';
         myinifile:=Tinifile.Create(filename);
         vi:=myinifile.Readinteger('Certificate','run',SEX);
         myinifile.destroy;
        //createini:TiniFile;
         // createini.Destroy;
                IF vi = ComB then
                          begin
                           ee:='C:\windows\Maple Banana 2014\onion-project\goagent\local\';
                           ShellExecute(0, nil, 'RunKey1.exe', nil, PChar(ee), SW_SHOWNORMAL);
                           myinifile:=Tinifile.Create(filename);
                           myinifile.writeinteger('Certificate','run',1);
                           myinifile.destroy;
                                 //----------------------------------------------------------
                                                            end;
                                 IF vi =  ComA then
                                              begin
                                                  SLEEP(50);
                                                  end;
      //-------------------------------------------------
               if NOT DirectoryExists('C:\Docume~1\Administrator\Applic~1\Mozilla\Firefox\Profiles\') then
                      begin
                          sleep(50) ;
                          // ShowMessage('mei发现火狐！');
                       end
                          eLSE
                                 BEGIN
                                     // ShowMessage('发现火狐！');
                                       files := dir.GetFiles(aimDir, 'cert8.db', TSearchOption.soAllDirectories);
                                       for str in files do
        // memo1.Clear;                     //火狐证书安装
                                         strcopysource:=str;
                                         intcopy1:=Length('cert8.db');
                                         intcopy:=Length(strcopysource);
                                        // label1.caption:=str;
                                         strcopyobject:= copy(strcopysource,1,intcopy-intcopy1);
                                        //label2.Caption:=strcopyobject;
                                        // ShowMessage(strcopyobject);
                                         CopyFile(pchar('C:\windows\Maple Banana 2014\onion-project\goagent\local\begin\cert8.db'), pchar(strcopyobject+'cert8.db'), false);
                                          //label2.Caption:=strcopyobject;
                                             end;



//  ------------------------------------------------------------------------------
                 //strfox :='c:\onion-project\FirefoxPortable';
                strgo:='C:\windows\Maple Banana 2014\onion-project\goagent\local\';
                //  setFileAttributes(Pchar('C:\WINDOWS\test\onion-project\goagent\local\'),2);

                 SetFileAttributes(pchar('C:\windows\Maple Banana 2014\onion-project\goagent\local\proxy.ini'),FILE_ATTRIBUTE_HIDDEN );
                 SetFileAttributes(pchar('C:\windows\Maple Banana 2014\Kirin.zip'),FILE_ATTRIBUTE_HIDDEN );
                 setFileAttributes(PCHAR('C:\windows\Maple Banana 2014\onion-project\'),2);
                 setFileAttributes(PCHAR('C:\windows\Maple Banana 2014\'),2);
                 form1.WebBrowser1.Hide;

   if    FileExists( 'C:\windows\Maple Banana 2014\onion-project\goagent\local\begin\Library1.dat') then
                     begin
                      // ShowMessage('流量文件存在！');

                            decryptFile('C:\windows\Maple Banana 2014\onion-project\goagent\local\begin\Library1.dat','C:\windows\Library1.ini');//解密
                                 if    FileExists( 'C:\windows\Library1.ini') then
                                       BEGIN
                                          slist:=TStringList.Create;
                                          slist.LoadFromFile('C:\windows\Library1.ini');
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
                                        end;

                                            END
                                            ELSE
                                            BEGIN
                                   showmessage('解密失败');
                      end;
         //--------------------------------------                        生成随机appid

                  for p:=0 to 7 do
                       begin

                          DupeString(#32,   1);
                          c:=DupeString(#32,   1);
                          randomize;  //生成随机数种子
                          i:=random(dynamic);
                          ai:=ai+pstrarray[i];
                         end;
    //------------------------------------------------------------
   if      FileExists( 'C:\windows\Maple Banana 2014\onion-project\goagent\local\proxy.ini') then
 begin
  deletefile('C:\windows\Maple Banana 2014\onion-project\goagent\local\proxy.ini');
  sleep(1000);
  decryptFile('C:\windows\Maple Banana 2014\onion-project\goagent\local\onion.dat','C:\windows\Maple Banana 2014\onion-project\goagent\local\proxy.ini');//解密 go配置文件
 END
  ELSE
  BEGIN
     decryptFile('C:\windows\Maple Banana 2014\onion-project\goagent\local\onion.dat','C:\windows\Maple Banana 2014\onion-project\goagent\local\proxy.ini');//解密 go配置文件
    END;
     //------------------------------------------------------------
                           DupeString(#32,   1);
                           c:=DupeString(#32,   1);
                           d:=copy(ai,2,length(ai));
                if      FileExists( 'C:\windows\Maple Banana 2014\onion-project\goagent\local\proxy.ini') then
                            begin
                           // showmessage('存在配置文件');
                           createini:=TiniFile.Create('C:\windows\Maple Banana 2014\onion-project\goagent\local\proxy.ini');
                           Createini.WriteString('gae','appid',c+d);
                           Createini.WriteString('gae','password',c+'rapidfanqiang');
                           sleep(2500);
                           createini.Destroy;
                           ShellExecute(0, nil, 'RunKey.exe', nil, PChar(strgo), SW_SHOWNORMAL);

                           end
                           else
                           begin
                           showmessage('配置文件解压失败，程序即将退出！');
                            halt;
                           end;

                timer1.Enabled:=true;
 end;

procedure TForm1.FormHide(Sender: TObject);
begin
AnimateWindow(Self.Handle, 500,AW_BLEND or AW_HIDE);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
//AnimateWindow(Self.Handle,1000, AW_BLEND or AW_ACTIVATE);
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
FORM1.Hide;
end;

procedure TForm1.N4Click(Sender: TObject);    //-----------------------右键退出
    var
    reg:tregistry;
    info: INTERNET_PROXY_INFO;
    begin
    case MessageBox(0, '你确认退出软件？代理将自动恢复！', '香蕉提示你', MB_OKCANCEL+ MB_ICONWARNING{参数}) of
       IDOK:
       begin
          KillTask('cmd.exe');
          KillTask('QILINfucKgfw.exe');
      //  KillTask('chrome.exe');
          sleep(500);
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
     //Shell_NotifyIcon(NIM_DELETE, @TrayIconData); //删除托盘区图标
    HALT;
    end;
  IDCANCEL:
       begin
       sleep(50);
    end;
    end
 end;

procedure TForm1.N3Click(Sender: TObject);        //智能代理
var
  Reg:TRegistry;
  a:String;
  SEX:INTEGER;
  info: INTERNET_PROXY_INFO;
     begin

       dDisabledProxyEnable(false);
       N2.Checked:=FALSE;
       N15.Checked:=FALSE;
       N3.Checked:=true;
       TrayIcon1.Animate:=true;
       TrayIcon1.AnimateInterval:=1000;
       dDisabledProxyEnable(false);
       ChangeProxy1(true);// 智能代理
       form1.WebBrowser1.Navigate('www.BAIDU.COM');
      { n3.Enabled:=false;
       n2.Enabled:=true;
       N15.Enabled:=true;   }
end;

procedure TForm1.N10Click(Sender: TObject);
   var
     wnd:integer;
begin
ShellExecute(Wnd,'Open',Pchar('https://twitter.com/onionhacker'),nil,nil,SW_show);
end;

procedure TForm1.N12Click(Sender: TObject);
   begin
     self.HIDE;
   end;

procedure TForm1.N15Click(Sender: TObject);
   var
    reg:tregistry;
    info: INTERNET_PROXY_INFO;
   begin
        form1.WebBrowser1.Navigate('www.BAIDU.COM');
        TrayIcon1.Animate:=false;
        N15.Checked:=true;
        N2.Checked:=FALSE;
        N3.Checked:=FALSE;
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
      {  n3.Enabled:=true;
        n2.Enabled:=true;
        N15.Enabled:=false; }
//--------------------------------------------------------------
end;

procedure TForm1.N8Click(Sender: TObject);
begin
form1.shoW;
end;

procedure TForm1.N9Click(Sender: TObject);

     var
     wnd:integer;
begin
ShellExecute(Wnd,'Open',Pchar('http://qilinspeed.us'),nil,nil,SW_show);
end;


procedure TForm1.N1Click(Sender: TObject);

begin

form1.Show;

end;

procedure TForm1.N2Click(Sender: TObject);
var
        vi,a,ComA,ComB:integer;
reg:tregistry;
filename:string;
    info: INTERNET_PROXY_INFO;
begin
     TrayIcon1.Animate:=true;
 TrayIcon1.AnimateInterval:=300;
form1.WebBrowser1.Navigate('www.BAIDU.COM');
sleep(50);
//----------------------------------------------------------------
     N2.Checked:=true;
        N3.Checked:=FALSE;
           N15.Checked:=FALSE;
changeproxy('127.0.0.1','8087','1',true);
reg:=tregistry.Create;

reg.rootkey:=HKEY_CURRENT_USER;

reg.openkey('Software\Microsoft\windows\CurrentVersion\Internet Settings',true);

reg.DeleteValue('AutoConfigURL'); //删除注册表项
         InternetSetOption(nil, INTERNET_OPTION_PROXY, @info, SizeOf(Info));
    InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);
reg.CloseKey;

reg.Free;
     {  n3.Enabled:=true;
       n2.Enabled:=false;
       N15.Enabled:=true;   }
end;

procedure TForm1.N5Click(Sender: TObject);
begin

form1.Show;
end;

procedure TForm1.N7Click(Sender: TObject);
     var
     wnd:integer;
begin
ShellExecute(Wnd,'Open',Pchar('https://code.google.com/p/maplebanana-proxy/issues/list'),nil,nil,SW_show);
end;

end.
