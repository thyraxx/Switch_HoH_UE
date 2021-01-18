FSH� �
 color   screenSz   lightInf   s_tex    s_light    s_light2    s_light_overlay    s_shadowInfo    s_decal    colors   6  varying highp vec2 v_texcoord0;
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
uniform vec4 colors[3];
void main ()
{
  lowp vec4 l_1;
  lowp vec4 px_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (s_tex, v_texcoord0) * color);
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (gl_FragCoord.xy / screenSz.xy);
  tmpvar_4 = texture2D (s_light_overlay, tmpvar_5);
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (s_light, tmpvar_5) + tmpvar_4);
  l_1 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = clamp ((dot (tmpvar_3.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = mix (mix (colors[0], colors[1], clamp (
    (tmpvar_7 * 2.0)
  , 0.0, 1.0)), colors[2], clamp ((
    (tmpvar_7 - 0.5)
   * 2.0), 0.0, 1.0));
  lowp vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_3.xyz, tmpvar_8.xyz, tmpvar_8.w);
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_9;
  tmpvar_10.w = tmpvar_3.w;
  px_2 = tmpvar_10;
  if ((v_texcoord1.x < 32.0)) {
    lowp vec4 ls_11;
    highp vec2 tmpvar_12;
    tmpvar_12.x = gl_FragCoord.x;
    tmpvar_12.y = v_texcoord1.y;
    lowp vec4 tmpvar_13;
    highp vec2 P_14;
    P_14 = (tmpvar_12 / screenSz.xy);
    tmpvar_13 = texture2D (s_shadowInfo, P_14);
    highp float tmpvar_15;
    tmpvar_15 = (1.0 - ((v_texcoord1.x - 10.0) / 22.0));
    if (((v_texcoord1.x < (tmpvar_13.x * 64.0)) || (tmpvar_13.y <= 0.5))) {
      highp vec2 tmpvar_16;
      tmpvar_16.x = gl_FragCoord.x;
      tmpvar_16.y = v_texcoord1.y;
      highp vec2 P_17;
      P_17 = (tmpvar_16 / screenSz.xy);
      ls_11 = texture2D (s_light2, P_17);
    } else {
      highp vec2 tmpvar_18;
      tmpvar_18.x = gl_FragCoord.x;
      tmpvar_18.y = v_texcoord1.y;
      highp vec2 P_19;
      P_19 = (tmpvar_18 / screenSz.xy);
      ls_11 = texture2D (s_light, P_19);
    };
    ls_11 = (ls_11 + tmpvar_4);
    l_1 = mix (tmpvar_6, ls_11, clamp ((tmpvar_15 * 
      (1.0 - ls_11.w)
    ), 0.0, 1.0));
    if ((v_texcoord1.x < 16.0)) {
      lowp vec4 dc_20;
      highp vec2 tmpvar_21;
      tmpvar_21.x = gl_FragCoord.x;
      tmpvar_21.y = (gl_FragCoord.y + floor((
        (gl_FragCoord.y - v_texcoord1.y)
       * 0.5)));
      highp vec2 tmpvar_22;
      tmpvar_22 = (tmpvar_21 / screenSz.xy);
      lowp vec4 tmpvar_23;
      tmpvar_23 = texture2D (s_decal, tmpvar_22);
      dc_20.xyz = tmpvar_23.xyz;
      highp vec2 tmpvar_24;
      tmpvar_24.x = gl_FragCoord.x;
      tmpvar_24.y = v_texcoord1.y;
      highp vec2 P_25;
      P_25 = (tmpvar_24 / screenSz.xy);
      dc_20.w = (texture2D (s_decal, P_25).w * (min (0.9, tmpvar_23.w) * (1.0 - 
        clamp (pow ((v_texcoord1.x / 16.0), 2.5), 0.0, 1.0)
      )));
      if ((dc_20.w > 0.0)) {
        px_2.xyz = (((
          (((4.0 * tmpvar_9) * (tmpvar_23.xyz * tmpvar_23.xyz)) + pow (tmpvar_9, vec3(5.0, 5.0, 5.0)))
         + 
          (0.3 * tmpvar_23.xyz)
        ) * dc_20.w) + (tmpvar_9 * (1.0 - dc_20.w)));
      };
    };
  };
  l_1.xyz = mix (vec3(1.0, 1.0, 1.0), (l_1.xyz * lightInf.w), lightInf.xyz);
  lowp vec4 tmpvar_26;
  tmpvar_26.xyz = ((px_2.xyz * l_1.xyz) + (l_1.xyz * l_1.w));
  tmpvar_26.w = px_2.w;
  gl_FragColor = tmpvar_26;
}

 