program DatabaseUpgraderRunner;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
//  OfficeDbUpgraderModules in 'OfficeDbUpgraderModules.pas',
  UpgraderRunner in 'UpgraderRunner.pas',
//  DbUpgraderRunnerTarget in 'DbUpgraderRunnerTarget.pas',
  DbUpgraderRunnerTargetFbEmbedded in 'DbUpgraderRunnerTargetFbEmbedded.pas';

//{/  DbUpgraderRunner in 'DbUpgraderRunner.pas';},
//  OfficeDbUpgraderModule3400 in 'OfficeDbUpgraderModule3400.pas',
//  OfficeDbUpgraderModule3500 in 'OfficeDbUpgraderModule3500.pas';

var
  GUpgraderRunner: TUpgraderRunner;

begin
{$ifdef debug}
  ReportMemoryLeaksOnShutdown := True;
{$endif}

  try
    GUpgraderRunner := TUpgraderRunner.Create(
      TDbUpgraderRunnerTargetFbEmbedded.Create('..\Test\Resource\DummyFbEmbed.dll'));
    //GUpgraderRunner.Run

    Writeln('DONE :)');

  except
    on E: Exception do
      Writeln(E.Message);
  end;

  if Assigned(GUpgraderRunner) then
    GUpgraderRunner.Free;

  Readln;
end.
