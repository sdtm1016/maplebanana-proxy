unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Wininet,Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,shellapi,
  Vcl.Imaging.jpeg,TLhelp32;

type
  TForm2 = class(TForm)
    Timer1: TTimer;
    Timer2: TTimer;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
      uses Unit1, Unit3;
{$R *.dfm}

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

procedure TForm2.FormCreate(Sender: TObject);
begin
SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);//让启动窗体不显示在任务栏！

    AnimateWindow(Self.Handle,500, AW_BLEND or AW_ACTIVATE);
SetWindowPos(Handle,HWND_TOPMOST,Left,Top,Width,Height,SWP_SHOWWINDOW);



  sleep(2000);

end;

procedure TForm2.FormHide(Sender: TObject);
VAR
   wnd:integer;
   begin
     // ShellExecute(Wnd,'Open',Pchar('https://www.twitter.com/onionhacker'),nil,nil,SW_show);

AnimateWindow(Self.Handle, 1500,AW_BLEND or AW_HIDE);
end;

procedure TForm2.FormShow(Sender: TObject);
//---------------------------------------------解决任务栏窗体无法隐藏的问题，xe下专用代码！
var
Style: Integer;
begin
Style := GetWindowLong(Handle, GWL_EXSTYLE);
SetWindowLong(Handle, GWL_EXSTYLE, Style and (not WS_EX_APPWINDOW));

ShowWindow(Application.Handle, SW_HIDE);
//---------------------------------------------解决任务栏窗体无法隐藏的问题，xe下专用代码！
  AnimateWindow(Self.Handle,1000, AW_BLEND or AW_ACTIVATE);
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
form2.show;



  timer2.Enabled:=true;

FORM2.timer1.Enabled:=false;
end;

procedure TForm2.Timer2Timer(Sender: TObject);
begin
//------------------------------------------------------

    //-----------------------------------------------------------


  HIDE;
timer2.Enabled:=false;
end;

end.
