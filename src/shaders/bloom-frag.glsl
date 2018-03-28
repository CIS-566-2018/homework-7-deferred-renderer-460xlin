#version 300 es
precision highp float;

in vec2 fs_UV;
out vec4 out_Col;

uniform sampler2D u_frame;
uniform sampler2D u_grey;

uniform float u_Time;
// uniform vec2 u_Dimensions;

void main() {
	vec3 color = texture(u_frame, fs_UV).xyz;
	out_Col = vec4(color, 1.0);
}