program demo19;

// RU: Этот файл содержит некоторые настройки(например использовать ли статическую компиляцию) и определения ОС под которую происходит компиляция.
// EN: This file contains some options(e.g. whether to use static compilation) and defines of OS for which is compilation going.
{$I zglCustomConfig.cfg}
{$I zgl_config.cfg}

{$IFDEF WINDOWS}
  {$R *.res}
{$ENDIF}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Math,
  zgl_window,
  zgl_screen,
  zgl_timers,
  zgl_utils,
  zgl_types,
  zgl_pasOpenGL,
  zgl_opengl_all,
  zgl_gltypeconst,
  zgl_matrix,    // new
  zgl_file,
  zgl_log;

const
  _vertex = 0;
  _color  = 1;

var
  DirApp  : UTF8String;
  DirHome : UTF8String;
  DirShader: UTF8String = {$IfNDef MAC_COCOA}'../shaders/'{$EndIf};

  TimeStart  : LongWord = 0;

  // RU: переменная для хранения индекса юниформа.
  // EN: variable to store the uniform index.
  projMatrLoc: GLuint;
  // RU: шейдер, вершинный шейдер, фрагментный шейдер.
  // EN: shader, vertex shader, fragment shader.
  shadProg, vertShad, fragShad: GLuint;
  // RU: вершины (3 координаты).
  // EN: vertices (3 coordinates).
  verticesData: array[0..11] of Single = (-1, 0, -2, 1,
                                          1, 0, -0.4, 1,
                                          3, 1, -2, 1);
  // RU: цветю.
  // EN: color.
  colorData: array[0..11] of Single    = (1, 0, 0, 1,
                                          0, 1, 0, 1,
                                          0, 0, 1, 1);
  vao: GLuint;
  vboHandles: array[0..1] of GLuint;

// RU: создание VAO и VBO.
// EN: creation of VAO and VBO.
procedure createVBOAndVAO;
begin
  // RU: буферные объекты.
  // EN: buffer objects.
  glGenBuffers(2, @vboHandles);

  // RU: Создаём объект массива вершин (для того чтоб при прорисовке этого не делать).
  // EN: We create an object of an array of vertices (so that we don’t have to do this when drawing).
  glGenVertexArrays(1, @vao);
  // установим созданный VAO как текущий
  glBindVertexArray(vao);

  // RU: активируем массив вершинных атрибутов.
  // EN: activate the array of vertex attributes.
  glEnableVertexAttribArray(_vertex); // vertex
  glEnableVertexAttribArray(_color);  // color

  // RU: закрепить индекс 0 за буфером координат.
  // EN: assign index 0 to the coordinate buffer.
  glBindBuffer(GL_ARRAY_BUFFER, vboHandles[_vertex]);
  // RU: заполнить буфер координат.      Это позволительно, ошибки не создаёт.
  // EN: fill the coordinate buffer.     This is permissible and does not create errors.
  glBufferData(GL_ARRAY_BUFFER, SizeOf(verticesData), @verticesData, GL_STATIC_DRAW);
  glVertexAttribPointer(_vertex, 4, GL_FLOAT, GL_FALSE, 0, nil);

  // RU: закрепить индекс 1 за буфером цвета.
  // EN: assign index 1 to the color buffer.
  glBindBuffer(GL_ARRAY_BUFFER, vboHandles[_color]);
  // RU: заполнить буфер цвета.      Это позволительно, ошибки не создаёт.
  // EN: fill the color buffer.      This is permissible and does not create errors.
  glBufferData(GL_ARRAY_BUFFER, SizeOf(colorData), @colorData, GL_STATIC_DRAW);
  glVertexAttribPointer(_color, 4, GL_FLOAT, GL_FALSE, 0, nil);
end;

// RU: определяем ViewPort для нашей программы.
// EN: We define the ViewPort for our program.
procedure UserSetViewPort;
begin
  // RU: вместо "zgl_Get(WINDOW_WIDTH)" и "zgl_Get(WINDOW_HEIGHT)" можно создать
  //     константы для ширины и высоты окна и указать их во ViewPort.
  // EN: Instead of "zgl_Get(WINDOW_WIDTH)" and "zgl_Get(WINDOW_HEIGHT)" you can
  //     create constants for the width and height of the window and specify them
  //     in the ViewPort.
  glViewport(0, 0, zgl_Get(WINDOW_WIDTH), zgl_Get(WINDOW_HEIGHT));
end;

// RU: используем свою матрицу проекции.
// EN: We use our projection matrix.
procedure UserMode;
begin
  Matrix4_Perspective(45, zgl_Get(WINDOW_WIDTH) / zgl_Get(WINDOW_HEIGHT), 1, 100);
  // glUseProgram(shadProg);        // это не обязательно в данном случае.
  // RU: если данная переменная не используется в шейдере, то и вызов делать не будем.
  // EN: if this variable is not used in the shader, then we will not make the call.
  if projMatrLoc <> -1 then
    glUniformMatrix4fv(projMatrLoc, 1, GL_FALSE, @projMatr);
  // glUseProgram(0);             // это не обязательно в данном случае.
end;

// RU: Тут можно выполнять загрузку основных ресурсов и производить инициализацию
//     начальных данных программы.
// EN: Here you can load the main resources and initialize the initial program data.
procedure Init;
var
  status: GLint;
begin
  // RU: создаём буфера и привязываем их к VAO.
  // EN: we create buffers and bind them to VAO.
  createVBOAndVAO;
  // RU: создание шедерной программы и шейдеров.
  // EN: creating a shader program and shaders.
  shadProg := glCreateProgram;
  vertShad := glCreateShader(GL_VERTEX_SHADER);
  fragShad := glCreateShader(GL_FRAGMENT_SHADER);
  // RU: загружаем шейдера, компилируем и делаем проверку успешно скомпилирован
  //     шейдер или нет.
  // EN: we load the shader, compile it and check whether the shader compiled
  //     successfully or not.
  if not LoadAndCreateShader(DirShader + 'first.vs', vertShad) or not LoadAndCreateShader(DirShader + 'first.fs', fragShad) then
  begin
    log_Add('Shader not loaded!!!');
    zgl_Exit;
  end;
  // RU: присоединяем шейдера к программе.
  // EN: We attach the shader to the program.
  glAttachShader(shadProg, vertShad);
  glAttachShader(shadProg, fragShad);
  // RU: линкуем программу.
  // EN: link the program.
  glLinkProgram(shadProg);
  // RU: проверяем статус линковки.
  // EN: check the status of the link.
  glGetProgramiv(shadProg, GL_LINK_STATUS, @status);
  if status <> 1 then
  begin
    log_Add('Shader program not link!!!');
    zgl_Exit;
  end;
  // RU: получаем юниформ-индекс projMatr из шейдерной программы.
  // EN: get the uniform index projMatr from the shader program.
  projMatrLoc := glGetUniformLocation(shadProg, 'projMatr');
  // RU: проверяем, указана ли данная матрица в шейдере.
  // EN: we check whether this matrix is specified in the shader.
  if projMatrLoc <> -1 then
  begin
    // RU: это может быть не критичной ошибкой. Просто данный аргумент не
    //     используется в шейдере или удалён из шейдера, как не используемый.
    // EN: this may not be a critical error. It’s just that this argument is not
    //     used in the shader or has been removed from the shader as not being used.
    log_Add('projMatr not found in shader.');
  end;

  // RU: проверка корректности скомпилированной программы.
  // EN: checking the correctness of the compiled program.
  glValidateProgram(shadProg);
  glGetProgramiv(shadProg, GL_VALIDATE_STATUS, @status);
  if status <> 1 then
  begin
    log_Add('Shader program not validate!!!');
    zgl_Exit;
  end;

  glDeleteShader(vertShad);
  glDeleteShader(fragShad);

  glUseProgram(shadProg);
  zgl_Enable(DEPTH_BUFFER);
  glDepthMask(GL_TRUE);
  glDepthFunc(GL_LEQUAL);
  glDepthRange(0.0, 1.0);
end;

procedure Draw;
begin
  // RU: Тут "рисуем" что угодно :)
  // EN: Here "draw" anything :)
  glClearDepth(1);
  // glUseProgram(shadProg);             // это не обязательно в данном случае.
  // glBindVertexArray(vao);             // это не обязательно в данном случае.
  glDrawArrays(GL_TRIANGLES, 0, 3);

  // glUseProgram(0);                    // это не обязательно  в данном случае.
end;

procedure Update( dt : Double );
begin
  // RU: Эта функция наземенима для реализация плавного движения чего-либо, т.к. точность таймеров ограничена FPS.
  // EN: This function is the best way to implement smooth moving of something, because accuracy of timers are restricted by FPS.
end;

// RU: Пример использования таймера.
// EN: An example of using a timer.
procedure Timer;
begin
  // RU: Будем в заголовке показывать количество кадров в секунду.
  // EN: Caption will show the frames per second.
  wnd_SetCaption( 'test OpenGL 3.3. [ FPS: ' + u_IntToStr( zgl_Get( RENDER_FPS ) ) + ' ]' );
end;

procedure KeyMouseEvent;
begin
  // RU: Функция обработки клавиатуры, мыши, джойстика и тачпада. Все события связанные с ними очищаются после её обработки.
  //     Все попытки обработать клавиатуру, мышь или тачпад в других функциях могут привести к непредвиденным ситуациям.
  // EN: Keyboard, mouse, joystick and touchpad handling function. All events associated with them are cleared after processing it.
  //     Any attempt to handle the keyboard, mouse, or touchpad in other functions may lead to unexpected situations.
end;

procedure Quit;
begin
  // RU: События которые надо произвести по завершению программы. Очистка данных.
  // EN: Events to be performed at the end of the program.
  // это нужно или нет?
  glBindBuffer(GL_ARRAY_BUFFER, 0);
  glDeleteBuffers(2, @vboHandles);
  glBindVertexArray(0);
  glDeleteVertexArrays(1, @vao);

  glUseProgram(0);

  glDeleteProgram(shadProg);
end;

Begin
  // RU: Для загрузки/создания каких-то своих настроек/профилей/etc. можно получить путь к домашенему каталогу пользователя, или к исполняемому файлу(не работает для GNU/Linux).
  // EN: For loading/creating your own options/profiles/etc. you can get path to user home directory, or to executable file(not works for GNU/Linux).
  DirApp  := utf8_Copy( PAnsiChar( zgl_Get( DIRECTORY_APPLICATION ) ) );
  DirHome := utf8_Copy( PAnsiChar( zgl_Get( DIRECTORY_HOME ) ) );

  // RU: Устанавливаем интервал на обработку событий клавиатуры, мыши, тачпада. И регистрируем процедуру.
  //     Вызывать zgl_SetEventInterval не обязательно. Значение 16 стоит по умолчанию.
  // EN: We set the interval for processing keyboard, mouse, touchpad events. And we register the procedure.
  //     Calling zgl_SetEventInterval is optional. The default is 16.
  zgl_SetEventsInterval(16);
  zgl_Reg(SYS_EVENTS, @KeyMouseEvent);

  // RU: Создаем таймер с интервалом 1000мс.
  // EN: Create a timer with interval 1000ms.
  TimeStart := timer_Add( @Timer, 1000, t_Start );

  // RU: Регистрируем процедуру, что выполнится сразу после инициализации ZenGL.
  // EN: Register the procedure, that will be executed after ZenGL initialization.
  zgl_Reg( SYS_LOAD, @Init );
  // RU: Регистрируем процедуру, где будет происходить рендер.
  // EN: Register the render procedure.
  zgl_Reg( SYS_DRAW, @Draw );
  // RU: Регистрируем процедуру, которая будет принимать разницу времени между кадрами.
  // EN: Register the procedure, that will get delta time between the frames.
  zgl_Reg( SYS_UPDATE, @Update );
  // RU: Регистрируем процедуру, которая выполнится после завершения работы ZenGL.
  // EN: Register the procedure, that will be executed after ZenGL shutdown.
  zgl_Reg( SYS_EXIT, @Quit );
  // RU: пользовательский ViewPort. В данном случае это не обязательно.
  // EN: custom ViewPort. In this case it is not necessary.
  zgl_Reg(OGL_VIEW_PORT, @UserSetViewPort);
  // RU: пользовательский режим 2d или 3d.
  // EN: custom 2d or 3d mode.
  zgl_Reg(OGL_USER_MODE, @UserMode);

  // RU: Устанавливаем заголовок окна.
  // EN: Set the caption of the window.
  wnd_SetCaption(utf8_Copy('01 - Initialization'));
  // RU: Разрешаем курсор мыши. True - по умолчанию, значит определять не надо.
  // EN: Allow to show the mouse cursor. True - by default, which means there is no need to define it.
  wnd_ShowCursor( TRUE );

  // RU: Указываем первоначальные настройки.
  // EN: Set screen options.
  zgl_SetParam(800, 600, false, false);

  {$IfDef GL_VERSION_3_0}
  // RU: Устанавливаем контекст OpenGL 3.3. Для этого надо включить  дефайн "USE_GL_33" и отключить "USE_MIN_OPENGL" в GLdefine.cfg.
  // EN: Setting context OpenGL 3.3. To do this, enable the "USE_GL_33" define and disable "USE_MIN_OPENGL" in GLdefine.cfg.
  SetGLVersionAndFlags(3, 3);
  {$EndIf}

  // RU: Инициализируем ZenGL.
  // EN: Initialize ZenGL.
  zgl_Init();
End.

