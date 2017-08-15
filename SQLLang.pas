unit SQLLang;

interface
 uses
  System.Classes, System.SysUtils, SQLite3, SQLiteTable3, System.Generics.Collections;

 type
  TFieldType = (ftInteger, ftString, ftFloat, ftDateTime, ftBlob, ftBoolean);

  TField = record
   private
    function GetSQL: string;
   public
    FieldType:TFieldType;
    FieldName:string;
    PrimaryKey:Boolean;
    NotNull:Boolean;
    property SQL:string read GetSQL;
  end;
  TFields = TList<TField>;
  TFieldNames = TStringList;

  TTable = class
   private
    FName:string;
    procedure SetName(const Value: string);
    function GetField(Index: Integer): TField;
    procedure SetField(Index: Integer; const Value: TField);
   protected
    FFields:TFields;
   public
    function GetSQL:string; virtual;
    procedure AddField(Name:string; FieldType:TFieldType; PrimaryKey:Boolean = False; NotNull:Boolean = False); virtual;
    procedure EndCreate; virtual;
    procedure Clear; virtual;
    constructor Create; virtual;
    property Fields[Index:Integer]:TField read GetField write SetField;
    property TableName:string read FName write SetName;
  end;

  TInsertValue = record
   public
    FieldType:TFieldType;
    FieldName:string;
    Value:Variant;
  end;
  TInsertValues = TList<TInsertValue>;

  TInsertInto = class
   private
    FName:string;
    procedure SetName(const Value: string);
   protected
    FFieldValues:TInsertValues;
   public
    function GetSQL:string;
    procedure EndCreate;
    procedure Clear;
    procedure AddValue(FieldName:string; FieldValue:Integer); overload;
    procedure AddValue(FieldName:string; FieldValue:string); overload;
    procedure AddValue(FieldName:string; FieldValue:Extended); overload;
    procedure AddValue(FieldName:string; FieldValue:TDateTime); overload;
    procedure AddValue(FieldName:string; FieldValue:Boolean); overload;
    constructor Create; virtual;
    property TableName:string read FName write SetName;
  end;

  TUpdate = class
   private
    FName:string;
    FWhere:string;
    procedure SetName(const Value: string);
   protected
    FFieldValues:TInsertValues;
   public
    function GetSQL:string;
    procedure EndCreate;
    procedure Clear;
    procedure AddValue(FieldName:string; FieldValue:Integer); overload;
    procedure AddValue(FieldName:string; FieldValue:string); overload;
    procedure AddValue(FieldName:string; FieldValue:Extended); overload;
    procedure AddValue(FieldName:string; FieldValue:TDateTime); overload;
    procedure AddValue(FieldName:string; FieldValue:Boolean); overload;
    constructor Create; virtual;
    property TableName:string read FName write SetName;
    property Where:string read FWhere write FWhere;
  end;

  TSelect = class
   private
    FName:string;
    FWhere:string;
    FOrderBy:string;
    FLimitInt:Integer;
    FDistinct:Boolean;
    procedure SetName(const Value: string);
    function GetField(Index: Integer): string;
    procedure SetField(Index: Integer; const Value: string);
   protected
    FFields:TFieldNames;
   public
    function GetSQL:string;
    procedure AddField(Name:string);
    procedure EndCreate;
    procedure Clear;
    constructor Create; virtual;
    property Fields[Index:Integer]:string read GetField write SetField;
    property TableName:string read FName write SetName;
    property Where:string read FWhere write FWhere;
    property Distinct:Boolean read FDistinct write FDistinct;
    property OrderBy:string read FOrderBy write FOrderBy;
    property Limit:Integer read FLimitInt write FLimitInt;
  end;

  TDelete = class
   private
    FName:string;
    FWhere:string;
    procedure SetName(const Value: string);
   public
    function GetSQL:string;
    procedure EndCreate;
    procedure Clear;
    constructor Create; virtual;
    property TableName:string read FName write SetName;
    property Where:string read FWhere write FWhere;
  end;

  TDropTable = class
   private
    FName:string;
    procedure SetName(const Value: string);
   public
    function GetSQL:string;
    procedure EndCreate;
    procedure Clear;
    constructor Create; virtual;
    property TableName:string read FName write SetName;
  end;
       {
  TGetLastIdentity = class
   private
    FName:string;
    procedure SetName(const Value: string);
   public
    function GetSQL:string;
    procedure EndCreate;
    procedure Clear;
    constructor Create; virtual;
    property TableName:string read FName write SetName;
  end;   }

  SQL = class
   public
    class function CreateField:TField;
    class function PRAGMA(Key, Value:string):string;
    class function CreateTable:TTable;
    class function InsertInto:TInsertInto;
    class function Delete:TDelete;
    class function DropTable:TDropTable;
    class function Update:TUpdate;
    class function Select:TSelect;
    class procedure UpdateBlob(SQLDB:TSQLiteDatabase; Table, BlobField, Where:string; BlobData: TStream);
  end;

  function Field(Name:string; FieldType:TFieldType; PrimaryKey, NotNull:Boolean):TField;
  function InsertValue(Name:string; FieldType:TFieldType; Value:Variant):TInsertValue;

implementation

function FloatToSQLStr(Value:Extended):string;
begin
 Result:=FloatToStr(Value);
 Result:=StringReplace(Result, ',', '.', [rfReplaceAll]);
end;

function FieldTypeToStr(Value:TFieldType):string;
begin
 case Value of
  ftInteger:  Result:='INTEGER';
  ftString:   Result:='TEXT';
  ftFloat:    Result:='REAL';
  ftDateTime: Result:='REAL';
  ftBlob:     Result:='BLOB';
  ftBoolean:  Result:='INTEGER';
 end;
end;

function Field;
begin
 Result.FieldType:=FieldType;
 Result.FieldName:=Name;
 Result.PrimaryKey:=PrimaryKey;
 Result.NotNull:=NotNull;
end;

function InsertValue(Name:string; FieldType:TFieldType; Value:Variant):TInsertValue; overload;
begin
 Result.FieldName:=Name;
 Result.FieldType:=FieldType;
 Result.Value:=Value;
end;

{ SQL }

class function SQL.CreateField: TField;
begin
 Result:=Field('', ftInteger, False, False);
end;

class function SQL.CreateTable: TTable;
begin
 Result:=TTable.Create;
end;

class function SQL.Delete: TDelete;
begin
 Result:=TDelete.Create;
end;

class function SQL.DropTable:TDropTable;
begin
 Result:=TDropTable.Create;
end;

class function SQL.InsertInto: TInsertInto;
begin
 Result:=TInsertInto.Create;
end;

class function SQL.PRAGMA(Key, Value: string): string;
begin
 //'PRAGMA key = "123456"'
 Result:='PRAGMA '+Key+' = "'+Value+'"';
end;

class function SQL.Select:TSelect;
begin
 Result:=TSelect.Create;
end;

class function SQL.Update: TUpdate;
begin
 Result:=TUpdate.Create;
end;

class procedure SQL.UpdateBlob;
begin
 //SQLBase.UpdateBlob('UPDATE FirstTable SET MYBLOB = ? WHERE ID = '+IntToStr(id)
 if Where <> '' then Where:='WHERE '+Where;
 SQLDB.UpdateBlob('UPDATE '+Table+' SET '+BlobField+' = ? '+Where, BlobData);
end;

{ TTable }

procedure TTable.AddField;
begin
 FFields.Add(Field(Name, FieldType, PrimaryKey, NotNull));
end;

procedure TTable.Clear;
begin
 TableName:='';
 FFields.Clear;
end;

constructor TTable.Create;
begin
 FFields:=TFields.Create;
end;

procedure TTable.EndCreate;
begin
 Clear;
 Free;
end;

function TTable.GetField(Index: Integer): TField;
begin
 Result:=FFields[Index];
end;

function TTable.GetSQL: string;
var i:Integer;
begin
 //CREATE TABLE FirstTable (ID INTEGER PRIMARY KEY, MYTEXT TEXT, MYBLOB BLOB)
 Result:='CREATE TABLE '+TableName+' (';         //CREATE TABLE FirstTable (
 for i:= 0 to FFields.Count - 1 do
  begin
   Result:=Result+FFields[i].GetSQL;
   if i <> FFields.Count - 1 then Result:=Result+', ';
  end;
 Result:=Result+')';
end;

procedure TTable.SetField(Index: Integer; const Value: TField);
begin
 FFields[Index]:=Value;
end;

procedure TTable.SetName(const Value: string);
begin
 FName:= Value;
end;

{ TField }

function TField.GetSQL: string;
begin
 Result:=FieldName+' '+FieldTypeToStr(FieldType);
 if PrimaryKey then Result:=Result+' PRIMARY KEY';
 if NotNull then Result:=Result+' NOT NULL';
end;

{ TInsertInto }

procedure TInsertInto.AddValue(FieldName: string; FieldValue: Extended);
begin
 FFieldValues.Add(InsertValue(FieldName, ftFloat, FieldValue));
end;

procedure TInsertInto.AddValue(FieldName, FieldValue: string);
begin
 FieldValue:=StringReplace(FieldValue, '"', '""', [rfReplaceAll]);
 FFieldValues.Add(InsertValue(FieldName, ftString, FieldValue));
end;

procedure TInsertInto.AddValue(FieldName: string; FieldValue: Integer);
begin
 FFieldValues.Add(InsertValue(FieldName, ftInteger, FieldValue));
end;

procedure TInsertInto.AddValue(FieldName: string; FieldValue: Boolean);
begin
 FFieldValues.Add(InsertValue(FieldName, ftBoolean, FieldValue));
end;

procedure TInsertInto.AddValue(FieldName: string; FieldValue: TDateTime);
begin
 FFieldValues.Add(InsertValue(FieldName, ftDateTime, FieldValue));
end;

procedure TInsertInto.SetName(const Value: string);
begin
 FName:=Value;
end;

procedure TInsertInto.Clear;
begin
 TableName:='';
 FFieldValues.Clear;
end;

constructor TInsertInto.Create;
begin
 FFieldValues:=TInsertValues.Create;
end;

procedure TInsertInto.EndCreate;
begin
 Clear;
 Free;
end;

function TInsertInto.GetSQL: string;
var i:Integer;
begin
 //insert into FirstTable (MYTEXT) values("Оно работает!")
 Result:='INSERT INTO '+TableName+' (';         //INSERT INTO FirstTable (
 for i:= 0 to FFieldValues.Count - 1 do
  begin
   Result:=Result+FFieldValues[i].FieldName;
   if i <> FFieldValues.Count - 1 then Result:=Result+', ';
  end;
 Result:=Result+') VALUES (';                   //INSERT INTO FirstTable (FIELDNAMES) VALUES (
 for i:= 0 to FFieldValues.Count - 1 do
  begin
   case FFieldValues[i].FieldType of
    ftInteger: Result:=Result+IntToStr(FFieldValues[i].Value);
    ftString:  Result:=Result+'"'+FFieldValues[i].Value+'"';
    ftFloat:   Result:=Result+FloatToSQLStr(FFieldValues[i].Value);
    ftDateTime:Result:=Result+FloatToSQLStr(FFieldValues[i].Value);
    ftBoolean: Result:=Result+IntToStr(FFieldValues[i].Value);
   end;
   if i <> FFieldValues.Count - 1 then Result:=Result+', ';
  end;
 Result:=Result+')';
end;

{ TSelect }

procedure TSelect.AddField(Name: string);
begin
 FFields.Add(Name);
end;

procedure TSelect.Clear;
begin
 FName:='';
 FFields.Clear;
end;

constructor TSelect.Create;
begin
 FFields:=TFieldNames.Create;
 FLimitInt:=0;
end;

procedure TSelect.EndCreate;
begin
 Clear;
 Free;
end;

function TSelect.GetField(Index: Integer): string;
begin
 Result:=FFields[Index];
end;

function TSelect.GetSQL: string;
var i:Integer;
    FieldsStr, ALimit, AOrderBy, AWhere:string;
begin
 //'SELECT MYBLOB FROM FirstTable WHERE ID='+IntToStr(id);
 if FWhere <> '' then AWhere:=' WHERE '+FWhere;
 if FOrderBy <> '' then AOrderBy:=' ORDER BY '+FOrderBy;
 if FLimitInt > 0 then ALimit:=' LIMIT '+IntToStr(FLimitInt);

 if FDistinct then Result:='SELECT DISTINCT ' else Result:='SELECT ';

 Result:=Result+'%s FROM '+TableName+AWhere+AOrderBy+ALimit;  //SELECT %s FROM FirstTable WHERE ID=1
 FieldsStr:='';
 for i:= 0 to FFields.Count - 1 do
  begin
   FieldsStr:=FieldsStr+FFields[i];
   if i <> FFields.Count - 1 then FieldsStr:=FieldsStr+', ';
  end;
 Result:=Format(Result, [FieldsStr]);
end;

procedure TSelect.SetField(Index: Integer; const Value: string);
begin
 FFields[Index]:=Value;
end;

procedure TSelect.SetName(const Value: string);
begin
 FName:=Value;
end;

{ TDelete }

procedure TDelete.Clear;
begin
 FName:='';
end;

constructor TDelete.Create;
begin
 //
end;

procedure TDelete.EndCreate;
begin
 Clear;
 Free;
end;

function TDelete.GetSQL: string;
begin
 if Where <> '' then Where:=' WHERE '+Where;
 Result:='DELETE FROM '+FName+Where;
end;

procedure TDelete.SetName(const Value: string);
begin
 FName:=Value;
end;

{ TUpdate }

procedure TUpdate.AddValue(FieldName: string; FieldValue: Extended);
begin
 FFieldValues.Add(InsertValue(FieldName, ftFloat, FieldValue));
end;

procedure TUpdate.AddValue(FieldName, FieldValue: string);
begin
 FieldValue:=StringReplace(FieldValue, '"', '""', [rfReplaceAll]);
 FFieldValues.Add(InsertValue(FieldName, ftString, FieldValue));
end;

procedure TUpdate.AddValue(FieldName: string; FieldValue: Integer);
begin
 FFieldValues.Add(InsertValue(FieldName, ftInteger, FieldValue));
end;

procedure TUpdate.AddValue(FieldName: string; FieldValue: Boolean);
begin
 FFieldValues.Add(InsertValue(FieldName, ftBoolean, FieldValue));
end;

procedure TUpdate.AddValue(FieldName: string; FieldValue: TDateTime);
begin
 FFieldValues.Add(InsertValue(FieldName, ftDateTime, FieldValue));
end;

procedure TUpdate.SetName(const Value: string);
begin
 FName:=Value;
end;

procedure TUpdate.Clear;
begin
 TableName:='';
 FFieldValues.Clear;
end;

constructor TUpdate.Create;
begin
 FFieldValues:=TInsertValues.Create;
end;

procedure TUpdate.EndCreate;
begin
 Clear;
 Free;
end;

function TUpdate.GetSQL: string;
var i:Integer;
    str:string;
begin
 //insert into FirstTable (MYTEXT) values("Оно работает!")
 Result:='UPDATE '+TableName+' SET ';         //INSERT INTO FirstTable (
 for i:= 0 to FFieldValues.Count - 1 do
  begin
   str:='';
   case FFieldValues[i].FieldType of
    ftInteger: str:=IntToStr(FFieldValues[i].Value);
    ftString:  str:='"'+FFieldValues[i].Value+'"';
    ftFloat:   str:=FloatToSQLStr(FFieldValues[i].Value);
    ftDateTime:str:=FloatToSQLStr(FFieldValues[i].Value);
    ftBoolean: str:=IntToStr(FFieldValues[i].Value);
   end;
   Result:=Result+FFieldValues[i].FieldName + ' = '+str;
   if i <> FFieldValues.Count - 1 then Result:=Result+', ';
  end;
 if Where <> '' then Where:=' WHERE '+Where;
 Result:=Result+Where;
end;

{ TDropTable }

procedure TDropTable.Clear;
begin
 TableName:='';
end;

constructor TDropTable.Create;
begin
 //
end;

procedure TDropTable.EndCreate;
begin
 Clear;
 Free;
end;

function TDropTable.GetSQL:string;
begin
 Result:='DROP TABLE '+TableName;
end;

procedure TDropTable.SetName(const Value: string);
begin
 FName:=Value;
end;

end.
