FSH��� s_tex    colors   w  varying highp vec4 v_color0;
varying highp vec2 v_texcoord0;
uniform sampler2D s_tex;
uniform vec4 colors[3];
void main ()
{
  lowp vec4 px_1;
  px_1 = (v_color0 * texture2D (s_tex, v_texcoord0));
  lowp float tmpvar_2;
  tmpvar_2 = clamp ((dot (px_1.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = mix (mix (colors[0], colors[1], clamp (
    (tmpvar_2 * 2.0)
  , 0.0, 1.0)), colors[2], clamp ((
    (tmpvar_2 - 0.5)
   * 2.0), 0.0, 1.0));
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = mix (px_1.xyz, tmpvar_3.xyz, tmpvar_3.w);
  tmpvar_4.w = px_1.w;
  px_1 = tmpvar_4;
  gl_FragColor = tmpvar_4;
}

 