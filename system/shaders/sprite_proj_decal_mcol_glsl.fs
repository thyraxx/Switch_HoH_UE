FSH� �
 color   screenSz   lightInf   s_tex    s_light    s_light2    s_light_overlay    s_shadowInfo    s_decal    multiColors   �  varying highp vec2 v_texcoord0;
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
uniform vec4 multiColors[24];
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
  l_1 = (texture2D (s_light, tmpvar_5) + tmpvar_4);
  bool tmpvar_6;
  tmpvar_6 = bool(1);
  lowp vec4 tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = clamp ((tmpvar_3.w * 1000.0), 0.0, 1.0);
  if ((tmpvar_3.w > 0.8888)) {
    lowp float tmpvar_9;
    tmpvar_9 = clamp ((dot (tmpvar_3.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
    lowp vec4 tmpvar_10;
    tmpvar_10.xyz = mix (mix (multiColors[21], multiColors[22], clamp (
      (tmpvar_9 * 2.0)
    , 0.0, 1.0)), multiColors[23], clamp ((
      (tmpvar_9 - 0.5)
     * 2.0), 0.0, 1.0)).xyz;
    tmpvar_10.w = tmpvar_8;
    tmpvar_7 = tmpvar_10;
    tmpvar_6 = bool(0);
  } else {
    if ((tmpvar_3.w > 0.7777)) {
      lowp float tmpvar_11;
      tmpvar_11 = clamp ((dot (tmpvar_3.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
      lowp vec4 tmpvar_12;
      tmpvar_12.xyz = mix (mix (multiColors[18], multiColors[19], clamp (
        (tmpvar_11 * 2.0)
      , 0.0, 1.0)), multiColors[20], clamp ((
        (tmpvar_11 - 0.5)
       * 2.0), 0.0, 1.0)).xyz;
      tmpvar_12.w = tmpvar_8;
      tmpvar_7 = tmpvar_12;
      tmpvar_6 = bool(0);
    } else {
      if ((tmpvar_3.w > 0.6666)) {
        lowp float tmpvar_13;
        tmpvar_13 = clamp ((dot (tmpvar_3.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
        lowp vec4 tmpvar_14;
        tmpvar_14.xyz = mix (mix (multiColors[15], multiColors[16], clamp (
          (tmpvar_13 * 2.0)
        , 0.0, 1.0)), multiColors[17], clamp ((
          (tmpvar_13 - 0.5)
         * 2.0), 0.0, 1.0)).xyz;
        tmpvar_14.w = tmpvar_8;
        tmpvar_7 = tmpvar_14;
        tmpvar_6 = bool(0);
      } else {
        if ((tmpvar_3.w > 0.5555)) {
          lowp float tmpvar_15;
          tmpvar_15 = clamp ((dot (tmpvar_3.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
          lowp vec4 tmpvar_16;
          tmpvar_16.xyz = mix (mix (multiColors[12], multiColors[13], clamp (
            (tmpvar_15 * 2.0)
          , 0.0, 1.0)), multiColors[14], clamp ((
            (tmpvar_15 - 0.5)
           * 2.0), 0.0, 1.0)).xyz;
          tmpvar_16.w = tmpvar_8;
          tmpvar_7 = tmpvar_16;
          tmpvar_6 = bool(0);
        } else {
          if ((tmpvar_3.w > 0.4444)) {
            lowp float tmpvar_17;
            tmpvar_17 = clamp ((dot (tmpvar_3.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
            lowp vec4 tmpvar_18;
            tmpvar_18.xyz = mix (mix (multiColors[9], multiColors[10], clamp (
              (tmpvar_17 * 2.0)
            , 0.0, 1.0)), multiColors[11], clamp ((
              (tmpvar_17 - 0.5)
             * 2.0), 0.0, 1.0)).xyz;
            tmpvar_18.w = tmpvar_8;
            tmpvar_7 = tmpvar_18;
            tmpvar_6 = bool(0);
          } else {
            if ((tmpvar_3.w > 0.3333)) {
              lowp float tmpvar_19;
              tmpvar_19 = clamp ((dot (tmpvar_3.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
              lowp vec4 tmpvar_20;
              tmpvar_20.xyz = mix (mix (multiColors[6], multiColors[7], clamp (
                (tmpvar_19 * 2.0)
              , 0.0, 1.0)), multiColors[8], clamp ((
                (tmpvar_19 - 0.5)
               * 2.0), 0.0, 1.0)).xyz;
              tmpvar_20.w = tmpvar_8;
              tmpvar_7 = tmpvar_20;
              tmpvar_6 = bool(0);
            } else {
              if ((tmpvar_3.w > 0.2222)) {
                lowp float tmpvar_21;
                tmpvar_21 = clamp ((dot (tmpvar_3.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
                lowp vec4 tmpvar_22;
                tmpvar_22.xyz = mix (mix (multiColors[3], multiColors[4], clamp (
                  (tmpvar_21 * 2.0)
                , 0.0, 1.0)), multiColors[5], clamp ((
                  (tmpvar_21 - 0.5)
                 * 2.0), 0.0, 1.0)).xyz;
                tmpvar_22.w = tmpvar_8;
                tmpvar_7 = tmpvar_22;
                tmpvar_6 = bool(0);
              } else {
                if ((tmpvar_3.w > 0.1111)) {
                  lowp float tmpvar_23;
                  tmpvar_23 = clamp ((dot (tmpvar_3.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
                  lowp vec4 tmpvar_24;
                  tmpvar_24.xyz = mix (mix (multiColors[0], multiColors[1], clamp (
                    (tmpvar_23 * 2.0)
                  , 0.0, 1.0)), multiColors[2], clamp ((
                    (tmpvar_23 - 0.5)
                   * 2.0), 0.0, 1.0)).xyz;
                  tmpvar_24.w = tmpvar_8;
                  tmpvar_7 = tmpvar_24;
                  tmpvar_6 = bool(0);
                };
              };
            };
          };
        };
      };
    };
  };
  if (tmpvar_6) {
    lowp vec4 tmpvar_25;
    tmpvar_25.xyz = tmpvar_3.xyz;
    tmpvar_25.w = tmpvar_8;
    tmpvar_7 = tmpvar_25;
    tmpvar_6 = bool(0);
  };
  px_2 = tmpvar_7;
  if ((v_texcoord1.x < 32.0)) {
    lowp vec4 ls_26;
    highp vec2 tmpvar_27;
    tmpvar_27.x = gl_FragCoord.x;
    tmpvar_27.y = v_texcoord1.y;
    lowp vec4 tmpvar_28;
    highp vec2 P_29;
    P_29 = (tmpvar_27 / screenSz.xy);
    tmpvar_28 = texture2D (s_shadowInfo, P_29);
    highp float tmpvar_30;
    tmpvar_30 = (1.0 - ((v_texcoord1.x - 10.0) / 22.0));
    if (((v_texcoord1.x < (tmpvar_28.x * 64.0)) || (tmpvar_28.y <= 0.5))) {
      highp vec2 tmpvar_31;
      tmpvar_31.x = gl_FragCoord.x;
      tmpvar_31.y = v_texcoord1.y;
      highp vec2 P_32;
      P_32 = (tmpvar_31 / screenSz.xy);
      ls_26 = texture2D (s_light2, P_32);
    } else {
      highp vec2 tmpvar_33;
      tmpvar_33.x = gl_FragCoord.x;
      tmpvar_33.y = v_texcoord1.y;
      highp vec2 P_34;
      P_34 = (tmpvar_33 / screenSz.xy);
      ls_26 = texture2D (s_light, P_34);
    };
    ls_26 = (ls_26 + tmpvar_4);
    l_1 = mix (l_1, ls_26, clamp ((tmpvar_30 * 
      (1.0 - ls_26.w)
    ), 0.0, 1.0));
    if ((v_texcoord1.x < 16.0)) {
      lowp vec4 dc_35;
      highp vec2 tmpvar_36;
      tmpvar_36.x = gl_FragCoord.x;
      tmpvar_36.y = (gl_FragCoord.y + floor((
        (gl_FragCoord.y - v_texcoord1.y)
       * 0.5)));
      highp vec2 tmpvar_37;
      tmpvar_37 = (tmpvar_36 / screenSz.xy);
      lowp vec4 tmpvar_38;
      tmpvar_38 = texture2D (s_decal, tmpvar_37);
      dc_35.xyz = tmpvar_38.xyz;
      highp vec2 tmpvar_39;
      tmpvar_39.x = gl_FragCoord.x;
      tmpvar_39.y = v_texcoord1.y;
      highp vec2 P_40;
      P_40 = (tmpvar_39 / screenSz.xy);
      dc_35.w = (texture2D (s_decal, P_40).w * (min (0.9, tmpvar_38.w) * (1.0 - 
        clamp (pow ((v_texcoord1.x / 16.0), 2.5), 0.0, 1.0)
      )));
      if ((dc_35.w > 0.0)) {
        px_2.xyz = (((
          (((4.0 * tmpvar_7.xyz) * (tmpvar_38.xyz * tmpvar_38.xyz)) + pow (tmpvar_7.xyz, vec3(5.0, 5.0, 5.0)))
         + 
          (0.3 * tmpvar_38.xyz)
        ) * dc_35.w) + (tmpvar_7.xyz * (1.0 - dc_35.w)));
      };
    };
  };
  l_1.xyz = mix (vec3(1.0, 1.0, 1.0), (l_1.xyz * lightInf.w), lightInf.xyz);
  lowp vec4 tmpvar_41;
  tmpvar_41.xyz = ((px_2.xyz * l_1.xyz) + (l_1.xyz * l_1.w));
  tmpvar_41.w = px_2.w;
  gl_FragColor = tmpvar_41;
}

 