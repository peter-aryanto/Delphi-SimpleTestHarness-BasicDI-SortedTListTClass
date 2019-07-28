unit OfficeDbUpgraderModules;

interface

uses
  System.Generics.Collections,
  DbUpgradermodule;

function OfficeDbUpgraderModuleList: TObjectList<TDbUpgraderModule>;

implementation

uses
  OfficeDbUpgraderModule3400,
  OfficeDbUpgraderModule3500
  ;

var
  MOfficeDbUpgraderModuleList: TObjectList<TDbUpgraderModule>;

function OfficeDbUpgraderModuleList: TObjectList<TDbUpgraderModule>;
begin
  if not Assigned(MOfficeDbUpgraderModuleList) then
    MOfficeDbUpgraderModuleList := TObjectList<TDbUpgraderModule>.Create(True);

  Result := MOfficeDbUpgraderModuleList;
end;

initialization
finalization
  if Assigned(MOfficeDbUpgraderModuleList) then
    MOfficeDbUpgraderModuleList.Free;
end.
