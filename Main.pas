unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IniFiles,
  Vcl.ComCtrls, Vcl.ImgList, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.Menus, Vcl.Imaging.jpeg, Vcl.Styles,
  Data.DB, Vcl.ToolWin, System.ImageList, System.Generics.Collections,
  Vcl.Buttons, sSpeedButton, sPanel, UnturnedIDB, Vcl.Grids, TableDraw, Vcl.Imaging.GIFImg,
  acPNG, sComboBoxes, sColorSelect, Vcl.Clipbrd;

type
  TLoadState = (lsNone, lsLoading, lsLoaded);
  TJumpsControl = procedure(Sender:TObject; JumpData:Integer) of Object;
  TJumps = TList<Integer>;
  TUENavigator = class
   private
    FJumps:TJumps;
    FCurrent:Integer;
    FOnJump:TNotifyEvent;
    FControl:TJumpsControl;
    function FGetCurrent: Integer;
    function GetAllowBack: Boolean;
    function GetAllowNext: Boolean;
    procedure DoJump;
    procedure DoControl;
   public
    procedure Jump(Data:Integer);
    procedure Clear;
    procedure Back;
    procedure Next;
    property GetCurrent:Integer read FGetCurrent;
    property AllowBack:Boolean read GetAllowBack;
    property AllowNext:Boolean read GetAllowNext;
    property Control:TJumpsControl read FControl write FControl;
    property OnJump:TNotifyEvent read FOnJump write FOnJump;
    constructor Create;
  end;
  TLanguage = record
   Version:string;
   Autor:string;
   Desc:string;
   Name:string;
  end;
  TLanguages = TList<TLanguage>;

  TFormMain = class(TForm)
    ImageList24: TImageList;
    PanelMenu: TsPanel;
    SpeedButtonReload: TsSpeedButton;
    SpeedButtonQuit: TsSpeedButton;
    SpeedButtonSettings: TsSpeedButton;
    SpeedButtonVehicles: TsSpeedButton;
    SpeedButtonMain: TsSpeedButton;
    sSpeedButton9: TsSpeedButton;
    SpeedButtonItems: TsSpeedButton;
    SpeedButtonMenu: TsSpeedButton;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    PanelClient: TPanel;
    PageControlMain: TPageControl;
    TabSheetManage: TTabSheet;
    TabSheetItems: TTabSheet;
    Panel1: TPanel;
    Panel4: TPanel;
    TabSheetVehicle: TTabSheet;
    Panel2: TPanel;
    Panel5: TPanel;
    TabSheetSettings: TTabSheet;
    Bevel4: TBevel;
    ButtonApply: TButton;
    TableExItems: TTableEx;
    TableExItemProp: TTableEx;
    Panel6: TPanel;
    PanelItemPic: TPanel;
    LabelDisImage: TLabel;
    ImageItem: TImage;
    PanelItemDesc: TPanel;
    Panel7: TPanel;
    Label9: TLabel;
    EditItemID: TEdit;
    Panel8: TPanel;
    Label13: TLabel;
    EditItemName: TEdit;
    Panel9: TPanel;
    Label14: TLabel;
    EditItemGroup: TEdit;
    TableExVehicles: TTableEx;
    Panel10: TPanel;
    Panel11: TPanel;
    Label15: TLabel;
    ImageVehicle: TImage;
    Panel12: TPanel;
    Panel13: TPanel;
    Label16: TLabel;
    EditVehID: TEdit;
    Panel14: TPanel;
    Label17: TLabel;
    EditVehDesc: TEdit;
    Panel15: TPanel;
    Label18: TLabel;
    EditVehGroup: TEdit;
    OpenDialog: TOpenDialog;
    PanelCtrlInfo: TPanel;
    Shape11: TShape;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Panel19: TPanel;
    EditUnturnedVer: TEdit;
    EditAppVer: TEdit;
    EditUnturnedPath: TEdit;
    Label1: TLabel;
    LabelItemCount: TLabel;
    LabelVehicleCount: TLabel;
    Label24: TLabel;
    TableExVehicleProp: TTableEx;
    PanelCtrlUpdate: TPanel;
    Shape1: TShape;
    Label2: TLabel;
    Label4: TLabel;
    Panel17: TPanel;
    EditOutdated: TEdit;
    EditUVersion: TEdit;
    ButtonChangeAppPath: TsSpeedButton;
    PanelCtrlGuide: TPanel;
    Shape5: TShape;
    Panel20: TPanel;
    Label6: TLabel;
    PanelCtrlAbout: TPanel;
    Shape6: TShape;
    Panel22: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    PanelLoading: TPanel;
    ProgressBarGeneral: TProgressBar;
    LabelCurrentLoad: TLabel;
    ButtonReload: TsSpeedButton;
    SpeedButtonLoadVehImages: TsSpeedButton;
    Panel3: TPanel;
    sSpeedButton1: TsSpeedButton;
    EditSearchItem: TEdit;
    Panel23: TPanel;
    sSpeedButton2: TsSpeedButton;
    EditSearchVehicle: TEdit;
    ComboBoxVehicleGroup: TComboBox;
    ComboBoxItemGroups: TComboBox;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Panel24: TPanel;
    Label8: TLabel;
    Label10: TLabel;
    ButtonLangUnload: TButton;
    FileSaveDialog: TFileSaveDialog;
    Panel25: TPanel;
    SpeedButtonINavBack: TsSpeedButton;
    SpeedButtonINavNext: TsSpeedButton;
    Panel26: TPanel;
    Label11: TLabel;
    Label19: TLabel;
    ComboBoxLang: TComboBox;
    Panel27: TPanel;
    Panel28: TPanel;
    ButtonSetApply: TButton;
    ButtonSetDefault: TButton;
    ButtonSetCancel: TButton;
    Label20: TLabel;
    Label25: TLabel;
    CheckBoxLangShowDef: TCheckBox;
    ColorSelectMain: TsColorSelect;
    Label26: TLabel;
    PanelCtrCllient: TPanel;
    PanelShare: TPanel;
    Shape12: TShape;
    Label27: TLabel;
    Panel18: TPanel;
    EditURL: TEdit;
    SpeedButtonCopyURL: TsSpeedButton;
    ImageShareG: TImage;
    ImageShareF: TImage;
    ImageShareV: TImage;
    ImageShareT: TImage;
    ImageShareTeleg: TImage;
    Edit1: TEdit;
    Label28: TLabel;
    SpeedButtonGame: TsSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonReloadClick(Sender: TObject);
    procedure ButtonChangeAppPathClick(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure SpeedButtonMenuClick(Sender: TObject);
    procedure SpeedButtonQuitClick(Sender: TObject);
    procedure SpeedButtonItemsClick(Sender: TObject);
    procedure SpeedButtonVehiclesClick(Sender: TObject);
    procedure SpeedButtonMainClick(Sender: TObject);
    procedure SpeedButtonSettingsClick(Sender: TObject);
    procedure TableExItemPropGetData(FCol, FRow: Integer; var Value: string);
    procedure TableExItemsGetData(FCol, FRow: Integer; var Value: string);
    procedure TableExItemsItemClick(Sender: TObject; MouseButton: TMouseButton; const Index: Integer);
    procedure TableExItemsDrawCellData(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure TableExItemPropDblClick(Sender: TObject);
    procedure ComboBoxItemGroupsChange(Sender: TObject);
    procedure EditSearchItemKeyPress(Sender: TObject; var Key: Char);
    procedure TableExVehiclesGetData(FCol, FRow: Integer; var Value: string);
    procedure TableExVehiclesItemClick(Sender: TObject; MouseButton: TMouseButton; const Index: Integer);
    procedure SpeedButtonReloadClick(Sender: TObject);
    procedure ComboBoxVehicleGroupChange(Sender: TObject);
    procedure ImageVehicleDblClick(Sender: TObject);
    procedure TableExVehiclesDrawCellData(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure EditSearchVehicleKeyPress(Sender: TObject; var Key: Char);
    procedure TableExVehiclePropGetData(FCol, FRow: Integer; var Value: string);
    procedure SpeedButtonLoadVehImagesClick(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure ButtonLangUnloadClick(Sender: TObject);
    procedure EditSearchVehicleChange(Sender: TObject);
    procedure EditSearchItemChange(Sender: TObject);
    procedure SpeedButtonINavBackClick(Sender: TObject);
    procedure SpeedButtonINavNextClick(Sender: TObject);
    procedure ButtonSetApplyClick(Sender: TObject);
    procedure ButtonSetDefaultClick(Sender: TObject);
    procedure ButtonSetCancelClick(Sender: TObject);
    procedure SpeedButtonCopyURLClick(Sender: TObject);
    procedure ImageShareGClick(Sender: TObject);
    procedure SpeedButtonGameClick(Sender: TObject);
  private
    //settings
    FIncreasingSortItem:Boolean;
    FColumnSortItem:Integer;
    FIncreasingSortVehicle:Boolean;
    FColumnSortVehicle:Integer;
    FLastSRItem:string;
    FLastSRVehicle:string;
    FLang:string;
    FLanguages:TLanguages;
    FMainColor:TColor;
    FShowDefLang:Boolean;
    /////////////////////
    FAppPath: string;
    FLoadState:TLoadState;
    FLoadInfoStr:string;
    procedure OnItemJump(Sender:TObject);
    procedure OnItemJumpCtrl(Sender:TObject; JumpData:Integer);
    procedure FUpdateTableVehicles;
    procedure PanelMenuState(Minimazed: Boolean);
    procedure SetLoadState(Value:TLoadState);
    procedure SetMenuColor(Value: TColor);
    procedure SetMenuIconColor(Color: TColor);
    procedure SetLoadInfoStr(Value:string);
    procedure SetAppPath(const Value: string);
    procedure SelectItem(Index:Integer; Hand:Boolean);
    procedure SetShowDefLang(const Value: Boolean);
  public
    NavItems:TUENavigator;
    UBase:TUnturnedItemBase;
    OpenMaster:Boolean;
    FVehicles:TDisplayDataVehicles;
    FVehicleProp:TItemProperties;
    FItems:TDisplayDataItems;
    FItemGroups:TGroups;
    FVehicleGroups:TGroups;
    FItemProp:TItemProperties;
    function FindItem(ID:Integer):Integer; overload;
    function FindItem(Str:string; Skip:Integer):Integer; overload;
    function FindVehicle(ID: Integer): Integer; overload;
    function FindVehicle(Str:string; Skip:Integer): Integer; overload;
    procedure OnLoadProgress(AMax, APos:Integer; Info:string);
    procedure Quit;
    procedure FUpdateTableItems;
    procedure FUpdateGroups;
    procedure FUpdateTableItemProp;
    procedure FUpdateTableVehicleProp;
    procedure CreateTables;
    procedure GetAllItems;
    procedure UpdateItemsData;
    procedure UpdateVehiclesData;
    function PathMaster:Boolean;
    function LoadSettings:Boolean;
    function SaveSettings:Boolean;
    function ApplySettings:Boolean;
    procedure DefaultSettings;
    procedure PutSettings;
    procedure Page(Tab:TTabSheet);
    procedure Share(Tag:Integer);
    property ShowDefLang:Boolean read FShowDefLang write SetShowDefLang;
    property LoadState:TLoadState read FLoadState write SetLoadState;
    property LoadInfoStr:string read FLoadInfoStr write SetLoadInfoStr;
    property AppPath:string read FAppPath write SetAppPath;
  end;

const
  AppVerMajor = 1;
  AppVerMinor = 1;
  VerPrefix = 'Beta';
  AppTitle = 'Проводник Unturned';
  AppDesc = 'Всегда свежий список ID предметов и транспорта в удобной для вас форме';
  URLApp = 'http://unturned.hemulgm.ru/app_unturned_explorer';
  SteamURL = 'steam://connect/188.234.213.65:27015';

var
  FormMain: TFormMain;
  MPath:string;         //C:\Program Files\Unturned Explorer\
  SettingsFN:string;    //C:\Program Files\Unturned Explorer\UESettings.ini
  DataBaseFN:string;    //C:\Program Files\Unturned Explorer\data.db

implementation
 uses System.Win.Registry, StartSet, Winapi.ShellAPI, UServer.CommonFunc;

{$R *.dfm}

//Замена подстрок
procedure RepVar(var Dest:string; Indent, VarInd:string);
var p:Word;
begin
 repeat
  p:=Pos(Indent, AnsiLowerCase(Dest));
  if p <> 0 then
   begin
    if p = 1 then
     Dest:=VarInd + Copy(Dest, p + Length(Indent), Length(Dest) - (p + Length(Indent)) + 1)
    else Dest:=Copy(Dest, 1, p - 1) + VarInd + Copy(Dest, p + Length(Indent), Length(Dest) - (p + Length(Indent)) + 1)
   end;
 until p = 0;
end;

procedure TFormMain.OnItemJump;
begin
 SpeedButtonINavBack.Enabled:=NavItems.AllowBack;
 SpeedButtonINavNext.Enabled:=NavItems.AllowNext;
end;

procedure TFormMain.OnItemJumpCtrl(Sender: TObject; JumpData: Integer);
var i:Integer;
begin
 i:=FindItem(JumpData);
 if i < 0 then Exit;
 TableExItems.ItemIndex:=i;
 SelectItem(i, False);
end;

procedure TFormMain.OnLoadProgress(AMax, APos: Integer; Info: string);
begin
 ProgressBarGeneral.Max:=AMax;
 ProgressBarGeneral.Position:=APos;
 LabelCurrentLoad.Caption:=Info;
 Repaint;
end;

function TFormMain.LoadSettings:Boolean;
var Ini:TIniFile;
begin
 Result:=True;
 if not FileExists(SettingsFN) then FileClose(FileCreate(SettingsFN));
 Ini:=TIniFile.Create(SettingsFN);
 AppPath:=Ini.ReadString('General', 'UnturnedPath', '');
 FIncreasingSortItem:=Ini.ReadBool('General', 'FIncreasingSortItem', True);
 FIncreasingSortVehicle:=Ini.ReadBool('General', 'FIncreasingSortVehicle', True);
 FColumnSortItem:=Ini.ReadInteger('General', 'FColumnSortItem', 0);
 FColumnSortVehicle:=Ini.ReadInteger('General', 'FColumnSortVehicle', 0);
 FLang:=Ini.ReadString('General', 'Language', '');
 FMainColor:=Ini.ReadInteger('General', 'SkinColor', FMainColor);
 FShowDefLang:=Ini.ReadBool('General', 'ShowDefLang', True);
 Ini.Free;
end;

function TFormMain.SaveSettings:Boolean;
var Ini:TIniFile;
begin
 if not FileExists(SettingsFN) then FileClose(FileCreate(SettingsFN));
 Ini:=TIniFile.Create(SettingsFN);
 Ini.WriteString('General', 'UnturnedPath', AppPath);
 Ini.WriteBool('General', 'FIncreasingSortItem', FIncreasingSortItem);
 Ini.WriteBool('General', 'FIncreasingSortVehicle', FIncreasingSortVehicle);
 Ini.WriteInteger('General', 'FColumnSortItem', FColumnSortItem);
 Ini.WriteInteger('General', 'FColumnSortVehicle', FColumnSortVehicle);
 Ini.WriteString('General', 'Language', FLang);
 Ini.WriteInteger('General', 'SkinColor', FMainColor);
 Ini.ReadBool('General', 'ShowDefLang', FShowDefLang);
 Ini.Free;
 Result:=True;
end;

function TFormMain.ApplySettings;
begin
 Result:=True;
 if FLang <> '' then
 try
  UBase.LoadLang(MPath+'language\'+FLang+'.lang');
 except

 end;
 SetMenuColor(ColorDarker(FMainColor));
 SetMenuIconColor(ColorLighter(FMainColor));
 UBase.ShowDefLang:=ShowDefLang;
end;

function TFormMain.PathMaster:Boolean;
begin
 Result:=False;
 FormStartSet.EditHandlePath.Text:=AppPath;
 if FormStartSet.ShowModal = mrOK then
  begin
   AppPath:=FormStartSet.EditHandlePath.Text;
   if DirectoryExists(AppPath) then
    begin
     Result:=True;
    end;
  end;
end;

procedure TFormMain.PutSettings;
var SR:TSearchRec;
    Item:TLanguage;
    Ini:TIniFile;
    CId, LID:Integer;
begin
 FLanguages.Clear;
 ComboBoxLang.Clear;
 CId:=-1;
 // По умолчанию
 Item.Desc:='По умолчанию';
 Item.Version:='None';
 Item.Autor:='None';
 Item.Name:='';
 LID:=FLanguages.Add(Item);
 if FLang = '' then CId:=LID;
 ComboBoxLang.Items.Add(Item.Desc);
 //
 if FindFirst(MPath+'language\*.lang', faAnyFile, SR) = 0 then
  repeat
   Item.Name:=SR.Name;
   try
    Ini:=TIniFile.Create(MPath+'language\'+SR.Name);
    Item.Desc:=Ini.ReadString('INFO', 'Description', SR.Name);
    Item.Version:=Ini.ReadString('INFO', 'Version', 'None');
    Item.Autor:=Ini.ReadString('INFO', 'Autor', 'None');
    Ini.Free;
   except
    Continue;
   end;
   LID:=FLanguages.Add(Item);
   if CId = -1 then if SR.Name = FLang+'.lang' then CId:=LID;
   ComboBoxLang.Items.Add(Item.Desc);
  until FindNext(SR) <> 0;
 try
  ComboBoxLang.ItemIndex:=CId;
 except
  ComboBoxLang.ItemIndex:=-1;
 end;

 ColorSelectMain.ColorValue:=FMainColor;
 CheckBoxLangShowDef.Checked:=ShowDefLang;
end;

procedure TFormMain.Quit;
begin
 SaveSettings;
 Application.Terminate;
end;

procedure TFormMain.TableExItemPropDblClick(Sender: TObject);
var PID, IID:Integer;
begin
 PID:=TableExItemProp.ItemIndex;
 if not IndexInList(PID, TList(FItemProp)) then Exit;
 if ComboBoxItemGroups.Items.Count > 0 then
  begin
   ComboBoxItemGroups.ItemIndex:=0;
   ComboBoxItemGroupsChange(nil);
  end;
 if FItemProp[PID].IsID then
  begin
   if not TryStrToInt(FItemProp[PID].Value, IID) then Exit;
   IID:=FindItem(IID);
   if IID < 0 then Exit;
   TableExItems.ItemIndex:=IID;
   SelectItem(IID, True);
  end;
end;

procedure TFormMain.TableExItemPropGetData(FCol, FRow: Integer; var Value: string);
begin
 Value:='';
 if FItemProp.Count = 0 then
  begin
   Value:='';
   if FCol = 1 then Value:='Пусто';
   Exit;
  end;
 if not Between(0, FRow, FItemProp.Count - 1) then Exit;

 case FCol of
  0:Value:=FItemProp[FRow].Desc;
  1:Value:=FItemProp[FRow].Value;
 end;
end;

procedure TFormMain.TableExItemsDrawCellData(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var BMP:TBitmap;
begin
 with TableExItems.Canvas do
  begin
   if ACol <> 0 then Exit;
   if not IndexInList(ARow, TList(FItems)) then Exit;
   BMP:=TBitmap.Create;
   if UBase.GetItemIcon(FItems[ARow].IID, BMP) then Draw(REct.Left, Rect.Top, BMP);
   BMP.Free;
  end;
end;

procedure TFormMain.TableExItemsGetData(FCol, FRow: Integer; var Value: string);
begin
 Value:='';
 if FItems.Count = 0 then
  begin
   Value:='';
   if FCol = 1 then Value:='Пусто';
   Exit;
  end;
 if not Between(0, FRow, FItems.Count - 1) then Exit;

 case FCol of
  1:Value:=IntToStr(FRow+1);
  2:Value:=IntToStr(FItems[FRow].ID);
  3:Value:=FItems[FRow].Desc;
  4:Value:=FItems[FRow].Group;
 end;
end;

procedure TFormMain.TableExItemsItemClick(Sender: TObject; MouseButton: TMouseButton; const Index: Integer);
begin
 SelectItem(Index, True);
end;

procedure TFormMain.TableExVehiclePropGetData(FCol, FRow: Integer; var Value: string);
begin
 Value:='';
 if FVehicleProp.Count = 0 then
  begin
   Value:='';
   if FCol = 1 then Value:='Пусто';
   Exit;
  end;
 if not Between(0, FRow, FVehicleProp.Count - 1) then Exit;

 case FCol of
  0:Value:=FVehicleProp[FRow].Desc;
  1:Value:=FVehicleProp[FRow].Value;
 end;
end;

procedure TFormMain.TableExVehiclesDrawCellData(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var BMP:TBitmap;
begin
 with TableExVehicles.Canvas do
  begin
   if ACol <> 0 then Exit;
   if not IndexInList(ARow, TList(FVehicles)) then Exit;
   BMP:=TBitmap.Create;
   if UBase.GetVehicleIcon(FVehicles[ARow].ID, BMP) then Draw(Rect.Left, Rect.Top, BMP);
   BMP.Free;
  end;
end;

procedure TFormMain.TableExVehiclesGetData(FCol, FRow: Integer; var Value: string);
begin
 Value:='';
 if FVehicles.Count = 0 then
  begin
   Value:='';
   if FCol = 1 then Value:='Пусто';
   Exit;
  end;
 if not Between(0, FRow, FVehicles.Count - 1) then Exit;

 case FCol of
  1:Value:=IntToStr(FRow+1);
  2:Value:=IntToStr(FVehicles[FRow].ID);
  3:Value:=FVehicles[FRow].Desc;
  4:Value:=FloatToStr(FVehicles[FRow].Speed);
  5:Value:=FloatToStr(FVehicles[FRow].Fuel);
  6:Value:=FloatToStr(FVehicles[FRow].Health);
  7:Value:=FVehicles[FRow].Group;
 end;
end;

procedure TFormMain.TableExVehiclesItemClick(Sender: TObject; MouseButton: TMouseButton; const Index: Integer);
var BMP:TBitmap;
begin
 if not IndexInList(Index, TList(FVehicles)) then Exit;
 UBase.GetVehicleData(FVehicles[Index].VID, FVehicleProp);
 FUpdateTableVehicleProp;
 EditVehID.Text:=IntToStr(FVehicles[Index].ID);
 EditVehDesc.Text:=FVehicles[Index].Desc;
 EditVehGroup.Text:=FVehicles[Index].Group;
 BMP:=TBitmap.Create;
 if UBase.GetVehicleImage(FVehicles[Index].ID, BMP) then
  ImageVehicle.Picture.Assign(BMP)
 else ImageVehicle.Picture.Assign(nil);
 BMP.Free;
end;

procedure TFormMain.UpdateItemsData;
var GID:Integer;
begin
 GID:=ComboBoxItemGroups.ItemIndex;
 if IndexInList(GID, TList(FItemGroups)) then
  GID:=FItemGroups[GID].GID
 else GID:=-1;
 UBase.GetDataItems(FItems, GID);
 FUpdateTableItems;
end;

procedure TFormMain.UpdateVehiclesData;
var GID:Integer;
begin
 GID:=ComboBoxVehicleGroup.ItemIndex;
 if IndexInList(GID, TList(FVehicleGroups)) then
  GID:=FVehicleGroups[GID].GID
 else GID:=-1;
 UBase.GetDataVehicles(FVehicles, GID);
 FUpdateTableVehicles;
end;

procedure TFormMain.SetLoadState(Value:TLoadState);
begin
 FLoadState:=Value;
 if FLoadState = lsLoaded then
  begin
   LoadInfoStr:='Готово';
   Repaint;
  end;
 PanelLoading.Visible:=FLoadState = lsLoading;
 Repaint;
end;

procedure TFormMain.SetMenuColor(Value:TColor);
var i:Integer;
begin
 PanelMenu.Color:=Value;
 TableExItems.LineSelColor:=Value;
 TableExItemProp.LineSelColor:=Value;
 TableExVehicles.LineSelColor:=Value;
 TableExVehicleProp.LineSelColor:=Value;
 for i:=0 to PanelMenu.ControlCount - 1 do
  begin
   if PanelMenu.Controls[i] is TShape then
    begin
     (PanelMenu.Controls[i] as TShape).Brush.Color:=ColorDarker(Value, 10);
     (PanelMenu.Controls[i] as TShape).Pen.Color:=ColorDarker(Value, 10);
    end;
   if PanelMenu.Controls[i] is TsSpeedButton then
    begin
     (PanelMenu.Controls[i] as TsSpeedButton).Font.Color:=$00E6E6E6;
    end;
  end;
end;

procedure TFormMain.Page(Tab: TTabSheet);
begin
 PageControlMain.ActivePage:=Tab;
 Caption:=AppTitle+' - ['+Tab.Caption+']';
 if Tab = TabSheetSettings then PutSettings;
 PanelMenuState(True);
end;

procedure TFormMain.PanelMenuState(Minimazed:Boolean);
begin
 PanelMenu.BringToFront;
 if Minimazed then PanelMenu.Width:=40 else PanelMenu.Width:=250;
end;

procedure TFormMain.SpeedButtonMenuClick(Sender: TObject);
begin
 PanelMenuState(PanelMenu.Width >= 250);
end;

procedure TFormMain.SelectItem(Index: Integer; Hand: Boolean);
var BMP:TBitmap;
begin
 if not IndexInList(Index, TList(FItems)) then Exit;
 UBase.GetItemData(FItems[Index].IID, FItemProp);
 if Hand then NavItems.Jump(FItems[Index].ID);
 FUpdateTableItemProp;
 EditItemID.Text:=IntToStr(FItems[Index].ID);
 EditItemName.Text:=FItems[Index].Desc;
 EditItemGroup.Text:=FItems[Index].Group;
 BMP:=TBitmap.Create;
 if UBase.GetItemImage(FItems[Index].IID, BMP) then
  ImageItem.Picture.Assign(BMP)
 else ImageItem.Picture.Assign(nil);
 BMP.Free;
end;

procedure TFormMain.SetAppPath(const Value: string);
begin
 FAppPath:= Value;
 EditUnturnedPath.Text:=FAppPath;
end;

procedure TFormMain.SetLoadInfoStr(Value:string);
begin
 LabelCurrentLoad.Caption:=Value;
end;

procedure TFormMain.ButtonLangUnloadClick(Sender: TObject);
begin
 if FileSaveDialog.Execute then UBase.UnloadDataStrings(FileSaveDialog.FileName);
end;

procedure TFormMain.ButtonSetDefaultClick(Sender: TObject);
begin
 if MessageBox(Handle, 'Вы действительно хотите установить все значения по умолчанию?', 'Внимание', MB_ICONWARNING or MB_YESNOCANCEL or MB_DEFBUTTON2) <> IDYES then Exit;
 DefaultSettings;
 PutSettings;
end;

procedure TFormMain.ButtonChangeAppPathClick(Sender: TObject);
begin
 PathMaster;
end;

procedure TFormMain.ButtonReloadClick(Sender: TObject);
begin
 LoadState:=lsLoading;
 try
  UBase.ReloadFrom(AppPath);
  GetAllItems;
 except
  MessageBox(Application.Handle, 'При обновлении базы произошла неизвестная ошибка', '', MB_ICONSTOP or MB_OK);
 end;
 LoadState:=lsLoaded;
end;

procedure TFormMain.ButtonSetApplyClick(Sender: TObject);
begin
 FMainColor:=ColorSelectMain.ColorValue;
 if ComboBoxLang.ItemIndex >= 0 then
  begin
   FLang:=FLanguages[ComboBoxLang.ItemIndex].Name;
   FLang:=Copy(FLang, 1, FLang.Length-5);
  end
 else FLang:='';
 ShowDefLang:=CheckBoxLangShowDef.Checked;
 ApplySettings;
 GetAllItems;
end;

procedure TFormMain.ButtonSetCancelClick(Sender: TObject);
begin
 PutSettings;
end;

procedure TFormMain.ComboBoxItemGroupsChange(Sender: TObject);
begin
 UpdateItemsData;
end;

procedure TFormMain.ComboBoxVehicleGroupChange(Sender: TObject);
begin
 UpdateVehiclesData;
end;

procedure TFormMain.CreateTables;
begin
 with TableExItems do
  begin
   with Columns[0] do
    begin
     Caption:='';
     Width:=32;
    end;
   with Columns[AddColumn] do
    begin
     Caption:='№';
     Width:=50;
    end;
   with Columns[AddColumn] do
    begin
     Caption:='ID';
     Width:=50;
    end;
   with Columns[AddColumn] do
    begin
     Caption:='Описание';
     Width:=100;
    end;
   with Columns[AddColumn] do
    begin
     Caption:='Группа';
     Width:=90;
    end;
   Columns[3].Width:=ClientWidth - (90 + 50 + 32 + 50);
  end;

 with TableExVehicles do
  begin
   with Columns[0] do
    begin
     Caption:='';
     Width:=32;
    end;
   with Columns[AddColumn] do
    begin
     Caption:='№';
     Width:=50;
    end;
   with Columns[AddColumn] do
    begin
     Caption:='ID';
     Width:=50;
    end;
   with Columns[AddColumn] do
    begin
     Caption:='Описание';
     Width:=20;
    end;
   with Columns[AddColumn] do
    begin
     Caption:='Скорость';
     Width:=60;
    end;
   with Columns[AddColumn] do
    begin
     Caption:='Топливо';
     Width:=60;
    end;
   with Columns[AddColumn] do
    begin
     Caption:='Броня';
     Width:=60;
    end;
   with Columns[AddColumn] do
    begin
     Caption:='Группа';
     Width:=90;
    end;
   Columns[3].Width:=ClientWidth - (32 + 50 + 50 + 60 + 60 + 60 + 90);
  end;

 with TableExItemProp do
  begin
   with Columns[0] do
    begin
     Caption:='Описание';
     Width:=60;
    end;
   with Columns[AddColumn] do
    begin
     Caption:='Значение';
     Width:=100;
    end;
   Columns[0].Width:=ClientWidth - 100;
  end;

 with TableExVehicleProp do
  begin
   with Columns[0] do
    begin
     Caption:='Описание';
     Width:=60;
    end;
   with Columns[AddColumn] do
    begin
     Caption:='Значение';
     Width:=100;
    end;
   Columns[0].Width:=ClientWidth - 100;
  end;
end;

procedure TFormMain.DefaultSettings;
begin
 FMainColor:=$00647C64; //$00666666 $00647C64
 FLang:='';
 ShowDefLang:=True;
end;

procedure TFormMain.EditSearchItemChange(Sender: TObject);
var Skip:Integer;
begin
 if EditSearchItem.Text <> '' then
  begin
   if EditSearchItem.Text = FLastSRItem then Skip:=TableExItems.ItemIndex else
    begin
     Skip:=-1;
     FLastSRItem:=EditSearchItem.Text;
    end;
   TableExItems.ItemIndex:=FindItem(FLastSRItem, Skip);
   if TableExItems.ItemIndex >= 0 then SelectItem(TableExItems.ItemIndex, True)
   else
    if TableExItems.ItemIndex <> -1 then
     begin
      TableExItems.ItemIndex:=-1;
      EditSearchItemChange(Sender);
     end;
  end
 else TableExItems.ItemIndex:=-1;
end;

procedure TFormMain.EditSearchItemKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  begin
   Key:=#0;
   EditSearchItemChange(Sender);
  end;
end;

procedure TFormMain.EditSearchVehicleChange(Sender: TObject);
var Skip:Integer;
begin
 if EditSearchVehicle.Text <> '' then
  begin
   if EditSearchVehicle.Text = FLastSRVehicle then Skip:=TableExVehicles.ItemIndex else
    begin
     Skip:=-1;
     FLastSRVehicle:=EditSearchVehicle.Text;
    end;
   TableExVehicles.ItemIndex:=FindVehicle(FLastSRVehicle, Skip);
   if TableExVehicles.ItemIndex >= 0 then TableExVehiclesItemClick(nil, mbLeft, TableExVehicles.ItemIndex)
   else
    if TableExVehicles.ItemIndex <> -1 then
     begin
      TableExVehicles.ItemIndex:=-1;
      EditSearchVehicleChange(Sender);
     end;
  end
 else TableExVehicles.ItemIndex:=-1;
end;

procedure TFormMain.EditSearchVehicleKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  begin
   Key:=#0;
   EditSearchVehicleChange(Sender);
  end;
end;

function TFormMain.FindItem(ID:Integer): Integer;
var i:Integer;
begin
 Result:=-1;
 for i:= 0 to FItems.Count-1 do
  begin
   if FItems[i].ID = ID then
    begin
     Exit(i);
    end;
  end;
end;

function TFormMain.FindItem(Str:string; Skip:Integer): Integer;
var i, r:Integer;
    Str2:string;
begin
 Result:=-1;
 if FItems.Count <= 0 then Exit;
 r:=-1;
 Str:=AnsiLowerCase(Str);
 if Skip = FItems.Count - 1 then Skip:=-1;
 for i:= 0 to FItems.Count - 1 do
  begin
   if i <= Skip then Continue;

   Str2:=AnsiLowerCase(IntToStr(FItems[i].ID));
   if Str = Str2 then Exit(i);
   if r = -1 then if Pos(Str, Str2) <> 0 then r:=i;

   Str2:=AnsiLowerCase(FItems[i].Desc);
   if Str = Str2 then Exit(i);
   if r = -1 then if Pos(Str, Str2) <> 0 then r:=i;
  end;
 if r <> -1 then Result:=r;
end;

function TFormMain.FindVehicle(ID: Integer): Integer;
var i:Integer;
begin
 Result:=-1;
 for i:= 0 to FVehicles.Count-1 do
  begin
   if FVehicles[i].ID = ID then
    begin
     TableExVehicles.ItemIndex:=i;
     TableExVehiclesItemClick(nil, mbLeft, i);
     Exit(i);
    end;
  end;
end;

function TFormMain.FindVehicle(Str:string; Skip:Integer): Integer;
var i, r:Integer;
    Str2:string;
begin
 Result:=-1;
 if FVehicles.Count <= 0 then Exit;
 r:=-1;
 Str:=AnsiLowerCase(Str);
 if Skip = FVehicles.Count - 1 then Skip:=-1;
 for i:= 0 to FVehicles.Count - 1 do
  begin
   if i <= Skip then Continue;

   Str2:=AnsiLowerCase(IntToStr(FVehicles[i].ID));
   if Str = Str2 then Exit(i);
   if r = -1 then if Pos(Str, Str2) <> 0 then r:=i;

   Str2:=AnsiLowerCase(FVehicles[i].Desc);
   if Str = Str2 then Exit(i);
   if r = -1 then if Pos(Str, Str2) <> 0 then r:=i;
  end;
 if r <> -1 then Result:=r;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caNone;
 Quit;
end;

procedure TFormMain.SetMenuIconColor(Color:TColor);
var i:Integer;
begin
 for i:= 0 to ImageList24.Count - 1 do ColorImages(ImageList24, i, Color);
end;

procedure TFormMain.SetShowDefLang(const Value: Boolean);
begin
 FShowDefLang:=Value;
end;

procedure TFormMain.Share(Tag: Integer);
procedure DoShare(link:string);
begin
 ShellExecute(Application.Handle, 'open', PWideChar(link), '', '', SW_NORMAL);
end;
begin
 //https://www.facebook.com/sharer/sharer.php?u=%s
  //https://twitter.com/intent/tweet?url=%s&text=%s
  //https://vk.com/share.php?url=%s&description=%s
  //https://plus.google.com/share?url=%s
 case Tag of
  1: DoShare(Format('https://plus.google.com/share?url=%s', [URLApp]));
  2: DoShare(Format('https://www.facebook.com/sharer/sharer.php?u=%s', [URLApp]));
  3: DoShare(Format('https://vk.com/share.php?url=%s&description=%s', [URLApp, AppTitle]));
  4: DoShare(Format('https://twitter.com/intent/tweet?url=%s&text=%s', [URLApp, AppDesc]));
  5: DoShare(Format('https://telegram.me/share/url?url=%s&text=%s&utm_source=share2', [URLApp, AppDesc]));
 end;
end;

procedure TFormMain.SpeedButtonCopyURLClick(Sender: TObject);
begin
 Clipboard.AsText:=EditURL.Text;
end;

procedure TFormMain.SpeedButtonGameClick(Sender: TObject);
begin
 ShellExecute(Application.Handle, 'open', PWideChar(SteamURL), '', '', SW_NORMAL);
end;

procedure TFormMain.SpeedButtonINavBackClick(Sender: TObject);
begin
 NavItems.Back;
end;

procedure TFormMain.SpeedButtonINavNextClick(Sender: TObject);
begin
 NavItems.Next;
end;

procedure TFormMain.SpeedButtonItemsClick(Sender: TObject);
begin
 Page(TabSheetItems);
end;

procedure TFormMain.SpeedButtonMainClick(Sender: TObject);
begin
 Page(TabSheetManage);
end;

procedure TFormMain.SpeedButtonQuitClick(Sender: TObject);
begin
 Quit;
end;

procedure TFormMain.SpeedButtonReloadClick(Sender: TObject);
begin
 GetAllItems;
end;

procedure TFormMain.SpeedButtonSettingsClick(Sender: TObject);
begin
 Page(TabSheetSettings);
end;

procedure TFormMain.SpeedButtonVehiclesClick(Sender: TObject);
begin
 Page(TabSheetVehicle);
end;

procedure TFormMain.sSpeedButton1Click(Sender: TObject);
begin
 EditSearchItem.Clear;
end;

procedure TFormMain.sSpeedButton2Click(Sender: TObject);
begin
 EditSearchVehicle.Clear;
end;

procedure TFormMain.SpeedButtonLoadVehImagesClick(Sender: TObject);
begin
 LoadState:=lsLoading;
 try
  UBase.LoadVehicleImages;
  GetAllItems;
 except
  MessageBox(Application.Handle, 'При обновлении базы изображений произошла неизвестная ошибка', '', MB_ICONSTOP or MB_OK);
 end;
 LoadState:=lsLoaded;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
 LoadState:=lsNone;
 OpenMaster:=False;
 DefaultSettings;
 CreateTables;
 NavItems:=TUENavigator.Create;
 NavItems.OnJump:=OnItemJump;
 NavItems.Control:=OnItemJumpCtrl;
 NavItems.Clear;
 FItems:=TDisplayDataItems.Create;
 FLanguages:=TLanguages.Create;
 FVehicles:=TDisplayDataVehicles.Create;
 FItemGroups:=TGroups.Create;
 FVehicleGroups:=TGroups.Create;
 FItemProp:=TItemProperties.Create;
 FUpdateTableItemProp;
 FVehicleProp:=TItemProperties.Create;
 FUpdateTableVehicleProp;
 UBase:=TUnturnedItemBase.Create(DataBaseFN);
 UBase.OnProgress:=OnLoadProgress;
 EditURL.Text:=URLApp;
 EditAppVer.Text:=IntToStr(AppVerMajor)+'.'+IntToStr(AppVerMinor);
 if not LoadSettings then OpenMaster:=True
 else
  begin
   if not DirectoryExists(AppPath) then OpenMaster:=True;
  end;
 ApplySettings;
 Page(TabSheetManage);
end;

procedure TFormMain.FUpdateGroups;
var i:Integer;
begin
 ComboBoxItemGroups.Clear;
 for i:= 0 to FItemGroups.Count-1 do
  begin
   ComboBoxItemGroups.Items.Add(FItemGroups[i].Desc);
  end;
 if ComboBoxItemGroups.Items.Count > 0 then ComboBoxItemGroups.ItemIndex:=0;


 ComboBoxVehicleGroup.Clear;
 for i:= 0 to FVehicleGroups.Count-1 do
  begin
   ComboBoxVehicleGroup.Items.Add(FVehicleGroups[i].Desc);
  end;
 if ComboBoxVehicleGroup.Items.Count > 0 then ComboBoxVehicleGroup.ItemIndex:=0;
end;

procedure TFormMain.FUpdateTableItemProp;
begin
 TableExItemProp.ItemCount:=FItemProp.Count;
 TableExItemProp.Repaint;
end;

procedure TFormMain.FUpdateTableItems;
begin
 TableExItems.ItemCount:=FItems.Count;
 TableExItems.Repaint;
end;

procedure TFormMain.FUpdateTableVehicleProp;
begin
 TableExVehicleProp.ItemCount:=FVehicleProp.Count;
 TableExVehicleProp.Repaint;
end;

procedure TFormMain.FUpdateTableVehicles;
begin
 TableExVehicles.ItemCount:=FVehicles.Count;
 TableExVehicles.Repaint;
end;

procedure TFormMain.GetAllItems;
begin
 EditUnturnedVer.Text:=UBase.Version;
 LabelVehicleCount.Caption:=IntToStr(UBase.VehicleCount);
 LabelItemCount.Caption:=IntToStr(UBase.ItemCount);
 if UBase.Outdated then EditOutdated.Text:='Да'
 else EditOutdated.Text:='Нет';
 EditUVersion.Text:=UBase.VersionPath;
 UBase.GetGroupsItem(FItemGroups);
 UBase.GetGroupsVehicles(FVehicleGroups);
 FUpdateGroups;

 UpdateItemsData;
 UpdateVehiclesData;
 if TableExItems.ItemCount > 0 then
  begin
   TableExItems.ItemIndex:=0;
   SelectItem(TableExItems.ItemIndex, False);
  end;
 if TableExVehicles.ItemCount > 0 then
  begin
   TableExVehicles.ItemIndex:=0;
   TableExVehiclesItemClick(nil, mbLeft, TableExVehicles.ItemIndex);
  end;
end;

procedure TFormMain.ImageShareGClick(Sender: TObject);
begin
 Share((Sender as TImage).Tag);
end;

procedure TFormMain.ImageVehicleDblClick(Sender: TObject);
var BMP:TBitmap;
    FName:string;
    VID:Integer;
    Image:TImage;
begin
 VID:=TableExVehicles.ItemIndex;
 if not IndexInList(VID, TList(FVehicles)) then Exit;
 VID:=FVehicles[VID].ID;
 if not OpenDialog.Execute(Handle) then Exit;
 FName:=OpenDialog.FileName;
 Image:=TImage.Create(nil);
 try
  Image.Picture.LoadFromFile(FName);
 except
  begin
   MessageBox(Application.Handle, 'Ошибка при открытии изображения', '', MB_ICONSTOP or MB_OK);
   Image.Free;
   Exit;
  end;
 end;
 BMP:=TBitmap.Create;
 BMP.SetSize(Image.Picture.Width, Image.Picture.Height);
 BMP.Canvas.Draw(0, 0, Image.Picture.Graphic);
 UBase.SetVehicleImage(VID, BMP);
 BMP.Free;
end;

procedure TFormMain.Label12Click(Sender: TObject);
begin
 ShellExecute(Application.Handle, 'open', 'https://vk.com/unturned_hgm', nil, nil, SW_NORMAL);
end;

procedure TFormMain.Label5Click(Sender: TObject);
begin
 ShellExecute(Application.Handle, 'open', 'http://unturned.hemulgm.ru', nil, nil, SW_NORMAL);
end;

{ TUENavigator }

procedure TUENavigator.Back;
begin
 if AllowBack then FCurrent:=FCurrent-1 else Exit;
 DoControl;
 DoJump;
end;

procedure TUENavigator.Next;
begin
 if AllowNext then FCurrent:=FCurrent+1 else Exit;
 DoControl;
 DoJump;
end;

procedure TUENavigator.Clear;
begin
 FJumps.Clear;
 FCurrent:=-1;
 DoJump;
end;

constructor TUENavigator.Create;
begin
 FJumps:=TJumps.Create;
 FCurrent:=-1;
end;

procedure TUENavigator.DoControl;
begin
 if Assigned(FControl) then FControl(Self, FJumps[FCurrent]);
end;

procedure TUENavigator.DoJump;
begin
 if Assigned(FOnJump) then FOnJump(Self);
end;

function TUENavigator.FGetCurrent: Integer;
begin
 if not IndexInList(FCurrent, TList(FJumps)) then Exit(-1);
 Result:=FJumps[FCurrent];
end;

function TUENavigator.GetAllowBack: Boolean;
begin
 Result:=(FJumps.Count > 0) and (FCurrent > 0);
end;

function TUENavigator.GetAllowNext: Boolean;
begin
 Result:=(FJumps.Count > 0) and (FCurrent < (FJumps.Count-1));
end;

procedure TUENavigator.Jump(Data: Integer);
begin
 if FJumps.Count > 0 then if FJumps.Last = Data then Exit;
 if AllowNext then FJumps.DeleteRange(FCurrent+1, FJumps.Count-(FCurrent+1));
 FCurrent:=FJumps.Add(Data);
 DoJump;
end;

initialization
 MPath:=ExtractFilePath(ParamStr(0));
 SettingsFN:=MPath+'config.ini';
 DataBaseFN:=MPath+'data.db';

end.
