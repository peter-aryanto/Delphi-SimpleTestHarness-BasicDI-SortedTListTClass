unit DbUpgraderModules;

interface

uses
//  System.Generics.Collections;
  System.Classes;

const
  CDbUpgraderModuleClassNamePrefix = 'DbUpgraderModule';
  COfficeDbUpgraderModuleClassNamePrefix = 'Office' + CDbUpgraderModuleClassNamePrefix;
  CClinicalDbUpgraderModuleClassNamePrefix = 'Clinica' + CDbUpgraderModuleClassNamePrefix;

type
  TDbUpgraderModuleClass = class of TDbUpgraderModule;
  TDbUpgraderModule = class(TPersistent)
  end;

//  TDbUpgraderModuleList = TList<TDbUpgraderModuleClass>;
  TDbUpgraderModules = class(TObject)
//    FModuleList: TDbUpgraderModuleList;
    FModuleClassNamePrefix: string;
    FSortedModuleList: TStringList;
  private
//    function GetModule(const AIndex: Integer): TDbUpgraderModuleClass;
    function GetModule(const AIndex: Integer): string;
  public
    constructor Create(const AModuleClassNamePrefix: string);
    destructor Destroy; override;
//    procedure RegisterModule(const AModule: TDbUpgraderModuleClass);
    procedure RegisterModule(const ADbUpgraderModuleClass: TDbUpgraderModuleClass);
//    property Modules[const AIndex: Integer]: TDbUpgraderModuleClass read GetModule; default;
    property Modules[const AIndex: Integer]: string read GetModule; default;
  end;

function OfficeDbUpgraderModules: TDbUpgraderModules;
function ClinicalDbUpgraderModules: TDbUpgraderModules;

implementation

uses
  System.RegularExpressions,
  System.SysUtils;

var
  MOfficeDbUpgraderModules: TDbUpgraderModules;
  MClinicalDbUpgraderModules: TDbUpgraderModules;

function OfficeDbUpgraderModules: TDbUpgraderModules;
begin
  if not Assigned(MOfficeDbUpgraderModules) then
    MOfficeDbUpgraderModules := TDbUpgraderModules.Create(COfficeDbUpgraderModuleClassNamePrefix);

  Result := MOfficeDbUpgraderModules;
end;

function ClinicalDbUpgraderModules: TDbUpgraderModules;
begin
  if not Assigned(MClinicalDbUpgraderModules) then
    MClinicalDbUpgraderModules := TDbUpgraderModules.Create(CClinicalDbUpgraderModuleClassNamePrefix);

  Result := MClinicalDbUpgraderModules;
end;

{ TDbUpgraderModules }

constructor TDbUpgraderModules.Create(const AModuleClassNamePrefix: string);
begin
//  FModuleList := TDbUpgraderModuleList.Create;
  FModuleClassNamePrefix := AModuleClassNamePrefix;
  FSortedModuleList := TStringList.Create;
  FSortedModuleList.Sorted := True;
end;

destructor TDbUpgraderModules.Destroy;
begin
  FSortedModuleList.Free;
  inherited;
end;

//function TDbUpgraderModules.GetModule(const AIndex: Integer): TDbUpgraderModuleClass;
function TDbUpgraderModules.GetModule(const AIndex: Integer): string;
begin
  Result := FSortedModuleList[AIndex];
end;

//procedure TDbUpgraderModules.RegisterModule(const AModule: TDbUpgraderModuleClass);
procedure TDbUpgraderModules.RegisterModule(const ADbUpgraderModuleClass: TDbUpgraderModuleClass);
const
  CModuleClassNameDbVersionFormat = '([0-9]{4})';
var
  LRegEx: TRegEx;
  LDbUpgraderModuleClassName: string;
  LRegExMatch: TMatch;
  LFoundIndex: Integer;

//  LClass: TPersistentClass;
//  LObj: TObject;
//  LIsCorrect: Boolean;
begin
  LRegEx := TRegEx.Create(FModuleClassNamePrefix + CModuleClassNameDbVersionFormat, [roIgnoreCase]);
  LDbUpgraderModuleClassName := ADbUpgraderModuleClass.ClassName;
  LRegExMatch := LRegEx.Match(LDbUpgraderModuleClassName);

  if not LRegExMatch.Success then
    raise Exception.Create('Please use module class name format: '
        + FModuleClassNamePrefix + CModuleClassNameDbVersionFormat);

  if FSortedModuleList.Find(LDbUpgraderModuleClassName, LFoundIndex) then
    raise Exception.Create('Found duplicate module class name: ' + LDbUpgraderModuleClassName);

  RegisterClass(ADbUpgraderModuleClass);
  FSortedModuleList.Add(LDbUpgraderModuleClassName);

//  LClass := GetClass(LDbUpgraderModuleClassName);
//  LObj := LClass.Create;
//  LIsCorrect := LObj is TDbUpgraderModuleClass;
end;

initialization
finalization
end.
