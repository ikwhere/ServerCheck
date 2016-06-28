program SERVER_P;

uses
  Forms,
  SERVER in 'SERVER.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
