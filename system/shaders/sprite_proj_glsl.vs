VSH� � u_modelViewProj   basePosY   �  attribute highp vec3 a_position;
attribute highp vec2 a_texcoord0;
varying highp vec2 v_texcoord0;
varying highp vec2 v_texcoord1;
uniform highp mat4 u_modelViewProj;
uniform highp vec4 basePosY;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = a_position;
  gl_Position = (u_modelViewProj * tmpvar_1);
  v_texcoord0 = a_texcoord0;
  highp vec2 tmpvar_2;
  tmpvar_2.x = (basePosY.x - a_position.y);
  tmpvar_2.y = basePosY.y;
  v_texcoord1 = tmpvar_2;
}

 