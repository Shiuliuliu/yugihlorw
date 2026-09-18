#ifdef GL_ES                                                            
precision mediump float;                                                
#endif                                                                  
                                                                                                                 
uniform float u_bright;                                                 
                                                                        
varying vec2 v_texCoord;                                                
varying vec4 v_fragmentColor;                                           
                                                                        
void main(void)                                                         
{                                                                       
    // Convert to greyscale using NTSC weightings                       
    vec4 col = v_fragmentColor * texture2D(CC_Texture0, v_texCoord);      
    float r = col.r + u_bright;                                         
    if (r > 1.0) r = 1.0;                                               
    float g = col.g + u_bright;                                         
    if (g > 1.0) g = 1.0;                                               
    float b = col.b + u_bright;                                         
    if (b > 1.0) b = 1.0;                                               
    gl_FragColor = vec4(r, g, b, 1.0) * col.a;                          
}       