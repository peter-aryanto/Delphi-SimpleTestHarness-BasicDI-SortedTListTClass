unit OfficeModule3500;

interface

uses
  DbUpgraderModules;

type
  TOfficeModule3500 = class(TDbUpgraderModule)
  end;

implementation

uses
  OfficeDbUpgraderModules;

initialization
  OfficeModules.RegisterModule(TOfficeModule3500);
end.
