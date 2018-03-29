#version 300 es
precision highp float;

// uniform vec2 u_Dimensions;

in vec2 fs_UV;
// out vec4 out_Col[2];
// out vec4 outColor;
out vec4 out_Col;

#define EPS 0.4
// float k[25] = float[](0.037823,	0.039428,	0.039978,	0.039428,	0.037823,
// 					0.039428,	0.041102,	0.041675,	0.041102,	0.039428,
// 					0.039978,	0.041675,	0.042257,	0.041675,	0.039978,
// 					0.039428,	0.041102,	0.041675,	0.041102,	0.039428,
// 					0.037823,	0.039428,	0.039978,	0.039428,	0.037823);
uniform sampler2D u_frame;
uniform float u_Time;

// Interpolate between regular color and channel-swizzled color
// on right half of screen. Also scale color to range [0, 5].
void main() {
	vec3 color = texture(u_frame, fs_UV).xyz;
	// out_Col[0] = vec4(color, 1.0);



	// float grey = 0.21 * color.x + 0.72 * color.y + 0.07 * color.z;
	// float m_grey = max(EPS, grey);
	// vec2 m_frag = gl_FragCoord.xy;
	// vec3 fin_Col2 = vec3(0.0); 
	// for(int i = 0; i < 5; i++)
	// {
	// 	for(int j = 0; j < 5; j++)
	// 	{
	// 		float intersity = k[i*5+j];
	// 		vec2 tempUV = vec2((m_frag.x + 2.0 - float(i)), (m_frag.y + 2.0 - float(j))) / u_Dimensions;
			
	// 		vec3 tempColor = texture(u_frame, tempUV).xyz;
	// 		fin_Col2 = fin_Col2 + tempColor * intersity;
	// 	}
	// }
	// out_Col[0] = vec4(1.0, 0.0, 0.0, 1.0);
	// out_Col[1] = vec4(1.0, 0.0, 0.0, 1.0);
	out_Col = vec4(color, 1.0);
}
