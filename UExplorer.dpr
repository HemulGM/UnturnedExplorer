program UExplorer;

uses
  Vcl.Forms,
  Main in 'Main.pas' {FormMain},
  Vcl.Themes,
  Vcl.Styles,
  StartSet in 'StartSet.pas' {FormStartSet};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Slate Classico');
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormStartSet, FormStartSet);
  Application.Run;
end.
