FSH��� s_tex    i  varying highp vec4 v_color0;
varying highp vec2 v_texcoord0;
uniform sampler2D s_tex;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (s_tex, v_texcoord0);
  if ((tmpvar_1.w < 0.5)) {
    discard;
  };
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = v_color0.xyz;
  tmpvar_2.w = tmpvar_1.w;
  gl_FragData[0] = tmpvar_2;
  gl_FragData[1] = gl_FragData[0];
}

 