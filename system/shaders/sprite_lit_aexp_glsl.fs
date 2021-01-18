FSH��� s_tex    screenSz   s_light    s_light_overlay    lightInf   aexp   m  varying highp vec4 v_color0;
varying highp vec2 v_texcoord0;
uniform sampler2D s_tex;
uniform highp vec4 screenSz;
uniform sampler2D s_light;
uniform sampler2D s_light_overlay;
uniform highp vec4 lightInf;
uniform highp vec4 aexp;
void main ()
{
  lowp vec4 l_1;
  lowp vec4 px_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (s_tex, v_texcoord0);
  px_2.xyz = tmpvar_3.xyz;
  if ((tmpvar_3.w <= 0.0)) {
    discard;
  };
  px_2.w = float((tmpvar_3.w >= (1.0 - aexp.x)));
  px_2 = (px_2 * v_color0);
  lowp vec4 tmpvar_4;
  highp vec2 texcoord_5;
  texcoord_5 = (gl_FragCoord.xy / screenSz.xy);
  tmpvar_4 = (texture2D (s_light, texcoord_5) + texture2D (s_light_overlay, texcoord_5));
  l_1.w = tmpvar_4.w;
  l_1.xyz = mix (vec3(1.0, 1.0, 1.0), (tmpvar_4.xyz * lightInf.w), lightInf.xyz);
  px_2.xyz = ((px_2.xyz * l_1.xyz) + (l_1.xyz * tmpvar_4.w));
  gl_FragColor = px_2;
}

 