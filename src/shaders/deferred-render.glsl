#version 300 es
precision highp float;

#define EPS 0.0001
#define PI 3.1415962

in vec2 fs_UV;
out vec4 out_Col;

uniform sampler2D u_gb0;
uniform sampler2D u_gb1;
uniform sampler2D u_gb2;

uniform float u_Time;

uniform mat4 u_View;


void main() { 
	// read from GBuffers

	vec4 u_CamPos = vec4(0,0,0,1);
	// Define my light position;
	vec4 tempLight = vec4(15, 0, 15, 1);
	
	vec4 m_light = u_View * tempLight;

	// Get camera_world normal and depth from gb0;
	vec4 gb0_normal = vec4(texture(u_gb0,fs_UV).xyz, 1.0);
	float z_buffer = texture(u_gb0, fs_UV).w;

	// Get camera_world position from gb1;
	//vec4 gb1_pos = texture(u_gb1, fs_UV);

	vec2 NDC = fs_UV * 2.0 - 1.0;
	vec4 ref = u_CamPos + z_buffer * vec4(0,0,1,0);
	float len = length(ref - u_CamPos);
	float a = 45.0 * PI / 180.0 / 2.0;
	vec4 V = vec4(0, 1, 0, 0) * len * tan(a);
	vec4 H = vec4(1, 0, 0, 0) * len * 1.0 * tan(a);
	vec4 gb1_pos = ref + NDC.x * H + NDC.y * V;

	// Lambert shading 
	vec4 lightDir = m_light - gb1_pos;
	float lightInteristy = dot(normalize(lightDir), gb0_normal);
	lightInteristy = clamp(lightInteristy, 0.0, 1.0);

	float ambientTerm = 0.2;
	
	
	// Blinn-Phong shading
	vec4 cameraDir = u_CamPos - gb1_pos;
	float exp = 1.0;
	float specularIntensity = max(pow(dot((cameraDir+lightDir)*0.5, gb0_normal), exp), 0.0);
	specularIntensity = 0.0;
	
	
	// Get color information from gb2;
	vec4 gb2 = texture(u_gb2, fs_UV);

	float lightTerm = lightInteristy + ambientTerm + specularIntensity;
	vec3 col = gb2.xyz;
	col = gb2.xyz * lightTerm;

	out_Col = vec4(col, 1.0);
}