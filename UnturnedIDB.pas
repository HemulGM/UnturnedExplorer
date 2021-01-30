unit UnturnedIDB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Dialogs,
  Vcl.Imaging.pngimage, System.Generics.Collections, System.JSON, System.Win.Registry, HGM.SQLite, HGM.SQLite.Wrapper,
  HGM.SQLang, System.IniFiles, Winapi.WinInet;

type
  //����������� � ��������� ��������
  TOnProgress = procedure(AMax, APos: Integer; Info: string) of object;

  //��������� �������� � �� ������
  TRegProperty = record
  private
    FTempFlag: Boolean;
    procedure SetTempFlag(const Value: Boolean);
  public
    //��
    Key: string;
    //��������
    Desc: string;
    //���� "��� �� ������� ��������"
    IsID: Boolean;
    //���� "���������� ���" (�������� ��� �������)
    Logical: Boolean;
    //��������� ���� (��������� ������ ��� ��������)
    property TempFlag: Boolean read FTempFlag write SetTempFlag;
  end;

  TRegProperies = TList<TRegProperty>;

  //�������� �������� � �� ������
  TItemPorp = record
   //��
    Key: string;
   //��������
    Desc: string;
   //��������
    Value: string;
   //��� �� ��������
    IsID: Boolean;
  end;

  TItemProperties = TList<TItemPorp>;

  //������� � ��� ������
  TDisplayDataItem = record
   //�� � �������
    IID: Integer;
   //�� ��������
    ID: Integer;
   //������
    Group: string;
   //��������
    Desc: string;
  end;

  TDisplayDataItems = TList<TDisplayDataItem>;

  //��������� � ��� ������
  TDisplayDataVehicle = record
   //�� � �������
    VID: Integer;
   //�� ����������
    ID: Integer;
   //������
    Group: string;
   //��������
    Desc: string;
   //����. ��������
    Speed: Double;
   //����� ����
    Fuel: Double;
   //�����
    Health: Double;
  end;

  TDisplayDataVehicles = TList<TDisplayDataVehicle>;

  //������ (�������� ��� ����������) � � ������
  TGroup = record
   //�� � �������
    GID: Integer;
   //��������
    Desc: string;
  end;

  TGroups = TList<TGroup>;

  TLangInfo = record
    Version: string;
    Autor: string;
    Desc: string;
  end;

const
  //URL �������� � ������������� ����������
  urlVehicles = 'http://unturned.hemulgm.ru/unturned_explorer/ID_Images/Vehicles/'{1.png};

type
  //����� ���������� ����� ������
  TUnturnedItemBase = class
  private
    FDBFileName: string;                                                         //��� ����� ��
    FFromPath: string;                                                           //������� � Unturned.exe
    FLangInfo: TLangInfo;                                                        //����. � ����� ��������
    FLangIni: TIniFile;                                                          //�������� ini-����
    FOnProgress: TOnProgress;                                                    //������� ��������� ����������
    FRegProp: TRegProperies;                                                     //������ ������� ���������
    FRegPropV: TRegProperies;                                                    //������ ������� ����������
    FShowDefLang: Boolean;                                                       //���������� � ������� ������������ �������� ��������, �������
    FSQLBase: TSQLiteDatabase;                                                   //���� SQLite
    FUseLang: Boolean;                                                           //������������ ���� ��������
    FVersion: string;                                                            //������ �� (�� ����)
    function FGetItemCount: Integer;                                             //���-�� ���������
    function FOutdated: Boolean;                                                 //���� ����������� �� (�� ���� � ��������)
    function FVehicleCount: Integer;                                             //���-�� ����������
    function GetUnturnedVersion(AUnturnedPath: string): string;                   //������ ������ ���� � ��������
    function GetVersion: string;                                                //������ ��
    function GetVersionPath: string;                                            //������ ����
    function RestartSQL: Integer;                                                //������������ ����
    procedure CreateTables;                                                     //������� �������
    procedure FReadVersion;                                                     //�������� ������ ������� ��
    procedure Progress(Value: Integer; Info: string);                             //��������� ���������� ��������
    procedure RegProps;                                                         //����������� �������
    procedure ReloadInfo(AUnturnedPath: string);                                //�������� ���. �� ����
    procedure ReloadItems(AUnturnedPath: string);                               //�������� ���������
    procedure ReloadVehicle(AUnturnedPath: string);                             //�������� ����������
  public
    constructor Create(ADBFile: string); virtual;                                //�����������
    destructor Destroy; override;
    function GetDataItems(var Items: TDisplayDataItems; Group: Integer = -1): Integer; //�������� ������ ���������
    function GetDataVehicles(var Items: TDisplayDataVehicles; Group: Integer = -1): Integer; //�������� ������ ����������
    function GetGroupsItem(var Items: TGroups): Integer;                          //�������� ������ ����� ���������
    function GetGroupsVehicles(var Items: TGroups): Integer;                      //�������� ������ ����� ����������
    function GetItemData(const IID: Integer; var Item: TItemProperties): Boolean;  //�������� �������� ��������
    function GetItemIcon(const IID: Integer; var BMP: TBitmap): Boolean;           //�������� ������ (32) ��������
    function GetItemImage(const IID: Integer; var BMP: TBitmap): Boolean;          //�������� ����������� (128) ��������
    function GetVehicleData(const VID: Integer; var Item: TItemProperties): Boolean; //�������� �������� ����������
    function GetVehicleIcon(const ID: Integer; var BMP: TBitmap): Boolean;         //�������� ������ (32) ����������
    function GetVehicleImage(const ID: Integer; var BMP: TBitmap): Boolean;        //�������� ����������� (128) ����������
    function SetVehicleImage(const ID: Integer; BMP: TBitmap): Boolean;            //���������� ����������� � ������ ����������
    function UnloadDataStrings(AFile: string): Boolean;                           //��������� ����������� ������ � ����
    procedure DropTables;                                                       //�������� ������� (����� �����. ����������)
    procedure DropVehiclesImages;                                               //�������� ������� ����������� ����������
    procedure LoadLang(LangFileName: string);                                    //��������� �������
    procedure LoadVehicleImages(urlDir: string = urlVehicles);                   //��������� �����. ���������� � �����
    procedure RegProp(PropName, PropDesc: string; Logical: Boolean; IsID: Boolean = False); //����������� �������� ��������
    procedure RegPropVehicle(PropName, PropDesc: string; Logical: Boolean; IsID: Boolean = False); //����������� �������� ����������
    procedure ReloadFrom(AUnturnedPath: string = '');                            //���������� ���� ������ (������ � ��������� ������  � �����)
    property ItemCount: Integer read FGetItemCount;                              //���-�� ���������
    property LangInfo: TLangInfo read FLangInfo;                                 //���� � ����� ��������
    property OnProgress: TOnProgress read FOnProgress write FOnProgress;         //������� ���������
    property Outdated: Boolean read FOutdated;                                   //���� �����������
    property PathFrom: string read FFromPath write FFromPath;                    //������� � �����
    property ShowDefLang: Boolean read FShowDefLang write FShowDefLang;          //���������� ������������ �������� ��������, ��������
    property UsingLanguage: Boolean read FUseLang;                               //������������ ���� ��������
    property VehicleCount: Integer read FVehicleCount;                           //���-�� ����������
    property Version: string read GetVersion;                                    //������ ��
    property VersionPath: string read GetVersionPath;                            //������ ���� � ��������
  end;

const
  //������� ���������
  tnItems = 'ITEMS';
  //������� ������� ���������
  tnItemData = 'ITEMDATA';
  //������� ����������
  tnVehicles = 'VEHICLES';
  //������� ������� ����������
  tnVehiclesData = 'VEHICLEDATA';
  //������� ����������� ����������
  tnVehiclesImages = 'VEHICLEIMAGES';
  //������� ���������� �� ����
  tnInfoData = 'INFODATA';
  //������� ����� ���������
  tnItemGroups = 'ITEMGROUPS';
  //������� ����� ����������
  tnVehiclesGroups = 'VEHICLESGROUPS';

  //����. �������� ������������
  pbMax = 100;

  //���� � ����� � ���. �� ����
  pathInfo = '\Status.json';
  //���� � ������� ���������
  pathItemIcons = '\Extras\Icons\';
  //�������� ����� ���������� ����
  pathUnturnedExe = 'Unturned.exe';
  //���� � ���������
  pathItems = '\Bundles\Items\';
  //���� � ����������
  pathVehicles = '\Bundles\Vehicles\';
  //
  pathMaps = '\Maps\';
  //���� ������ ��������� � ����������
  pathItemsData = '.dat';

  //����� ���� ��������� Steam
function LookSteamPath(var SteamPath: string): Boolean;
  //����� ���� ��������� Unturned (������� �� LookSteamPath)

function LookUnturnedPath(var aUnturnedPath: string): Boolean;

implementation

//������ ��������
procedure RepVar(var Dest: string; Indent, VarInd: string);
var
  p: Word;
begin
  repeat
    p := Pos(Indent, AnsiLowerCase(Dest));
    if p <> 0 then
    begin
      if p = 1 then
        Dest := VarInd + Copy(Dest, p + Length(Indent), Length(Dest) - (p + Length(Indent)) + 1)
      else
        Dest := Copy(Dest, 1, p - 1) + VarInd + Copy(Dest, p + Length(Indent), Length(Dest) - (p + Length(Indent)) + 1)
    end;
  until p = 0;
end;

function LookSteamPath(var SteamPath: string): Boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  SteamPath := '';
  Reg := TRegistry.Create(KEY_READ);
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  if not Reg.OpenKeyReadOnly('SOFTWARE\Valve\Steam') then
    Exit;
  SteamPath := Reg.ReadString('InstallPath');
  Reg.Free;
  Result := True;
end;

function LookUnturnedPath(var aUnturnedPath: string): Boolean;
var
  SteamPath, tmp: string;
  Libs, Paths: TStringList;
  i, j, c: word;
begin
  Result := False;
  Paths := TStringList.Create;
  if LookSteamPath(SteamPath) then
  begin
    Libs := TStringList.Create;
    Libs.LoadFromFile(SteamPath + '\steamapps\libraryfolders.vdf');
    if Libs.Count > 0 then
    begin
      j := 1;
      for i := 0 to Libs.Count - 1 do
      begin
        if Pos('"' + IntToStr(j) + '"', Libs.Strings[i]) <> 0 then
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
      for i := 0 to Libs.Count - 1 do
      begin
        j := Pos('"', Libs.Strings[i], 5);
        if j = 0 then
          Continue;
        Inc(j);
        c := Length(Libs.Strings[i]);
        tmp := Copy(Libs.Strings[i], j, c - j);
        RepVar(tmp, '\\', '\');
        Paths.Add(tmp);
      end;
    end;
    Libs.Free;
  end;
  Paths.Add('C:\Games\SteamLibrary');
  Paths.Add('C:\Program Files\SteamLibrary');
  Paths.Add('C:\Program Files (x86)\SteamLibrary');
  for i := 0 to Paths.Count - 1 do
  begin
    if DirectoryExists(Paths.Strings[i] + '\steamapps\common\Unturned') then
    begin
      aUnturnedPath := Paths.Strings[i] + '\steamapps\common\Unturned';
      Result := True;
      Break;
    end;
  end;
  Paths.Free;
  if not Result then
    aUnturnedPath := '';
end;

{ TUnturnedItemBase }

procedure TUnturnedItemBase.RegProp;
var
  Prop: TRegProperty;
begin
  Prop.Key := PropName;
  Prop.Desc := PropDesc;
  Prop.IsID := IsID;
  Prop.Logical := Logical;
  FRegProp.Add(Prop);
end;

procedure TUnturnedItemBase.RegProps;
begin
 //RegProp('ID', '��-��������');
  RegProp('Health', '��������', False);
  RegProp('Food', '���', False);
  RegProp('Water', '����', False);
  RegProp('Energy', '�������', False);
  RegProp('Virus', '����������', False);
  RegProp('Volume', '��������', False);
  RegProp('Fuel', '�������', False);
  RegProp('Armor', '���������', False);
  RegProp('Magazine', 'ID ��������', False, True);
  RegProp('Sight', 'ID �������', False, True);
  RegProp('Barrel', 'ID �������', False, True);
  RegProp('Caliber', '������', False);
  RegProp('Silenced', '��������', False);
  RegProp('Firerate', '����������������', False);
  RegProp('Range', '������ ��������', False);
  RegProp('Player_Damage', '���� �������', False);
  RegProp('Zombie_Damage', '���� �����', False);
  RegProp('Animal_Damage', '���� ��������', False);
  RegProp('Barricade_Damage', '����������� ���������', False);
  RegProp('Structure_Damage', '����������� ���������', False);
  RegProp('Vehicle_Damage', '����������� ����������', False);
  RegProp('Resource_Damage', '���� ��������', False);
  RegProp('Object_Damage', '����������� ��������', False);
  RegProp('Reload_Time', '����� �����������', False);
  RegProp('Replace', '����� ����� ������', False);
  RegProp('Amount', '�����������', False);
  RegProp('Zoom', '���', False);
  RegProp('Width', '����������� (������)', False);
  RegProp('Height', '����������� (������)', False);
  RegProp('Warmth', '����������', True);
  RegProp('Warmth', '����������', False);
  RegProp('Aid', '������ ������', True);
  RegProp('Disinfectant', '�����������', False);
  RegProp('Broken', '������� ��������', True);
  RegProp('Bleeding', '��������� ������������', True);
  RegProp('Stamina', '������� ������', False);
  RegProp('Strength', '���������', False);
  RegProp('Strong', '����', False);
  RegProp('Slot', '�����', False);
  RegProp('Rarity', '��������', False);
  RegProp('Pro', '�����������', True);
  RegProp('Useable', '�������������', False);
  RegProp('Food_Constrains_Water', '��������� �����', True);
  RegProp('Action_0_Key Craft_Seed', '�������� ������', True);
  RegProp('Blueprint_0_Skill', '��������� �����', False);
  RegProp('Blueprint_0_Level', '������� �����', False);
  RegProp('Vision', '���������� ������', True);
  RegProp('Proof_Radiation', '������ �� ��������', True);
  RegProp('Proof_Water', '������ �� ���� (��������)', True);
  RegProp('Proof_Fire', '������ �� ����', True);
  RegProp('Blueprint_0_Product', '����� �������� �������', False, True);
  RegProp('Blueprint_0_Products', '���������� ���������', False);

  RegPropVehicle('Rarity', '��������', False);
  RegPropVehicle('Speed_Max', '����. ��������', False);
  RegPropVehicle('Fuel', '����� ����', False);
  RegPropVehicle('Health', '��������� �����', False);
  RegPropVehicle('Turrets', '������', False);
  RegPropVehicle('Passenger_Explosion_Armor', '���������� ����� �� ������', False);
end;

procedure TUnturnedItemBase.RegPropVehicle;
var
  Prop: TRegProperty;
begin
  Prop.Key := PropName;
  Prop.Desc := PropDesc;
  Prop.IsID := IsID;
  Prop.Logical := Logical;
  FRegPropV.Add(Prop);
end;

procedure TUnturnedItemBase.ReloadFrom(AUnturnedPath: string);
begin
  if not FileExists(AUnturnedPath + '\' + pathUnturnedExe) then
    Exit;
  FFromPath := AUnturnedPath;
  DropTables;
  ReloadInfo(FFromPath);
  ReloadItems(FFromPath);
  ReloadVehicle(FFromPath);
  LoadVehicleImages;
  Progress(50, '����������� ����...');
  FSQLBase.ExecSQL('VACUUM');
  Progress(100, '������');
end;

procedure TUnturnedItemBase.ReloadInfo;
begin
  Progress(50, '�������� ����������...');
  FVersion := GetUnturnedVersion(aUnturnedPath);
  with SQL.InsertInto do
  begin
    TableName := tnInfoData;
    AddValue('Key', 'Version');
    AddValue('Value', FVersion);
    FSQLBase.ExecSQL(GetSQL);
    EndCreate;
  end;
  Progress(pbMax, '�������� ���������� ���������');
end;

procedure TUnturnedItemBase.ReloadItems;
type
  TDataItem = record
    IID: Integer;
    ID: Integer;
    Group: Integer;
    Desc: string;
  end;
var
  GID: integer;
  IconsPath, ItemPath, tmp: string;
  ListItems: TStringList;
  SR, SRDir: TSearchRec;

  function LookIcon(Item: string): Integer;
  var
    it, P: Integer;
  begin
    Result := -1;
    if ListItems.Count <= 0 then
      Exit;
    for it := 0 to ListItems.Count - 1 do
    begin
      P := Pos(Item, ListItems.Strings[it]);
      if P <> 0 then
      begin
        Result := it;
        Break;
      end;
    end;
  end;

  function InsertItemData(ItemFile, IDesc: string; IGroup: Integer): TDataItem;
  var
    j, p: Integer;
    Data: TStringList;
    ResPos: Integer;
    Str, Query: string;
    Prop: TRegProperty;
  begin
    Data := TStringList.Create;
    try
      Data.LoadFromFile(ItemFile);
    except
    end;
    if Data.Count <= 0 then
    begin
      Data.Free;
      Exit;
    end;
    Result.ID := -1;
    Result.Desc := IDesc;
    Result.Group := IGroup;
    for j := 0 to Data.Count - 1 do
    begin
      Str := Data.Strings[j];
      if Result.ID = -1 then
      begin
        ResPos := Pos('ID ', Str);
        if ResPos = 1 then
        try
          Delete(Str, 1, 3);
          Result.ID := StrToInt(Str);
          Break;
        except
          Result.ID := 0;
        end;
      end;
    end;
    with SQL.InsertInto do
    begin
      TableName := tnItems;
      AddValue('ID', Result.ID);
      AddValue('Desc', Result.Desc);
      AddValue('GID', Result.Group);
      FSQLBase.ExecSQL(GetSQL);
      Result.IID := FSQLBase.LastInsertRowID;
      EndCreate;
    end;
    Query := '';
    for p := 0 to FRegProp.Count - 1 do
    begin
      Prop := FRegProp[p];
      Prop.TempFlag := False;
      FRegProp[p] := Prop;
    end;
    FSQLBase.BeginTransaction;
    try
      for j := 0 to Data.Count - 1 do
      begin
        Str := Data.Strings[j];
        for p := 0 to FRegProp.Count - 1 do
        begin
          if not FRegProp[p].TempFlag then
          begin
            if FRegProp[p].Logical then
              ResPos := Ord(FRegProp[p].Key = Str)
            else
              ResPos := Pos(FRegProp[p].Key + ' ', Str);
            if ResPos = 1 then
            begin
              Delete(Str, 1, Length(FRegProp[p].Key) + 1);
              with SQL.InsertInto do
              begin
                TableName := tnItemData;
                AddValue('IID', Result.IID);
                AddValue('IsID', FRegProp[p].IsID);
                AddValue('Key', FRegProp[p].Key);
                AddValue('Desc', FRegProp[p].Desc);
                AddValue('Value', Str);
                FSQLBase.ExecSQL(GetSQL);
                EndCreate;
              end;
              Prop := FRegProp[p];
              Prop.TempFlag := True;
              FRegProp[p] := Prop;
              Break;
            end;
          end;
        end;
      end;
      FSQLBase.Commit;
    except
      FSQLBase.Rollback;
    end;
    Data.Free;
  end;

  procedure FillItem(FileDat, DRName: string; GroupID: Integer);
  var
    str: string;
    PNGRect: TRect;
    IconFile: Integer;
    PNG: TPngImage;
    B32: Tbitmap;
    B128: Tbitmap;
    Stream: TMemoryStream;
    DI: TDataItem;
  begin
    str := DRName;
    RepVar(str, '_', ' ');
    DI := InsertItemData(FileDat, str, GroupID);
    IconFile := LookIcon(DRName + '_' + IntToStr(DI.ID));
    if IconFile > 0 then
    begin
      PNG := TPngImage.Create;
      B32 := TBitmap.Create;
      B128 := TBitmap.Create;
      try
        PNG.LoadFromFile(IconsPath + ListItems.Strings[IconFile]);
    //32x32
        PNGRect.Left := 0;
        PNGRect.Top := 0;
        if PNG.Width > PNG.Height then
        begin
          PNGRect.Width := 32;
          PNGRect.Height := Round(PNG.Height * (32 / PNG.Width));
        end
        else if PNG.Width < PNG.Height then
        begin
          PNGRect.Height := 32;
          PNGRect.Width := Round(PNG.Width * (32 / PNG.Height));
        end
        else
        begin
          PNGRect.Width := 32;
          PNGRect.Height := 32;
        end;
        OffsetRect(PNGRect, Round((32 / 2) - (PNGRect.Width / 2)), Round((32 / 2) - (PNGRect.Height / 2)));
        B32.SetSize(32, 32);
        B32.Canvas.StretchDraw(PNGRect, PNG);
    //128x128
        PNGRect.Left := 0;
        PNGRect.Top := 0;
        if PNG.Width > PNG.Height then
        begin
          PNGRect.Width := 128;
          PNGRect.Height := Round(PNG.Height * (128 / PNG.Width));
        end
        else if PNG.Width < PNG.Height then
        begin
          PNGRect.Height := 128;
          PNGRect.Width := Round(PNG.Width * (128 / PNG.Height));
        end
        else
        begin
          PNGRect.Width := 128;
          PNGRect.Height := 128;
        end;
        OffsetRect(PNGRect, Round((128 / 2) - (PNGRect.Width / 2)), Round((128 / 2) - (PNGRect.Height / 2)));
    //PNGRect.Top:=Round((128 / 2) - (PNGRect.Height / 2));
    //PNGRect.Left:=Round((128 / 2) - (PNGRect.Width / 2));
        B128.SetSize(128, 128);
        B128.Canvas.StretchDraw(PNGRect, PNG);

        Stream := TMemoryStream.Create;
        try
          B128.SaveToStream(Stream);
          Stream.Position := 0;
          with SQL.UpdateBlob(tnItems) do
          begin
            BlobField := 'Image';
            WhereFieldEqual('IID', DI.IID);
            FSQLBase.UpdateBlob(GetSQL, Stream);
            EndCreate;
          end;
          Stream.Clear;
        finally
          Stream.Free;
        end;

        Stream := TMemoryStream.Create;
        try
          B32.SaveToStream(Stream);
          Stream.Position := 0;
          with SQL.UpdateBlob(tnItems) do
          begin
            BlobField := 'Icon';
            WhereFieldEqual('IID', DI.IID);
            FSQLBase.UpdateBlob(GetSQL, Stream);
            EndCreate;
          end;
          Stream.Clear;
        finally
          Stream.Free;
        end;
      finally
        begin
          PNG.Free;
          B128.Free;
          B32.Free;
        end;
      end;
    end;
  end;

  procedure FillItemGroup(Dir, SRName: string; GroupID: Integer);
  var
    DR: TSearchRec;
    FName: string;
  begin
    if FindFirst(Dir + '\' + SRName + '\*.*', faDirectory, DR) = 0 then
      repeat
        if (DR.Name = '.') or (DR.Name = '..') then
          Continue;
        FName := Dir + '\' + SRName + '\' + DR.Name + '\' + DR.Name + pathItemsData;
        if not FileExists(FName) then
        begin
          FName := Dir + '\' + SRName + '\' + DR.Name + '\Asset' + pathItemsData;
          if not FileExists(FName) then
          begin
            FillItemGroup(Dir, SRName + '\' + DR.Name, GroupID);
            Continue;
          end;
        end;
        FillItem(FName, DR.Name, GroupID);
      until (FindNext(DR) <> 0);
  end;

begin
  Progress(Round(pbMax * (1 / 5)), '�������� ������ �����: ����� ������� �����...');

  IconsPath := aUnturnedPath + pathItemIcons;
  ListItems := TStringList.Create;

  if (FindFirst(IconsPath + '*.png', faAnyFile, SR) = 0) then
    repeat
      ListItems.Add(SR.Name);
    until (FindNext(SR) <> 0);

  ItemPath := aUnturnedPath + pathItems;

  Progress(Round(pbMax * (2 / 5)), '�������� ������ �����: ������ ���������� �����...');
  if (FindFirst(ItemPath + '*.*', faDirectory, SR) = 0) then
    repeat
      if (SR.Name = '.') or (SR.Name = '..') then
        Continue;
      if not DirectoryExists(ItemPath + SR.Name) then
        Continue;
      Progress(Round(pbMax * (3 / 5)), '�������� ������ �����: ' + SR.Name);
      with SQL.InsertInto do
      begin
        TableName := tnItemGroups;
        AddValue('Desc', SR.Name);
        FSQLBase.ExecSQL(GetSQL);
        EndCreate;
      end;
      GID := FSQLBase.LastInsertRowID;
      FillItemGroup(ItemPath, SR.Name, GID);
    until (FindNext(SR) <> 0);
  FindClose(SR);

  if (FindFirst(aUnturnedPath + pathMaps + '*.*', faDirectory, SRDir) = 0) then
    repeat
      if (SRDir.Name = '.') or (SRDir.Name = '..') then
        Continue;
      if not DirectoryExists(aUnturnedPath + pathMaps + SRDir.Name) then
        Continue;
      Progress(Round(pbMax * (4 / 5)), '�������� ������ �����: ' + SRDir.Name);
      ItemPath := aUnturnedPath + pathMaps + SRDir.Name + pathItems;
      if (FindFirst(ItemPath + '*.*', faDirectory, SR) = 0) then
        repeat
          if (SR.Name = '.') or (SR.Name = '..') then
            Continue;
          if not DirectoryExists(ItemPath + SR.Name) then
            Continue;

          tmp := ItemPath + '\' + SR.Name + '\' + SR.Name + pathItemsData;
          if FileExists(tmp) then
          begin
            with SQL.InsertInto do
            begin
              TableName := tnItemGroups;
              AddValue('Desc', SRDir.Name);
              FSQLBase.ExecSQL(GetSQL);
              EndCreate;
            end;
            GID := FSQLBase.LastInsertRowID;
            FillItem(tmp, SR.Name, GID);
            Continue;
          end;

          Progress(Round(pbMax * (4 / 5)), '�������� ������ �����: ' + SR.Name);
          with SQL.InsertInto do
          begin
            TableName := tnItemGroups;
            AddValue('Desc', SR.Name + ' ' + SRDir.Name);
            FSQLBase.ExecSQL(GetSQL);
            EndCreate;
          end;
          GID := FSQLBase.LastInsertRowID;
          FillItemGroup(ItemPath, SR.Name, GID);
        until (FindNext(SR) <> 0);
      FindClose(SR);
    until (FindNext(SRDir) <> 0);
  FindClose(SRDir);
  ListItems.Free;
  Progress(Round(pbMax), '������');
end;

procedure TUnturnedItemBase.ReloadVehicle;
type
  TDataItem = record
    VID: Integer;
    ID: Integer;
    Group: Integer;
    Desc: string;
    Speed: Double;
    Fuel: Double;
    Health: Double;
    Engine: string;
  end;
var
  ItemPath: string;
  DI: TDataItem;
  SR, SRDir: TSearchRec;

  function InsertItemData(ItemFile, IDesc, Map: string): TDataItem;
  var
    j: Word;
    Data: TStringList;
    ResPos, p: Integer;
    Str, Query: string;
    Prop: TRegProperty;
    Table: TSQLiteTable;
  begin
    Data := TStringList.Create;
    try
      Data.LoadFromFile(ItemFile);
    except
    end;
    if Data.Count <= 0 then
    begin
      Data.Free;
      Exit;
    end;
    Result.Desc := IDesc;
    RepVar(Result.Desc, '_', ' ');
    Result.ID := -1;
    Result.Group := -1;
    Result.Speed := -1;
    Result.Fuel := -1;
    Result.Health := -1;
    Result.Engine := '';
    for j := 0 to Data.Count - 1 do
    begin
      Str := Data.Strings[j];
      if Result.ID = -1 then
      begin
        ResPos := Pos('ID ', Str);
        if ResPos = 1 then
        try
          Delete(Str, 1, 3);
          Result.ID := StrToInt(Str);
          Continue;
        except
          Result.ID := 0;
        end;
      end;

      if Result.Speed = -1 then
      begin
        ResPos := Pos('Speed_Max ', Str);
        if ResPos = 1 then
        try
          Delete(Str, 1, Length('Speed_Max') + 1);
          RepVar(Str, '.', ',');
          Result.Speed := StrToFloat(Str);
          Continue;
        except
          Result.Speed := 0;
        end;
      end;

      if Result.Fuel = -1 then
      begin
        ResPos := Pos('Fuel ', Str);
        if ResPos = 1 then
        try
          Delete(Str, 1, Length('Fuel') + 1);
          RepVar(Str, '.', ',');
          Result.Fuel := StrToFloat(Str);
          Continue;
        except
          Result.Fuel := 0;
        end;
      end;

      if Result.Health = -1 then
      begin
        ResPos := Pos('Health ', Str);
        if ResPos = 1 then
        try
          Delete(Str, 1, Length('Health') + 1);
          RepVar(Str, '.', ',');
          Result.Health := StrToFloat(Str);
          Continue;
        except
          Result.Health := 0;
        end;
      end;

      if Result.Engine = '' then
      begin
        ResPos := Pos('Engine ', Str);
        if ResPos = 1 then
        try
          Delete(Str, 1, Length('Engine') + 1);
          Result.Engine := Str;
          Continue;
        except
        end;
      end;
    end;
    if Result.Engine = '' then
      Result.Engine := 'Vehicle';
    if Map <> '' then
      Result.Engine := Result.Engine + ' ' + Map;
    with SQl.Select(tnVehiclesGroups, 'GID') do
    begin
      WhereFieldEqual('Desc', Result.Engine);
      Table := FSQLBase.Query(GetSQL);
      EndCreate;
    end;
    if Table.RowCount <= 0 then
    begin
      with SQL.InsertInto do
      begin
        TableName := tnVehiclesGroups;
        AddValue('Desc', Result.Engine);
        FSQLBase.ExecSQL(GetSQL);
        Result.Group := FSQLBase.LastInsertRowID;
        EndCreate;
      end;
    end
    else
      Result.Group := Table.FieldAsInteger(0);
    Table.Free;

    with SQL.InsertInto do
    begin
      TableName := tnVehicles;
      AddValue('ID', Result.ID);
      AddValue('Desc', Result.Desc);
      AddValue('GID', Result.Group);
      AddValue('Speed', Result.Speed);
      AddValue('Fuel', Result.Fuel);
      AddValue('Health', Result.Health);
      FSQLBase.ExecSQL(GetSQL);
      Result.VID := FSQLBase.LastInsertRowID;
      EndCreate;
    end;

    Query := '';
    for p := 0 to FRegPropV.Count - 1 do
    begin
      Prop := FRegPropV[p];
      Prop.TempFlag := False;
      FRegPropV[p] := Prop;
    end;
    FSQLBase.BeginTransaction;
    try
      for j := 0 to Data.Count - 1 do
      begin
        Str := Data.Strings[j];
        for p := 0 to FRegPropV.Count - 1 do
        begin
          if not FRegPropV[p].TempFlag then
          begin
            if FRegPropV[p].Logical then
              ResPos := Ord(FRegProp[p].Key = Str)
            else
              ResPos := Pos(FRegPropV[p].Key + ' ', Str);
            if ResPos = 1 then
            begin
              Delete(Str, 1, Length(FRegPropV[p].Key) + 1);
              with SQL.InsertInto do
              begin
                TableName := tnVehiclesData;
                AddValue('VID', Result.VID);
                AddValue('IsID', FRegPropV[p].IsID);
                AddValue('Key', FRegPropV[p].Key);
                AddValue('Desc', FRegPropV[p].Desc);
                AddValue('Value', Str);
                FSQLBase.ExecSQL(GetSQL);
                EndCreate;
              end;
              Prop := FRegPropV[p];
              Prop.TempFlag := True;
              FRegPropV[p] := Prop;
              Break;
            end;
          end;
        end;
      end;
      FSQLBase.Commit;
    except
      FSQLBase.Rollback;
    end;
    Data.Free;
  end;

  procedure ProcFolder(Path, Map: string);
  var
    Search: TSearchRec;
  begin
    if (FindFirst(Path + '\*.*', faDirectory, Search) = 0) then
      repeat
        if (Search.Name = '.') or (Search.Name = '..') then
          Continue;
        Progress(Round(pbMax * (3 / 4)), '�������� ������ ����������: ' + Search.Name + '...');
        if not FileExists(Path + '\' + Search.Name + '\' + Search.Name + pathItemsData) then
        begin
          ProcFolder(Path + '\' + Search.Name, Map);
          Continue;
        end;
        DI := InsertItemData(Path + '\' + Search.Name + '\' + Search.Name + pathItemsData, Search.Name, Map);
      until (FindNext(Search) <> 0);
    FindClose(Search);
  end;

begin
  Progress(1, '�������� ������ ����������...');

  ItemPath := aUnturnedPath + pathVehicles;

  Progress(Round(pbMax * (1 / 4)), '�������� ������ ����������...');
  if (FindFirst(ItemPath + '*.*', faDirectory, SR) = 0) then
    repeat
      if not FileExists(ItemPath + SR.Name + '\' + SR.Name + pathItemsData) then
        Continue;
      Progress(Round(pbMax * (2 / 4)), '�������� ������ ����������: ' + SR.Name + '...');
      DI := InsertItemData(ItemPath + SR.Name + '\' + SR.Name + pathItemsData, SR.Name, '');
    until (FindNext(SR) <> 0);
  FindClose(SR);

  if (FindFirst(aUnturnedPath + pathMaps + '*.*', faDirectory, SRDir) = 0) then
    repeat
      if (SRDir.Name = '.') or (SRDir.Name = '..') then
        Continue;
      if not DirectoryExists(aUnturnedPath + pathMaps + SRDir.Name) then
        Continue;
      Progress(Round(pbMax * (3 / 4)), '�������� ������ ����������: ' + SRDir.Name);
      ItemPath := aUnturnedPath + pathMaps + SRDir.Name + pathVehicles;
      ProcFolder(ItemPath, SRDir.Name);
    until (FindNext(SRDir) <> 0);
  FindClose(SRDir);

  Progress(Round(pbMax), '������');
end;

function TUnturnedItemBase.RestartSQL: Integer;
begin
  try
    if Assigned(FSQLBase) then
    begin
      FSQLBase.Free;
    end;
    FSQLBase := TSQLiteDatabase.Create(FDBFileName);
    FSQLBase.ExecSQL('PRAGMA synchronous = OFF');
    FSQLBase.ExecSQL('PRAGMA temp_store = MEMORY');
    Result := ERROR_SUCCESS;
  except
    Result := ERROR_OPEN_FAILED;
  end;
end;

function TUnturnedItemBase.SetVehicleImage(const ID: Integer; BMP: TBitmap): Boolean;
var
  VDID: Integer;
  Stream: TMemoryStream;
  PNGRect: TRect;
  B32, B128: TBitmap;
begin
  Result := False;
  try
  //32x32
    PNGRect.Left := 0;
    PNGRect.Top := 0;
    if BMP.Width > BMP.Height then
    begin
      PNGRect.Width := 32;
      PNGRect.Height := Round(BMP.Height * (32 / BMP.Width));
    end
    else if BMP.Width < BMP.Height then
    begin
      PNGRect.Height := 32;
      PNGRect.Width := Round(BMP.Width * (32 / BMP.Height));
    end
    else
    begin
      PNGRect.Width := 32;
      PNGRect.Height := 32;
    end;
    OffsetRect(PNGRect, Round((32 / 2) - (PNGRect.Width / 2)), Round((32 / 2) - (PNGRect.Height / 2)));
    B32 := TBitmap.Create;
    B32.SetSize(32, 32);
    B32.Canvas.StretchDraw(PNGRect, BMP);
  //128x128
    PNGRect.Left := 0;
    PNGRect.Top := 0;
    if BMP.Width > BMP.Height then
    begin
      PNGRect.Width := 128;
      PNGRect.Height := Round(BMP.Height * (128 / BMP.Width));
    end
    else if BMP.Width < BMP.Height then
    begin
      PNGRect.Height := 128;
      PNGRect.Width := Round(BMP.Width * (128 / BMP.Height));
    end
    else
    begin
      PNGRect.Width := 128;
      PNGRect.Height := 128;
    end;
    OffsetRect(PNGRect, Round((128 / 2) - (PNGRect.Width / 2)), Round((128 / 2) - (PNGRect.Height / 2)));
    B128 := TBitmap.Create;
    B128.SetSize(128, 128);
    B128.Canvas.StretchDraw(PNGRect, BMP);
    with SQL.Delete do
    begin
      TableName := tnVehiclesImages;
      WhereFieldEqual('ID', ID);
      FSQLBase.ExecSQL(GetSQL);
      EndCreate;
    end;
    with SQL.InsertInto do
    begin
      TableName := tnVehiclesImages;
      AddValue('ID', ID);
      FSQLBase.ExecSQL(GetSQL);
      VDID := FSQLBase.LastInsertRowID;

      Stream := TMemoryStream.Create;
      B128.SaveToStream(Stream);
      Stream.Position := 0;
      with SQL.UpdateBlob(tnVehiclesImages) do
      begin
        BlobField := 'Image';
        WhereFieldEqual('VDID', VDID);
        FSQLBase.UpdateBlob(GetSQL, Stream);
        EndCreate;
      end;
      Stream.Free;
      B128.Free;

      Stream := TMemoryStream.Create;
      B32.SaveToStream(Stream);
      Stream.Position := 0;
      with SQL.UpdateBlob(tnVehiclesImages) do
      begin
        BlobField := 'Icon';
        WhereFieldEqual('VDID', VDID);
        FSQLBase.UpdateBlob(GetSQL, Stream);
        EndCreate;
      end;
      Stream.Free;
      B32.Free;

      EndCreate;
    end;
  except
  end;
end;

function TUnturnedItemBase.UnloadDataStrings(AFile: string): Boolean;
var
  FileStrings: TStringList;
  Abc: set of Char;
  Str: string;
begin
  FileStrings := TStringList.Create;
  Abc := ['a'..'z', 'A'..'Z'];
  FileStrings.Add('[' + tnItems + ']');
  with SQL.Select(tnItems, ['ID', 'Desc']) do
  begin
    with FSQLBase.Query(GetSQL) do
    begin
      while not Eof do
      begin
        FileStrings.Add(FieldAsString(0) + #9 + FieldAsString(1));
        Next;
      end;
      Free;
    end;
    EndCreate;
  end;
  FileStrings.Add('[' + tnItemData + ']');
  with SQL.Select(tnItemData, 'DISTINCT Value') do
  begin
    with FSQLBase.Query(GetSQL) do
    begin
      while not Eof do
      begin
        Str := FieldAsString(0);
        if Str.Length > 0 then
          if CharInSet(Str[1], Abc) then
            FileStrings.Add(Str);
        Next;
      end;
      Free;
    end;
    EndCreate;
  end;
  FileStrings.Add('[' + tnItemGroups + ']');
  with SQL.Select(tnItemGroups, 'DISTINCT Desc') do
  begin
    with FSQLBase.Query(GetSQL) do
    begin
      while not Eof do
      begin
        FileStrings.Add(FieldAsString(0));
        Next;
      end;
      Free;
    end;
    EndCreate;
  end;
  FileStrings.Add('[' + tnVehicles + ']');
  with SQL.Select(tnVehicles, ['ID', 'Desc']) do
  begin
    with FSQLBase.Query(GetSQL) do
    begin
      while not Eof do
      begin
        FileStrings.Add(FieldAsString(0) + #9 + FieldAsString(1));
        Next;
      end;
      Free;
    end;
    EndCreate;
  end;
  FileStrings.Add('[' + tnVehiclesData + ']');
  with SQL.Select(tnVehiclesData, 'DISTINCT Value') do
  begin
    with FSQLBase.Query(GetSQL) do
    begin
      while not Eof do
      begin
        Str := FieldAsString(0);
        if Str.Length > 0 then
          if CharInSet(Str[1], Abc) then
            FileStrings.Add(Str);
        Next;
      end;
      Free;
    end;
    EndCreate;
  end;
  FileStrings.Add('[' + tnVehiclesGroups + ']');
  with SQL.Select(tnVehiclesGroups, 'Desc') do
  begin
    with FSQLBase.Query(GetSQL) do
    begin
      while not Eof do
      begin
        FileStrings.Add(FieldAsString(0));
        Next;
      end;
      Free;
    end;
    EndCreate;
  end;
  FileStrings.SaveToFile(AFile);
  FileStrings.Free;
  Result := True;
end;

function TUnturnedItemBase.GetVehicleData(const VID: Integer; var Item: TItemProperties): Boolean;
var
  Table: TSQLiteTable;
  Prop: TItemPorp;
  LangStr: string;
begin
  with SQL.Select(tnVehiclesData, ['Key', 'Desc', 'IsID', 'Value']) do
  begin
    WhereFieldEqual('VID', VID);
    Table := FSQLBase.Query(GetSQL);
    EndCreate;
  end;
  Item.Clear;
  while not Table.EOF do
  begin
    Prop.Key := Table.FieldAsString(0);
    Prop.Desc := Table.FieldAsString(1);
    Prop.IsID := Boolean(Table.FieldAsInteger(2));
    Prop.Value := Table.FieldAsString(3);
    if FUseLang then
    begin
      LangStr := FLangIni.ReadString(tnVehiclesData, Prop.Value, '');
      if LangStr <> '' then
        Prop.Value := LangStr;
    end;
    Item.Add(Prop);
    Table.Next;
  end;
  Result := Table.RowCount > 0;
  Table.Free;
end;

function TUnturnedItemBase.GetVehicleIcon(const ID: Integer; var BMP: TBitmap): Boolean;
var
  Table: TSQLiteTable;
  Mem: TMemoryStream;
begin
  Result := False;
  with SQL.Select(tnVehiclesImages, 'Icon') do
  begin
    WhereFieldEqual('ID', ID);
    Table := FSQLBase.Query(GetSQL);
    EndCreate;
  end;
  if Table.RowCount > 0 then
  begin
    Mem := Table.FieldAsBlob(0);
    if Mem <> nil then
    begin
      Mem.Position := 0;
      BMP.LoadFromStream(Mem);
      Mem.Clear;
      Result := True;
    end;
  end;
  Table.Free;
end;

function TUnturnedItemBase.GetVehicleImage(const ID: Integer; var BMP: TBitmap): Boolean;
var
  Table: TSQLiteTable;
  Mem: TMemoryStream;
begin
  Result := False;
  with SQL.Select(tnVehiclesImages, 'Image') do
  begin
    WhereFieldEqual('ID', ID);
    Table := FSQLBase.Query(GetSQL);
    EndCreate;
  end;
  if Table.RowCount > 0 then
  begin
    Mem := Table.FieldAsBlob(0);
    if Mem <> nil then
    begin
      Mem.Position := 0;
      BMP.LoadFromStream(Mem);
      Mem.Clear;
      Result := True;
    end;
  end;
  Table.Free;
end;

function TUnturnedItemBase.GetVersion: string;
begin
  if FVersion = '' then
    FReadVersion;
  Result := FVersion;
end;

function TUnturnedItemBase.GetVersionPath: string;
begin
  Result := GetUnturnedVersion(FFromPath);
end;

procedure TUnturnedItemBase.LoadLang(LangFileName: string);
begin
  try
    if FileExists(LangFileName) then
    begin
      FLangIni := TIniFile.Create(LangFileName);
      FLangInfo.Version := FLangIni.ReadString('INFO', 'Version', '');
      FLangInfo.Autor := FLangIni.ReadString('INFO', 'Autor', '');
      FLangInfo.Desc := FLangIni.ReadString('INFO', 'Description', '');
      FUseLang := True;
    end
    else
      FUseLang := False;
  except
    FUseLang := False;
  end;
  if not FUseLang then
  begin
    FLangInfo.Version := '';
    FLangInfo.Autor := '';
    FLangInfo.Desc := '';
  end;
end;

procedure TUnturnedItemBase.LoadVehicleImages(urlDir: string);
const
  BufferSize = 64 * 1024;
var
  hSession, hfile: hInternet;
  dwIndex, dwCodeLen: DWORD;
  dwCode: array[1..20] of char;
  Res: PChar;
  DoLoad: Boolean;
  hURL: string;
  Buffer: array[1..BufferSize] of Byte;
  BufferLen: DWORD;
  Stream: TMemoryStream;
  FVehicles: TDisplayDataVehicles;
  i: Integer;
  PNG: TPngImage;
  BMP: TBitmap;
begin
  if Pos('http://', AnsiLowerCase(urlDir)) <> 1 then
    urlDir := 'http://' + urlDir;
  hSession := InternetOpen('UExplorer', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if not Assigned(hSession) then
    Exit;
  FVehicles := TDisplayDataVehicles.Create;
  GetDataVehicles(FVehicles);
  Progress(1, '�������� ����������� ����������: ...');
  for i := 0 to FVehicles.Count - 1 do
  begin
    hURL := urlDir + IntToStr(FVehicles[i].ID) + '.png';
    Progress(Round((pbMax / FVehicles.Count) * i), '�������� ����������� ����������: ' + hURL);
    hfile := InternetOpenUrl(hSession, PChar(hURL), nil, 0, INTERNET_FLAG_RELOAD, 0);
    dwIndex := 0;
    dwCodeLen := 10;
    HttpQueryInfo(hfile, HTTP_QUERY_STATUS_CODE, @dwCode, dwCodeLen, dwIndex);
    Res := PChar(@dwCode);
    DoLoad := (Res = '200') or (Res = '302');
    if not Assigned(hfile) then
      Continue;
    if DoLoad then
    begin
      Stream := TMemoryStream.Create;
      repeat
        BufferLen := 0;
        if InternetReadFile(hfile, @Buffer, SizeOf(Buffer), BufferLen) then
          if BufferLen > 0 then
            Stream.WriteBuffer(Buffer, BufferLen);
      until BufferLen = 0;
      Stream.Position := 0;
      if Stream.Size > 0 then
      begin
        BMP := TBitmap.Create;
        PNG := TPngImage.Create;
        try
          PNG.LoadFromStream(Stream);
          BMP.SetSize(PNG.Width, PNG.Height);
          BMP.Canvas.Draw(0, 0, PNG);
          SetVehicleImage(FVehicles[i].ID, BMP);
        finally
          begin
            PNG.Free;
            BMP.Free;
          end;
        end;
      end;
      Stream.Free;
    end;
    InternetCloseHandle(hfile);
  end;

  FVehicles.Free;
  InternetCloseHandle(hSession);
  Progress(pbMax, '�������� ����������� ����������: ������');
end;

procedure TUnturnedItemBase.CreateTables;
begin
  with SQL.CreateTable do
  begin
    if not FSQLBase.TableExists(tnInfoData) then
    begin
      TableName := tnInfoData;
      AddField('ID', ftInteger, True, True);
      AddField('Key', ftString);
      AddField('Value', ftString);
      FSQLBase.ExecSQL(GetSQL);
      Clear;
    end;

    if not FSQLBase.TableExists(tnItems) then
    begin
      TableName := tnItems;
      AddField('IID', ftInteger, True, True);
      AddField('ID', ftInteger);
      AddField('Image', ftBlob);
      AddField('Icon', ftBlob);
      AddField('Desc', ftString);
      AddField('GID', ftInteger);
      FSQLBase.ExecSQL(GetSQL);
      Clear;
    end;

    if not FSQLBase.TableExists(tnItemData) then
    begin
      TableName := tnItemData;
      AddField('DID', ftInteger, True, True);
      AddField('IID', ftInteger);
      AddField('IsID', ftBoolean);
      AddField('Key', ftString);
      AddField('Desc', ftString);
      AddField('Value', ftString);
      FSQLBase.ExecSQL(GetSQL);
      Clear;
    end;

    if not FSQLBase.TableExists(tnItemGroups) then
    begin
      TableName := tnItemGroups;
      AddField('GID', ftInteger, True, True);
      AddField('Desc', ftString);
      FSQLBase.ExecSQL(GetSQL);
      Clear;
    end;

    if not FSQLBase.TableExists(tnVehicles) then
    begin
      TableName := tnVehicles;
      AddField('VID', ftInteger, True, True);
      AddField('ID', ftInteger);
      AddField('Desc', ftString);
      AddField('Speed', ftFloat);
      AddField('Health', ftFloat);
      AddField('Fuel', ftFloat);
      AddField('GID', ftInteger);
      FSQLBase.ExecSQL(GetSQL);
      Clear;
    end;

    if not FSQLBase.TableExists(tnVehiclesData) then
    begin
      TableName := tnVehiclesData;
      AddField('DID', ftInteger, True, True);
      AddField('VID', ftInteger);
      AddField('IsID', ftBoolean);
      AddField('Key', ftString);
      AddField('Desc', ftString);
      AddField('Value', ftString);
      FSQLBase.ExecSQL(GetSQL);
      Clear;
    end;

    if not FSQLBase.TableExists(tnVehiclesImages) then
    begin
      TableName := tnVehiclesImages;
      AddField('VDID', ftInteger, True, True);
      AddField('ID', ftInteger);
      AddField('Image', ftBlob);
      AddField('Icon', ftBlob);
      FSQLBase.ExecSQL(GetSQL);
      Clear;
    end;

    if not FSQLBase.TableExists(tnVehiclesGroups) then
    begin
      TableName := tnVehiclesGroups;
      AddField('GID', ftInteger, True, True);
      AddField('Desc', ftString);
      FSQLBase.ExecSQL(GetSQL);
      Clear;
    end;

    EndCreate;
  end;
end;

procedure TUnturnedItemBase.DropTables;
begin
  with SQL.Delete do
  begin
    if FSQLBase.TableExists(tnInfoData) then
    begin
      TableName := tnInfoData;
      FSQLBase.ExecSQL(GetSQL);
    end;

    if FSQLBase.TableExists(tnItems) then
    begin
      TableName := tnItems;
      FSQLBase.ExecSQL(GetSQL);
    end;

    if FSQLBase.TableExists(tnItemData) then
    begin
      TableName := tnItemData;
      FSQLBase.ExecSQL(GetSQL);
    end;

    if FSQLBase.TableExists(tnItemGroups) then
    begin
      TableName := tnItemGroups;
      FSQLBase.ExecSQL(GetSQL);
    end;

    if FSQLBase.TableExists(tnVehicles) then
    begin
      TableName := tnVehicles;
      FSQLBase.ExecSQL(GetSQL);
    end;

    if FSQLBase.TableExists(tnVehiclesData) then
    begin
      TableName := tnVehiclesData;
      FSQLBase.ExecSQL(GetSQL);
    end;

    if FSQLBase.TableExists(tnVehiclesGroups) then
    begin
      TableName := tnVehiclesGroups;
      FSQLBase.ExecSQL(GetSQL);
    end;

    EndCreate;
  end;
end;

procedure TUnturnedItemBase.DropVehiclesImages;
begin
  with SQL.Delete do
  begin
    if FSQLBase.TableExists(tnVehiclesImages) then
    begin
      TableName := tnVehiclesImages;
      FSQLBase.ExecSQL(GetSQL);
    end;
    EndCreate;
  end;
end;

function TUnturnedItemBase.FGetItemCount: Integer;
begin
  with SQL.Select(tnItems, 'COUNT(*)') do
  begin
    Result := FSQLBase.GetTableValue(GetSQL);
    EndCreate;
  end;
end;

function TUnturnedItemBase.FOutdated: Boolean;
begin
  Result := True;
  if FVersion = '' then
    Exit;
  Result := Version <> GetUnturnedVersion(FFromPath);
end;

procedure TUnturnedItemBase.FReadVersion;
begin
  with SQL.Select(tnInfoData, 'Value') do
  begin
    WhereFieldEqual('Key', 'Version');
    FVersion := FSQLBase.GetTableString(GetSQL);
    EndCreate;
  end;
end;

function TUnturnedItemBase.FVehicleCount: Integer;
begin
  with SQL.Select(tnVehicles, 'COUNT(*)') do
  begin
    Result := FSQLBase.GetTableValue(GetSQL);
    EndCreate;
  end;
end;

function TUnturnedItemBase.GetDataItems;
var
  Item: TDisplayDataItem;
  Table: TSQLiteTable;
  SelQuery, LangStr: string;
begin
  Items.Clear;
  SelQuery := 'SELECT IID, ID, ITEMS.Desc, ITEMGROUPS.Desc FROM ITEMS INNER JOIN ITEMGROUPS ON ITEMS.GID = ITEMGROUPS.GID';
  if Group <> -1 then
    SelQuery := SelQuery + ' WHERE ITEMS.GID = ' + QuotedStr(IntToStr(Group));
  SelQuery := SelQuery + ' ORDER BY ITEMS.GID, ITEMS.ID';

  Table := FSQLBase.Query(SelQuery);
  while not Table.EOF do
  begin
    Item.IID := Table.FieldAsInteger(0);
    Item.ID := Table.FieldAsInteger(1);
    Item.Desc := Table.FieldAsString(2);
    if FUseLang then
    begin
      LangStr := FLangIni.ReadString(tnItems, IntToStr(Item.ID), '');
      if LangStr <> '' then
      begin
        if ShowDefLang then
          Item.Desc := LangStr + ' (' + Item.Desc + ')'
        else
          Item.Desc := LangStr;
      end;
    end;
    Item.Group := Table.FieldAsString(3);
    if FUseLang then
    begin
      LangStr := FLangIni.ReadString(tnItemGroups, Item.Group, '');
      if LangStr <> '' then
        Item.Group := LangStr;
    end;
    Items.Add(Item);
    Table.Next;
  end;
  Result := Table.RowCount;
  Table.Free;
end;

function TUnturnedItemBase.GetDataVehicles(var Items: TDisplayDataVehicles; Group: Integer): Integer;
var
  Item: TDisplayDataVehicle;
  Table: TSQLiteTable;
  SelQuery, LangStr: string;
begin
  Items.Clear;
  SelQuery :=
    'SELECT VID, ID, VEHICLES.Desc, VEHICLESGROUPS.Desc, Speed, Fuel, Health FROM VEHICLES INNER JOIN VEHICLESGROUPS ON VEHICLES.GID = VEHICLESGROUPS.GID';
  if Group <> -1 then
    SelQuery := SelQuery + ' WHERE VEHICLES.GID = ' + QuotedStr(IntToStr(Group));
  SelQuery := SelQuery + ' ORDER BY VEHICLES.GID, VEHICLES.ID';

  Table := FSQLBase.Query(SelQuery);
  while not Table.EOF do
  begin
    Item.VID := Table.FieldAsInteger(0);
    Item.ID := Table.FieldAsInteger(1);
    Item.Desc := Table.FieldAsString(2);
    if FUseLang then
    begin
      LangStr := FLangIni.ReadString(tnVehicles, IntToStr(Item.ID), '');
      if LangStr <> '' then
      begin
        if ShowDefLang then
          Item.Desc := LangStr + ' (' + Item.Desc + ')'
        else
          Item.Desc := LangStr;
      end;
    end;
    Item.Group := Table.FieldAsString(3);
    if FUseLang then
    begin
      LangStr := FLangIni.ReadString(tnVehiclesGroups, Item.Group, '');
      if LangStr <> '' then
        Item.Group := LangStr;
    end;
    Item.Speed := Table.FieldAsDouble(4);
    Item.Fuel := Table.FieldAsDouble(5);
    Item.Health := Table.FieldAsDouble(6);
    Items.Add(Item);
    Table.Next;
  end;
  Result := Table.RowCount;
  Table.Free;
end;

function TUnturnedItemBase.GetGroupsItem(var Items: TGroups): Integer;
var
  Table: TSQLiteTable;
  Group: TGroup;
  LangStr: string;
begin
  with SQL.Select(tnItemGroups, ['GID', 'Desc']) do
  begin
    Table := FSQLBase.Query(GetSQL);
    EndCreate;
  end;
  Items.Clear;
  Group.GID := -1;
  Group.Desc := '��� ������ ���������';
  Items.Add(Group);
  while not Table.EOF do
  begin
    Group.GID := Table.FieldAsInteger(0);
    Group.Desc := Table.FieldAsString(1);
    if FUseLang then
    begin
      LangStr := FLangIni.ReadString(tnItemGroups, Group.Desc, '');
      if LangStr <> '' then
        Group.Desc := LangStr;
    end;
    Items.Add(Group);
    Table.Next;
  end;
  Result := Table.RowCount;
  Table.Free;
end;

function TUnturnedItemBase.GetGroupsVehicles(var Items: TGroups): Integer;
var
  Table: TSQLiteTable;
  Group: TGroup;
  LangStr: string;
begin
  with SQL.Select(tnVehiclesGroups, ['GID', 'Desc']) do
  begin
    Table := FSQLBase.Query(GetSQL);
    EndCreate;
  end;
  Items.Clear;
  Group.GID := -1;
  Group.Desc := '��� ���� ����������';
  Items.Add(Group);
  while not Table.EOF do
  begin
    Group.GID := Table.FieldAsInteger(0);
    Group.Desc := Table.FieldAsString(1);
    if FUseLang then
    begin
      LangStr := FLangIni.ReadString(tnVehiclesGroups, Group.Desc, '');
      if LangStr <> '' then
        Group.Desc := LangStr;
    end;
    Items.Add(Group);
    Table.Next;
  end;
  Result := Table.RowCount;
  Table.Free;
end;

function TUnturnedItemBase.GetItemData(const IID: Integer; var Item: TItemProperties): Boolean;
var
  Table: TSQLiteTable;
  Prop: TItemPorp;
  LangStr: string;
begin
  with SQL.Select(tnItemData, ['Key', 'Desc', 'IsID', 'Value']) do
  begin
    WhereFieldEqual('IID', IID);
    Table := FSQLBase.Query(GetSQL);
    EndCreate;
  end;
  Item.Clear;
  while not Table.EOF do
  begin
    Prop.Key := Table.FieldAsString(0);
    Prop.Desc := Table.FieldAsString(1);
    Prop.IsID := Boolean(Table.FieldAsInteger(2));
    Prop.Value := Table.FieldAsString(3);
    if FUseLang then
    begin
      LangStr := FLangIni.ReadString(tnItemData, Prop.Value, '');
      if LangStr <> '' then
        Prop.Value := LangStr;
    end;
    Item.Add(Prop);
    Table.Next;
  end;
  Result := Table.RowCount > 0;
  Table.Free;
end;

function TUnturnedItemBase.GetItemIcon(const IID: Integer; var BMP: TBitmap): Boolean;
var
  Table: TSQLiteTable;
  Mem: TMemoryStream;
begin
  Result := False;
  with SQL.Select(tnItems, 'Icon') do
  begin
    WhereFieldEqual('IID', IID);
    Table := FSQLBase.Query(GetSQL);
    EndCreate;
  end;
  if Table.RowCount > 0 then
  begin
    Mem := Table.FieldAsBlob(0);
    if Mem <> nil then
    begin
      Mem.Position := 0;
      BMP.LoadFromStream(Mem);
      Mem.Clear;
      Result := True;
    end;
  end;
  Table.Free;
end;

function TUnturnedItemBase.GetItemImage(const IID: Integer; var BMP: TBitmap): Boolean;
var
  Table: TSQLiteTable;
  Mem: TMemoryStream;
begin
  Result := False;
  with SQL.Select(tnItems, 'Image') do
  begin
    WhereFieldEqual('IID', IID);
    Table := FSQLBase.Query(GetSQL);
    EndCreate;
  end;
  if Table.RowCount > 0 then
  begin
    Mem := Table.FieldAsBlob(0);
    if Mem <> nil then
    begin
      Mem.Position := 0;
      BMP.LoadFromStream(Mem);
      Mem.Clear;
      Result := True;
    end;
  end;
  Table.Free;
end;

function TUnturnedItemBase.GetUnturnedVersion;
var
  JSON: TStringList;
  FJSONObject: TJSONObject;
  Major_Version: Integer;
  Minor_Version: Integer;
  Patch_Version: Integer;
begin
  Result := '';
  if FileExists(aUnturnedPath + pathInfo) then
  begin
    JSON := TStringList.Create;
    try
      JSON.LoadFromFile(aUnturnedPath + pathInfo);
      FJSONObject := TJSONObject.ParseJSONValue(JSON.Text) as TJSONObject;

      if Assigned(FJSONObject) then
      begin
        Major_Version := FJSONObject.Get('Game').JsonValue.GetValue<integer>('Major_Version');
        Minor_Version := FJSONObject.Get('Game').JsonValue.GetValue<integer>('Minor_Version');
        Patch_Version := FJSONObject.Get('Game').JsonValue.GetValue<integer>('Patch_Version');
        Result := Format('%d.%d.%d', [Major_Version, Minor_Version, Patch_Version]);
        FJSONObject.Free;
      end;
    finally
      JSON.Free;
    end;
  end;
end;

procedure TUnturnedItemBase.Progress(Value: Integer; Info: string);
begin
  if Assigned(FOnProgress) then
    FOnProgress(pbMax, Value, Info);
end;

constructor TUnturnedItemBase.Create(ADBFile: string);
begin
  FDBFileName := ADBFile;
  FUseLang := False;
  FRegProp := TRegProperies.Create;
  FRegPropV := TRegProperies.Create;
  RestartSQL;
  CreateTables;
  RegProps;
end;

destructor TUnturnedItemBase.Destroy;
begin
  FRegProp.Free;
  FRegPropV.Free;
  FSQLBase.Free;
  FLangIni.Free;
  inherited;
end;

{ TRegProperty }

procedure TRegProperty.SetTempFlag(const Value: Boolean);
begin
  FTempFlag := Value;
end;

end.

