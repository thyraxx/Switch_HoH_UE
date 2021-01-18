FSH��� s_tex    s_light    s_light_overlay    texSz   texBnds   screenSz   lightInf   �  varying highp vec4 v_color0;
varying highp vec2 v_texcoord0;
uniform sampler2D s_tex;
uniform sampler2D s_light;
uniform sampler2D s_light_overlay;
uniform highp vec4 texSz;
uniform highp vec4 texBnds;
uniform highp vec4 screenSz;
uniform highp vec4 lightInf;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (s_tex, v_texcoord0);
  if ((tmpvar_1.w > 0.0)) {
    lowp vec4 l_2;
    highp vec2 tmpvar_3;
    tmpvar_3 = (gl_FragCoord.xy / screenSz.xy);
    lowp vec4 tmpvar_4;
    tmpvar_4 = (texture2D (s_light, tmpvar_3) + texture2D (s_light_overlay, tmpvar_3));
    l_2.w = tmpvar_4.w;
    l_2.xyz = mix (vec3(1.0, 1.0, 1.0), (tmpvar_4.xyz * lightInf.w), lightInf.xyz);
    lowp vec3 tmpvar_5;
    tmpvar_5 = ((v_color0.xyz * l_2.xyz) + (l_2.xyz * tmpvar_4.w));
    highp float tmpvar_6;
    highp vec2 tmpvar_7;
    tmpvar_7.x = float((v_texcoord0.x >= texBnds.z));
    tmpvar_7.y = float((v_texcoord0.y >= texBnds.w));
    highp vec2 tmpvar_8;
    tmpvar_8 = (vec2(greaterThanEqual (v_texcoord0, texBnds.xy)) - tmpvar_7);
    tmpvar_6 = (tmpvar_8.x * tmpvar_8.y);
    if ((tmpvar_6 < 1.0)) {
      lowp vec4 tmpvar_9;
      tmpvar_9.w = 1.0;
      tmpvar_9.xyz = tmpvar_5;
      gl_FragColor = tmpvar_9;
    } else {
      highp vec2 tmpvar_10;
      tmpvar_10.y = 0.0;
      tmpvar_10.x = texSz.x;
      lowp vec4 tmpvar_11;
      tmpvar_11 = texture2D (s_tex, (v_texcoord0 + tmpvar_10));
      if ((tmpvar_11.w == 0.0)) {
        lowp vec4 tmpvar_12;
        tmpvar_12.w = 1.0;
        tmpvar_12.xyz = tmpvar_5;
        gl_FragColor = tmpvar_12;
      } else {
        highp vec2 tmpvar_13;
        tmpvar_13.y = 0.0;
        tmpvar_13.x = -(texSz.x);
        lowp vec4 tmpvar_14;
        tmpvar_14 = texture2D (s_tex, (v_texcoord0 + tmpvar_13));
        if ((tmpvar_14.w == 0.0)) {
          lowp vec4 tmpvar_15;
          tmpvar_15.w = 1.0;
          tmpvar_15.xyz = tmpvar_5;
          gl_FragColor = tmpvar_15;
        } else {
          highp vec2 tmpvar_16;
          tmpvar_16.x = 0.0;
          tmpvar_16.y = texSz.y;
          lowp vec4 tmpvar_17;
          tmpvar_17 = texture2D (s_tex, (v_texcoord0 + tmpvar_16));
          if ((tmpvar_17.w == 0.0)) {
            lowp vec4 tmpvar_18;
            tmpvar_18.w = 1.0;
            tmpvar_18.xyz = tmpvar_5;
            gl_FragColor = tmpvar_18;
          } else {
            highp vec2 tmpvar_19;
            tmpvar_19.x = 0.0;
            tmpvar_19.y = -(texSz.y);
            lowp vec4 tmpvar_20;
            tmpvar_20 = texture2D (s_tex, (v_texcoord0 + tmpvar_19));
            if ((tmpvar_20.w == 0.0)) {
              lowp vec4 tmpvar_21;
              tmpvar_21.w = 1.0;
              tmpvar_21.xyz = tmpvar_5;
              gl_FragColor = tmpvar_21;
            } else {
              lowp vec4 tmpvar_22;
              tmpvar_22.w = 1.0;
              tmpvar_22.xyz = (tmpvar_5 / 2.0);
              gl_FragColor = tmpvar_22;
            };
          };
        };
      };
    };
  } else {
    gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
  };
}

 