#version 300 es
precision highp float;


in vec2 fs_UV;
out vec4 out_Col;

uniform sampler2D u_frame;
uniform sampler2D u_frame2;

uniform vec2 u_Dimensions;

float k[81] = float[](
						0.008397,	0.009655,	0.010667,	0.011324,	0.011552,	0.011324,	0.010667,	0.009655,	0.008397,
						0.009655,	0.0111,		0.012264,	0.013019,	0.013282,	0.013019,	0.012264,	0.0111,		0.009655,
						0.010667,	0.012264,	0.013549,	0.014384,	0.014674,	0.014384,	0.013549,	0.012264,	0.010667,
						0.011324,	0.013019,	0.014384,	0.01527,	0.015578,	0.01527,	0.014384,	0.013019,	0.011324,
						0.011552,	0.013282,	0.014674,	0.015578,	0.015891,	0.015578,	0.014674,	0.013282,	0.011552,
						0.011324,	0.013019,	0.014384,	0.01527,	0.015578,	0.01527,	0.014384,	0.013019,	0.011324,
						0.010667,	0.012264,	0.013549,	0.014384,	0.014674,	0.014384,	0.013549,	0.012264,	0.010667,
						0.009655,	0.0111,		0.012264,	0.013019,	0.013282,	0.013019,	0.012264,	0.0111,		0.009655,
						0.008397,	0.009655,	0.010667,	0.011324,	0.011552,	0.011324,	0.010667,	0.009655,	0.008397);

// Interpolate between regular color and channel-swizzled color
// on right half of screen. Also scale color to range [0, 5].
void main() {
	float blurTerm = abs(texture(u_frame2, fs_UV).w) / 100.0;

    blurTerm *= 0.5;
    // vec3 color = texture(u_frame, fs_UV).xyz;

    vec2 m_frag = gl_FragCoord.xy;
	

	vec3 fin_Col2 = vec3(0.0); 
	for(int i = 0; i < 9; i++)
	{
		for(int j = 0; j < 9; j++)
		{
			float intersity = k[i*5+j];
			vec2 tempUV = vec2((m_frag.x + 4.0 - float(i)*blurTerm), (m_frag.y + 4.0 - float(j)*blurTerm)) / u_Dimensions;
			vec3 tempCol = texture(u_frame, tempUV).xyz;	
		    fin_Col2 = fin_Col2 + tempCol * intersity;
			
		}
	}


	out_Col = vec4(fin_Col2, 1.0);
}