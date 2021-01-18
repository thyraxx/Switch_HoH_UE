FSH� �
 color   screenSz   lightInf   s_tex    s_light    s_light2    s_light_overlay    s_shadowInfo    multiColors   colors   "  varying highp vec2 v_texcoord0;
varying highp vec2 v_texcoord1;
uniform highp vec4 color;
uniform highp vec4 screenSz;
uniform highp vec4 lightInf;
uniform sampler2D s_tex;
uniform sampler2D s_light;
uniform sampler2D s_light2;
uniform sampler2D s_light_overlay;
uniform sampler2D s_shadowInfo;
uniform vec4 multiColors[24];
uniform vec4 colors[3];
void main ()
{
  lowp vec4 l_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = (gl_FragCoord.xy / screenSz.xy);
  tmpvar_2 = texture2D (s_light_overlay, tmpvar_3);
  l_1 = (texture2D (s_light, tmpvar_3) + tmpvar_2);
  lowp vec4 px_4;
  px_4 = (texture2D (s_tex, v_texcoord0) * color);
  bool tmpvar_5;
  tmpvar_5 = bool(1);
  lowp vec4 tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = clamp ((px_4.w * 1000.0), 0.0, 1.0);
  if ((px_4.w > 0.8888)) {
    lowp float tmpvar_8;
    tmpvar_8 = clamp ((dot (px_4.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
    lowp vec4 tmpvar_9;
    tmpvar_9.xyz = mix (mix (multiColors[21], multiColors[22], clamp (
      (tmpvar_8 * 2.0)
    , 0.0, 1.0)), multiColors[23], clamp ((
      (tmpvar_8 - 0.5)
     * 2.0), 0.0, 1.0)).xyz;
    tmpvar_9.w = tmpvar_7;
    tmpvar_6 = tmpvar_9;
    tmpvar_5 = bool(0);
  } else {
    if ((px_4.w > 0.7777)) {
      lowp float tmpvar_10;
      tmpvar_10 = clamp ((dot (px_4.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
      lowp vec4 tmpvar_11;
      tmpvar_11.xyz = mix (mix (multiColors[18], multiColors[19], clamp (
        (tmpvar_10 * 2.0)
      , 0.0, 1.0)), multiColors[20], clamp ((
        (tmpvar_10 - 0.5)
       * 2.0), 0.0, 1.0)).xyz;
      tmpvar_11.w = tmpvar_7;
      tmpvar_6 = tmpvar_11;
      tmpvar_5 = bool(0);
    } else {
      if ((px_4.w > 0.6666)) {
        lowp float tmpvar_12;
        tmpvar_12 = clamp ((dot (px_4.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
        lowp vec4 tmpvar_13;
        tmpvar_13.xyz = mix (mix (multiColors[15], multiColors[16], clamp (
          (tmpvar_12 * 2.0)
        , 0.0, 1.0)), multiColors[17], clamp ((
          (tmpvar_12 - 0.5)
         * 2.0), 0.0, 1.0)).xyz;
        tmpvar_13.w = tmpvar_7;
        tmpvar_6 = tmpvar_13;
        tmpvar_5 = bool(0);
      } else {
        if ((px_4.w > 0.5555)) {
          lowp float tmpvar_14;
          tmpvar_14 = clamp ((dot (px_4.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
          lowp vec4 tmpvar_15;
          tmpvar_15.xyz = mix (mix (multiColors[12], multiColors[13], clamp (
            (tmpvar_14 * 2.0)
          , 0.0, 1.0)), multiColors[14], clamp ((
            (tmpvar_14 - 0.5)
           * 2.0), 0.0, 1.0)).xyz;
          tmpvar_15.w = tmpvar_7;
          tmpvar_6 = tmpvar_15;
          tmpvar_5 = bool(0);
        } else {
          if ((px_4.w > 0.4444)) {
            lowp float tmpvar_16;
            tmpvar_16 = clamp ((dot (px_4.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
            lowp vec4 tmpvar_17;
            tmpvar_17.xyz = mix (mix (multiColors[9], multiColors[10], clamp (
              (tmpvar_16 * 2.0)
            , 0.0, 1.0)), multiColors[11], clamp ((
              (tmpvar_16 - 0.5)
             * 2.0), 0.0, 1.0)).xyz;
            tmpvar_17.w = tmpvar_7;
            tmpvar_6 = tmpvar_17;
            tmpvar_5 = bool(0);
          } else {
            if ((px_4.w > 0.3333)) {
              lowp float tmpvar_18;
              tmpvar_18 = clamp ((dot (px_4.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
              lowp vec4 tmpvar_19;
              tmpvar_19.xyz = mix (mix (multiColors[6], multiColors[7], clamp (
                (tmpvar_18 * 2.0)
              , 0.0, 1.0)), multiColors[8], clamp ((
                (tmpvar_18 - 0.5)
               * 2.0), 0.0, 1.0)).xyz;
              tmpvar_19.w = tmpvar_7;
              tmpvar_6 = tmpvar_19;
              tmpvar_5 = bool(0);
            } else {
              if ((px_4.w > 0.2222)) {
                lowp float tmpvar_20;
                tmpvar_20 = clamp ((dot (px_4.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
                lowp vec4 tmpvar_21;
                tmpvar_21.xyz = mix (mix (multiColors[3], multiColors[4], clamp (
                  (tmpvar_20 * 2.0)
                , 0.0, 1.0)), multiColors[5], clamp ((
                  (tmpvar_20 - 0.5)
                 * 2.0), 0.0, 1.0)).xyz;
                tmpvar_21.w = tmpvar_7;
                tmpvar_6 = tmpvar_21;
                tmpvar_5 = bool(0);
              } else {
                if ((px_4.w > 0.1111)) {
                  lowp float tmpvar_22;
                  tmpvar_22 = clamp ((dot (px_4.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
                  lowp vec4 tmpvar_23;
                  tmpvar_23.xyz = mix (mix (multiColors[0], multiColors[1], clamp (
                    (tmpvar_22 * 2.0)
                  , 0.0, 1.0)), multiColors[2], clamp ((
                    (tmpvar_22 - 0.5)
                   * 2.0), 0.0, 1.0)).xyz;
                  tmpvar_23.w = tmpvar_7;
                  tmpvar_6 = tmpvar_23;
                  tmpvar_5 = bool(0);
                };
              };
            };
          };
        };
      };
    };
  };
  if (tmpvar_5) {
    lowp vec4 tmpvar_24;
    tmpvar_24.xyz = px_4.xyz;
    tmpvar_24.w = tmpvar_7;
    tmpvar_6 = tmpvar_24;
    tmpvar_5 = bool(0);
  };
  lowp float tmpvar_25;
  tmpvar_25 = clamp ((dot (tmpvar_6.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
  lowp vec4 tmpvar_26;
  tmpvar_26 = mix (mix (colors[0], colors[1], clamp (
    (tmpvar_25 * 2.0)
  , 0.0, 1.0)), colors[2], clamp ((
    (tmpvar_25 - 0.5)
   * 2.0), 0.0, 1.0));
  lowp vec3 tmpvar_27;
  tmpvar_27 = mix (tmpvar_6.xyz, tmpvar_26.xyz, tmpvar_26.w);
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = tmpvar_27;
  tmpvar_28.w = tmpvar_6.w;
  if ((v_texcoord1.x < 32.0)) {
    lowp vec4 ls_29;
    highp vec2 tmpvar_30;
    tmpvar_30.x = gl_FragCoord.x;
    tmpvar_30.y = v_texcoord1.y;
    lowp vec4 tmpvar_31;
    highp vec2 P_32;
    P_32 = (tmpvar_30 / screenSz.xy);
    tmpvar_31 = texture2D (s_shadowInfo, P_32);
    highp float tmpvar_33;
    tmpvar_33 = (1.0 - ((v_texcoord1.x - 10.0) / 22.0));
    if (((v_texcoord1.x < (tmpvar_31.x * 64.0)) || (tmpvar_31.y <= 0.5))) {
      highp vec2 tmpvar_34;
      tmpvar_34.x = gl_FragCoord.x;
      tmpvar_34.y = v_texcoord1.y;
      highp vec2 P_35;
      P_35 = (tmpvar_34 / screenSz.xy);
      ls_29 = texture2D (s_light2, P_35);
    } else {
      highp vec2 tmpvar_36;
      tmpvar_36.x = gl_FragCoord.x;
      tmpvar_36.y = v_texcoord1.y;
      highp vec2 P_37;
      P_37 = (tmpvar_36 / screenSz.xy);
      ls_29 = texture2D (s_light, P_37);
    };
    ls_29 = (ls_29 + tmpvar_2);
    l_1 = mix (l_1, ls_29, clamp ((tmpvar_33 * 
      (1.0 - ls_29.w)
    ), 0.0, 1.0));
  };
  l_1.xyz = mix (vec3(1.0, 1.0, 1.0), (l_1.xyz * lightInf.w), lightInf.xyz);
  lowp vec4 tmpvar_38;
  tmpvar_38.xyz = ((tmpvar_27 * l_1.xyz) + (l_1.xyz * l_1.w));
  tmpvar_38.w = tmpvar_28.w;
  gl_FragColor = tmpvar_38;
}

 