unit MapPrev;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin;

type
  TFormMap = class(TForm)
    ScrollBox1: TScrollBox;
    ImageMap: TImage;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    procedure ImageMapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageMapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageMapMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMap: TFormMap;
  MoveMap:Boolean;
  OldPosX, OldPosY:Integer;
  Zoom:Double = 1;

implementation

{$R *.dfm}

procedure TFormMap.ImageMapMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 OldPosX:=Mouse.CursorPos.X;
 OldPosY:=Mouse.CursorPos.Y;
 MoveMap:=True;
end;

procedure TFormMap.ImageMapMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if MoveMap then
  begin
   ScrollBox1.HorzScrollBar.Position:=ScrollBox1.HorzScrollBar.Position+(OldPosX-Mouse.CursorPos.X);
   ScrollBox1.VertScrollBar.Position:=ScrollBox1.VertScrollBar.Position+(OldPosY-Mouse.CursorPos.Y);

   OldPosX:=Mouse.CursorPos.X;
   OldPosY:=Mouse.CursorPos.Y;
  end;
end;

procedure TFormMap.ImageMapMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 MoveMap:=False;
end;

procedure TFormMap.ToolButton1Click(Sender: TObject);
begin
 //in
 Zoom:=Zoom + 0.05;
 ImageMap.Height:=Round(ImageMap.Picture.Height * Zoom);
 ImageMap.Width:=Round(ImageMap.Picture.Width * Zoom);
 ToolButton3.Caption:=IntToStr(Round(Zoom * 100));
end;

procedure TFormMap.ToolButton2Click(Sender: TObject);
begin
 //out
 Zoom:=Zoom - 0.05;
 ImageMap.Height:=Round(ImageMap.Picture.Height * Zoom);
 ImageMap.Width:=Round(ImageMap.Picture.Width * Zoom);
 ToolButton3.Caption:=IntToStr(Round(Zoom * 100));
end;

procedure TFormMap.ToolButton3Click(Sender: TObject);
begin
 Zoom:=1;
 ImageMap.Height:=Round(ImageMap.Picture.Height * Zoom);
 ImageMap.Width:=Round(ImageMap.Picture.Width * Zoom);
 ToolButton3.Caption:=IntToStr(Round(Zoom * 100));
end;

end.
