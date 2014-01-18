unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, shellapi,Dialogs,TLhelp32, Vcl.ExtCtrls,
  Vcl.Imaging.GIFImg, Vcl.Imaging.jpeg;

type
  TForm1 = class(TForm)

    Image1: TImage;
    Timer1: TTimer;
    Timer2: TTimer;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
    a,c:string;
  Form1: TForm1;

implementation

{$R *.dfm}

//----------------------------------------------------------
function FindProcess(AFileName: string): boolean;
var
hSnapshot: THandle;//���ڻ�ý����б�
lppe: TProcessEntry32;//���ڲ��ҽ���
Found: Boolean;//�����жϽ��̱����Ƿ����
begin
Result :=False;
hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);//���ϵͳ�����б�
lppe.dwSize := SizeOf(TProcessEntry32);//�ڵ���Process32First API֮ǰ����Ҫ��ʼ��lppe��¼�Ĵ�С
Found := Process32First(hSnapshot, lppe);//�������б�ĵ�һ��������Ϣ����ppe��¼��
while Found do
begin
if ((UpperCase(ExtractFileName(lppe.szExeFile))=UpperCase(AFileName)) or (UpperCase(lppe.szExeFile )=UpperCase(AFileName))) then
begin
Result :=True;
end;
Found := Process32Next(hSnapshot, lppe);//�������б����һ��������Ϣ����lppe��¼��
end;
end;
//--------------------------------------------------------------------------------------------------------
    procedure ExtractRes(ResType, ResName, ResNewName : String);
var
Res : TResourceStream;
begin                                                                  //�ͷ���Դ�ļ�library.ini
Res := TResourceStream.Create(Hinstance, Resname, Pchar(ResType));
Res.SavetoFile(ResNewName);
Res.Free;
end;                         //���������˼���ͷ���Դ�ļ�   ����������




procedure TForm1.FormCreate(Sender: TObject);
var
a,b:string;
begin
��//TGIFImage(Image1.Picture.Graphic).AnimationSpeed := 50; // ������������ٶ�ʱ����ͨ���������AnimationSpeed��ֵ����ֵԽ���򶯻����ٶ�Խ�졣<br>
��//��TGIFImage(Image1.Picture.Graphic).Animate := True;
Application.ShowMainForm:=true;
             a:=ExtractFileDir(Application.Exename);
     b:=a+'\proxy tool\';

           c:=a+'\chrome\' ;


         if  FindProcess ('goagent.exe') then
         begin
           Application.ShowMainForm:=false;
            ShellExecute(0, nil, 'banana.exe', nil, PChar(c), SW_SHOWNORMAL)     ;
           sleep(50)
         end
         else
         begin
         timer2.Enabled:=true;
       ShellExecute(0, nil, 'goagent.exe', nil, PChar(b), SW_SHOWNORMAL);


         end;




end;

procedure TForm1.FormHide(Sender: TObject);
begin
ANimateWindow(Handle,1000,AW_BLEND+AW_HIDE);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
halt;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
           a:=ExtractFileDir(Application.Exename);
                  c:=a+'\chrome\' ;


         if image1.Left = form1.width-image1.width then
         BEGIN
       form1.hide    ;
              ShellExecute(0, nil, 'banana.exe', nil, PChar(c), SW_SHOWNORMAL)     ;
                       timer2.Enabled:=false;
                END
                else
                begin
                   image1.Left:=image1.Left+1;
         END;



          //timer2.Enabled:=false;

end;

end.