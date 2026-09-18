#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;

void main(void)
{
	vec4 c = v_fragmentColor * texture2D(CC_Texture0, v_texCoord);
    float gray = 0.2126 * c.r + 0.7152 * c.g + 0.0722 * c.b + 0.12 * c.w;
    if (gray > 1.0) gray = 1.0;	
	gl_FragColor = vec4(gray, gray, gray, c.w);
}