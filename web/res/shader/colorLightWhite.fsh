#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;

vec3 rgb2hsv(vec3 c)
{
    vec4 k = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, k.wz), vec4(c.gb, k.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 k = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + k.xyz) * 6.0 - k.www);
    return c.z * mix(k.xxx, clamp(p - k.xxx, 0.0, 1.0), c.y);
}

void main()
{
    vec4 textureColor = v_fragmentColor * texture2D(CC_Texture0, v_texCoord);
    vec3 fragRGB = textureColor.rgb;
    if (textureColor.a > 0.0)
    {
        vec3 fragHSV = rgb2hsv(fragRGB).xyz;
        fragHSV.x = mod(fragHSV.x -56.0 / 360.0, 1.0);
        fragHSV.y = clamp(fragHSV.y - 0.8, 0.0, 1.0);
        fragRGB = hsv2rgb(fragHSV);
    }

    gl_FragColor = vec4(fragRGB, textureColor.a);
}
