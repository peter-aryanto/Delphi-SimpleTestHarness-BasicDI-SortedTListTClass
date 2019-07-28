program DatabaseUpgraderRunner;

{$APPTYPE CONSOLE}

{$R *.res}

uses
//  System.Generics.Collections,
//  DbUpgraderModules,
//
  System.SysUtils,
  UpgraderRunner in 'UpgraderRunner.pas',
  DbUpgraderRunnerTargetFbEmbedded in 'DbUpgraderRunnerTargetFbEmbedded.pas',
  OfficeDbUpgraderModule3400 in 'Module\OfficeDbUpgraderModule3400.pas';

var
  GUpgraderRunner: TUpgraderRunner;
//
//  GList: TList<TDbUpgraderModuleClass>;

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

//    GList := TList<TDbUpgraderModuleClass>.Create;
//    GList.Add(TOfficeDbUpgraderModule3400);
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
