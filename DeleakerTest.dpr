program DeleakerTest;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uXmpp in 'uXmpp.pas',
  uApp in 'uApp.pas';

begin
  try
    TApp.Run;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
