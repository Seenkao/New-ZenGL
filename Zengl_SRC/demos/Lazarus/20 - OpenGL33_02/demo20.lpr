program demo20;

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
  zgl_textures,
  zgl_textures_png,
  zgl_pasOpenGL,
  zgl_opengl_all,
  zgl_gltypeconst,
  zgl_matrix,    // new
  zgl_file,
  zgl_log;

const
  _vertex   = 0;
  _texture  = 1;
  _index    = 2;
  // RU: константы для размеров нашего окна. Окно изначально создаётся статичным.
  // EN: constants for the size of our window. The window is initially created static.
  windowWidth = 1280;
  windowHeight = 1024;
  // RU: количество вершин куба.
  // EN: number of vertices of the cube.
  cubeVerticesCount = 24;
  // RU: количество индексов куба.
  // EN: number of cube indexes.
  cubeIndicesCount = 36;

var
  DirApp   : UTF8String;
  DirHome  : UTF8String;
  DirShader: UTF8String{$IfNDef MAC_COCOA} = '../shaders/'{$EndIf};
  dirRes   : UTF8String{$IFNDEF MACOSX} = '../data/' {$ENDIF};

  TimeStart  : LongWord = 0;

  // RU: переменная для хранения индекса юниформа.
  // EN: variable to store the uniform index.
  projMatrLoc: GLuint;
  // RU: шейдер, вершинный шейдер, фрагментный шейдер.
  // EN: shader, vertex shader, fragment shader.
  shadProg, vertShad, fragShad: GLuint;
(*  // RU: вершины (3 координаты).
  // EN: vertices (3 coordinates).
  verticesData: array[0..11] of Single = (-1, 0, -1, 1,
                                          1, 0, -0.4, 1,
                                          3, 1, 0, 1);
  // RU: цвет.
  // EN: color.
  colorData: array[0..11] of Single    = (1, 0, 0, 1,
                                          0, 1, 0, 1,
                                          0, 0, 1, 1);   *)

  vao: GLuint;
  vboHandles: array[0..2] of GLuint;
  // RU: описание геометрии куба для всех его сторон. Координаты вершин куба.
  // EN: description of the geometry of the cube for all its sides. Coordinates of the vertices of the cube.
  cubePositions: array [0..cubeVerticesCount - 1, 0..2] of Single = ((-1, 1, 1), (1, 1, 1), (1, -1, 1), (-1, -1, 1),       // front?
                                                                     (1, 1, -1), (-1, 1, -1), (-1, -1, -1), (1, -1, -1),   // back?
                                                                     (-1, 1, -1), (1, 1, -1), (1, 1, 1), (-1, 1, 1),       // top?
                                                                     (1, -1, -1), (-1, -1, -1), (-1, -1, 1), (1, -1, 1),   // bottom?
                                                                     (-1, 1, -1), (-1, 1, 1), (-1, -1, 1), (-1, -1, -1),   // left?
                                                                     (1, 1, 1), (1, 1, -1), (1, -1, -1), (1, -1, 1));      // right?
  // RU: текстурные кооринаты куба.
  // EN: texture coordinates of the cube.
  cubeTexcoords: array [0..cubeVerticesCount - 1, 0..1] of Single = ((0, 1), (1, 1), (1, 0), (0, 0),       // front?
                                                                     (0, 1), (1, 1), (1, 0), (0, 0),       // back?
                                                                     (0, 1), (1, 1), (1, 0), (0, 0),       // top?
                                                                     (0, 1), (1, 1), (1, 0), (0, 0),       // bottom?
                                                                     (0, 1), (1, 1), (1, 0), (0, 0),       // left?
                                                                     (0, 1), (1, 1), (1, 0), (0, 0));      // right?
  // RU: индексы вершин куба в порядке поротив часовой стрелки.
  // EN: cube vertex indices in counterclockwise order.
  cubeIndices: array [0..cubeIndicesCount - 1] of LongWord = ( 0, 3, 1,  1, 3, 2,   // front
                                                              4, 7, 5,  5, 7, 6,   // back
                                                              8,11, 9,  9,11,10,   // top
                                                             12,15,13, 13,15,14,   // bottom
                                                             16,19,17, 17,19,18,   // left
                                                             20,23,21, 21,23,22);  // right
  // RU: значение угла вращения по X, Y и Z.
  // EN: rotation angle value in X, Y and Z.
  cubeRotation: array [0..2] of Single;
  // RU: текстура.
  // EN: texture.
  texMiku: zglPTexture;
  // RU: переменная для хранения индекса текстуры.
  // EN: variable to store the texture index.
  textureLocation: GLint = -1;
  // RU: переменные для хранения индексов вершинных атрибутов.
  // EN: variables for storing vertex attribute indices.
  positionLocation: GLint = -1;
  texcoordLocation: GLint = -1;
  // RU:
  // EN:

// RU: создание VAO и VBO. Во избежание ошибок, создавайте VAO и VBO после создания шейдера!
// EN: creation of VAO and VBO. To avoid errors, create VAO and VBO after creating the shader!
procedure createVBOAndVAO;
begin
  // RU: буферные объекты.
  // EN: buffer objects.
  glGenBuffers(3, @vboHandles);

  // RU: Создаём объект массива вершин (для того чтоб при прорисовке этого не делать).
  // EN: We create an object of an array of vertices (so that we don’t have to do this when drawing).
  glGenVertexArrays(1, @vao);
  // установим созданный VAO как текущий
  glBindVertexArray(vao);

  // vertex
  positionLocation := glGetAttribLocation(shadProg, 'position');
  if positionLocation <> -1 then
  begin
    // RU: закрепить индекс 0 за буфером координат.
    // EN: assign index 0 to the coordinate buffer.
    glBindBuffer(GL_ARRAY_BUFFER, vboHandles[_vertex]);
    // RU: заполнить буфер координат.      Это позволительно, ошибки не создаёт.
    // EN: fill the coordinate buffer.     This is permissible and does not create errors.
    glBufferData(GL_ARRAY_BUFFER, cubeVerticesCount * 3 * SizeOf(Single), @cubePositions, GL_STATIC_DRAW);
    glVertexAttribPointer(positionLocation, 3, GL_FLOAT, GL_FALSE, 3 * SizeOf(Single), nil);
    // RU: активируем массив вершинных атрибутов.
    // EN: activate the array of vertex attributes.
    glEnableVertexAttribArray(positionLocation);
  end;
  // texture        в данном случае texcoordLocation должно быть равно константе _texture.
  texcoordLocation := glGetAttribLocation(shadProg, 'texcoord');
  if texcoordLocation <> - 1 then
  begin
    // RU: закрепить индекс 1 за буфером текстуры.
    // EN: assign index 1 to the texture buffer.
    glBindBuffer(GL_ARRAY_BUFFER, vboHandles[_texture]);
    // RU: заполнить буфер текстур.
    // EN: fill the color buffer.      This is permissible and does not create errors.
    glBufferData(GL_ARRAY_BUFFER, cubeVerticesCount * 2 * SizeOf(Single), @cubeTexcoords, GL_STATIC_DRAW);
    glVertexAttribPointer(texcoordLocation, 2, GL_FLOAT, GL_FALSE, 2 * SizeOf(Single), nil);
    glEnableVertexAttribArray(texcoordLocation);
  end;

  // RU: вывод будет происходить используя индексный буфер.
  // EN: output will occur using the index buffer.
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, vboHandles[_index]);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, cubeIndicesCount * SizeOf(LongWord), @cubeIndices, GL_STATIC_DRAW);
end;

// RU: определяем ViewPort для нашей программы.
// EN: We define the ViewPort for our program.
procedure UserSetViewPort;
begin
  glViewport(0, 0, windowWidth, windowHeight);
end;

// RU: используем свою матрицу проекции.
// EN: We use our projection matrix.
procedure UserMode;
begin
  // RU: если матрица будет изменяться, то желательно сразу вычислить значение
  //     aspectRatio = windowWidth / windowHeight, чтоб не делать это постоянно.
  // EN: if the matrix changes, then it is advisable to immediately calculate the value of
  //     aspectRatio = windowWidth / windowHeight, so as not to do this constantly.
  Matrix4x4_Perspective(45, windowWidth / windowHeight, 1, 100);
  // glUseProgram(shadProg);        // это не обязательно в данном случае.

  // RU: если данная переменная не используется в шейдере, то и вызов делать не будем.
  // EN: if this variable is not used in the shader, then we will not make the call.
  if projMatrLoc <> -1 then
  // RU: мы можем привязать любую матрицу к uniform.
  // EN: we can bind any matrix to a uniform.
    glUniformMatrix4fv(projMatrLoc, 1, GL_FALSE, @zgl_Matrixs[modelViewProjectionMatrix]);
  // glUseProgram(0);             // это не обязательно в данном случае.
end;

// RU: Тут можно выполнять загрузку основных ресурсов и производить инициализацию
//     начальных данных программы.
// EN: Here you can load the main resources and initialize the initial program data.
procedure Init;
var
  status: GLint;
begin
  // RU: создание шедерной программы и шейдеров.
  // EN: creating a shader program and shaders.
  shadProg := glCreateProgram;
  vertShad := glCreateShader(GL_VERTEX_SHADER);
  fragShad := glCreateShader(GL_FRAGMENT_SHADER);
  // RU: загружаем шейдера, компилируем и делаем проверку успешно скомпилирован
  //     шейдер или нет.
  // EN: we load the shader, compile it and check whether the shader compiled
  //     successfully or not.
  if not LoadAndCreateShader(DirShader + 'demo20.vs', vertShad) or not LoadAndCreateShader(DirShader + 'demo20.fs', fragShad) then
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

  // RU: создаём буфера и привязываем их к VAO.
  // EN: we create buffers and bind them to VAO.
  createVBOAndVAO;
  zgl_Enable(DEPTH_BUFFER);
  glDepthMask(GL_TRUE);
  glDepthFunc(GL_LEQUAL);
  glDepthRange(0.0, 1.0);

  // RU: начальные вычисления для матриц. Это можно сделать здесь, но если матрицы будут меняться в процессе программы, то здесь делать нельзя.
  // EN: initial calculations for matrices. This can be done here, but if the matrices will change during the program, then it cannot be done here.
  Matrix4x4_Translation(@zgl_MatrixS[viewMatrix], -1, 1, -2);
  Matrix4x4Multiply4x4(@zgl_MatrixS[projectionMatrix], @zgl_MatrixS[viewMatrix], @zgl_MatrixS[viewProjectionMatrix]);

  // загруженная текстура ни как не связана с объектом...
  texMiku := tex_LoadFromFile(dirRes + 'back02.png');

  //  glActiveTexture(GL_TEXTURE0);                      // возникает вопрос, а зачем это, если и без этого работает?
  //  glBindTexture(GL_TEXTURE_2D, texMiku.ID);          // возможно когда много текстур и разных объектов?

  // RU: получаем юниформ-индекс colorTexture из шейдерной программы.
  // EN: get the uniform index colorTexture from the shader program.
  textureLocation := glGetUniformLocation(shadProg, 'colorTexture');
  if textureLocation <> -1 then
    glUniform1f(textureLocation, 0);
end;

procedure Draw;
begin
  // RU: Тут "рисуем" что угодно :)
  // EN: Here "draw" anything :)
  glClearDepth(1);
  // glUseProgram(shadProg);             // это не обязательно в данном случае.
  // glBindVertexArray(vao);             // это не обязательно в данном случае.
  glDrawElements(GL_TRIANGLES, cubeIndicesCount, GL_UNSIGNED_INT, nil);

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
  cubeRotation[0] := cubeRotation[0] + 0.015;
  if cubeRotation[0] > 360 then
    cubeRotation[0] := cubeRotation[0] - 360;
  cubeRotation[1] := cubeRotation[1] + 0.045;
  if cubeRotation[1] > 360 then
    cubeRotation[1] := cubeRotation[1] - 360;
  cubeRotation[2] := cubeRotation[2] + 0.025;
  if cubeRotation[2] > 360 then
    cubeRotation[2] := cubeRotation[2] - 360;
  Matrix4x4_Rotation(@zgl_MatrixS[modelMatrix], cubeRotation[0], cubeRotation[1], cubeRotation[2]);
  Matrix4x4Multiply4x4(@zgl_MatrixS[viewProjectionMatrix], @zgl_MatrixS[modelMatrix], @zgl_MatrixS[modelViewProjectionMatrix]);
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
  TimeStart := timer_Add( @Timer, round(1000 / 60), t_Start );

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
  zgl_SetParam(windowWidth, windowHeight, false, false);

  {$IfDef GL_VERSION_3_0}
  // RU: Устанавливаем контекст OpenGL 3.3. Для этого надо включить  дефайн "USE_GL_33" и отключить "USE_MIN_OPENGL" в GLdefine.cfg.
  // EN: Setting context OpenGL 3.3. To do this, enable the "USE_GL_33" define and disable "USE_MIN_OPENGL" in GLdefine.cfg.
  SetGLVersionAndFlags(3, 3);
  {$EndIf}

  // RU: Инициализируем ZenGL.
  // EN: Initialize ZenGL.
  zgl_Init();
End.

