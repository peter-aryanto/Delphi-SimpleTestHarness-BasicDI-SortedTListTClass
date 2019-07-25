unit OfficeDbUpgraderModule3500;

interface

uses
  DbUpgraderModule
  ;

type
  TOfficeDbUpgraderModule3500 = class(TDbUpgraderModule)
  end;

implementation

uses
  OfficeDbUpgraderModules
  ;

initialization
  OfficeDbUpgraderModuleList.Add(TOfficeDbUpgraderModule3500.Create);
end.

