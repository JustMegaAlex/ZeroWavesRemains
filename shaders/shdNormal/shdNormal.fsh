//
// Normal map lighting
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

uniform sampler2D tex;
uniform vec3 lights;
uniform float light_z;

const vec3 ambiance = vec3(0.63, 0.63, 0.63);
const vec3 lightColor = vec3(1., 1., 1.);

vec3 apply_light(vec3 light, vec3 normal, vec4 DifSample)
{
    vec3 lightPos = vec3(light.xy, light_z);
    float range = light.z;
    float attenuation = max(1.0-length(vec2(v_vPosition)-lightPos.xy)/range,0.0);
    //graded attenuation
    if (attenuation > 0.25)
    {
        attenuation = 1.0;
    } else if (attenuation > 0.0)
    {
        attenuation = 0.5;
    }
    
    // normal mapping
    vec3 lightDir = normalize(lightPos - vec3(v_vPosition.x, v_vPosition.y, 0)); 
    float d = max(dot(normal, lightDir), 0.0);
    return d * lightColor * DifSample.rgb * attenuation;
}

void main()
{   
    vec4 DifSample = texture2D( gm_BaseTexture, v_vTexcoord);
    vec3 normal = normalize(texture2D( tex, v_vTexcoord ).rgb*-2.0+1.0);
    vec3 result = ambiance * DifSample.rgb;

    result += apply_light(lights, normal, DifSample);

    result.x = min(result.x, DifSample.x);
    result.y = min(result.y, DifSample.y);
    result.z = min(result.z, DifSample.z);

    gl_FragColor = vec4(result, DifSample.a) * v_vColour;
}
