unit uXmpp;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections;

type
  { TXmppAttribute }

  TXmppAttribute = class
  private
    FName: string;
    FValue: string;
    procedure SetName(const Value: string);
    procedure SetValue(const Value: string);
  public
    property Name: string read FName write SetName;
    property Value: string read FValue write SetValue;

    constructor Create(AName: string; AValue: string = '');

    function ToString: string; override;
  end;

  { TXmppAttributeList }

  TXmppAttributeList = class
  private
    FAttributes: TObjectList<TXmppAttribute>;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Push(AName: string; AValue: string = '');

    function GetEnumerator: TEnumerator<TXmppAttribute>;
  end;

implementation

{ TXmppAttribute }

{--------------------------------------------------------------------------------------------------}
constructor TXmppAttribute.Create(AName, AValue: string);
begin
  FValue := AValue;
  SetName(AName);
end;

{--------------------------------------------------------------------------------------------------}
procedure TXmppAttribute.SetName(const Value: string);
begin
  if (string.isNullOrEmpty(Value)) then
    raise Exception.Create('Missing value for attribute name');

  FName := Value;
end;

{--------------------------------------------------------------------------------------------------}
procedure TXmppAttribute.SetValue(const Value: string);
begin
  FValue := Value;
end;

{--------------------------------------------------------------------------------------------------}
function TXmppAttribute.ToString: string;
begin
  Result := string.format('%s=''%s''', [FName, FValue]);
end;

{ TXmppAttributeList }

{--------------------------------------------------------------------------------------------------}
constructor TXmppAttributeList.Create;
begin
  // to force a leak, pass False as an argument to the Create method
  FAttributes := TObjectList<TXmppAttribute>.Create();
end;

{--------------------------------------------------------------------------------------------------}
destructor TXmppAttributeList.Destroy;
begin
  if Assigned(FAttributes) then
    FreeAndNil(FAttributes);

  inherited;
end;

{--------------------------------------------------------------------------------------------------}
function TXmppAttributeList.GetEnumerator: TEnumerator<TXmppAttribute>;
begin
  Result := FAttributes.GetEnumerator;
end;

{--------------------------------------------------------------------------------------------------}
procedure TXmppAttributeList.Push(AName, AValue: string);
begin
  FAttributes.Add(TXmppAttribute.Create(AName, AValue));
end;

end.
