FSH��� s_tex      varying highp vec4 v_color0;
varying highp vec2 v_texcoord0;
uniform sampler2D s_tex;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (s_tex, v_texcoord0);
  gl_FragData[0] = (tmpvar_1.x * v_color0);
  gl_FragData[1] = vec4(0.0, 0.0, 0.0, 0.0);
}

 