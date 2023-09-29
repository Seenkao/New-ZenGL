#version 330 core

// матрица преобразования координат, получаемая из программы
uniform mat4 projMatr;

// входные вершинные атрибуты
layout(location = 0) in vec3 position;
layout(location = 1) in vec2 texcoord;

// исходящие параметры, которые будут переданы в фрагментный шейдер
out vec2 fragTexcoord;

void main(void)
{
  // перевод позиции вершины из локальных координат в однородные
  gl_Position = projMatr * vec4(position, 1.0);

  // передадим текстурные координаты в фрагментный шейдер
  fragTexcoord = texcoord;
}
