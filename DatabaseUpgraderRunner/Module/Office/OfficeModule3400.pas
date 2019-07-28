unit OfficeModule3400;

interface

uses
  DbUpgraderModules;

type
  TOfficeModule3400 = class(TDbUpgraderModule)
  end;

implementation

uses
  OfficeDbUpgraderModules;

initialization
  OfficeModules.RegisterModule(TOfficeModule3400);
end.
