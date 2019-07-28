program DatabaseUpgraderRunner;

{$APPTYPE CONSOLE}

{$R *.res}

uses
//  System.Generics.Collections,
//  DBUpgraderModules,
//  OfficeModule3400,
//  OfficeModule3500,

  System.SysUtils,
  UpgraderRunner in 'UpgraderRunner.pas',
  DbUpgraderRunnerTargetFbEmbedded in 'DbUpgraderRunnerTargetFbEmbedded.pas',
  OfficeDbUpgraderModules in 'Module\Office\OfficeDbUpgraderModules.pas';

var
  GUpgraderRunner: TUpgraderRunner;
//
//  GList: TDbUpgraderModules;

begin
{$ifdef debug}
  ReportMemoryLeaksOnShutdown := True;
{$endif}

  GUpgraderRunner := nil;

  try
    GUpgraderRunner := TUpgraderRunner.Create(
      TDbUpgraderRunnerTargetFbEmbedded.Create('..\Test\Resource\DummyFbEmbed.dll'));
    //GUpgraderRunner.Run

//    TDbUpgraderModules.Create('TestDbUpgraderModule').RegisterModule('TestDbUpgraderMODULE3100');

//    GList := TDbUpgraderModules.Create(COfficeDbUpgraderModuleClassNamePrefix);
//    GList.RegisterModule(TOfficeModule3500);
//    GList.RegisterModule(TOfficeModule3400);
//    GList.Sort;
//    GList.Free;

    Writeln('DONE :)');

  except
    on E: Exception do
      Writeln(E.Message);
  end;

  if Assigned(GUpgraderRunner) then
    GUpgraderRunner.Free;

  Readln;
end.
