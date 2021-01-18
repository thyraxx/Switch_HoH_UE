FSH��� s_tex    aexp   �  varying highp vec4 v_color0;
varying highp vec2 v_texcoord0;
uniform sampler2D s_tex;
uniform highp vec4 aexp;
void main ()
{
  lowp vec4 px_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (s_tex, v_texcoord0);
  px_1.xyz = tmpvar_2.xyz;
  if ((tmpvar_2.w <= 0.0)) {
    discard;
  };
  px_1.w = float((tmpvar_2.w >= (1.0 - aexp.x)));
  px_1 = (px_1 * v_color0);
  gl_FragColor = px_1;
}

 