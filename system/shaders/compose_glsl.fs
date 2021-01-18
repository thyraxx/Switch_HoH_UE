FSHo>< s_tex    vignetteColor   texSz   offset     varying highp vec2 v_texcoord0;
uniform sampler2D s_tex;
uniform highp vec4 vignetteColor;
uniform highp vec4 texSz;
uniform highp vec4 offset;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (s_tex, clamp ((v_texcoord0 + offset.xy), 0.0, 1.0));
  highp vec2 tmpvar_2;
  tmpvar_2.x = v_texcoord0.x;
  tmpvar_2.y = (-(texSz.w) + (v_texcoord0.y * texSz.y));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = mix (tmpvar_1.xyz, ((vignetteColor.xyz * 
    dot (tmpvar_1.xyz, vignetteColor.xyz)
  ) + vignetteColor.xyz), (clamp (
    pow (((1.0 - clamp (
      pow ((15.0 * ((
        (v_texcoord0.x * (1.0 - v_texcoord0.x))
       * tmpvar_2.y) * (1.0 - tmpvar_2.y))), 0.575)
    , 0.0, 1.0)) + 0.1), 4.0)
  , 0.0, 1.0) * vignetteColor.w));
  gl_FragColor = tmpvar_3;
}

 