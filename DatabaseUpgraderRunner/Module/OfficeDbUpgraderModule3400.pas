unit OfficeDbUpgraderModule3400;

interface

uses
  DbUpgraderModules;

type
  TOfficeDbUpgraderModule3400 = class(TDbUpgraderModule)
  end;

implementation

//uses
//  DbUpgraderModules;

initialization
  OfficeDbUpgraderModules.RegisterModule(TOfficeDbUpgraderModule3400);
end.
