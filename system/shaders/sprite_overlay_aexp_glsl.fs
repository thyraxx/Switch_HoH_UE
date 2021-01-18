FSH��� s_tex    s_light    screenSz   aexp   �  varying highp vec4 v_color0;
varying highp vec2 v_texcoord0;
uniform sampler2D s_tex;
uniform sampler2D s_light;
uniform highp vec4 screenSz;
uniform highp vec4 aexp;
void main ()
{
  lowp vec4 px_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (s_tex, v_texcoord0);
  px_1.xyz = tmpvar_2.xyz;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = (gl_FragCoord.xy / screenSz.xy);
  tmpvar_3 = texture2D (s_light, P_4);
  if ((tmpvar_2.w <= 0.5)) {
    discard;
  };
  px_1.w = float((tmpvar_2.w >= (1.0 - aexp.x)));
  lowp vec4 tmpvar_5;
  tmpvar_5.xyz = (((v_color0.xyz + 
    (v_color0.xyz * tmpvar_3.xyz)
  ) + (tmpvar_3.xyz * tmpvar_3.w)) / 2.0);
  tmpvar_5.w = clamp ((px_1.w * v_color0.w), 0.0, 1.0);
  gl_FragColor = tmpvar_5;
}

 