#ifdef GL_ES                                                            
precision mediump float;                                                
#endif                                                                                                                                                                                                                           
                                                                        
varying vec2 v_texCoord;                                                
varying vec4 v_fragmentColor;                                           
                                                                        
void main(void)                                                         
{                                                                       
    // Convert to grayscale using NTSC weightings                       
    vec4 col = v_fragmentColor * texture2D(CC_Texture0, v_texCoord);

    if (col.a > 0.0)
    {
        float light = 0.2 * col.a;
        float r = col.r + light;
        if (r > 1.0) r = 1.0;
        float g = col.g + light;
        if (g > 1.0) g = 1.0;
        float b = col.b + light;
        if (b > 1.0) b = 1.0;

        col.rgb = vec3(r, g, b);
    }

    gl_FragColor = col;
}