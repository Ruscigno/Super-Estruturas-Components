unit useApplication;

interface

uses
  {$IF RTLVersion >= 19}
    System.Classes,
  {$ELSE}
    Classes,
  {$IFEND}
  useGeneral;

type
  TseApplication = class(TComponent)
  private
    FbConnCreated : Boolean;
    FbFileLoaded : Boolean; //Já leu o arquivo de log? Ao iniciar?
    FbIsService: boolean;
    FbLogAutoSave: Boolean;
    FfrmMenu: TComponent;
    FLog: TStringList;
//    FncdInstalacao: integer;
//    FncdSistema: integer;
    FoUsuario : String;
    FsLogFile: string;
    FsConfigFile: string;
    procedure ReloadFile;
    procedure ClearOutOfBounds;
    procedure SetConfigFile(const Value: string);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    class procedure StartMyApplication; virtual;
    class procedure StopMyApplication; virtual;
    procedure AddLog(psSection, psLog : string);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure SaveLog(psFile : string = ''; OnLog : TSimpleEvent = nil);
    property frmMenu : TComponent read FfrmMenu write FfrmMenu;
    property IsService : boolean read FbIsService write FbIsService;
    property Log : TStringList read FLog write FLog;
    property LogFile : string read FsLogFile write FsLogFile;
  published
    property ConfigFile : string read FsConfigFile write SetConfigFile;
    property LogAutoSave : Boolean read FbLogAutoSave write FbLogAutoSave;
    property Usuario : String read FoUsuario write FoUsuario;
  end;
//
//  TseApplicationDB = class(TseApplication)
//  private
//    FbConnCreated : Boolean;
//    FogConnection : TmpgConnection;
//    procedure SetConnection(const Value: TmpgConnection);
//    function GetConnection: TmpgConnection;
//  public
//    constructor Create(AOwner : TComponent); override;
//    destructor Destroy; override;
//    procedure Initialize;
//    property Connection : TmpgConnection read GetConnection write SetConnection;
//    property sqlExecs : TmpgSQLProcessor read FsqlExecs;
//  published
//  end;

var
  oAplicacao : TseApplication;
  sFormCadCompleto : string;
  onCont : integer;

implementation

uses
  {$IF RTLVersion >= 19}
    System.SysUtils,
  {$ELSE}
    SysUtils,
  {$IFEND}
  useFunctions, useConstants;

{ TseApplication }

constructor TseApplication.Create(AOwner : TComponent);
begin
  inherited;
  FbConnCreated := False;
  FbFileLoaded := False;
  FbIsService := False;
  FLog := TStringList.Create;
  Usuario := 'SANDER';
  FbLogAutoSave := True;
  if not Assigned(oAplicacao) then
    oAplicacao := Self;
end;

procedure TseApplication.AddLog(psSection, psLog: string);
begin
  Log.Add(FormatDateTime('dd/mm/yyy hh:nn:ss:zzz', Now) + ' [' + psSection + '] ' + psLog);
  if (FbLogAutoSave) then
    SaveLog;
end;

destructor TseApplication.Destroy;
begin
  FreeAndNil(FLog);
  inherited;
end;

procedure TseApplication.SaveLog(psFile : string = ''; OnLog : TSimpleEvent = nil);
begin
  if (psFile = '') then
  begin
    if (FsLogFile = '') then
      FsLogFile := GetAppLogFile;
  end
  else
    FsLogFile := psFile;

  ReloadFile;
  ClearOutOfBounds;
  if (FLog.Count > 0) then
    try
      FLog.SaveToFile(FsLogFile);
    except
    end;
  if Assigned(OnLog) then
    OnLog;
end;

procedure TseApplication.ClearOutOfBounds;
begin
  while FLog.Count > 20000 do
    FLog.Delete(0);
end;

procedure TseApplication.ReloadFile;
var
  oFileToSave : TStringList;
begin
  oFileToSave := TStringList.Create;
  try
    if FileExists(FsLogFile) and not(FbFileLoaded) then
    begin
      oFileToSave.LoadFromFile(FsLogFile);
      oFileToSave.Add(FLog.Text);
      FLog.Text := oFileToSave.Text;
      FbFileLoaded := True;
    end;
  finally
    oFileToSave.Free;
  end;
end;


procedure TseApplication.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
end;

class procedure TseApplication.StartMyApplication;
begin
  onCont := 0;
  sFormCadCompleto := sfseCadCompleto;
  if not Assigned(oAplicacao) then
    oAplicacao := TseApplication.Create(nil);
end;

class procedure TseApplication.StopMyApplication;
begin
  if Assigned(oAplicacao) then
    FreeAndNil(oAplicacao);
end;

procedure TseApplication.SetConfigFile(const Value: string);
begin
  useFunctions.SetConfigFile(Value, FsConfigFile);
end;

//constructor TseApplicationDB.Create(AOwner : TComponent);
//begin
//  inherited;
//  FsqlExecs := TmpgSQLProcessor.Create(nil);
//  FbConnCreated := False;
//end;
//
//destructor TseApplicationDB.Destroy;
//begin
//  FreeAndNil(FsqlExecs);
//  if (FbConnCreated) then
//    FreeAndNil(FogConnection);
//  inherited;
//end;

//procedure TseApplicationDB.Initialize;
//begin
//  if not Assigned(FogConnection) then
//  begin
//    Connection := TmpgConnection.Create(nil);
//    Connection.ConfigFile := ConfigFile;
//    FbConnCreated := True;
//  end;
//end;
//
//procedure TseApplicationDB.Notification(AComponent: TComponent; Operation: TOperation);
//begin
//  inherited;
//  if (Operation = opRemove) and (AComponent = FogConnection) then
//    FogConnection := nil;
//end;
//
//procedure TseApplicationDB.SetConnection(const Value: TmpgConnection);
//begin
//  if (Value <> FogConnection) then
//  begin
//    FogConnection := Value;
//    FreeNotification(FogConnection);
//    FbConnCreated := False;
//    FsqlExecs.Connection := FogConnection;
//  end;
//end;
//
//function TseApplicationDB.GetConnection: TmpgConnection;
//begin
//  if not Assigned(FogConnection) and not (FbConnCreated) then
//    Initialize;
//  Result := FogConnection;
//end;

//initialization
//  TseApplication.StartMyApplication;
//
//finalization
//  TseApplication.StopMyApplication;

end.

