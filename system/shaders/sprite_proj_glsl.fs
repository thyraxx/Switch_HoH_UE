FSH� � color   screenSz   lightInf   s_tex    s_light    s_light2    s_light_overlay    s_shadowInfo    7  varying highp vec2 v_texcoord0;
varying highp vec2 v_texcoord1;
uniform highp vec4 color;
uniform highp vec4 screenSz;
uniform highp vec4 lightInf;
uniform sampler2D s_tex;
uniform sampler2D s_light;
uniform sampler2D s_light2;
uniform sampler2D s_light_overlay;
uniform sampler2D s_shadowInfo;
void main ()
{
  lowp vec4 l_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (s_tex, v_texcoord0) * color);
  lowp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (gl_FragCoord.xy / screenSz.xy);
  tmpvar_3 = texture2D (s_light_overlay, tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (s_light, tmpvar_4) + tmpvar_3);
  l_1 = tmpvar_5;
  if ((v_texcoord1.x < 32.0)) {
    lowp vec4 ls_6;
    highp vec2 tmpvar_7;
    tmpvar_7.x = gl_FragCoord.x;
    tmpvar_7.y = v_texcoord1.y;
    lowp vec4 tmpvar_8;
    highp vec2 P_9;
    P_9 = (tmpvar_7 / screenSz.xy);
    tmpvar_8 = texture2D (s_shadowInfo, P_9);
    highp float tmpvar_10;
    tmpvar_10 = (1.0 - ((v_texcoord1.x - 10.0) / 22.0));
    if (((v_texcoord1.x < (tmpvar_8.x * 64.0)) || (tmpvar_8.y <= 0.5))) {
      highp vec2 tmpvar_11;
      tmpvar_11.x = gl_FragCoord.x;
      tmpvar_11.y = v_texcoord1.y;
      highp vec2 P_12;
      P_12 = (tmpvar_11 / screenSz.xy);
      ls_6 = texture2D (s_light2, P_12);
    } else {
      highp vec2 tmpvar_13;
      tmpvar_13.x = gl_FragCoord.x;
      tmpvar_13.y = v_texcoord1.y;
      highp vec2 P_14;
      P_14 = (tmpvar_13 / screenSz.xy);
      ls_6 = texture2D (s_light, P_14);
    };
    ls_6 = (ls_6 + tmpvar_3);
    l_1 = mix (tmpvar_5, ls_6, clamp ((tmpvar_10 * 
      (1.0 - ls_6.w)
    ), 0.0, 1.0));
  };
  l_1.xyz = mix (vec3(1.0, 1.0, 1.0), (l_1.xyz * lightInf.w), lightInf.xyz);
  lowp vec4 tmpvar_15;
  tmpvar_15.xyz = ((tmpvar_2.xyz * l_1.xyz) + (l_1.xyz * l_1.w));
  tmpvar_15.w = tmpvar_2.w;
  gl_FragColor = tmpvar_15;
}

 