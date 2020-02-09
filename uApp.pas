unit uApp;

interface

type
  { Sample application to simulate a couple of common programming mistakes leading to leaks }

  TApp = class
  strict private
    procedure Execute;

    // using a class variable to see if Deleaker correctly identifies class-level leaks
    class var
      FInstance: TApp;

  public
    class procedure Run;

    class constructor Create;
    class destructor Destroy;
  end;

implementation

uses
  System.SysUtils, System.Classes, uXmpp;
{ TApp }

{--------------------------------------------------------------------------------------------------}
class constructor TApp.Create;
begin
  FInstance := TApp.Create;
end;

{--------------------------------------------------------------------------------------------------}
class destructor TApp.Destroy;
begin
  // comment this out test if deleaker detects this leak
  if Assigned(FInstance) then
    FreeAndNil(FInstance);
end;

{--------------------------------------------------------------------------------------------------}
procedure TApp.Execute;
var
  Attributes: TXmppAttributeList;
  Attribute: TXmppAttribute;
begin
  Attributes := TXmppAttributeList.Create;
  try
    Attributes.Push('type', 'get');
    Attributes.Push('id', '1');
    Attributes.Push('from', 'david@stjoseph');
    Attributes.Push('to', 'ginny@stjoseph');

    for Attribute in Attributes do
      Writeln(Attribute.ToString);
  finally
    // comment this out to test if deleaker detects this leak
    FreeAndNil(Attributes);
  end;
  Readln;
end;

{--------------------------------------------------------------------------------------------------}
class procedure TApp.Run;
begin
  FInstance.Execute;
end;


end.
