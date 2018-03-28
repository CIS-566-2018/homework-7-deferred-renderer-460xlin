#version 300 es

// A vertex shader used by all post-process shaders to simply pass UV data
// to the fragment shader, and to position the vertices of the screen-space quad 

precision highp float;

in vec4 vs_Pos;


void main() {
	gl_Position = vs_Pos;
}
