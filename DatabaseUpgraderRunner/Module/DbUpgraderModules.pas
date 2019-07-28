unit DbUpgraderModules;

interface

uses
  System.Generics.Collections,
  System.Generics.Defaults;

type
  TDbUpgraderModuleClass = class of TDbUpgraderModule;
  TDbUpgraderModule = class(TObject)
  public
    class function Compare(const ALeft, ARight: TDbUpgraderModuleClass): Integer;
  end;

  TDbUpgraderModules = class(TObject)
  private
    FModuleClassNamePrefix: string;
    FSortedModuleList: TList<TDbUpgraderModuleClass>;
    function GetModule(const AIndex: Integer): TDbUpgraderModuleClass;
  public
    constructor Create(const AModuleClassNamePrefix: string);
    destructor Destroy; override;
    procedure RegisterModule(const ADbUpgraderModuleClass: TDbUpgraderModuleClass);
    property Modules[const AIndex: Integer]: TDbUpgraderModuleClass read GetModule; default;
  end;

implementation

uses
  System.RegularExpressions,
  System.SysUtils;

{ TDbUpgraderModule }

class function TDbUpgraderModule.Compare(const ALeft, ARight: TDbUpgraderModuleClass): Integer;
begin
  Result := CompareText(ALeft.ClassName, ARight.ClassName);
end;

{ TDbUpgraderModules }

constructor TDbUpgraderModules.Create(const AModuleClassNamePrefix: string);
begin
  FModuleClassNamePrefix := AModuleClassNamePrefix;
  FSortedModuleList := TList<TDbUpgraderModuleClass>.Create(
    TComparer<TDbUpgraderModuleClass>.Construct(TDbUpgraderModule.Compare));
end;

destructor TDbUpgraderModules.Destroy;
begin
  FSortedModuleList.Free;
  inherited;
end;

function TDbUpgraderModules.GetModule(const AIndex: Integer): TDbUpgraderModuleClass;
begin
  Result := FSortedModuleList[AIndex];
end;

procedure TDbUpgraderModules.RegisterModule(const ADbUpgraderModuleClass: TDbUpgraderModuleClass);
const
  CModuleClassNameDbVersionFormat = '([0-9]{4})';
var
  LRegEx: TRegEx;
  LDbUpgraderModuleClassName: string;
  LRegExMatch: TMatch;
begin
  LRegEx := TRegEx.Create(FModuleClassNamePrefix + CModuleClassNameDbVersionFormat, [roIgnoreCase]);
  LDbUpgraderModuleClassName := ADbUpgraderModuleClass.ClassName;
  LRegExMatch := LRegEx.Match(LDbUpgraderModuleClassName);

  if not LRegExMatch.Success then
    raise Exception.Create('Please use module class name format: '
        + FModuleClassNamePrefix + CModuleClassNameDbVersionFormat);

  if FSortedModuleList.Contains(ADbUpgraderModuleClass) then
    raise Exception.Create('Found duplicate module class name: ' + LDbUpgraderModuleClassName);

  FSortedModuleList.Add(ADbUpgraderModuleClass);
  FSortedModuleList.Sort;
end;

end.
