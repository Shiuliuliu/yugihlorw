#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;

void main() {
		vec4 sum = vec4(0.0);
		
    //apply blurring, using a 9-tap filter with predefined gaussian weights
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y - 0.0104)) * 0.0162162162;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y - 0.0078)) * 0.0540540541;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y - 0.0052)) * 0.1216216216;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y - 0.0026)) * 0.1945945946;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y         )) * 0.2270270270;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y + 0.0026)) * 0.1945945946;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y + 0.0052)) * 0.1216216216;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y + 0.0078)) * 0.0540540541;
    sum += texture2D(CC_Texture0, vec2(v_texCoord.x, v_texCoord.y + 0.0104)) * 0.0162162162;

    //discard alpha
    gl_FragColor = v_fragmentColor * vec4(sum.rgb, 1.0);
}