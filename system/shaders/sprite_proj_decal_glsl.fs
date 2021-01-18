FSH� �	 color   screenSz   lightInf   s_tex    s_light    s_light2    s_light_overlay    s_shadowInfo    s_decal    ]  varying highp vec2 v_texcoord0;
varying highp vec2 v_texcoord1;
uniform highp vec4 color;
uniform highp vec4 screenSz;
uniform highp vec4 lightInf;
uniform sampler2D s_tex;
uniform sampler2D s_light;
uniform sampler2D s_light2;
uniform sampler2D s_light_overlay;
uniform sampler2D s_shadowInfo;
uniform sampler2D s_decal;
void main ()
{
  lowp vec4 l_1;
  lowp vec4 px_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (s_tex, v_texcoord0) * color);
  px_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (gl_FragCoord.xy / screenSz.xy);
  tmpvar_4 = texture2D (s_light_overlay, tmpvar_5);
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (s_light, tmpvar_5) + tmpvar_4);
  l_1 = tmpvar_6;
  if ((v_texcoord1.x < 32.0)) {
    lowp vec4 ls_7;
    highp vec2 tmpvar_8;
    tmpvar_8.x = gl_FragCoord.x;
    tmpvar_8.y = v_texcoord1.y;
    lowp vec4 tmpvar_9;
    highp vec2 P_10;
    P_10 = (tmpvar_8 / screenSz.xy);
    tmpvar_9 = texture2D (s_shadowInfo, P_10);
    highp float tmpvar_11;
    tmpvar_11 = (1.0 - ((v_texcoord1.x - 10.0) / 22.0));
    if (((v_texcoord1.x < (tmpvar_9.x * 64.0)) || (tmpvar_9.y <= 0.5))) {
      highp vec2 tmpvar_12;
      tmpvar_12.x = gl_FragCoord.x;
      tmpvar_12.y = v_texcoord1.y;
      highp vec2 P_13;
      P_13 = (tmpvar_12 / screenSz.xy);
      ls_7 = texture2D (s_light2, P_13);
    } else {
      highp vec2 tmpvar_14;
      tmpvar_14.x = gl_FragCoord.x;
      tmpvar_14.y = v_texcoord1.y;
      highp vec2 P_15;
      P_15 = (tmpvar_14 / screenSz.xy);
      ls_7 = texture2D (s_light, P_15);
    };
    ls_7 = (ls_7 + tmpvar_4);
    l_1 = mix (tmpvar_6, ls_7, clamp ((tmpvar_11 * 
      (1.0 - ls_7.w)
    ), 0.0, 1.0));
    if ((v_texcoord1.x < 16.0)) {
      lowp vec4 dc_16;
      highp vec2 tmpvar_17;
      tmpvar_17.x = gl_FragCoord.x;
      tmpvar_17.y = (gl_FragCoord.y + floor((
        (gl_FragCoord.y - v_texcoord1.y)
       * 0.5)));
      highp vec2 tmpvar_18;
      tmpvar_18 = (tmpvar_17 / screenSz.xy);
      lowp vec4 tmpvar_19;
      tmpvar_19 = texture2D (s_decal, tmpvar_18);
      dc_16.xyz = tmpvar_19.xyz;
      highp vec2 tmpvar_20;
      tmpvar_20.x = gl_FragCoord.x;
      tmpvar_20.y = v_texcoord1.y;
      highp vec2 P_21;
      P_21 = (tmpvar_20 / screenSz.xy);
      dc_16.w = (texture2D (s_decal, P_21).w * (min (0.9, tmpvar_19.w) * (1.0 - 
        clamp (pow ((v_texcoord1.x / 16.0), 2.5), 0.0, 1.0)
      )));
      if ((dc_16.w > 0.0)) {
        px_2.xyz = (((
          (((4.0 * tmpvar_3.xyz) * (tmpvar_19.xyz * tmpvar_19.xyz)) + pow (tmpvar_3.xyz, vec3(5.0, 5.0, 5.0)))
         + 
          (0.3 * tmpvar_19.xyz)
        ) * dc_16.w) + (tmpvar_3.xyz * (1.0 - dc_16.w)));
      };
    };
  };
  l_1.xyz = mix (vec3(1.0, 1.0, 1.0), (l_1.xyz * lightInf.w), lightInf.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22.xyz = ((px_2.xyz * l_1.xyz) + (l_1.xyz * l_1.w));
  tmpvar_22.w = px_2.w;
  gl_FragColor = tmpvar_22;
}

 