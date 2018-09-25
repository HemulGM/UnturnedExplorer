unit BetweenID;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFormBID = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    EditBegin: TEdit;
    EditEnd: TEdit;
    Label2: TLabel;
    ButtonCancel: TButton;
    ButtonOK: TButton;
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    class function GetBID(var IDB, IDE:Integer):Boolean;
  end;

var
  FormBID: TFormBID;

implementation

{$R *.dfm}

procedure TFormBID.ButtonOKClick(Sender: TObject);
begin
 ModalResult:=mrOk;
end;

class function TFormBID.GetBID(var IDB, IDE: Integer): Boolean;
begin
 Result:=False;
 with TFormBID.Create(Application) do
  begin
   EditBegin.Text:=IntToStr(IDB);
   EditEnd.Text:=IntToStr(IDE);
   if ShowModal = mrOK then
    begin
     try
      IDB:=StrToInt(EditBegin.Text);
      IDE:=StrToInt(EditEnd.Text);
      Result:=True;
     except
      Exit;
     end;
    end;
  end;
end;

end.
