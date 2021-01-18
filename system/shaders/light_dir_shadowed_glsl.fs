FSH     s_mask    s_shadow    screenSz   color   shadowColor   �  uniform sampler2D s_mask;
uniform sampler2D s_shadow;
uniform highp vec4 screenSz;
uniform highp vec4 color;
uniform highp vec4 shadowColor;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = (gl_FragCoord.xy / screenSz.xy);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (s_mask, tmpvar_1);
  if ((tmpvar_2.x <= 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (s_shadow, tmpvar_1);
  if (((tmpvar_3.x * tmpvar_2.x) > 0.0)) {
    lowp vec4 tmpvar_4;
    tmpvar_4 = mix (color, shadowColor, tmpvar_3.z);
    gl_FragData[0] = tmpvar_4;
  } else {
    gl_FragData[0] = (tmpvar_2.x * color);
  };
  gl_FragData[1] = (tmpvar_2.x * color);
}

 