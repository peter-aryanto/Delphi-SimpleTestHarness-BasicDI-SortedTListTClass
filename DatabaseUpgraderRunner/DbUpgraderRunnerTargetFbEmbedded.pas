unit DbUpgraderRunnerTargetFbEmbedded;

interface

uses
  Data.DB,
  DbUpgraderRunnerTarget;

type
  TDummyTFDConnection = class(TCustomConnection)
  protected
    function GetConnected: Boolean; override;
    procedure SetConnected(AValue: Boolean); override;
  public
    constructor Create; reintroduce;
    procedure Open; reintroduce;
  end;

  TDbUpgraderRunnerTargetFbEmbedded = class(TDbUpgraderRunnerTarget, IDbUpgraderRunnerTarget)
  private
    function GetInternalDbConn: TDummyTFDConnection;
    property DbConn: TDummyTFDConnection read GetInternalDbConn;
  public
    constructor Create(const AFbEmbeddedFile: string); reintroduce;
    procedure SetDbLocation(const ADbFile: string); override;
    function GetDbVersion: Integer; override;
  end;

implementation

uses
  System.SysUtils;

{ TDummyTFDConnection }

constructor TDummyTFDConnection.Create;
begin
  // Do nothing.
end;

function TDummyTFDConnection.GetConnected: Boolean;
begin
  Result := True;
end;

procedure TDummyTFDConnection.SetConnected(AValue: Boolean);
begin
  // Do nothing.
end;

procedure TDummyTFDConnection.Open;
begin
  // Do nothing.
end;

{ TDbUpgraderRunnerTargetFbEmbedded }

constructor TDbUpgraderRunnerTargetFbEmbedded.Create(const AFbEmbeddedFile: string);
var
  LFDConnection: TDummyTFDConnection;
begin
  if not FileExists(AFbEmbeddedFile) then
    raise Exception.Create('Cannot find Firebird Embedded driver at: ' + AFbEmbeddedFile);

  // Create TFDPhysDriverLink and set .VendorLib := AFbEmbeddedFile.
  LFDConnection := TDummyTFDConnection.Create;
  inherited Create(LFDConnection);
end;

function TDbUpgraderRunnerTargetFbEmbedded.GetInternalDbConn: TDummyTFDConnection;
begin
  Result := GetDbConnection as TDummyTFDConnection;
end;

procedure TDbUpgraderRunnerTargetFbEmbedded.SetDbLocation(const ADbFile: string);
begin
  inherited SetDbLocation(ADbFile);

  if not FileExists(GetDbLocation) then
    raise Exception.Create('Cannot find Firebird database file at: ' + ADbFile);
end;

function TDbUpgraderRunnerTargetFbEmbedded.GetDbVersion: Integer;
begin
  Result := inherited;
  if DBConn.Connected then
    Result := 3000
end;

end.
