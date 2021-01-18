FSH��� s_tex    multiColors     varying highp vec4 v_color0;
varying highp vec2 v_texcoord0;
uniform sampler2D s_tex;
uniform vec4 multiColors[24];
void main ()
{
  lowp vec4 px_1;
  px_1 = (v_color0 * texture2D (s_tex, v_texcoord0));
  bool tmpvar_2;
  tmpvar_2 = bool(1);
  lowp vec4 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = clamp ((px_1.w * 1000.0), 0.0, 1.0);
  if ((px_1.w > 0.8888)) {
    lowp float tmpvar_5;
    tmpvar_5 = clamp ((dot (px_1.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
    lowp vec4 tmpvar_6;
    tmpvar_6.xyz = mix (mix (multiColors[21], multiColors[22], clamp (
      (tmpvar_5 * 2.0)
    , 0.0, 1.0)), multiColors[23], clamp ((
      (tmpvar_5 - 0.5)
     * 2.0), 0.0, 1.0)).xyz;
    tmpvar_6.w = tmpvar_4;
    tmpvar_3 = tmpvar_6;
    tmpvar_2 = bool(0);
  } else {
    if ((px_1.w > 0.7777)) {
      lowp float tmpvar_7;
      tmpvar_7 = clamp ((dot (px_1.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
      lowp vec4 tmpvar_8;
      tmpvar_8.xyz = mix (mix (multiColors[18], multiColors[19], clamp (
        (tmpvar_7 * 2.0)
      , 0.0, 1.0)), multiColors[20], clamp ((
        (tmpvar_7 - 0.5)
       * 2.0), 0.0, 1.0)).xyz;
      tmpvar_8.w = tmpvar_4;
      tmpvar_3 = tmpvar_8;
      tmpvar_2 = bool(0);
    } else {
      if ((px_1.w > 0.6666)) {
        lowp float tmpvar_9;
        tmpvar_9 = clamp ((dot (px_1.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
        lowp vec4 tmpvar_10;
        tmpvar_10.xyz = mix (mix (multiColors[15], multiColors[16], clamp (
          (tmpvar_9 * 2.0)
        , 0.0, 1.0)), multiColors[17], clamp ((
          (tmpvar_9 - 0.5)
         * 2.0), 0.0, 1.0)).xyz;
        tmpvar_10.w = tmpvar_4;
        tmpvar_3 = tmpvar_10;
        tmpvar_2 = bool(0);
      } else {
        if ((px_1.w > 0.5555)) {
          lowp float tmpvar_11;
          tmpvar_11 = clamp ((dot (px_1.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
          lowp vec4 tmpvar_12;
          tmpvar_12.xyz = mix (mix (multiColors[12], multiColors[13], clamp (
            (tmpvar_11 * 2.0)
          , 0.0, 1.0)), multiColors[14], clamp ((
            (tmpvar_11 - 0.5)
           * 2.0), 0.0, 1.0)).xyz;
          tmpvar_12.w = tmpvar_4;
          tmpvar_3 = tmpvar_12;
          tmpvar_2 = bool(0);
        } else {
          if ((px_1.w > 0.4444)) {
            lowp float tmpvar_13;
            tmpvar_13 = clamp ((dot (px_1.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
            lowp vec4 tmpvar_14;
            tmpvar_14.xyz = mix (mix (multiColors[9], multiColors[10], clamp (
              (tmpvar_13 * 2.0)
            , 0.0, 1.0)), multiColors[11], clamp ((
              (tmpvar_13 - 0.5)
             * 2.0), 0.0, 1.0)).xyz;
            tmpvar_14.w = tmpvar_4;
            tmpvar_3 = tmpvar_14;
            tmpvar_2 = bool(0);
          } else {
            if ((px_1.w > 0.3333)) {
              lowp float tmpvar_15;
              tmpvar_15 = clamp ((dot (px_1.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
              lowp vec4 tmpvar_16;
              tmpvar_16.xyz = mix (mix (multiColors[6], multiColors[7], clamp (
                (tmpvar_15 * 2.0)
              , 0.0, 1.0)), multiColors[8], clamp ((
                (tmpvar_15 - 0.5)
               * 2.0), 0.0, 1.0)).xyz;
              tmpvar_16.w = tmpvar_4;
              tmpvar_3 = tmpvar_16;
              tmpvar_2 = bool(0);
            } else {
              if ((px_1.w > 0.2222)) {
                lowp float tmpvar_17;
                tmpvar_17 = clamp ((dot (px_1.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
                lowp vec4 tmpvar_18;
                tmpvar_18.xyz = mix (mix (multiColors[3], multiColors[4], clamp (
                  (tmpvar_17 * 2.0)
                , 0.0, 1.0)), multiColors[5], clamp ((
                  (tmpvar_17 - 0.5)
                 * 2.0), 0.0, 1.0)).xyz;
                tmpvar_18.w = tmpvar_4;
                tmpvar_3 = tmpvar_18;
                tmpvar_2 = bool(0);
              } else {
                if ((px_1.w > 0.1111)) {
                  lowp float tmpvar_19;
                  tmpvar_19 = clamp ((dot (px_1.xyz, vec3(0.299, 0.587, 0.114)) * 1.2), 0.0, 1.0);
                  lowp vec4 tmpvar_20;
                  tmpvar_20.xyz = mix (mix (multiColors[0], multiColors[1], clamp (
                    (tmpvar_19 * 2.0)
                  , 0.0, 1.0)), multiColors[2], clamp ((
                    (tmpvar_19 - 0.5)
                   * 2.0), 0.0, 1.0)).xyz;
                  tmpvar_20.w = tmpvar_4;
                  tmpvar_3 = tmpvar_20;
                  tmpvar_2 = bool(0);
                };
              };
            };
          };
        };
      };
    };
  };
  if (tmpvar_2) {
    lowp vec4 tmpvar_21;
    tmpvar_21.xyz = px_1.xyz;
    tmpvar_21.w = tmpvar_4;
    tmpvar_3 = tmpvar_21;
    tmpvar_2 = bool(0);
  };
  px_1 = tmpvar_3;
  gl_FragColor = tmpvar_3;
}

 