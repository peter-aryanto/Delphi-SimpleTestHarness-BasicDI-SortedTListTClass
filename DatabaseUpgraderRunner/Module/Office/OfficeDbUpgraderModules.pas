unit OfficeDbUpgraderModules;

interface

uses
  DbUpgraderModules;

const
  COfficeDbUpgraderModuleClassNamePrefix = 'OfficeModule';

function OfficeModules: TDbUpgraderModules;
//function ClinicalModules: TDbUpgraderModules;

implementation

uses
  OfficeModule3400,
  OfficeModule3500;

var
  MOfficeModules: TDbUpgraderModules;
//  MClinicalModules: TDbUpgraderModules;

function OfficeModules: TDbUpgraderModules;
begin
  if not Assigned(MOfficeModules) then
    MOfficeModules := TDbUpgraderModules.Create(COfficeDbUpgraderModuleClassNamePrefix);

  Result := MOfficeModules;
end;

//function ClinicalModules: TDbUpgraderModules;
//begin
//  if not Assigned(MClinicalModules) then
//    MClinicalModules := TDbUpgraderModules.Create(CClinicalDbUpgraderModuleClassNamePrefix);
//
//  Result := MClinicalModules;
//end;

initialization
finalization
  if Assigned(MOfficeModules) then
    MOfficeModules.Free;
//  if Assigned(MClinicalModules) then
//    MClinicalModules.Free;
end.
