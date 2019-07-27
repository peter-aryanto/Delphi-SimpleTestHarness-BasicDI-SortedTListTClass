unit UpgraderRunner;

interface

uses
  DbUpgraderRunnerTarget;

type
  TUpgraderRunner = class(TObject)
  private
    FTargetDbIntf: IDbUpgraderRunnerTarget;
  public
//    function GetExistingDbVersion(const ADbFilePathName: string): Integer;
    constructor Create(const ATargetDbIntf: IDbUpgraderRunnerTarget);
  end;

implementation

uses
  System.SysUtils;

//function TUpgraderRunner.GetExistingDbVersion(const ADbFilePathName: string): Integer;
//begin
//  Result := 30;
//end;

{ TUpgraderRunner }

constructor TUpgraderRunner.Create(const ATargetDbIntf: IDbUpgraderRunnerTarget);
begin
  if not Assigned(ATargetDbIntf) then
    raise Exception.Create('Target database component is missing.');

  FTargetDbIntf := ATargetDbIntf;
end;

end.
