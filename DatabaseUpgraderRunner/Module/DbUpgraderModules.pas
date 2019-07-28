unit DbUpgraderModules;

interface

uses
  System.Classes,
  System.Generics.Collections,
  System.Generics.Defaults;

type
  TDbUpgraderModuleClass = class of TDbUpgraderModule;
  TDbUpgraderModule = class(TPersistent)
  public
    class function Compare(const ALeft, ARight: TDbUpgraderModuleClass): Integer;
  end;

//  TDbUpgraderModuleList = TList<TDbUpgraderModuleClass>;
  TDbUpgraderModules = class(TObject)
  private
//    FModuleList: TDbUpgraderModuleList;
    FModuleClassNamePrefix: string;
//    FSortedModuleList: TStringList;
    FModuleComparison: TComparison<TDbUpgraderModuleClass>;
    FSortedModuleList: TList<TDbUpgraderModuleClass>;
//    function GetModule(const AIndex: Integer): TDbUpgraderModuleClass;
    function GetModule(const AIndex: Integer): string;
//    function Compare(const Left, Right: TDbUpgraderModuleClass): Integer;
  public
    constructor Create(const AModuleClassNamePrefix: string);
    destructor Destroy; override;
//    procedure RegisterModule(const AModule: TDbUpgraderModuleClass);
    procedure RegisterModule(const ADbUpgraderModuleClass: TDbUpgraderModuleClass);
//    property Modules[const AIndex: Integer]: TDbUpgraderModuleClass read GetModule; default;
    property Modules[const AIndex: Integer]: string read GetModule; default;
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
//  FModuleList := TDbUpgraderModuleList.Create;
  FModuleClassNamePrefix := AModuleClassNamePrefix;
//  FSortedModuleList := TStringList.Create;
//  FSortedModuleList.Sorted := True;

  FModuleComparison :=
    function(const Left, Right: TDbUpgraderModuleClass): Integer
    begin
      Result := CompareText(Left.ClassName, Right.ClassName);
    end;

  FSortedModuleList := TList<TDbUpgraderModuleClass>.Create(TComparer<TDbUpgraderModuleClass>.Construct(TDbUpgraderModule.Compare));
end;

destructor TDbUpgraderModules.Destroy;
begin
  FSortedModuleList.Free;
  inherited;
end;

//function TDbUpgraderModules.GetModule(const AIndex: Integer): TDbUpgraderModuleClass;
function TDbUpgraderModules.GetModule(const AIndex: Integer): string;
begin
  Result := FSortedModuleList[AIndex].ClassName;
end;

//function TDbUpgraderModules.Compare(const Left, Right: TDbUpgraderModuleClass): Integer;
//begin
//  Result := CompareText(Left.ClassName, Right.ClassName);
//end;

//procedure TDbUpgraderModules.RegisterModule(const AModule: TDbUpgraderModuleClass);
procedure TDbUpgraderModules.RegisterModule(const ADbUpgraderModuleClass: TDbUpgraderModuleClass);
const
  CModuleClassNameDbVersionFormat = '([0-9]{4})';
var
  LRegEx: TRegEx;
  LDbUpgraderModuleClassName: string;
  LRegExMatch: TMatch;
//  LFoundIndex: Integer;

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

//  if FSortedModuleList.Find(LDbUpgraderModuleClassName, LFoundIndex) then
  if FSortedModuleList.Contains(ADbUpgraderModuleClass) then
    raise Exception.Create('Found duplicate module class name: ' + LDbUpgraderModuleClassName);

//  RegisterClass(ADbUpgraderModuleClass);
//  FSortedModuleList.Add(LDbUpgraderModuleClassName);
  FSortedModuleList.Add(ADbUpgraderModuleClass);
  FSortedModuleList.Sort;

//  LClass := GetClass(LDbUpgraderModuleClassName);
//  LObj := LClass.Create;
//  LIsCorrect := LObj is TDbUpgraderModuleClass;
end;

end.
