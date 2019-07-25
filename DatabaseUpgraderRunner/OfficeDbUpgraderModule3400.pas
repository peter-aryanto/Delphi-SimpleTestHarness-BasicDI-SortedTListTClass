unit OfficeDbUpgraderModule3400;

interface

uses
  DbUpgraderModule
  ;

type
  TOfficeDbUpgraderModule3400 = class(TDbUpgraderModule)
  end;

implementation

uses
  OfficeDbUpgraderModules
  ;

initialization
  OfficeDbUpgraderModuleList.Add(TOfficeDbUpgraderModule3400.Create);
end.
