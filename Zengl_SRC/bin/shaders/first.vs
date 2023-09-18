#version 330 core

layout(location = 0) in vec4 pos;
layout(location = 1) in vec4 color;

uniform mat4 projMatr;

out vec4 fragColor;

void main() {
    gl_Position = projMatr * pos;
    fragColor = color;
}