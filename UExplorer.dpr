program UExplorer;

uses
  Vcl.Forms,
  Main in 'Main.pas' {FormMain},
  StartSet in 'StartSet.pas' {FormStartSet},
  Main.MD5 in '..\UnturnedServer\Main.MD5.pas',
  UServer.CommonFunc in '..\UnturnedServer\UServer.CommonFunc.pas',
  UnturnedIDB in 'UnturnedIDB.pas',
  SQLite3 in '..\SQLite\SQLite3.pas',
  SQLiteTable3 in '..\SQLite\SQLiteTable3.pas',
  SQLLang in '..\SQLite\SQLLang.pas';

{$R *.res}

begin
 Application.Initialize;
 Application.MainFormOnTaskbar:= True;
 Application.Title:= 'Проводник Unturned';
 Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormStartSet, FormStartSet);
  FormMain.Show;
 Application.ProcessMessages;
 if FormMain.OpenMaster then FormMain.PathMaster;
 FormMain.UBase.PathFrom:=FormMain.AppPath;
 FormMain.GetAllItems;
 Application.Run;
end.
