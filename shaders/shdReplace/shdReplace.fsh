//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

#define LN 1 //Number of lights

uniform sampler2D tex;
//uniform float lights[LN*3];
uniform vec3 lights;

const vec3 lightColor = vec3(0.63, 0.63, 0.63);

void main()
{   
    vec4 DifSample = texture2D( gm_BaseTexture, v_vTexcoord);
    vec3 normal = normalize(texture2D( tex, v_vTexcoord ).rgb*-2.0+1.0);
    vec3 result = DifSample.rgb;
    
    //int i = 0;
    //vec3 lightPos = vec3(lights[i*3], lights[i*3+1], -300.);
    vec3 lightPos = vec3(lights.xy, -300.);
    float range = lights.z;
    float attenuation = max(1.0-length(vec2(v_vPosition)-lightPos.xy)/range,0.0);
    //graded attenuation
    if (attenuation > 0.25)
    {
        attenuation = 1.0;
    } else if (attenuation > 0.0)
    {
        attenuation = 0.5;
    }
    
    
		//normal mapping
		vec3 lightDir = normalize(lightPos - vec3(v_vPosition.x, v_vPosition.y, 0)); 
		float d = max(dot(normal, lightDir), 0.0);
		vec3 diffuse = d * lightColor * DifSample.rgb * attenuation;
		result += diffuse;
		// result.x = min(result.x, DifSample.x);
		// result.y = min(result.y, DifSample.y);
		// result.z = min(result.z, DifSample.z);
    
    gl_FragColor = vec4(result, DifSample.a) * v_vColour;
    //gl_FragColor = vec4(normal, DifSample.a) * v_vColour;
}
