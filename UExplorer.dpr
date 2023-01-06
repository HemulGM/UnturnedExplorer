program UExplorer;

uses
  Vcl.Forms,
  Main in 'Main.pas' {FormMain},
  Vcl.Themes,
  Vcl.Styles,
  StartSet in 'StartSet.pas' {FormStartSet},
  Main.MD5 in '..\UnturnedServer\Main.MD5.pas',
  UServer.CommonFunc in '..\UnturnedServer\UServer.CommonFunc.pas',
  UnturnedIDB in 'UnturnedIDB.pas',
  HGM.SQLang in '..\SQLite\HGM.SQLang.pas',
  HGM.SQLite in '..\SQLite\HGM.SQLite.pas',
  HGM.SQLite.Wrapper in '..\SQLite\HGM.SQLite.Wrapper.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Проводник Unturned';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormStartSet, FormStartSet);
  FormMain.Show;
  Application.ProcessMessages;
  if FormMain.OpenMaster then
    FormMain.PathMaster;
  FormMain.UBase.PathFrom := FormMain.AppPath;
  FormMain.GetAllItems;
  Application.Run;
end.

