program ZenFont;

{$mode objfpc}{$H+}

uses
  {$IFDEF LINUX}
  cthreads,
  {$ENDIF}
  Interfaces,
  Forms,
  uMain;

{$R *.res}

begin
  Application.Title := '';
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

