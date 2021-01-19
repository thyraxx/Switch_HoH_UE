FSHo>< s_tex    zoom     varying highp vec2 v_texcoord0;
uniform sampler2D s_tex;
uniform highp vec4 zoom;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = texture2D (s_tex, (((v_texcoord0 - vec2(0.5, 0.5)) * zoom.x) + vec2(0.5, 0.5))).xyz;
  gl_FragColor = tmpvar_1;
}

 