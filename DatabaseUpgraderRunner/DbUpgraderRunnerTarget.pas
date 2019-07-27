unit DbUpgraderRunnerTarget;

interface

uses
  Data.DB;

type
  IDbUpgraderRunnerTarget = interface
    ['{3B771B3E-272A-45EA-9071-00DA6EA3FE33}']
    function GetDbConnection: TCustomConnection;
    function GetDbLocation: string;
    procedure SetDbLocation(const ADbLocation: string);
    function GetDbVersion: Integer;
  end;

  TDbUpgraderRunnerTarget = class(TInterfacedObject, IDbUpgraderRunnerTarget)
  private
    FDbConnection: TCustomConnection;
    FDbLocation: string;
    procedure ValidateDbConnection;
  protected const
    CInvalidDbVersion = -1;
  public
    constructor Create(const ADbConnection: TCustomConnection); virtual;
    destructor Destroy; override;
    function GetDbConnection: TCustomConnection; virtual; final;
    function GetDbLocation: string; virtual; final;
    procedure SetDbLocation(const ADbLocation: string); virtual;
    function GetDbVersion: Integer; virtual;
  end;

implementation

uses
  System.SysUtils;

{ TDbUpgraderRunnerTarget }

constructor TDbUpgraderRunnerTarget.Create(const ADbConnection: TCustomConnection);
begin
  if not Assigned(ADbConnection) then
    raise Exception.Create('Database connection component is missing.');

  FDbConnection := ADbConnection;
  FDbLocation := '';
end;

destructor TDbUpgraderRunnerTarget.Destroy;
begin
  FDbConnection.Free;
  inherited;
end;

function TDbUpgraderRunnerTarget.GetDbConnection: TCustomConnection;
begin
  Result := FDbConnection;
end;

function TDbUpgraderRunnerTarget.GetDbLocation: string;
begin
  Result := FDbLocation;
end;

procedure TDbUpgraderRunnerTarget.SetDbLocation(const ADbLocation: string);
var
  LDbLocation: string;
begin
  LDbLocation := Trim(ADbLocation);

  if Trim(LDbLocation) = '' then
    raise Exception.Create('Database location is unknown.');

  FDbLocation := LDbLocation;
end;

procedure TDbUpgraderRunnerTarget.ValidateDbConnection;
begin
  if FDbLocation = '' then
    raise Exception.Create('Please set database location.');

  if not FDbConnection.Connected then
    raise Exception.Create('Please get database connection and open the connection.');
end;

function TDbUpgraderRunnerTarget.GetDbVersion: Integer;
begin
  ValidateDbConnection;
  Result := CInvalidDbVersion;
end;

end.
