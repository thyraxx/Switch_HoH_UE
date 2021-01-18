FSH��� s_tex    s_shadow    screenSz   !  varying highp vec4 v_color0;
varying highp vec2 v_texcoord0;
uniform sampler2D s_tex;
uniform sampler2D s_shadow;
uniform highp vec4 screenSz;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (s_tex, v_texcoord0);
  highp vec2 tmpvar_2;
  tmpvar_2 = (gl_FragCoord.xy / screenSz.xy);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (s_shadow, tmpvar_2);
  gl_FragData[1] = (tmpvar_1.x * v_color0);
  if ((tmpvar_3.x > 0.0)) {
    gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    gl_FragData[0] = (tmpvar_1.x * v_color0);
  };
}

 