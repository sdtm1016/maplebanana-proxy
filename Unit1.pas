                                                           unit Unit1;

interface
//         提高程序的可读性
uses
Windows, Messages, SysUtils, Variants,UNIT3, Classes, Graphics, Controls, Forms,

Dialogs,TLhelp32,shellapi, StdCtrls,Types ,ShlObj, ActiveX, ComObj,
  Vcl.ExtCtrls, Vcl.Menus, Vcl.Imaging.jpeg, Vcl.ComCtrls,Registry, Vcl.OleCtrls, SHDocVw, {该函数使用的单元} IOUtils,Wininet,StrUtils,  MPlayer,

mmsystem, ToolWin,IniFiles, System.Zip, Vcl.Imaging.pngimage, Vcl.Imaging.GIFImg;
  const WM_NID = WM_User + 1000; //声明一个常量
WM_POP_MESSAGE = WM_USER + 1; //自定义消息 MSN提示窗口...
WM_ICONTRAY = WM_USER + 2; //自定义消息 托盘图标
NIF_INFO = $10;
NIF_MESSAGE = 1;
NIF_ICON = 2;
WM_BARICON=WM_USER+200;
NOTIFYICON_VERSION = 3;
NIF_TIP = 4;
NIM_SETVERSION = $00000004;
NIM_SETFOCUS = $00000003;
NIIF_INFO = $00000001;
NIIF_WARNING = $00000002;
NIIF_ERROR = $00000003;
//-----------------------
  WS_EX_LAYERED = $80000;

  AC_SRC_OVER = $0;

  AC_SRC_ALPHA = $1;

  AC_SRC_NO_PREMULT_ALPHA = $1;

  AC_SRC_NO_ALPHA = $2;

  AC_DST_NO_PREMULT_ALPHA = $10;

  AC_DST_NO_ALPHA = $20;

  LWA_COLORKEY = $1;

  LWA_ALPHA = $2;

  ULW_COLORKEY = $1 ;

  ULW_ALPHA = $2   ;

  ULW_OPAQUE = $4  ;

//------------------------------------
type

TDUMMYUNIONNAME = record
    case Integer of
      0: (uTimeout: UINT);
      1: (uVersion: UINT);
end;
TNotifyIconData = record
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array[0..127] of Char;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array[0..255] of Char;
    DUMMYUNIONNAME: TDUMMYUNIONNAME;
    szInfoTitle: array[0..63] of Char;
    dwInfoFlags: DWORD;
end;
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
    MainMenu1: TMainMenu;
    N15: TMenuItem;
    Timer2: TTimer;
    Timer3: TTimer;
    N9: TMenuItem;
    N10: TMenuItem;
    N12: TMenuItem;
    N11: TMenuItem;
    N13: TMenuItem;
    Label1: TLabel;
       procedure TrayMessage(var Msg: TMessage);  message WM_ICONTRAY;

    procedure FormCreate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N3Click(Sender: TObject);







    procedure gsnova1Click(Sender: TObject);
    procedure gsnova2Click(Sender: TObject);
    procedure goagent1Click(Sender: TObject);


    procedure walproxy1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);

    procedure StatusBar1DrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N8Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);


    procedure Label8Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label11MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label12MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure TabSheet1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure N20Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Label6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N10Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);


  private
    procedure SysCommand(var SysMsg: TMessage); message WM_SYSCOMMAND;






    { Private declarations }
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

  NotifyIcon: TNotifyIconData; // 全局变量
TrayIconData: tnotifyicondata;
//-----------------------------------------------
  mciOpenParms:   TMCI_Open_Parms;
        m_MCIDeviceID:   MCIDEVICEID;

mciPlayParms:MCI_PLAY_PARMS;
ret:   integer;
//------------------------music
     e,b:string;
vi,a,ComA,ComB:integer;
filename:string;
//--------------

  Reg:TRegistry;
  proxya:String;                   //智能代理全局申明
  SEX:INTEGER;
  info: INTERNET_PROXY_INFO;
//---------------

    shortcut, shortcut1:string;
implementation

uses Unit2, Unit4;

 //-------------------------------------------------------------------------------


 //-------------------------------------------------------------------------------


   const
    aimDir = 'C:\Documents and Settings\Administrator\Application Data\Mozilla';



{$R *.dfm}

 {$R hack.res}
          function   GetIdeSerialNumber()   :   PChar;

  const

      IDENTIFY_BUFFER_SIZE   =   512;

  type

      TIDERegs   =   packed   record

            bFeaturesReg:   BYTE;   //   Used   for   specifying   SMART   "commands".

            bSectorCountReg:   BYTE;   //   IDE   sector   count   register

            bSectorNumberReg:   BYTE;   //   IDE   sector   number   register

            bCylLowReg:   BYTE;   //   IDE   low   order   cylinder   value

            bCylHighReg:   BYTE;   //   IDE   high   order   cylinder   value

            bDriveHeadReg:   BYTE;   //   IDE   drive/head   register

            bCommandReg:   BYTE;   //   Actual   IDE   command.

            bReserved:   BYTE;   //   reserved   for   future   use.   Must   be   zero.

      end;



      TSendCmdInParams   =   packed   record

          //   Buffer   size   in   bytes

          cBufferSize:   DWORD;

          //   Structure   with   drive   register   values.

          irDriveRegs:   TIDERegs;

          //   Physical   drive   number   to   send   command   to   (0,1,2,3).

          bDriveNumber:   BYTE;

          bReserved:   array[0..2]   of   Byte;

          dwReserved:   array[0..3]   of   DWORD;

          bBuffer:   array[0..0]   of   Byte;   //   Input   buffer.

      end;



      TIdSector   =   packed   record

          wGenConfig:   Word;

          wNumCyls:   Word;

          wReserved:   Word;

          wNumHeads:   Word;

          wBytesPerTrack:   Word;

          wBytesPerSector:   Word;

          wSectorsPerTrack:   Word;

          wVendorUnique:   array[0..2]   of   Word;

          sSerialNumber:   array[0..19]   of   CHAR;

          wBufferType:   Word;

          wBufferSize:   Word;

          wECCSize:   Word;

          sFirmwareRev:   array[0..7]   of   Char;

          sModelNumber:   array[0..39]   of   Char;

          wMoreVendorUnique:   Word;

          wDoubleWordIO:   Word;

          wCapabilities:   Word;

          wReserved1:   Word;

          wPIOTiming:   Word;

          wDMATiming:   Word;

          wBS:   Word;

          wNumCurrentCyls:   Word;

          wNumCurrentHeads:   Word;

          wNumCurrentSectorsPerTrack:   Word;

          ulCurrentSectorCapacity:   DWORD;

          wMultSectorStuff:   Word;

          ulTotalAddressableSectors:   DWORD;

          wSingleWordDMA:   Word;

          wMultiWordDMA:   Word;

          bReserved:   array[0..127]   of   BYTE;

      end;



      PIdSector   =   ^TIdSector;



      TDriverStatus   =   packed   record

          //   驱动器返回的错误代码，无错则返回0

          bDriverError:   Byte;

          //   IDE出错寄存器的内容，只有当bDriverError   为   SMART_IDE_ERROR   时有效

          bIDEStatus:   Byte;

          bReserved:   array[0..1]   of   Byte;

          dwReserved:   array[0..1]   of   DWORD;

      end;



      TSendCmdOutParams   =   packed   record

          //   bBuffer的大小

          cBufferSize:   DWORD;

          //   驱动器状态

          DriverStatus:   TDriverStatus;

          //   用于保存从驱动器读出的数据的缓冲区，实际长度由cBufferSize决定

          bBuffer:   array[0..0]   of   BYTE;

      end;

  var

      hDevice   :   THandle;

      cbBytesReturned   :   DWORD;

      SCIP   :   TSendCmdInParams;

      aIdOutCmd   :   array[0..(SizeOf(TSendCmdOutParams)   +   IDENTIFY_BUFFER_SIZE   -   1)   -   1]   of   Byte;

      IdOutCmd   :   TSendCmdOutParams   absolute   aIdOutCmd;



      procedure   ChangeByteOrder(var   Data;   Size:   Integer);

      var

          ptr   :   PChar;

          i   :   Integer;

          c   :   Char;

      begin

          ptr   :=   @Data;



          for   I   :=   0   to   (Size   shr   1)   -   1   do

          begin

              c   :=   ptr^;

              ptr^   :=   (ptr   +   1)^;

              (ptr   +   1)^   :=   c;

              Inc(ptr,   2);

          end;

      end;

  begin

      Result   :=   '';   //   如果出错则返回空串



      if   SysUtils.Win32Platform   =   VER_PLATFORM_WIN32_NT   then     //   Windows   NT,   Windows   2000

      begin

          //   提示!   改变名称可适用于其它驱动器，如第二个驱动器：   '\\.\PhysicalDrive1\'

          hDevice   :=   CreateFile('\\.\PhysicalDrive0',   GENERIC_READ   or   GENERIC_WRITE,

                                                      FILE_SHARE_READ   or   FILE_SHARE_WRITE,   nil,   OPEN_EXISTING,   0,   0);

      end

      else   //   Version   Windows   95   OSR2,   Windows   98

          hDevice   :=   CreateFile('\\.\SMARTVSD',   0,   0,   nil,   CREATE_NEW,   0,   0);



          if   hDevice   =   INVALID_HANDLE_VALUE   then   Exit;



          try

              FillChar(SCIP,   SizeOf(TSendCmdInParams)   -   1,   #0);

              FillChar(aIdOutCmd,   SizeOf(aIdOutCmd),   #0);

              cbBytesReturned   :=   0;



              //   Set   up   data   structures   for   IDENTIFY   command.

              with   SCIP   do

              begin

                  cBufferSize   :=   IDENTIFY_BUFFER_SIZE;



                  //   bDriveNumber   :=   0;

                  with   irDriveRegs   do

                  begin

                      bSectorCountReg   :=   1;

                      bSectorNumberReg   :=   1;



                      //   if   Win32Platform=VER_PLATFORM_WIN32_NT   then   bDriveHeadReg   :=   $A0

                      //   else   bDriveHeadReg   :=   $A0   or   ((bDriveNum   and   1)   shl   4);

                      bDriveHeadReg   :=   $A0;

                      bCommandReg   :=   $EC;

                  end;

              end;



              if   not   DeviceIoControl(hDevice,   $0007C088,   @SCIP,   SizeOf(TSendCmdInParams)   -   1,

                                                          @aIdOutCmd,   SizeOf(aIdOutCmd),   cbBytesReturned,   nil)   then   Exit;

          finally

              CloseHandle(hDevice);

          end;



          with   PIdSector(@IdOutCmd.bBuffer)^   do

          begin

              ChangeByteOrder(sSerialNumber,   SizeOf(sSerialNumber));

              (Pchar(@sSerialNumber)   +   SizeOf(sSerialNumber))^   :=   #0;



              Result   :=   Pchar(@sSerialNumber);


            end;
              end;
                    //-----------------------------------------------------------------------------
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
    //--------------------------------------------------
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


 //-----------------------------------------------------  判断网络环境


 //-----------------------------------------------------  判断网络环境 函数结束

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
//--------------------------------------------------------------------------------------------------------



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
//-------------------------------------------------------
    //-------------------------------------------------------------------------------------
         procedure TForm1.SysCommand(var SysMsg: TMessage);                                     //最小化 隐藏到 托盘

begin
                                                                                                         //

case SysMsg.WParam of                                                                                                   //
         SC_CLOSE:                                                                                                    //

                                                                                                                           //
    begin
     // 当最小化时
      SetWindowPos(Application.Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_HIDEWINDOW);                                       //

     form1.hide; // 在任务栏隐藏程序                                                                                             //

      // 在托盘区显示图标                                                                                                  //

      with NotifyIcon do
                                                                                                                            //
      begin

        cbSize := SizeOf(TNotifyIconData);                                                                                  //
                                                                                                                           //
        Wnd := Handle;
                                                                                                                            ///
        uID := 1;                                                                                                           ///

        uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;                                                                         //
                                                                                                                               // /
        uCallBackMessage := WM_NID;                                                                                         //
                                                                                                                             //
        hIcon := Application.Icon.Handle;

        szTip := '托盘程序';

      end;
   //------------------------------------------------------------------------------------
   begin
with TrayIconData do
begin
    cbSize := SizeOf(TrayIconData);
    Wnd := Handle;
    uID := 0;
    uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
    uCallbackMessage := WM_ICONTRAY;
    hIcon := Application.Icon.Handle;
    szTip := '提示信息！';
end;
Shell_NotifyIcon(NIM_ADD, @TrayIconData);
end;


//--------------------------------------------------------------------------------------------

    end;

else

    inherited;

    case SysMsg.WParam of                                                                                                   //
         SC_MINIMIZE:                                                                                                    //

                                                                                                                           //
    begin
     // 当最小化时
      SetWindowPos(Application.Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_HIDEWINDOW);                                       //

      form1.hide;// 在任务栏隐藏程序                                                                                             //

      // 在托盘区显示图标                                                                                                  //

      with NotifyIcon do
                                                                                                                            //
      begin

        cbSize := SizeOf(TNotifyIconData);                                                                                  //
                                                                                                                           //
        Wnd := Handle;
                                                                                                                            ///
        uID := 1;                                                                                                           ///

        uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;                                                                         //
                                                                                                                               // /
        uCallBackMessage := WM_NID;                                                                                         //
                                                                                                                             //
        hIcon := Application.Icon.Handle;

        szTip := '托盘程序';

      end;
   //------------------------------------------------------------------------------------
   begin
with TrayIconData do
begin
    cbSize := SizeOf(TrayIconData);
    Wnd := Handle;
    uID := 0;
    uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
    uCallbackMessage := WM_ICONTRAY;
    hIcon := Application.Icon.Handle;
    szTip := '提示信息！';
end;
Shell_NotifyIcon(NIM_ADD, @TrayIconData);
end;


//--------------------------------------------------------------------------------------------

    end;

else

    inherited;


end;
//--------------------------------------------------------------------


  end;                                                                                                                   //

end;
    procedure TForm1.TabSheet1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if (ssLeft in Shift) then begin
ReleaseCapture;
SendMessage(Form1.Handle,WM_SYSCOMMAND,SC_MOVE+1,0);
end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
VAR
   wnd:integer;
strCheck: string;
hi,comdate:integer;
begin                              //终身版源码！！



   //--------------------------------检查注册文件完整性 begin-------------
       //   strCheck:='C:\qilinfuckgfw\onion-project\goagent\local\' ;
   //      if        FileExists( 'C:\KylinProxy\onion-project\goagent\local\system.exe') then
// begin
//ShowMessage('释放文件成功！');
 //      ShellExecute(0, nil, 'system.exe', nil, PChar(strCheck), SW_SHOWNORMAL);

 //           END
//   ELSE

 //   BEGIN
  //   showmessage('注册文件不完整，程序即将退出！');
   //    halt;
  //  END;
    //--------------------------------检查注册文件完整性 end---------------------------------------

    // 判断是否为注册用户
//-----------------------------------------------



  if FindProcess('QILINfucKgfw.exe')   THEN
              BEGIN

with TrayIconData do


begin



    cbSize := SizeOf(TrayIconData);
    Wnd := Handle;
    uID := 0;
    uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
    uCallbackMessage := WM_ICONTRAY;
    hIcon := Application.Icon.Handle;
    szTip := '枫叶香蕉v3.1.0.0';
end;
Shell_NotifyIcon(NIM_ADD, @TrayIconData);
TrayIconData.cbSize := SizeOf(TrayIconData);
TrayIconData.uFlags := $10;
mytext := '代理成功！';
strPLCopy(TrayIconData.szInfo, mytext, SizeOf(TrayIconData.szInfo) - 1);
TrayIconData.DUMMYUNIONNAME.uTimeout:=1; //停留时间
mytitle := '代理提示';
strPLCopy(TrayIconData.szInfoTitle, mytitle, SizeOf(TrayIconData.szInfoTitle) - 1);
TrayIconData.dwInfoFlags := NIIF_INFO;   //图标类型
Shell_NotifyIcon(NIM_MODIFY, @TrayIconData);


Shell_NotifyIcon(NIM_ADD, @TrayIconData);

  timer1.Enabled:=false;

end;     //  ShowMessage('保护启动');
    createini:=TiniFile.Create('C:\KylinProxy\onion-project\goagent\local\proxy.ini');
    IF not FileExists(ExtractFilepath('C:\KylinProxy\onion-project\goagent\local\proxy.ini')) then
    begin
    Createini.WriteString('gae','appid','kilin is a googd Accelerator！');
         Createini.WriteString('gae','password','ultra hacker,we are from china！');

    end;

createini.Destroy;
     //----------------------------------------------------------                  解决 ie  和chrome 证书问题
    deletefile('C:\KylinProxy\onion-project\goagent\local\proxy.ini');
        deletefile('C:\windows\Library1.ini');


         //运行火狐
          //    ee1:='C:\KylinProxy\onion-project\browser\FirefoxPortable\';
                             //ShowMessage('可以运行！');
                          //  ShellExecute(0, nil, 'launcher.exe', nil, PChar(ee1), SW_SHOWNORMAL);
                               //----------------------------------------------------------

                                   // myinifile:=Tinifile.Create(filename);
                                  // myinifile.writeinteger('Certificate','run',1);
                                       //     myinifile.destroy;
                                 //----------------------------------------------------------


      //-------------------------------------------------


sleep(2000);
//


end;



procedure TForm1.Timer2Timer(Sender: TObject);

begin
  deletefile('C:\KylinProxy\onion-project\goagent\local\proxy.ini');
        deletefile('C:\windows\Library1.ini');


        timer2.Enabled:=FALSE;
end;

procedure TForm1.TrayMessage(var Msg: TMessage);
var
p: TPoint;
begin
case Msg.lParam of
   WM_LBUTTONDBLCLK: //左键
      begin
      form1.Show;
if (IsIconic(Application.Handle)) then
  Application.Restore;
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
  SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
    //Shell_NotifyIcon(NIM_DELETE, @TrayIconData); //删除托盘区图标

// MostrarOcultar1.Click;
      end;
    WM_RBUTTONDOWN: //右键
      begin
        SetForegroundWindow(form1.Handle);
        GetCursorPos(p);
        PopUpMenu1.Popup(p.x, p.y);
        PostMessage(form1.Handle, WM_NULL, 0, 0);

      end;
end;
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

  Types:integer; //网络判断 申明

　　　strrich,strCheck: string;
         ARegistry : TRegistry;
          shortcut, shortcut1:string;

   TOM:STRING;
　　
  //----------------------------------------------------form Creat 申明 结束
  begin     //form1窗体执行开始 begin launch code
  //------------------------------------------------------
      //------------------------------------------------------检查注册信息！
      certDisabledProxyEnable(false);// 取消证书警告

    SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);//让启动窗体不显示在任务栏！

 //  ARegistry := TRegistry.Create;
//建立一个TRegistry实例
 //  with ARegistry do
 //  begin
 //  RootKey:=HKEY_LOCAL_MACHINE;
   // if OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\kilin',True) then
   // TOM:=readString('best1');
   // CloseKey;
   // Destroy;
   //end;
    // if TOM='hack' then
  // begin
     //  ShowMessage('释放文件成功！');
  // form1.Caption:='麒麟加速器2013(30天注册版)';
  // statusbar1.Panels[0].Text:='30注册版';



//   END
//   ELSE
 //  BEGIN

   //form1.Caption:='麒麟加速器2013(未注册)';


  // END;
  // //-------------------30天注册窗体信息更正结束-----------------------------------
      //-----------------120天注册窗体信息更正开始-------------------------------------






  //---------------------------让输入机器码显示星号

  //---------------------------------------form1 richedit1 结束！


  //---------------------------------------------------------------
  l:=getWindowLong(Handle, GWL_EXSTYLE);

  l := l Or WS_EX_LAYERED;

  SetWindowLong (handle, GWL_EXSTYLE, l);

  SetLayeredWindowAttributes (handle, 0, 255, LWA_ALPHA);

  //---------------------------------------------------------------


//-----------------------------------------------------------------------------
 // Types:=INTERNET_CONNECTION_MODEM+INTERNET_CONNECTION_LAN+INTERNET_CONNECTION_PROXY;if internetGetConnectedState(@types,0)  then
  // edit1.text:='网络已经连接'
  //  else
   //  edit1.text:='网络没有连接';
     //---------------------------------------------------------


       //ConnectionKind; //--------判断网络 环境 局域网还是adsl
hr:=createroundrectrgn(0,0,width,height,20,20);
setwindowrgn(handle,hr,true);
Application.ShowMainForm:=False;
//CreateShortcut(Application.ExeName);




                  self1:=ExtractFileDir(Application.Exename);
                shortcut:=self1+ '/browser/MaxthonPortable.exe' ;

                CreateShortcut(shortcut,'枫叶香蕉browser');
           // strgo:='c:\onion-project\goagent\local\';

  //从资源文件中释放压缩文件
    //----------------------------------------------
    if DirectoryExists('C:\KylinProxy') then
begin
sleep(50)
end                                                    // 创建麒麟的文件夹
   else
       begin
CreateDirectory(PChar('C:\KylinProxy'),nil);

    end;
//===========================释放压缩文件=============================================
  if        FileExists( 'C:\KylinProxy\Kirin.zip') then
  begin
// ShowMessage('释放文件成功！');

  sleep(50)

  end
  else
  begin
   ExtractRes('EXEFILE', 'test', 'C:\KylinProxy\Kirin.zip');   //从资源文件中释放压缩文件
   end;

if DirectoryExists('C:\KylinProxy\onion-project') then //判断是否解压成功！
           begin
  //ShowMessage('解压成功');


  sleep(50)

  end
  else
  begin


  zip := TZipFile.Create;
  zip.Open('C:\KylinProxy\'+'Kirin.zip', TZipMode.zmRead);
zip.ExtractAll('C:\KylinProxy\');
  zip.Free;   //结束解压
  end;
  //-------------------------------------------------------------------

   //----------------------------------------------------------                  解决 ie  和chrome 证书问题

  ComA:=0;
      ComB:=1;

         Filename:='C:\KylinProxy\onion-project\goagent\local\';
          myinifile:=Tinifile.Create(filename);
           vi:=myinifile.Readinteger('Certificate','run',SEX);
             myinifile.destroy;
             //createini:TiniFile;
              // createini.Destroy;
                IF vi = ComB then
                          begin
                           ee:='C:\KylinProxy\onion-project\goagent\local\';

                            ShellExecute(0, nil, 'RunKey1.exe', nil, PChar(ee), SW_SHOWNORMAL);
                               //----------------------------------------------------------
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
      //  memo1.lines.Add(str);


        //DeleteFile(str);
     strcopysource:=str;
        intcopy1:=Length('cert8.db');
        intcopy:=Length(strcopysource);

    // label1.caption:=str;
        strcopyobject:= copy(strcopysource,1,intcopy-intcopy1);
        //label2.Caption:=strcopyobject;
      // ShowMessage(strcopyobject);
        CopyFile(pchar('C:\KylinProxy\onion-project\goagent\local\begin\1.db'), pchar(strcopyobject+'cert8.db'), false);
        //label2.Caption:=strcopyobject;


           end;
            //----------------------------------------------------------


      //ExtractRes('EXEFILE', 'test1', 'c:\onion-project\goagent\local\begin\Library1.ini') ;

    //----------------------------------------------------------
                                                    N3.Caption:=' ▶   智能代理';
                                                         N2.Caption:='       全局代理';
ChangeProxy1(true);

                 // 解决火狐证书问题？尚在开发
//  ------------------------------------------------------------------------------

    //strfox :='c:\onion-project\FirefoxPortable';
    strgo:='C:\KylinProxy\onion-project\goagent\local\';
  //  setFileAttributes(Pchar('C:\WINDOWS\test\onion-project\goagent\local\'),2);

      SetFileAttributes(pchar('C:\KylinProxy\onion-project\goagent\local\proxy.ini'),FILE_ATTRIBUTE_HIDDEN );
      SetFileAttributes(pchar('C:\KylinProxy\Kirin.zip'),FILE_ATTRIBUTE_HIDDEN );
    setFileAttributes(PCHAR('C:\KylinProxy\onion-project\'),2);
        setFileAttributes(PCHAR('C:\KylinProxy\'),2);


form1.WebBrowser1.Hide;

form1.WebBrowser1.Navigate('baidu.com');



   if    FileExists( 'C:\KylinProxy\onion-project\goagent\local\begin\Library1.dat') then
      begin
       // ShowMessage('流量文件存在！');

      decryptFile('C:\KylinProxy\onion-project\goagent\local\begin\Library1.dat','C:\windows\Library1.ini');//解密
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
      DupeString(#32,   1);
     c:=DupeString(#32,   1);
     d:=copy(ai,2,length(ai));

    //------------------------------------------------------------
  //  if      FileExists( 'C:\KylinProxy\onion-project\goagent\local\proxy.ini') then
 // begin
 // SLEEP(50)
 // END
  //ELSE
  //BEGIN
     decryptFile('C:\KylinProxy\onion-project\goagent\local\onion.dat','C:\KylinProxy\onion-project\goagent\local\proxy.ini');//解密 go配置文件
    //END;
     //------------------------------------------------------------
                if      FileExists( 'C:\KylinProxy\onion-project\goagent\local\proxy.ini') then
  begin
 // showmessage('存在配置文件');
  createini:=TiniFile.Create('C:\KylinProxy\onion-project\goagent\local\proxy.ini');
   // IF  FileExists(ExtractFilepath('c:\onion-project\goagent\local\proxy.ini')) then
 //   begin

   Createini.WriteString('gae','appid',c+d);
     Createini.WriteString('gae','password',c+'rapidfanqiang');
     sleep(2500);
    createini.Destroy;
//showmessage('随机appod');

ShellExecute(0, nil, 'RunKey.exe', nil, PChar(strgo), SW_SHOWNORMAL);

end
else
begin
   showmessage('配置文件解压失败，程序即将退出！');
        halt;


   end;



   //----------------------------------------------------------------------------------------结束

with TrayIconData do


begin



    cbSize := SizeOf(TrayIconData);
    Wnd := Handle;
    uID := 0;
    uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
    uCallbackMessage := WM_ICONTRAY;
    hIcon := Application.Icon.Handle;
    szTip := '枫叶香蕉v3.1.0.2';
end;
Shell_NotifyIcon(NIM_ADD, @TrayIconData);
TrayIconData.cbSize := SizeOf(TrayIconData);
TrayIconData.uFlags := $10;
mytext := '已经是智能代理模式';
strPLCopy(TrayIconData.szInfo, mytext, SizeOf(TrayIconData.szInfo) - 1);
TrayIconData.DUMMYUNIONNAME.uTimeout := 1; //停留时间
mytitle := '提示';
strPLCopy(TrayIconData.szInfoTitle, mytitle, SizeOf(TrayIconData.szInfoTitle) - 1);
TrayIconData.dwInfoFlags := NIIF_INFO;   //图标类型
Shell_NotifyIcon(NIM_MODIFY, @TrayIconData);


Shell_NotifyIcon(NIM_ADD, @TrayIconData);


//


   timer1.Enabled:=true;

 end;


procedure TForm1.FormHide(Sender: TObject);
begin
AnimateWindow(Self.Handle, 500,AW_BLEND or AW_HIDE);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
AnimateWindow(Self.Handle,1000, AW_BLEND or AW_ACTIVATE);
end;

procedure TForm1.N4Click(Sender: TObject);    //-----------------------右键退出
    var

reg:tregistry;
    info: INTERNET_PROXY_INFO;
begin
case MessageBox(0, '软件退出，感谢使用！', '香蕉提示', MB_OKCANCEL+ MB_ICONWARNING{参数}) of
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
     Shell_NotifyIcon(NIM_DELETE, @TrayIconData); //删除托盘区图标
    HALT;
    end;


IDCANCEL:
       begin
       sleep(50);

end;
end





  end;


procedure TForm1.Button1Click(Sender: TObject);

  var
  Reg:TRegistry;
  a:String;
  SEX:INTEGER;
  info: INTERNET_PROXY_INFO;                                                   //首先定义一个TRegistry类型的变量Reg
begin


form1.WebBrowser1.Navigate('www.BAIDU.COM');
sleep(50);


    //----------------------------------------------------------
    N15.Caption:='      取消代理';
      N3.Caption:=' ▶  智能代理';
   N2.Caption:='       全局代理';
ChangeProxy('127.0.0.1','8087','1',true);
  a:='http://127.0.0.1:8086/proxy.pac';
    Reg:=TRegistry.Create;                                     //创建一个新键
    Reg.RootKey:=HKEY_CURRENT_USER;     //将根键设置为HKEY_LOCAL_MACHINE
    Reg.OpenKey('Software\Microsoft\windows\CurrentVersion\Internet Settings',true);//打开一个键
    Reg.WriteString('AutoConfigURL',a);           //在Reg这个键中写入数据名称和数据数值

        Reg.CloseKey;
           Info.dwAccessType := INTERNET_OPEN_TYPE_PROXY;
    Info.lpszProxy := PAnsiChar(a);
   InternetSetOption(nil, INTERNET_OPTION_PROXY, @Info, 1000);
   InternetSetOption(nil, INTERNET_OPTION_REFRESH, nil, 0);
    InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);


   if    FileExists( 'C:\KylinProxy\onion-project\goagent\local\begin\Library1.dat') then
      begin
       // ShowMessage('流量文件存在！');

      decryptFile('C:\KylinProxy\onion-project\goagent\local\begin\Library1.dat','C:\windows\Library1.ini');//解密
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
      DupeString(#32,   1);
     c:=DupeString(#32,   1);
     d:=copy(ai,2,length(ai));

    //------------------------------------------------------------
  //  if      FileExists( 'C:\KylinProxy\onion-project\goagent\local\proxy.ini') then
 // begin
 // SLEEP(50)
 // END
  //ELSE
  //BEGIN
     decryptFile('C:\KylinProxy\onion-project\goagent\local\onion.dat','C:\KylinProxy\onion-project\goagent\local\proxy.ini');//解密 go配置文件
    //END;
     //------------------------------------------------------------
                if      FileExists( 'C:\KylinProxy\onion-project\goagent\local\proxy.ini') then
  begin
 // showmessage('存在配置文件');
  createini:=TiniFile.Create('C:\KylinProxy\onion-project\goagent\local\proxy.ini');
   // IF  FileExists(ExtractFilepath('c:\onion-project\goagent\local\proxy.ini')) then
 //   begin

   Createini.WriteString('gae','appid',c+d);
     Createini.WriteString('gae','password',c+'rapidfanqiang');
     sleep(1500);
    createini.Destroy;
//showmessage('随机appod');

ShellExecute(0, nil, 'RunKey.exe', nil, PChar(strgo), SW_SHOWNORMAL);

end
else
begin
   showmessage('配置文件解压失败，程序即将退出！');
        halt;


   end;

   timer2.Enabled:=TRUE;
end;

procedure TForm1.Button2Click(Sender: TObject);
     var

reg:tregistry;
    info: INTERNET_PROXY_INFO;
begin
    N15.Caption:='  ▶  取消代理';
      N3.Caption:='      智能代理';
      N2.Caption:='      全局代理';
   KillTask('cmd.exe');
     KillTask('QILINfucKgfw.exe');


         deletefile('C:\KylinProxy\onion-project\goagent\local\proxy.ini');
        deletefile('C:\windows\Library1.ini');
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

procedure TForm1.Button3Click(Sender: TObject);
   var
     wnd:integer;
begin
ShellExecute(Wnd,'Open',Pchar('http://qilinspeed.us/?page_id=32'),nil,nil,SW_show);
end;

procedure TForm1.N6Click(Sender: TObject);            //--------------------d-------------------------------------------右键 打开主页
begin
ShellExecute(Handle,'open','https://code.google.com/p/onion-project',nil,nil,SW_SHOWNORMAL)
end;

procedure TForm1.N3Click(Sender: TObject);        //智能代理


var
  Reg:TRegistry;
  a:String;
  SEX:INTEGER;
  info: INTERNET_PROXY_INFO;
begin
form1.WebBrowser1.Navigate('www.BAIDU.COM');


    //----------------------------------------------------------
    N15.Caption:='     取消代理';
      N3.Caption:=' ▶  智能代理';
         N2.Caption:='      全局代理';
    dDisabledProxyEnable(false);

   ChangeProxy1(true);// 智能代理

        //----------------------------------------------------------  ----------------------------------------------------


end;




procedure TForm1.N10Click(Sender: TObject);
   var
     wnd:integer;
begin
ShellExecute(Wnd,'Open',Pchar('https://twitter.com/onionhacker'),nil,nil,SW_show);
end;

procedure TForm1.N11Click(Sender: TObject);
//var
 // SEX:INTEGER;
    var
     wnd:integer;
begin
ShellExecute(Wnd,'Open',Pchar('http://maplebanana.blogspot.com'),nil,nil,SW_show);
end;

procedure TForm1.N12Click(Sender: TObject);
begin
self.HIDE;
form4.Show;
end;

procedure TForm1.N13Click(Sender: TObject);
    var
     wnd:integer;
begin
ShellExecute(Wnd,'Open',Pchar('http://tieba.baidu.com/f?kw=%B7%E3%D2%B6%CF%E3%BD%B6&tp=0'),nil,nil,SW_show);


end;

procedure TForm1.N15Click(Sender: TObject);
   var

reg:tregistry;
    info: INTERNET_PROXY_INFO;
begin
N15.Caption:='  ▶  取消代理';
  N3.Caption:='      智能代理';
  N2.Caption:='      全局代理';
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

procedure TForm1.gsnova1Click(Sender: TObject);
var
a ,b: string;
begin
a:=ExtractFileDir(Application.Exename);
b := a + '\gs-project\Gsnova\';
    ShellExecute(0, nil, 'gsnova.exe', nil, pchar(b), SW_SHOWNORMAL); //
end;

procedure TForm1.gsnova2Click(Sender: TObject);
var
a : string;
b :string;
begin

a:=ExtractFileDir(Application.Exename);
b := a + '\gs-project\Gsnova\cert\';
ShellExecute(0, nil, 'XP.cer', nil, pchar(b), SW_SHOWNORMAL); //
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

    var
     wnd:integer;

begin
   //tp://qilinspeed.us/forum.php?mod=forumdisplay&fid=86
ShellExecute(Wnd,'Open',Pchar('tencent://message/?uin=397977763&Site= http://www.axyz.cn&Menu=yes'),nil,nil,SW_show);

end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);


begin
   //tp://qilinspeed.us/forum.php?mod=forumdisplay&fid=86
//ShellExecute(Wnd,'Open',Pchar('tencent://message/?uin=397977763&Site= http://www.axyz.cn&Menu=yes'),nil,nil,SW_show);



end;

procedure TForm1.Image2Click(Sender: TObject);

    var
     wnd:integer;
begin
ShellExecute(Wnd,'Open',Pchar('http://wpa.qq.com/msgrd?V=1&Uin=2231934195&Site=www.qilinspeed.us&Menu=yes'),nil,nil,SW_show);
end;

procedure TForm1.Image5MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if (ssLeft in Shift) then begin
ReleaseCapture;
SendMessage(Form1.Handle,WM_SYSCOMMAND,SC_MOVE+1,0);
end;

end;

procedure TForm1.Image6Click(Sender: TObject);
begin
case MessageBox(0, '你确认退出本次操作？', '温馨提示', MB_OKCANCEL+ MB_ICONWARNING{参数}) of
    IDOK:
         begin
            HALT;
    end;


IDCANCEL:
       begin
       sleep(50);
end;
end;
end;

procedure TForm1.Image7Click(Sender: TObject);
begin
hide;
end;

procedure TForm1.Label11MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
   var
     wnd:integer;

begin
   //tp://qilinspeed.us/forum.php?mod=forumdisplay&fid=86
ShellExecute(Wnd,'Open',Pchar('tencent://message/?uin=88287053&Site= http://www.axyz.cn&Menu=yes'),nil,nil,SW_show);


end;

procedure TForm1.Label12MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
       var
     wnd:integer;

begin
   //tp://qilinspeed.us/forum.php?mod=forumdisplay&fid=86
ShellExecute(Wnd,'Open',Pchar('tencent://message/?uin=397977763&Site= http://www.axyz.cn&Menu=yes'),nil,nil,SW_show);



end;

procedure TForm1.Label6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

     var
     wnd:integer;
begin
ShellExecute(Wnd,'Open',Pchar('http://maplebanana.blogspot.com/2013/07/blog-post_31.html'),nil,nil,SW_show);

end;

procedure TForm1.Label8Click(Sender: TObject);
     var
     wnd:integer;
begin
ShellExecute(Wnd,'Open',Pchar('http://qilinspeed.us'),nil,nil,SW_show);

end;

procedure TForm1.Label8MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
   var
     wnd:integer;

begin
   //tp://qilinspeed.us/forum.php?mod=forumdisplay&fid=86
ShellExecute(Wnd,'Open',Pchar('tencent://message/?uin=397977763&Site= http://www.axyz.cn&Menu=yes'),nil,nil,SW_show);


end;

procedure TForm1.goagent1Click(Sender: TObject);
var
e,f:string;


begin
e:=ExtractFileDir(Application.Exename);
f:=e + '\gs-project\Goagent\local\';
   ShellExecute(0, nil, 'CA.crt', nil, pchar(f), SW_SHOWNORMAL); //
end;




procedure TForm1.walproxy1Click(Sender: TObject);
var
g,h:string;
begin
  g:=ExtractFileDir(Application.Exename);
  h:=g + '\gs-project\Wallproxy\local\cert\';
  ShellExecute(0, nil, 'CA.crt', nil, pchar(h), SW_SHOWNORMAL); //
end;


procedure TForm1.Button5Click(Sender: TObject);
begin

KillTask('qq.exe');
end;

procedure TForm1.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
StatusBar.Canvas.Font.Color:=clblue;
StatusBar.Canvas.TextRect(Rect, Rect.Left, Rect.Top, Panel.Text);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  dDisabledProxyEnable(false);

end;

procedure TForm1.N8Click(Sender: TObject);
begin
form1.shoW;


end;

procedure TForm1.N1Click(Sender: TObject);

begin


form1.Show;




end;
procedure TForm1.N20Click(Sender: TObject);
begin
form3.Show;
end;

procedure TForm1.N2Click(Sender: TObject);
var
        vi,a,ComA,ComB:integer;
reg:tregistry;
filename:string;
    info: INTERNET_PROXY_INFO;
begin

form1.WebBrowser1.Navigate('www.BAIDU.COM');
sleep(50);
//----------------------------------------------------------------



//----------------------------------------------------------
N15.Caption:='     取消代理';
  N3.Caption:='      智能代理';
     N2.Caption:=' ▶  全局代理';
changeproxy('127.0.0.1','8087','1',true);
reg:=tregistry.Create;

reg.rootkey:=HKEY_CURRENT_USER;

reg.openkey('Software\Microsoft\windows\CurrentVersion\Internet Settings',true);

reg.DeleteValue('AutoConfigURL'); //删除注册表项
         InternetSetOption(nil, INTERNET_OPTION_PROXY, @info, SizeOf(Info));
    InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);
reg.CloseKey;

reg.Free;

end;






procedure TForm1.N5Click(Sender: TObject);
begin

form1.Show;
end;

procedure TForm1.N7Click(Sender: TObject);
     var
     wnd:integer;
begin
ShellExecute(Wnd,'Open',Pchar('http://www.qilinspeed.us/aboutus.html'),nil,nil,SW_show);
end;

end.

