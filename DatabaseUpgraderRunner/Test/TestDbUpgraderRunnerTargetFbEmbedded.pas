unit TestDbUpgraderRunnerTargetFbEmbedded;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  DUnitX.TestFramework, {DUnitX.DUnitCompatibility, }DUnitX.Assert,{Data.DB, DbUpgraderRunnerTarget, }DbUpgraderRunnerTargetFbEmbedded;

type
  [TestFixture]
  TestTDbUpgraderRunnerTargetFbEmbedded = class(TObject)
  strict private const
    CDbFile = '..\Resource\DummyDb.fdb';
  strict private
    FDbUpgraderRunnerTargetFbEmbedded: TDbUpgraderRunnerTargetFbEmbedded;
  public
    [SetupFixture]
    procedure SetUp;
    [TearDownFixture]
    procedure TearDown;
    [Test]
    procedure TestGetDbLocation;
    [Test]
    procedure TestSetDbLocation;
    [Test]
    procedure TestGetDbVersion;
  end;

implementation

uses
  System.SysUtils;

procedure TestTDbUpgraderRunnerTargetFbEmbedded.SetUp;
begin
  FDbUpgraderRunnerTargetFbEmbedded :=
    TDbUpgraderRunnerTargetFbEmbedded.Create('..\Resource\DummyFbEmbed.dll');
end;

procedure TestTDbUpgraderRunnerTargetFbEmbedded.TearDown;
begin
  FDbUpgraderRunnerTargetFbEmbedded.Free;
  FDbUpgraderRunnerTargetFbEmbedded := nil;
end;

procedure TestTDbUpgraderRunnerTargetFbEmbedded.TestGetDbLocation;
begin
  // INCLUDED in TestSetDbLocation.
end;

procedure TestTDbUpgraderRunnerTargetFbEmbedded.TestSetDbLocation;
begin
//  try
    Assert.AreEqual('', FDbUpgraderRunnerTargetFbEmbedded.GetDbLocation);
    FDbUpgraderRunnerTargetFbEmbedded.SetDbLocation(CDbFile);
    Assert.AreEqual(CDbFile, FDbUpgraderRunnerTargetFbEmbedded.GetDbLocation);
//  except on E: Exception do
//    Fail(E.Message);
//  end;
end;

procedure TestTDbUpgraderRunnerTargetFbEmbedded.TestGetDbVersion;
begin
//  try
//    TestSetDbLocation;
    Assert.AreEqual(3000, FDbUpgraderRunnerTargetFbEmbedded.GetDbVersion);
//  except on E: Exception do
//    Fail(E.Message);
//  end;
end;

initialization
  // Register any test cases with the test runner
  TDUnitX.RegisterTestFixture(TestTDbUpgraderRunnerTargetFbEmbedded);
end.

