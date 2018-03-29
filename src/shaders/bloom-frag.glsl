#version 300 es
precision highp float;

in vec2 fs_UV;
out vec4 out_Col[2];

uniform sampler2D u_frame;
uniform float u_Time;
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

void main() {
	vec3 originColor = texture(u_frame, fs_UV).xyz; //texture from deferred-render path

	
	vec2 m_frag = gl_FragCoord.xy;
	vec3 fin_Col = originColor;
	
	float blurTerm = 3.0;

	vec3 fin_Col2 = vec3(0.0); 
	for(int i = 0; i < 9; i++)
	{
		for(int j = 0; j < 9; j++)
		{
			float intersity = k[i*5+j];
			vec2 tempUV = vec2((m_frag.x + 4.0 - float(i)*blurTerm), (m_frag.y + 4.0 - float(j)*blurTerm)) / u_Dimensions;
			vec3 tempCol = texture(u_frame, tempUV).xyz;	
			float grey = 0.21 * tempCol.x + 0.72 * tempCol.y + 0.07 * tempCol.z;
			if(grey > 0.2)
			{
				fin_Col2 = fin_Col2 + tempCol * intersity;
			}
			
		}
	}
	fin_Col = fin_Col2;	

	out_Col[0] = vec4(originColor, 1.0);
	out_Col[1] = vec4(fin_Col, 1.0);
}