FSH��� s_tex    colors   �  varying highp vec4 v_color0;
varying highp vec2 v_texcoord0;
uniform sampler2D s_tex;
uniform vec4 colors[3];
void main ()
{
  lowp vec4 px_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (s_tex, v_texcoord0);
  lowp float tmpvar_3;
  tmpvar_3 = clamp ((dot (tmpvar_2.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (mix (colors[0], colors[1], clamp (
    (tmpvar_3 * 2.0)
  , 0.0, 1.0)), colors[2], clamp ((
    (tmpvar_3 - 0.5)
   * 2.0), 0.0, 1.0));
  lowp vec4 tmpvar_5;
  tmpvar_5.xyz = mix (tmpvar_2.xyz, tmpvar_4.xyz, tmpvar_4.w);
  tmpvar_5.w = tmpvar_2.w;
  px_1 = (tmpvar_5 * v_color0);
  gl_FragColor = px_1;
}

 