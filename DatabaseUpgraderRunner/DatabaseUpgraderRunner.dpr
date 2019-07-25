program DatabaseUpgraderRunner;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  OfficeDbUpgraderModules in 'OfficeDbUpgraderModules.pas',
  UpgraderRunner in 'UpgraderRunner.pas';

//{/  DbUpgraderRunner in 'DbUpgraderRunner.pas';},
//  OfficeDbUpgraderModule3400 in 'OfficeDbUpgraderModule3400.pas',
//  OfficeDbUpgraderModule3500 in 'OfficeDbUpgraderModule3500.pas';

begin
  ReportMemoryLeaksOnShutdown := True;

  try


  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  Readln;
end.
