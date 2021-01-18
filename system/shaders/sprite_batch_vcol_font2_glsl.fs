FSH��� s_tex    4  varying highp vec4 v_color0;
varying highp vec2 v_texcoord0;
uniform sampler2D s_tex;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (s_tex, v_texcoord0);
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = v_color0.xyz;
  tmpvar_2.w = ((v_color0.w * tmpvar_1.x) * tmpvar_1.w);
  gl_FragColor = tmpvar_2;
}

 