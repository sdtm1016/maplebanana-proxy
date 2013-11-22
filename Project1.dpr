
program Project1;

uses
  windows,
  Forms,
  shellapi,
  Dialogs,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Unit4 in 'Unit4.pas' {Form4};

{$R *.res}
var
myMutex:HWND;

begin



   //CreateMutex建立互斥对象，并且给互斥对象起一个唯一的名字。
myMutex:=CreateMutex(nil,false,'lokOngled10Co0py');
//程序没有被运行过
if WaitForSingleObject(myMutex,0)<>wait_TimeOut then
    begin
  Application.Title := '麒麟网络加速器2013';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm4, Form4);
  Application.ShowMainForm := false;
  Application.Run;
  end;
end.
