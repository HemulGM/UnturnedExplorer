unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IniFiles, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdTelnet, Vcl.ComCtrls, Vcl.ImgList,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.Menus, Vcl.Imaging.jpeg, Vcl.Styles, Vcl.Themes;

type
  TFormMain = class;
  TItemField = record
   Desc:string;
   Food:string;      //Еда
   Volume:string;    //Объем
   Energy:string;    //Энергия
   Water:string;     //Вода
   Virus:string;     //Отравление
   Health:string;    //Здоровье
   Fuel:string;      //Топливо
   Magazine:string;  //ИД магазина
   Sight:string;     //ИД прицела
   Caliber:string;   //Калибр
   Firerate:string;  //Скорострельность
   Range:string;     //Радиус поражения

   Player_Damage:string; //Урон
   Zombie_Damage:string;
   Animal_Damage:string;
   Barricade_Damage:string;
   Structure_Damage:string;
   Vehicle_Damage:string;
   Resource_Damage:string;
   Object_Damage:string;

   Zoom:string;
   Reload_Time:string; //Перезарядка
   Replace:string;     //Смена магазины
   Armor:string;       //Броня
   Amount:string;      //Размер (обойма)
   Pack:string; //Width height вместимость
   Vision:string;
   Proof_Radiation:string;
   Proof_Water:string;
   Proof_Fire:string;

   Warmth:string;       //Согревание 0
   Aid:string;          //Лечение en
   Disinfectant:string; //Дизинфекция 0
   Broken:string;       //Лечение перелома en
   Bleeding:string;     //Остановка кровотечения en
   Stamina:string;      //Затраты энергии 0

   Strength:string;     //Прочность 0
   Strong:string;       //Сила 0
   Slot:string;         //Слот  Secondary
   Rarity:string;       //Редкость 0
   ID:Cardinal;
  end;

  TVehicleField = record
   Desc:string;
   Speed:Double;
   Health:Double;
   Fuel:Double;
   Engine:string;
   ID:Cardinal;
  end;

  TUnturned = record
   Version:string;
   AppPath:string;
  end;

  TLoadState = (lsNone, lsLoading, lsLoaded);

  TFormMain = class(TForm)
    PageControlMain: TPageControl;
    TabSheetManage: TTabSheet;
    TabSheetItems: TTabSheet;
    TabSheetVehicle: TTabSheet;
    ImageWallpaper: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    ImageBG: TImage;
    LabelItemID: TLabel;
    ImageItem: TImage;
    LabelUnturnedVer: TLabel;
    LabelAppVer: TLabel;
    TimerImageUpdate: TTimer;
    Bevel1: TBevel;
    Panel2: TPanel;
    Image1: TImage;
    LabelVehicleID: TLabel;
    Image2: TImage;
    LabelVehicleSpeed: TLabel;
    LabelVehicleFuel: TLabel;
    LabelVehicleHealts: TLabel;
    ButtonReload: TButton;
    EditVehicleDesc: TEdit;
    EditItemDesc: TEdit;
    LabelUnturnedPath: TLabel;
    Label4: TLabel;
    ButtonChangeAppPath: TButton;
    Bevel2: TBevel;
    MemoItemDesc: TMemo;
    LabelDisImage: TLabel;
    PanelLoading: TPanel;
    ProgressBarGeneral: TProgressBar;
    ProgressBarItem: TProgressBar;
    LabelCurrentLoad: TLabel;
    Panel3: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    TabSheetSettings: TTabSheet;
    ComboBoxExTheme: TComboBoxEx;
    ButtonApply: TButton;
    Label9: TLabel;
    Bevel3: TBevel;
    Label10: TLabel;
    TabSheetServers: TTabSheet;
    Panel4: TPanel;
    ListViewItems: TListView;
    EditSearchItem: TEdit;
    CheckBoxGroup: TCheckBox;
    Label11: TLabel;
    Bevel4: TBevel;
    ButtonUpdate: TButton;
    Panel5: TPanel;
    ListViewVehicle: TListView;
    EditSearchVehicle: TEdit;
    Label12: TLabel;
    CheckBoxListPicLoad: TCheckBox;
    Label13: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ListViewItemsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure TimerImageUpdateTimer(Sender: TObject);
    procedure ListViewVehicleSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ButtonReloadClick(Sender: TObject);
    procedure ButtonChangeAppPathClick(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure ButtonApplyClick(Sender: TObject);
    procedure ListViewItemsColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListViewVehicleColumnClick(Sender: TObject; Column: TListColumn);
    procedure ButtonUpdateClick(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure EditSearchItemKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditSearchVehicleKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FIncreasingSortItem:Boolean;
    FColumnSortItem:Integer;
    FIncreasingSortVehicle:Boolean;
    FColumnSortVehicle:Integer;
    FListPicLoad:Boolean;
    FLoadState:TLoadState;
    FLoadInfoStr:string;
    FLastSRItem, FLastSRVehicle:string;
    ListItems:TStringList;
    ListVehicle:TStringList;
    procedure SetLoadState(Value:TLoadState);
    procedure SetLoadInfoStr(Value:string);
  public
    Unturned:TUnturned;
    OpenMaster:Boolean;
    procedure ReloadItemsWG(PB:TProgressBar);
    procedure ReloadInfo(PB:TProgressBar);
    procedure ReloadVehicle(PB:TProgressBar);
    procedure ReloadAll(PBG, PBI:TProgressBar);
    function SelectSearch(LV:TListView; Str:string; Skip:Integer):Integer;
    function PathMaster:Boolean;
    function LoadSettings:Boolean;
    function SaveSettings:Boolean;
    function ApplySettings:Boolean;
    property LoadState:TLoadState read FLoadState write SetLoadState;
    property LoadInfoStr:string read FLoadInfoStr write SetLoadInfoStr;
  end;

const
  AppVer = 'Beta 0.4';

var
  FormMain: TFormMain;
  MPath:string;
  SettingsFN:string;

function CustomUniSortProc(Item1, Item2:TListItem; ParamSort:integer):integer; stdcall;
function LookSteamPath(var SteamPath:string):Boolean;
function LookUnturnedPath(var aUnturnedPath:string):Boolean;

implementation

{$R *.dfm}
 uses System.Win.Registry, StartSet, Winapi.ShellAPI;

function GetGroupID(LV:TListView; GrName:string):Integer;
var i:Integer;
begin
 if LV.Groups.Count > 0 then
  for i:= 0 to LV.Groups.Count - 1 do
   if LV.Groups[i].Header = GrName then Exit(i);

 with LV.Groups.Add do
  begin
   Header:=GrName;
   Result:=GroupID;
  end;
end;

//Универсальный сортировщик
function CustomUniSortProc(Item1, Item2:TListItem; ParamSort:integer):integer;
var Atom1, Atom2:string;
    Int1, Int2:Integer;
    Flt1, Flt2:Extended;
    Dte1, Dte2:TDateTime;
    M1, M2:SmallInt;
begin
 Result:=0;
 M1:=1;
 M2:=-1;
 if (Item1 = nil) or (Item2 = nil) then Exit;

 if Assigned(Item1.ListView) then
  case Item1.ListView.Tag of
   1:
    begin
     M1:=-1;
     M2:=1;
    end;
  end;
 if ParamSort < 0 then
  begin
   Atom1:=item1.Caption;
   Atom2:=item2.Caption;
  end
 else
  begin
   if ParamSort > item1.SubItems.Count - 1 then Exit;
   if ParamSort > item2.SubItems.Count - 1 then Exit;

   Atom1:=item1.SubItems[ParamSort];
   Atom2:=item2.SubItems[ParamSort];
  end;

 if TryStrToInt(Atom1, Int1) then
  if TryStrToInt(Atom2, Int2) then
   begin
    if Int1 > Int2 then Result:= M1 else
    if Int1 < Int2 then Result:= M2;
    Exit;
   end;
 if TryStrToFloat(Atom1, Flt1) then
  if TryStrToFloat(Atom2, Flt2) then
   begin
    if Flt1 > Flt2 then Result:= M1 else
    if Flt1 < Flt2 then Result:= M2;
    Exit;
   end;
 if TryStrToDateTime(Atom1, Dte1) then
  if TryStrToDateTime(Atom2, Dte2) then
   begin
    if Dte1 > Dte2 then Result:= M1 else
    if Dte1 < Dte2 then Result:= M2;
    Exit;
   end;

 if AnsiLowerCase(Atom1) > AnsiLowerCase(Atom2) then Result:= M1 else
 if AnsiLowerCase(Atom1) < AnsiLowerCase(Atom2) then Result:= M2;
end;

procedure OnListViewSort(LV:TListView; FInc:Boolean; FCol:Integer);
begin
 if FInc then LV.Tag:=0 else LV.Tag:=1;
 LV.CustomSort(@CustomUniSortProc, FCol);
end;

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

function LookSteamPath(var SteamPath:string):Boolean;
var Reg:TRegistry;
begin
 Result:=False;
 SteamPath:='';
 Reg:=TRegistry.Create(KEY_READ);
 Reg.RootKey:=HKEY_LOCAL_MACHINE;
 if not Reg.OpenKeyReadOnly('SOFTWARE\Valve\Steam') then Exit;
 SteamPath:=Reg.ReadString('InstallPath');
 Reg.Free;
 Result:=True;
end;

function LookUnturnedPath(var aUnturnedPath:string):Boolean;
var SteamPath, tmp:string;
    Libs, Paths:TStringList;
    i, j, c:word;
begin
 Result:=False;
 Paths:=TStringList.Create;
 if LookSteamPath(SteamPath) then
  begin
   Libs:=TStringList.Create;
   Libs.LoadFromFile(SteamPath+'\steamapps\libraryfolders.vdf');
   if Libs.Count > 0 then
    begin
     j:=1;
     for i:= 0 to Libs.Count - 1 do
      begin
       if Pos('"'+IntToStr(j)+'"', Libs.Strings[i]) <> 0 then
        begin
         Paths.Add(Libs.Strings[i]);
         Inc(j);
        end;
      end;
     Libs.Clear;
     Libs.AddStrings(Paths);
     Paths.Clear;
    end;
   if Libs.Count > 0 then
    begin
     for i:= 0 to Libs.Count - 1 do
      begin
       j:=Pos('"', Libs.Strings[i], 5);
       if j = 0 then Continue;
       Inc(j);
       c:=Length(Libs.Strings[i]);
       tmp:=Copy(Libs.Strings[i], j, c - j);
       RepVar(tmp, '\\', '\');
       Paths.Add(tmp);
      end;
    end;
  end;
 Paths.Add('C:\Games\SteamLibrary');
 Paths.Add('C:\Program Files\SteamLibrary');
 Paths.Add('C:\Program Files (x86)\SteamLibrary');
 for i:= 0 to Paths.Count - 1 do
  begin
   if DirectoryExists(Paths.Strings[i]+'\steamapps\common\Unturned') then
    begin
     aUnturnedPath:=Paths.Strings[i]+'\steamapps\common\Unturned';
     Exit(True);
    end;
  end;
 aUnturnedPath:='';
end;

function GetItemFields(Item:string):TItemField;
var i:Word;
begin
 try
  Item:=Copy(Item, 1, Length(Item) - 4);
  RepVar(Item, '_', ' ');
  i:=Length(Item);
  while Item[i] in ['0'..'9'] do
   begin
    i:=i - 1;
   end;
  Result.Desc:=Copy(Item, 1, i - 1);
  Delete(Item, 1, i);
  Result.ID:=StrToInt(Item);
 except
  Result.Desc:='';
  Result.ID:=0;
 end;
end;

function GetVehicleFields(Vehicle:string):TVehicleField;
var i:Word;
    VehFile:TStringList;
    ResPos:Integer;
    Str:string;
begin
 Result.Desc:='';
 VehFile:=TStringList.Create;
 try
  VehFile.LoadFromFile(Vehicle);
 except
  Exit;
 end;
 Str:=ExtractFileName(Vehicle);
 Delete(Str, Length(Str) - 3, 4);
 RepVar(Str, '_', ' ');
 Result.Desc:=Str;
 if VehFile.Count <= 0 then Exit;
 Result.Engine:='Vehicle';
 for i:= 0 to VehFile.Count - 1 do
  begin
   Str:=VehFile.Strings[i];
   ResPos:=Pos('ID ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('ID')+1);
     Result.ID:=StrToInt(Str);
     Continue;
    except
     Result.ID:=0;
    end;

   Str:=VehFile.Strings[i];
   ResPos:=Pos('Speed_Max ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Speed_Max')+1);
     RepVar(Str, '.', ',');
     Result.Speed:=StrToFloat(Str);
     Continue;
    except
     Result.Speed:=0;
    end;

   Str:=VehFile.Strings[i];
   ResPos:=Pos('Fuel ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Fuel')+1);
     RepVar(Str, '.', ',');
     Result.Fuel:=StrToFloat(Str);
     Continue;
    except
     Result.Fuel:=0;
    end;

   Str:=VehFile.Strings[i];
   ResPos:=Pos('Health ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Health')+1);
     RepVar(Str, '.', ',');
     Result.Health:=StrToFloat(Str);
     Continue;
    except
     Result.Health:=0;
    end;

   Str:=VehFile.Strings[i];
   ResPos:=Pos('Engine ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Engine')+1);
     Result.Engine:=Str;
     Continue;
    except

    end;
  end;
end;

function GetItemWGFields(Vehicle:string):TItemField;
var i:Word;
    VehFile:TStringList;
    ResPos, Amount:Integer;
    Str:string;
begin
 Result.Desc:='';
 VehFile:=TStringList.Create;
 try
  VehFile.LoadFromFile(Vehicle);
 except
  Exit;
 end;
 Str:=ExtractFileName(Vehicle);
 Delete(Str, Length(Str) - 3, 4);
 RepVar(Str, '_', ' ');
 Result.Desc:=Str;
 Result.Food:='';
 Result.Volume:='';
 Result.Energy:='';
 Result.Water:='';
 Result.Virus:='';
 Result.Health:='';
 Result.Fuel:='';
 Result.Magazine:='';
 Result.Sight:='';
 Result.Caliber:='';
 Result.Firerate:='';
 Result.Range:='';
 Result.Zombie_Damage:='';
 Result.Player_Damage:='';
 Result.Animal_Damage:='';
 Result.Barricade_Damage:='';
 Result.Structure_Damage:='';
 Result.Vehicle_Damage:='';
 Result.Resource_Damage:='';
 Result.Object_Damage:='';
 Result.Reload_Time:='';
 Result.Zoom:='';
 Result.Replace:='';
 Result.Armor:='';
 Result.Amount:='';
 Result.Pack:='';
 Result.Vision:='';
 Result.Proof_Radiation:='';
 Result.Proof_Water:='';
 Result.Proof_Fire:='';
 Result.Warmth:='';
 Result.Aid:='';
 Result.Disinfectant:='';
 Result.Broken:='';
 Result.Bleeding:='';
 Result.Stamina:='';

 Result.Strength:='';
 Result.Strong:='';
 Result.Slot:='';
 Result.Rarity:='';


 if VehFile.Count <= 0 then Exit;
 Amount:=0;
 for i:= 0 to VehFile.Count - 1 do
  begin
   Str:=VehFile.Strings[i];
   ResPos:=Pos('ID ', Str);
   if ResPos = 1  then
    try
     Delete(Str, 1, 3);
     Result.ID:=StrToInt(Str);
     Continue;
    except
     Result.ID:=0;
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Health ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Health')+1);
     Result.Health:='Здоровье: '+Str;
     Continue;
    except
     Result.Health:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Food ', Str);
   if ResPos = 1  then
    try
     Delete(Str, 1, Length('Food')+1);
     Result.Food:='Еда: '+Str;
     Continue;
    except
     Result.Food:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Water ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Water')+1);
     Result.Water:='Вода: '+Str;
     Continue;
    except
     Result.Water:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Energy ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Energy')+1);
     Result.Energy:='Энергия: '+Str;
     Continue;
    except
     Result.Energy:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Virus ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Virus')+1);
     Result.Virus:='Отравление: '+Str;
     Continue;
    except
     Result.Virus:='';
    end;

   Str:=VehFile.Strings[i];
   ResPos:=Pos('Volume ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Volume')+1);
     Result.Volume:='Увеличение: '+Str;
     Continue;
    except
     Result.Volume:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Fuel ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Fuel')+1);
     Result.Fuel:='Топливо: '+Str;
     Continue;
    except
     Result.Fuel:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Armor ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Armor')+1);
     RepVar(Str, '.', ',');
     Result.Armor:='Броня: '+FloatToStr(1-StrToFloat(Str));
     Continue;
    except
     Result.Armor:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Magazine ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Magazine')+1);
     Result.Magazine:='ID магазина: '+Str;
     Continue;
    except
     Result.Magazine:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Sight ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Sight')+1);
     Result.Sight:='ID прицела: '+Str;
     Continue;
    except
     Result.Sight:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Caliber ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Caliber')+1);
     Result.Caliber:='Калибр: '+Str;
     Continue;
    except
     Result.Caliber:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Firerate ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Firerate')+1);
     Result.Firerate:='Скорострельность: '+Str;
     Continue;
    except
     Result.Firerate:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Range ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Range')+1);
     Result.Range:='Радиус поражения: '+Str;
     Continue;
    except
     Result.Range:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Player_Damage ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Player_Damage')+1);
     Result.Player_Damage:='Урон игрокам: '+Str;
     Continue;
    except
     Result.Player_Damage:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Zombie_Damage ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Zombie_Damage')+1);
     Result.Zombie_Damage:='Урон зомби: '+Str;
     Continue;
    except
     Result.Zombie_Damage:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Animal_Damage ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Animal_Damage')+1);
     Result.Animal_Damage:='Урон животным: '+Str;
     Continue;
    except
     Result.Animal_Damage:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Barricade_Damage ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Barricade_Damage')+1);
     Result.Barricade_Damage:='Повреждение барикадам: '+Str;
     Continue;
    except
     Result.Barricade_Damage:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Structure_Damage ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Structure_Damage')+1);
     Result.Structure_Damage:='Повреждение строениям: '+Str;
     Continue;
    except
     Result.Structure_Damage:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Vehicle_Damage ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Vehicle_Damage')+1);
     Result.Vehicle_Damage:='Повреждение транспорту: '+Str;
     Continue;
    except
     Result.Vehicle_Damage:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Resource_Damage ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Resource_Damage')+1);
     Result.Resource_Damage:='Повреждение ресурсам: '+Str;
     Continue;
    except
     Result.Resource_Damage:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Object_Damage ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Object_Damage')+1);
     Result.Object_Damage:='Повреждение объектам: '+Str;
     Continue;
    except
     Result.Object_Damage:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Reload_Time ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Reload_Time')+1);
     Result.Reload_Time:='Время перезарадки: '+Str;
     Continue;
    except
     Result.Reload_Time:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Replace ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Replace')+1);
     Result.Replace:='Время смены обоймы: '+Str;
     Continue;
    except
     Result.Replace:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Amount ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Amount')+1);
     Result.Amount:='Вместимость: '+Str;
     Continue;
    except
     Result.Amount:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Zoom ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Zoom')+1);
     Result.Zoom:='Зум: '+Str;
     Continue;
    except
     Result.Zoom:='';
    end;

   Str:=VehFile.Strings[i];
   ResPos:=Pos('Width ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Width')+1);
     if Result.Pack = '' then
      begin
       Result.Pack:='Вместимость: '+Str;
       Amount:=StrToInt(Str);
      end
     else
      begin
       Amount:=Amount*StrToInt(Str);
       Result.Pack:=Result.Pack+'x'+Str+' (ячеек: '+IntToStr(Amount)+')';
      end;
     Continue;
    except
     Result.Pack:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Height ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Height')+1);
     if Result.Pack = '' then
      begin
       Result.Pack:='Вместимость: '+Str;
       Amount:=StrToInt(Str);
      end
     else
      begin
       Amount:=Amount*StrToInt(Str);
       Result.Pack:=Result.Pack+'x'+Str+' (ячеек: '+IntToStr(Amount)+')';
      end;
     Continue;
    except
     Result.Pack:='';
    end;

   {
   Warmth:string;       //Согревание 0
   Aid:string;          //Лечение en
   Disinfectant:string; //Дизинфекция 0
   Broken:string;       //Лечение перелома en
   Bleeding:string;     //Остановка кровотечения en
   Stamina:string;      //Затраты энергии 0

   Strength:string;     //Прочность 0
   Strong:string;       //Сила 0
   Slot:string;         //Слот  Secondary
   Rarity:string;       //Редкость 0
   }
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Warmth ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Warmth')+1);
     Result.Warmth:='Согревание: '+Str;
     Continue;
    except
     Result.Warmth:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Aid', Str);
   if ResPos = 1 then
    try
     Result.Aid:='Первая помощь';
     Continue;
    except
     Result.Aid:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Disinfectant ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Disinfectant')+1);
     Result.Disinfectant:='Дизинфекция: '+Str;
     Continue;
    except
     Result.Disinfectant:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Broken', Str);
   if ResPos = 1 then
    try
     Result.Broken:='Лечение перелома';
     Continue;
    except
     Result.Broken:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Bleeding', Str);
   if ResPos = 1 then
    try
     Result.Bleeding:='Остановка кровотечения';
     Continue;
    except
     Result.Bleeding:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Stamina ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Stamina')+1);
     Result.Stamina:='Затрата энегии: '+Str;
     Continue;
    except
     Result.Stamina:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Strength ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Strength')+1);
     Result.Strength:='Прочность: '+Str;
     Continue;
    except
     Result.Strength:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Strong ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Strong')+1);
     Result.Strong:='Сила: '+Str;
     Continue;
    except
     Result.Strong:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Slot ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Slot')+1);
     Result.Slot:='Слоты: '+Str;
     Continue;
    except
     Result.Slot:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Rarity ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Rarity')+1);
     Result.Rarity:='Редкость: '+Str;
     Continue;
    except
     Result.Rarity:='';
    end;


   Str:=VehFile.Strings[i];
   ResPos:=Pos('Vision ', Str);
   if ResPos = 1 then
    try
     Delete(Str, 1, Length('Vision')+1);
     Result.Vision:='Галлюцинации: '+Str;
     Continue;
    except
     Result.Vision:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Proof_Radiation', Str);
   if ResPos = 1 then
    try
     Str:='Защита от радиации';
     Result.Proof_Radiation:=Str;
     Continue;
    except
     Result.Proof_Radiation:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Proof_Water', Str);
   if ResPos = 1 then
    try
     Str:='Защита от воды (кислород)';
     Result.Proof_Water:=Str;
     Continue;
    except
     Result.Proof_Water:='';
    end;
   Str:=VehFile.Strings[i];
   ResPos:=Pos('Proof_Fire', Str);
   if ResPos = 1 then
    try
     Str:='Защита от огня';
     Result.Proof_Fire:=Str;
     Continue;
    except
     Result.Proof_Fire:='';
    end;

   {

   Reload_Time:string; //Перезарядка
   Replace:string;     //Смена магазины
   Armor:string;       //Броня
   Amount:string;      //Размер (обойма)
   Pack:string; //Width height вместимость
   Vision:string;
   Proof_Radiation:string;
   Proof_Water:string;
   Proof_Fire:string;
   }
  end;
 VehFile.Free;
end;

function TFormMain.LoadSettings:Boolean;
var Ini:TIniFile;
begin
 Result:=True;
 if not FileExists(SettingsFN) then FileClose(FileCreate(SettingsFN));
 Ini:=TIniFile.Create(SettingsFN);
 Unturned.AppPath:=Ini.ReadString('Global', 'UnturnedPath', '');
 TStyleManager.TrySetStyle(Ini.ReadString('Global', 'Skin', 'Glossy'));
 CheckBoxGroup.Checked:=Ini.ReadBool('Global', 'Groups', True);
 FIncreasingSortItem:=Ini.ReadBool('Global', 'FIncreasingSortItem', True);
 FIncreasingSortVehicle:=Ini.ReadBool('Global', 'FIncreasingSortVehicle', True);
 FColumnSortItem:=Ini.ReadInteger('Global', 'FColumnSortItem', 0);
 FColumnSortVehicle:=Ini.ReadInteger('Global', 'FColumnSortVehicle', 0);
 FLastSRItem:=Ini.ReadString('Global', 'FLastSRItem', '');
 FLastSRVehicle:=Ini.ReadString('Global', 'FLastSRVehicle', '');
 FListPicLoad:=Ini.ReadBool('Global', 'FListPicLoad', False);
 Ini.Free;
end;

function TFormMain.SaveSettings:Boolean;
var Ini:TIniFile;
begin
 if not FileExists(SettingsFN) then FileClose(FileCreate(SettingsFN));
 Ini:=TIniFile.Create(SettingsFN);
 Ini.WriteString('Global', 'UnturnedPath', Unturned.AppPath);
 Ini.WriteString('Global', 'Skin', TStyleManager.ActiveStyle.Name);
 Ini.WriteBool('Global', 'Groups', CheckBoxGroup.Checked);
 Ini.WriteBool('Global', 'FIncreasingSortItem', FIncreasingSortItem);
 Ini.WriteBool('Global', 'FIncreasingSortVehicle', FIncreasingSortVehicle);
 Ini.WriteInteger('Global', 'FColumnSortItem', FColumnSortItem);
 Ini.WriteInteger('Global', 'FColumnSortVehicle', FColumnSortVehicle);
 Ini.WriteBool('Global', 'FListPicLoad', FListPicLoad);
 Ini.WriteString('Global', 'FLastSRItem', FLastSRItem);
 Ini.WriteString('Global', 'FLastSRVehicle', FLastSRVehicle);
 Ini.Free;
 Result:=True;
end;

function TFormMain.ApplySettings;
begin
 if TStyleManager.ActiveStyle.Name <> ComboBoxExTheme.Items[ComboBoxExTheme.ItemIndex] then
  TStyleManager.TrySetStyle(ComboBoxExTheme.Items[ComboBoxExTheme.ItemIndex]);
 ListViewItems.GroupView:=CheckBoxGroup.Checked;
 ListViewVehicle.GroupView:=CheckBoxGroup.Checked;
 FListPicLoad:=CheckBoxListPicLoad.Checked;
end;

function TFormMain.PathMaster:Boolean;
begin
 Result:=False;
 FormStartSet.EditHandlePath.Text:=Unturned.AppPath;
 if FormStartSet.ShowModal = mrOK then
  begin
   Unturned.AppPath:=FormStartSet.EditHandlePath.Text;
   if DirectoryExists(Unturned.AppPath) then
    begin
     ReloadInfo(ProgressBarItem);
     Result:=True;
    end;
  end;
end;

function TFormMain.SelectSearch(LV:TListView; Str:string; Skip:Integer):Integer;
var i, j, r:Integer;
    Str2:string;
begin
 Result:=-1;
 if LV.Items.Count <= 0 then Exit;
 r:=-1;
 Str:=AnsiLowerCase(Str);
 if Skip = LV.Items.Count - 1 then Skip:=-1;
 for i:= 0 to LV.Items.Count - 1 do
  begin
   if i <= Skip then Continue;

   Str2:=AnsiLowerCase(LV.Items[i].Caption);
   if Str = Str2 then Exit(i);
   if r = -1 then if Pos(Str, Str2) <> 0 then r:=i;

   if LV.Items[i].SubItems.Count > 0 then
    for j:= 0 to LV.Items[i].SubItems.Count - 1 do
     begin
      Str2:=AnsiLowerCase(LV.Items[i].SubItems[j]);
      if Str = Str2 then Exit(i);
      if r = -1 then if Pos(Str, Str2) <> 0 then r:=i;
     end;
  end;
 if r <> -1 then Result:=r;
end;

procedure TFormMain.TimerImageUpdateTimer(Sender: TObject);
var ic:Integer;
begin
 if ListViewItems.SelCount > 0 then
  if ImageItem.Tag <> ListViewItems.ItemIndex then
   begin
    try
     ImageItem.Tag:=ListViewItems.ItemIndex;
     ic:=Integer(ListViewItems.Selected.Data^);
     if ic >= 0 then
      begin
       ImageItem.Picture.LoadFromFile(ListItems[ic]);
       ImageItem.Show;
       LabelDisImage.Hide;
      end
     else
      begin
       ImageItem.Hide;
       LabelDisImage.Show;
      end;
    except

    end;
   end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TFormMain.ReloadInfo;
var JSON:TStringList;
    i:Word;
    Str:string;
begin
 PB.Position:=1;
 LoadInfoStr:='Загрузка информации...';
 try
  ImageWallpaper.Picture.LoadFromFile(Unturned.AppPath+'\Extras\Wallpaper.png');
 except

 end;
 if FileExists(Unturned.AppPath+'\Status.json') then
  begin
   JSON:=TStringList.Create;
   JSON.LoadFromFile(Unturned.AppPath+'\Status.json');
   if JSON.Count > 0 then
    begin
     Str:='';
     for i:= 0 to JSON.Count - 1 do
      begin
       PB.Position:=Round((100 / JSON.Count) * i);
       Application.ProcessMessages;
       if i >= 65000 then Break;
       if Pos('"Version":', JSON.Strings[i]) <> 0 then
        begin
         Str:=JSON.Strings[i];
         Break;
        end;
      end;
     JSON.Clear;
     if Str <> '' then
      begin
       i:=Pos('"Version":', Str);
       Delete(Str, 1, i+11);
       Delete(Str, Length(Str), 1);
      end
     else Str:='Ошибка';
     Unturned.Version:=Str;
    end;
  end;
 LabelUnturnedVer.Caption:=Unturned.Version;
 LabelAppVer.Caption:=AppVer;
 LabelUnturnedPath.Caption:=Unturned.AppPath;
 PB.Position:=PB.Max;
 Application.ProcessMessages;
 Sleep(100);
end;

procedure TFormMain.ReloadVehicle;
var VPath:string;
    SR:TSearchRec;
    LI:TListItem;
    FI:TVehicleField;
    VehCount, c:Integer;
begin
 PB.Position:=1;
 VehCount:=0;
 c:=0;
 LoadInfoStr:='Подсчет транспорта...';
 VPath:=Unturned.AppPath+'\Bundles\Vehicles\';
 ListViewVehicle.Items.BeginUpdate;
 ListViewVehicle.Items.Clear;
 ListViewVehicle.Groups.Clear;
 ListVehicle.Clear;
 if (FindFirst(VPath+'*.*', faDirectory, SR) = 0) then
  repeat
   Inc(VehCount);
  until (FindNext(SR) <> 0);

 if (FindFirst(VPath+'*.*', faDirectory, SR) = 0) then
  repeat
   Inc(c);
   PB.Position:=Round((100 / VehCount) * c);
   Application.ProcessMessages;
   if not FileExists(VPath+SR.Name+'\'+SR.Name+'.dat') then Continue;
   with ListViewVehicle.Items do
    begin
     FI:=GetVehicleFields(VPath+SR.Name+'\'+SR.Name+'.dat');
     if FI.Desc = '' then Continue;
     LI:=Add;
     LI.Caption:=IntToStr(FI.ID);
     LI.SubItems.Add(FI.Desc);
     LI.SubItems.Add(FloatToStr(FI.Speed));
     LI.SubItems.Add(FloatToStr(FI.Fuel));
     LI.SubItems.Add(FloatToStr(FI.Health));
     LI.GroupID:=GetGroupID(ListViewVehicle, FI.Engine);
     LI.Data:=AllocMem(SizeOf(Word));
     Word(LI.Data^):=ListVehicle.Add(VPath+SR.Name);
    end;
  until (FindNext(SR) <> 0);
 ListViewVehicle.Items.EndUpdate;
 FindClose(SR);
 PB.Position:=PB.Max;
 Application.ProcessMessages;
 Sleep(100);
end;

procedure TFormMain.ReloadItemsWG;
var IconsPath, ItemPath:string;
    SR:TSearchRec;
    LI:TListItem;
    FI:TItemField;
    GID:Integer;
    i, P:Integer;

function LookIcon(Item:string):Integer;
var it:Integer;
begin
 Result:=-1;
 if ListItems.Count <= 0 then Exit;
 for it:= 0 to ListItems.Count - 1 do
  begin
   Application.ProcessMessages;
   P:=Pos(Item, ListItems.Strings[it]);
   if P <> 0 then
    begin
     Result:=it;
     Break;
    end;
  end;
end;

procedure ProcDir(dir:string);
var DR:TSearchRec;
    BMP:TBitmap;
    PNG:TPngImage;
begin
 if (FindFirst(dir+'\*.*', faDirectory, DR) = 0) then
  repeat
   Application.ProcessMessages;
   if not FileExists(dir+'\'+DR.Name+'\'+DR.Name+'.dat') then Continue;
   with ListViewItems.Items do
    begin
     FI:=GetItemWGFields(dir+'\'+DR.Name+'\'+DR.Name+'.dat');
     FI.Desc:=DR.Name;
     RepVar(FI.Desc, '_', ' ');
     if FI.Desc = '' then Continue;
     LI:=Add;
     LI.Caption:=IntToStr(FI.ID);
     LI.SubItems.Add(FI.Desc);
     LI.SubItems.Add(FI.Food);
     LI.SubItems.Add(FI.Volume);
     LI.SubItems.Add(FI.Energy);
     LI.SubItems.Add(FI.Water);
     LI.SubItems.Add(FI.Virus);
     LI.SubItems.Add(FI.Health);
     LI.SubItems.Add(FI.Fuel);
     LI.SubItems.Add(FI.Magazine);
     LI.SubItems.Add(FI.Sight);
     LI.SubItems.Add(FI.Caliber);
     LI.SubItems.Add(FI.Firerate);
     LI.SubItems.Add(FI.Range);
     LI.SubItems.Add(FI.Player_Damage);
     LI.SubItems.Add(FI.Zombie_Damage);
     LI.SubItems.Add(FI.Animal_Damage);
     LI.SubItems.Add(FI.Barricade_Damage);
     LI.SubItems.Add(FI.Structure_Damage);
     LI.SubItems.Add(FI.Vehicle_Damage);
     LI.SubItems.Add(FI.Resource_Damage);
     LI.SubItems.Add(FI.Object_Damage);
     LI.SubItems.Add(FI.Reload_Time);
     LI.SubItems.Add(FI.Replace);
     LI.SubItems.Add(FI.Armor);
     LI.SubItems.Add(FI.Zoom);
     LI.SubItems.Add(FI.Amount);
     LI.SubItems.Add(FI.Pack);
     LI.SubItems.Add(FI.Vision);
     LI.SubItems.Add(FI.Proof_Radiation);
     LI.SubItems.Add(FI.Proof_Water);
     LI.SubItems.Add(FI.Proof_Fire);
     LI.SubItems.Add(FI.Warmth);
     LI.SubItems.Add(FI.Aid);
     LI.SubItems.Add(FI.Disinfectant);
     LI.SubItems.Add(FI.Broken);
     LI.SubItems.Add(FI.Bleeding);
     LI.SubItems.Add(FI.Stamina);
     LI.SubItems.Add(FI.Strength);
     LI.SubItems.Add(FI.Strong);
     LI.SubItems.Add(FI.Slot);
     LI.SubItems.Add(FI.Rarity);

     LI.GroupID:=GID;
     LI.Data:=AllocMem(SizeOf(Integer));
     Integer(LI.Data^):=LookIcon(DR.Name+'_'+IntToStr(FI.ID));
     if FListPicLoad then
      try
       PNG:=TPngImage.Create;
       PNG.LoadFromFile(IconsPath+ListItems.Strings[Integer(LI.Data^)]);
       BMP:=TBitmap.Create;
       BMP.SetSize(32, 32);
       BMP.Canvas.StretchDraw(Rect(0, 0, 32, 32), PNG);
       PNG.Free;
       LI.ImageIndex:=ListViewItems.SmallImages.AddMasked(BMP, BMP.TransparentColor);
       BMP.Free;
      except
       LI.ImageIndex:=-1;
      end;
    end;
  until (FindNext(DR) <> 0);

end;

begin
 IconsPath:=Unturned.AppPath+'\Extras\Icons\';
 ListViewItems.Items.BeginUpdate;
 ListViewItems.Items.Clear;
 if FListPicLoad then
  if Assigned(ListViewItems.SmallImages) then ListViewItems.SmallImages.Clear
  else
   begin
    ListViewItems.SmallImages:=TImageList.Create(ListViewItems);
    ListViewItems.SmallImages.SetSize(32, 32);
    ListViewItems.SmallImages.ColorDepth:=cd32Bit;
   end;
 ListItems.Clear;
 PB.Position:=1;
 LoadInfoStr:='Загрузка списка вещей: Поиск образов вещей...';

 if (FindFirst(IconsPath+'*.png', faAnyFile, SR) = 0) then
  repeat
   Application.ProcessMessages;
   ListItems.Add(SR.Name);
  until (FindNext(SR) <> 0);
 ListViewItems.Groups.Clear;
 ItemPath:=Unturned.AppPath+'\Bundles\Items\';
 PB.Position:=Round(PB.Max * (1/3));

 LoadInfoStr:='Загрузка списка вещей: Чтение параметров вещей...';
 if (FindFirst(ItemPath+'*.*', faDirectory, SR) = 0) then
  repeat
   Application.ProcessMessages;
   if not DirectoryExists(ItemPath+SR.Name) then Continue;
   with ListViewItems.Groups.Add do
    begin
     Header:=SR.Name;
     GID:=GroupID;
    end;
   ProcDir(ItemPath+SR.Name);
  until (FindNext(SR) <> 0);
 PB.Position:=Round(PB.Max * (2/3));
 ListViewItems.Items.EndUpdate;
 FindClose(SR);

 LoadInfoStr:='Загрузка списка вещей: Построение корректных путей образов...';
 if ListItems.Count <= 0 then Exit;
 for i:= 0 to ListItems.Count - 1 do
  begin
   Application.ProcessMessages;
   ListItems.Strings[i]:=IconsPath+ListItems.Strings[i];
  end;
 PB.Position:=PB.Max;
 Application.ProcessMessages;
 Sleep(100);
end;

////////////////////////////////////////////////////////////////////////////////

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

procedure TFormMain.SetLoadInfoStr(Value:string);
begin
 LabelCurrentLoad.Caption:=Value;
end;

procedure TFormMain.ReloadAll;
begin
 if not FileExists(Unturned.AppPath+'\Unturned.exe') then
  begin
   if not PathMaster then
    begin
     ShowMessage('Вы не указали каталог с игрой');
     Exit;
    end;
  end;
 LoadState:=lsLoading;
 PBG.Position:=1;
 Application.ProcessMessages;
 PageControlMain.ActivePage:=TabSheetManage;

 ReloadInfo(PBI);
 PBG.Position:=Round(PBG.Max * (1/3));
 Application.ProcessMessages;

 ReloadItemsWG(PBI);
 OnListViewSort(ListViewItems, FIncreasingSortItem, FColumnSortItem);
 PBG.Position:=Round(PBG.Max * (2/3));
 Application.ProcessMessages;

 ReloadVehicle(PBI);
 OnListViewSort(ListViewVehicle, FIncreasingSortVehicle, FColumnSortVehicle);
 PBG.Position:=PBG.Max;
 Application.ProcessMessages;
 Sleep(400);

 LoadState:=lsLoaded;
end;

procedure TFormMain.ButtonApplyClick(Sender: TObject);
begin
 ApplySettings;
end;

procedure TFormMain.ButtonChangeAppPathClick(Sender: TObject);
begin
 PathMaster;
end;

procedure TFormMain.ButtonReloadClick(Sender: TObject);
begin
 ReloadAll(ProgressBarGeneral, ProgressBarItem);
end;

procedure TFormMain.ButtonUpdateClick(Sender: TObject);
begin
 ShellExecute(Application.Handle, 'open', 'https://hemulgm.ru/softpub/UnturnedExplorer_Setup.rar', nil, nil, SW_NORMAL);
end;

procedure TFormMain.EditSearchItemKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
 var Skip:Integer;
begin
 if EditSearchItem.Text <> '' then
  begin
   if EditSearchItem.Text = FLastSRItem then Skip:=ListViewItems.ItemIndex else
    begin
     Skip:=-1;
     FLastSRItem:=EditSearchItem.Text;
    end;
   ListViewItems.ItemIndex:=SelectSearch(ListViewItems, FLastSRItem, Skip);
   if ListViewItems.ItemIndex >= 0 then
    begin
     ListViewItems.Items[ListViewItems.ItemIndex].MakeVisible(False);
     ListViewItems.Items[ListViewItems.ItemIndex].Focused:=True;
    end;
  end;
 if Key = VK_RETURN then Key:=0;
end;

procedure TFormMain.EditSearchVehicleKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
 var Skip:Integer;
begin
 if EditSearchVehicle.Text <> '' then
  begin
   if EditSearchVehicle.Text = FLastSRVehicle then Skip:=ListViewVehicle.ItemIndex else
    begin
     Skip:=-1;
     FLastSRVehicle:=EditSearchVehicle.Text;
    end;
   ListViewVehicle.ItemIndex:=SelectSearch(ListViewVehicle, FLastSRVehicle, Skip);
   if ListViewVehicle.ItemIndex >= 0 then
    begin
     ListViewVehicle.Items[ListViewVehicle.ItemIndex].MakeVisible(False);
     ListViewVehicle.Items[ListViewVehicle.ItemIndex].Focused:=True;
    end;
  end;
 if Key = VK_RETURN then Key:=0;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 SaveSettings;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var i:Integer;
    CBI:TComboExItem;
begin
 FColumnSortItem:=0;
 LoadState:=lsNone;
 OpenMaster:=False;

 ListItems:=TStringList.Create;
 ListVehicle:=TStringList.Create;
 if not LoadSettings then OpenMaster:=True
 else
  begin
   if not DirectoryExists(Unturned.AppPath) then OpenMaster:=True;
  end;

 ComboBoxExTheme.ItemsEx.Clear;
 if Length(TStyleManager.StyleNames) > 0 then
  begin
   for i:= Low(TStyleManager.StyleNames) to High(TStyleManager.StyleNames) do
    with ComboBoxExTheme.ItemsEx do
     begin
      CBI:=Add;
      CBI.Caption:=TStyleManager.StyleNames[i];
      if TStyleManager.ActiveStyle.Name = TStyleManager.StyleNames[i] then ComboBoxExTheme.ItemIndex:=CBI.Index;
     end;
  end;
 ApplySettings;
 ReloadInfo(ProgressBarItem);
 PageControlMain.ActivePage:=TabSheetManage;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
 if OpenMaster then PathMaster;
end;

procedure TFormMain.Label12Click(Sender: TObject);
begin
 ShellExecute(Application.Handle, 'open', 'https://vk.com/unturned_hgm', nil, nil, SW_NORMAL);
end;

procedure TFormMain.Label5Click(Sender: TObject);
begin
 ShellExecute(Application.Handle, 'open', 'https://www.hemulgm.ru', nil, nil, SW_NORMAL);
end;

procedure TFormMain.ListViewItemsColumnClick(Sender: TObject; Column: TListColumn);
begin
 if Column.Index - 1 = FColumnSortItem then FIncreasingSortItem:=not FIncreasingSortItem
 else FColumnSortItem:=Column.Index - 1;
 OnListViewSort(ListViewItems, FIncreasingSortItem, FColumnSortItem);
end;

procedure TFormMain.ListViewItemsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var i:word;
begin
 EditItemDesc.Text:=Item.SubItems[0];
 LabelItemID.Caption:='ID: '+Item.Caption;
 MemoItemDesc.Lines.Clear;
 MemoItemDesc.Lines.BeginUpdate;
 for i:= 1 to Item.SubItems.Count - 1 do
  if Item.SubItems[i] <> '' then MemoItemDesc.Lines.Add(Item.SubItems[i]);
 MemoItemDesc.Lines.EndUpdate;
end;

procedure TFormMain.ListViewVehicleColumnClick(Sender: TObject;
  Column: TListColumn);
begin
 if Column.Index - 1 = FColumnSortVehicle then FIncreasingSortVehicle:=not FIncreasingSortVehicle
 else FColumnSortVehicle:=Column.Index - 1;
 OnListViewSort(ListViewVehicle, FIncreasingSortVehicle, FColumnSortVehicle);
end;

procedure TFormMain.ListViewVehicleSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
 EditVehicleDesc.Text:=Item.SubItems[0];
 LabelVehicleID.Caption:='ID: '+Item.Caption;
 LabelVehicleSpeed.Caption:='Макс. скорость: '+Item.SubItems[1];
 LabelVehicleFuel.Caption:='Топливный бак: '+Item.SubItems[2];
 LabelVehicleHealts.Caption:='Прочность: '+Item.SubItems[3];
end;

initialization
 MPath:=ExtractFilePath(ParamStr(0));
 SettingsFN:=MPath+'UESettings.ini';

end.
