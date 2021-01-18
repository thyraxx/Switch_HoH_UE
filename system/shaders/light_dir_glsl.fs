FSH     s_mask    screenSz   color   j  uniform sampler2D s_mask;
uniform highp vec4 screenSz;
uniform highp vec4 color;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = (gl_FragCoord.xy / screenSz.xy);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (s_mask, tmpvar_1);
  if ((tmpvar_2.x <= 0.0)) {
    discard;
  };
  gl_FragData[0] = (tmpvar_2.x * color);
  gl_FragData[1] = (tmpvar_2.x * color);
}

 