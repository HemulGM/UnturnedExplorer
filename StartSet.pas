unit StartSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFormStartSet = class(TForm)
    EditHandlePath: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
    Bevel2: TBevel;
    ButtonOK: TButton;
    Button2: TButton;
    FileOpenDialogApp: TFileOpenDialog;
    LabelResult: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormStartSet: TFormStartSet;

implementation
 uses Main, UnturnedIDB;

{$R *.dfm}

procedure TFormStartSet.Button1Click(Sender: TObject);
begin
 if FileOpenDialogApp.Execute then
  begin
   EditHandlePath.Text:=ExtractFilePath(FileOpenDialogApp.FileName);
  end;
end;

procedure TFormStartSet.Button2Click(Sender: TObject);
var path:string;
begin
 if LookUnturnedPath(path) then
  begin
   EditHandlePath.Text:=path;
   LabelResult.Caption:='Всё ок. Путь к игре найден и вставлен в поле';
   //ShowMessage('Всё ок. Путь к игре найден и вставлен в поле');
  end
 else
  begin
   LabelResult.Caption:='Путь к игре не найден. Пожалуйста, укажите путь вручную';
   //ShowMessage('Путь к игре не найден. Пожалуйста, укажите путь вручную');
  end;
end;

procedure TFormStartSet.FormShow(Sender: TObject);
begin
 LabelResult.Caption:='';
end;

end.
