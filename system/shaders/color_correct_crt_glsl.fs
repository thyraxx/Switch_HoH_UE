FSHo>< s_tex    colorCorrect   res   �  varying highp vec2 v_texcoord0;
uniform sampler2D s_tex;
uniform highp vec4 colorCorrect;
uniform highp vec4 res;
void main ()
{
  lowp vec3 px_1;
  lowp vec3 color_prev_prev_2;
  lowp vec3 color_prev_3;
  lowp vec3 color_4;
  highp float intensity_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = (1.0/((2.5 * res.x)));
  highp vec2 tmpvar_7;
  tmpvar_7 = (v_texcoord0 - 0.5);
  highp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_7, tmpvar_7);
  highp vec2 tmpvar_9;
  tmpvar_9 = (v_texcoord0 + ((tmpvar_7 * 
    (tmpvar_8 + ((colorCorrect.w * tmpvar_8) * tmpvar_8))
  ) * colorCorrect.w));
  highp vec2 tmpvar_10;
  tmpvar_10 = ((v_texcoord0 - tmpvar_6) + ((tmpvar_7 * 
    (tmpvar_8 + ((colorCorrect.w * tmpvar_8) * tmpvar_8))
  ) * colorCorrect.w));
  highp vec2 tmpvar_11;
  tmpvar_11 = ((v_texcoord0 - (2.0 * tmpvar_6)) + ((tmpvar_7 * 
    (tmpvar_8 + ((colorCorrect.w * tmpvar_8) * tmpvar_8))
  ) * colorCorrect.w));
  intensity_5 = exp((-0.15 * (float(mod (
    (v_texcoord0.y * res.y)
  , 2.5)))));
  if ((((
    (tmpvar_9.x > 0.0)
   && 
    (tmpvar_9.y > 0.0)
  ) && (tmpvar_9.x < 1.0)) && (tmpvar_9.y < 1.0))) {
    color_4 = texture2D (s_tex, tmpvar_9).xyz;
  };
  if ((((
    (tmpvar_10.x > 0.0)
   && 
    (tmpvar_10.y > 0.0)
  ) && (tmpvar_10.x < 1.0)) && (tmpvar_10.y < 1.0))) {
    color_prev_3 = texture2D (s_tex, tmpvar_10).xyz;
  };
  if ((((
    (tmpvar_11.x > 0.0)
   && 
    (tmpvar_11.y > 0.0)
  ) && (tmpvar_11.x < 1.0)) && (tmpvar_11.y < 1.0))) {
    color_prev_prev_2 = texture2D (s_tex, tmpvar_11).xyz;
  };
  highp float tmpvar_12;
  tmpvar_12 = ((2.5 * v_texcoord0.x) * res.x);
  highp vec3 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (float(mod ((tmpvar_12 + 3.0), 3.0)));
  if ((tmpvar_14 >= 2.0)) {
    highp vec3 tmpvar_15;
    tmpvar_15.y = 0.0;
    tmpvar_15.x = (tmpvar_14 - 2.0);
    tmpvar_15.z = (3.0 - tmpvar_14);
    tmpvar_13 = tmpvar_15;
  } else {
    if ((tmpvar_14 >= 1.0)) {
      highp vec3 tmpvar_16;
      tmpvar_16.x = 0.0;
      tmpvar_16.y = (2.0 - tmpvar_14);
      tmpvar_16.z = (tmpvar_14 - 1.0);
      tmpvar_13 = tmpvar_16;
    } else {
      highp vec3 tmpvar_17;
      tmpvar_17.z = 0.0;
      tmpvar_17.x = (1.0 - tmpvar_14);
      tmpvar_17.y = tmpvar_14;
      tmpvar_13 = tmpvar_17;
    };
  };
  highp float pixel_18;
  pixel_18 = (tmpvar_12 - 1.0);
  highp vec3 tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (float(mod ((pixel_18 + 3.0), 3.0)));
  pixel_18 = tmpvar_20;
  if ((tmpvar_20 >= 2.0)) {
    highp vec3 tmpvar_21;
    tmpvar_21.y = 0.0;
    tmpvar_21.x = (tmpvar_20 - 2.0);
    tmpvar_21.z = (3.0 - tmpvar_20);
    tmpvar_19 = tmpvar_21;
  } else {
    if ((tmpvar_20 >= 1.0)) {
      highp vec3 tmpvar_22;
      tmpvar_22.x = 0.0;
      tmpvar_22.y = (2.0 - tmpvar_20);
      tmpvar_22.z = (tmpvar_20 - 1.0);
      tmpvar_19 = tmpvar_22;
    } else {
      highp vec3 tmpvar_23;
      tmpvar_23.z = 0.0;
      tmpvar_23.x = (1.0 - tmpvar_20);
      tmpvar_23.y = tmpvar_20;
      tmpvar_19 = tmpvar_23;
    };
  };
  highp float pixel_24;
  pixel_24 = (tmpvar_12 - 2.0);
  highp vec3 tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = (float(mod ((pixel_24 + 3.0), 3.0)));
  pixel_24 = tmpvar_26;
  if ((tmpvar_26 >= 2.0)) {
    highp vec3 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = (tmpvar_26 - 2.0);
    tmpvar_27.z = (3.0 - tmpvar_26);
    tmpvar_25 = tmpvar_27;
  } else {
    if ((tmpvar_26 >= 1.0)) {
      highp vec3 tmpvar_28;
      tmpvar_28.x = 0.0;
      tmpvar_28.y = (2.0 - tmpvar_26);
      tmpvar_28.z = (tmpvar_26 - 1.0);
      tmpvar_25 = tmpvar_28;
    } else {
      highp vec3 tmpvar_29;
      tmpvar_29.z = 0.0;
      tmpvar_29.x = (1.0 - tmpvar_26);
      tmpvar_29.y = tmpvar_26;
      tmpvar_25 = tmpvar_29;
    };
  };
  px_1 = ((intensity_5 * (2.3 * 
    pow ((((
      (1.2 * color_4)
     * tmpvar_13) + (
      (0.9 * color_prev_3)
     * tmpvar_19)) + ((0.45 * color_prev_prev_2) * tmpvar_25)), vec3(1.4, 1.4, 1.4))
  )) * clamp (pow (
    (16.0 * (((v_texcoord0.x * v_texcoord0.y) * (1.0 - v_texcoord0.x)) * (1.0 - v_texcoord0.y)))
  , 0.3), 0.0, 1.0));
  px_1 = (((
    (pow (px_1, (1.0/(colorCorrect.xxx))) - 0.5)
   * colorCorrect.z) + 0.5) + colorCorrect.y);
  lowp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = clamp (px_1, 0.0, 1.0);
  gl_FragColor = tmpvar_30;
}

 