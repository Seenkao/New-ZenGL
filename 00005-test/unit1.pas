unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, unixtype, X, xlib, xutil, xrandr,
  dglOpenGL, gtk2, Gtk2Proc, gdk2x;//, GLEngine;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
  private

  public

  end;

type
  point2 = array[1..2] of GLfloat;

var
  Form1: TForm1;

implementation

uses
  Unit2;

{$R *.frm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  widget := GetFixedWidget( PGtkWidget( Panel1.Handle ) );
  gtk_widget_realize( widget );

  if not InitWindowOpenGL then
    form1.Destroy;

  WidthHandle := Panel1.Width;
  HeightHandle := Panel1.Height;
  Form1.Resize;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i, j: Integer;
  p: point2 = (0.0, 0.0);
  vertices: array[1..3] of point2 = ((0.0, 0.0), (250.0, 500.0),(500.0, 0.0));
begin
  glClearColor(0.3, 0.2, 0, 1);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glLoadIdentity;
  glColor3f(0, 1, 1);
  for i := 1 to 250000 do
  begin
    j := Random(3) + 1;
    p[1] := (p[1] + vertices[j, 1]) / 2;
    p[2] := (p[2] + vertices[j, 2]) / 2;
    glBegin(GL_POINTS);
      glVertex2fv(@p);
    glEnd;
  end;
  glXSwapBuffers(winDisplay, GDK_WINDOW_XID(widget^.window));

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  // уничтожаем openGL
  glXMakeCurrent(winDisplay, 0, nil);
  glXDestroyContext(winDisplay, myGlContext);
  FreeOpenGL;

  // уничтожаем окно
  XRRFreeScreenConfigInfo(winSettings);
  XSync(winDisplay, FALSE);
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if key = 27 then Form1.Close;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  if height = 0 then height := 1;
  glViewport(0, 0, _width, _height);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluOrtho2D(0, 500, 0, 500);
//  gluPerspective(45, width / height, 0.1, 1000);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
end;

end.