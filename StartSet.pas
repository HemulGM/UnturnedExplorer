unit StartSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls;

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
    procedure AutoSearch;
  end;

var
  FormStartSet: TFormStartSet;

implementation

uses
  Main, UnturnedIDB;

{$R *.dfm}

procedure TFormStartSet.AutoSearch;
var
  path: string;
begin
  LabelResult.Caption := 'Поиск...';
  Application.ProcessMessages;
  Sleep(500);
  if LookUnturnedPath(path) then
  begin
    EditHandlePath.Text := path;
    LabelResult.Caption := 'Всё ок. Путь к игре найден и вставлен в поле. Нажмите "Готово"';
   //ShowMessage('Всё ок. Путь к игре найден и вставлен в поле');
  end
  else
  begin
    LabelResult.Caption := 'Путь к игре не найден. Пожалуйста, укажите путь вручную';
   //ShowMessage('Путь к игре не найден. Пожалуйста, укажите путь вручную');
  end;
end;

procedure TFormStartSet.Button1Click(Sender: TObject);
begin
  if FileOpenDialogApp.Execute then
  begin
    EditHandlePath.Text := ExtractFilePath(FileOpenDialogApp.FileName);
  end;
end;

procedure TFormStartSet.Button2Click(Sender: TObject);
begin
  AutoSearch;
end;

procedure TFormStartSet.FormShow(Sender: TObject);
begin
  Application.ProcessMessages;
  LabelResult.Caption := '';
  if EditHandlePath.Text = '' then
    AutoSearch;
end;

end.

