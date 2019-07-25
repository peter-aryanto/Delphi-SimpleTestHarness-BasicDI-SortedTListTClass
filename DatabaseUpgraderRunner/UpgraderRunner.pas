unit UpgraderRunner;

interface

type
  TUpgraderRunner = class(TObject)
  public
    function GetExistingDbVersion(const ADbFilePathName: string): Integer;
  end;

implementation

{ TUpgraderRunner }

function TUpgraderRunner.GetExistingDbVersion(const ADbFilePathName: string): Integer;
begin
  Result := 30;
end;

end.
