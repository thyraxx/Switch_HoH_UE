<!-- A B X Y -->
<!--
<sprite name="A" texture="gui/controllerbuttons.png"><frame>0 0 24 24</frame></sprite>
<sprite name="B" texture="gui/controllerbuttons.png"><frame>24 0 24 24</frame></sprite>
<sprite name="X" texture="gui/controllerbuttons.png"><frame>48 0 24 24</frame></sprite>
<sprite name="Y" texture="gui/controllerbuttons.png"><frame>72 0 24 24</frame></sprite>
-->

<!-- Dir -->
<!--
<sprite name="Up" texture="gui/controllerbuttons.png"><frame>0 24 24 24</frame></sprite>
<sprite name="Down" texture="gui/controllerbuttons.png"><frame>24 24 24 24</frame></sprite>
<sprite name="Left" texture="gui/controllerbuttons.png"><frame>48 24 24 24</frame></sprite>
<sprite name="Right" texture="gui/controllerbuttons.png"><frame>72 24 24 24</frame></sprite>
-->
<!-- LR -->
<!--
<sprite name="L" texture="gui/controllerbuttons.png"><frame>0 48 24 24</frame></sprite>
<sprite name="R" texture="gui/controllerbuttons.png"><frame>24 48 24 24</frame></sprite>
<sprite name="ZL" texture="gui/controllerbuttons.png"><frame>48 48 24 24</frame></sprite>
<sprite name="ZR" texture="gui/controllerbuttons.png"><frame>72 48 24 24</frame></sprite>
-->
<!-- Misc -->
<!--
<sprite name="Home" texture="gui/controllerbuttons.png"><frame>0 72 24 24</frame></sprite>
<sprite name="Bottons" texture="gui/controllerbuttons.png"><frame>24 72 24 24</frame></sprite>
<sprite name="+" texture="gui/controllerbuttons.png"><frame>48 72 24 24</frame></sprite>
<sprite name="-" texture="gui/controllerbuttons.png"><frame>72 72 24 24</frame></sprite>
-->
<!-- Joystick -->
<!--
<sprite name="JoystickL" texture="gui/controllerbuttons.png"><frame>0 96 24 24</frame></sprite>
<sprite name="JoystickR" texture="gui/controllerbuttons.png"><frame>24 96 24 24</frame></sprite>
-->

<!--
<sprite name="A" texture="gui/controllerbuttons64.png"><frame>0 0 64 64</frame></sprite>
<sprite name="B" texture="gui/controllerbuttons64.png"><frame>64 0 64 64</frame></sprite>
<sprite name="X" texture="gui/controllerbuttons64.png"><frame>128 0 64 64</frame></sprite>
<sprite name="Y" texture="gui/controllerbuttons64.png"><frame>192 0 64 64</frame></sprite>

<sprite name="L" texture="gui/controllerbuttons64.png"><frame>0 64 64 64</frame></sprite>
<sprite name="R" texture="gui/controllerbuttons64.png"><frame>64 64 64 64</frame></sprite>
<sprite name="ZL" texture="gui/controllerbuttons64.png"><frame>128 64 64 64</frame></sprite>
<sprite name="ZR" texture="gui/controllerbuttons64.png"><frame>192 64 64 64</frame></sprite>

<sprite name="+" texture="gui/controllerbuttons64.png"><frame>0 128 64 64</frame></sprite>
<sprite name="-" texture="gui/controllerbuttons64.png"><frame>64 128 64 64</frame></sprite>
-->
%if TARGET_NX
<sprite name="A" texture="gui/controllerbuttonsmini.png"><frame>0 0  24 24</frame></sprite>
<sprite name="B" texture="gui/controllerbuttonsmini.png"><frame>24 0 24 24</frame></sprite>
<sprite name="X" texture="gui/controllerbuttonsmini.png"><frame>48 0 24 24</frame></sprite>
<sprite name="Y" texture="gui/controllerbuttonsmini.png"><frame>72 0 24 24</frame></sprite>

<sprite name="L" texture="gui/controllerbuttonsmini.png"><frame>0 24 24 24</frame></sprite>
<sprite name="R" texture="gui/controllerbuttonsmini.png"><frame>24 24 24 24</frame></sprite>
<sprite name="ZL" texture="gui/controllerbuttonsmini.png"><frame>48 24 24 24</frame></sprite>
<sprite name="ZR" texture="gui/controllerbuttonsmini.png"><frame>72 24 24 24</frame></sprite>

<sprite name="+" texture="gui/controllerbuttonsmini.png"><frame>0 48 24 24</frame></sprite>
<sprite name="-" texture="gui/controllerbuttonsmini.png"><frame>24 48 24 24</frame></sprite>

%elif TARGET_XB1
<sprite name="A" texture="gui/controllerbuttonsminiXBO.png"><frame>0 0  24 24</frame></sprite>
<sprite name="B" texture="gui/controllerbuttonsminiXBO.png"><frame>24 0 24 24</frame></sprite>
<sprite name="Y" texture="gui/controllerbuttonsminiXBO.png"><frame>48 0 24 24</frame></sprite>
<sprite name="X" texture="gui/controllerbuttonsminiXBO.png"><frame>72 0 24 24</frame></sprite>

<sprite name="L" texture="gui/controllerbuttonsminiXBO.png"><frame>0 24 24 24</frame></sprite>
<sprite name="R" texture="gui/controllerbuttonsminiXBO.png"><frame>24 24 24 24</frame></sprite>
<sprite name="ZL" texture="gui/controllerbuttonsminiXBO.png"><frame>48 24 24 24</frame></sprite>
<sprite name="ZR" texture="gui/controllerbuttonsminiXBO.png"><frame>72 24 24 24</frame></sprite>

<sprite name="+" texture="gui/controllerbuttonsmini.png"><frame>0 48 24 24</frame></sprite>
<sprite name="-" texture="gui/controllerbuttonsmini.png"><frame>24 48 24 24</frame></sprite>

%else
<sprite name="A" texture="gui/controllerbuttonsminiXBO.png"><frame>0 0  24 24</frame></sprite>
<sprite name="B" texture="gui/controllerbuttonsminiXBO.png"><frame>24 0 24 24</frame></sprite>
<sprite name="Y" texture="gui/controllerbuttonsminiXBO.png"><frame>48 0 24 24</frame></sprite>
<sprite name="X" texture="gui/controllerbuttonsminiXBO.png"><frame>72 0 24 24</frame></sprite>

<sprite name="L" texture="gui/controllerbuttonsminiXBO.png"><frame>0 24 24 24</frame></sprite>
<sprite name="R" texture="gui/controllerbuttonsminiXBO.png"><frame>24 24 24 24</frame></sprite>
<sprite name="ZL" texture="gui/controllerbuttonsminiXBO.png"><frame>48 24 24 24</frame></sprite>
<sprite name="ZR" texture="gui/controllerbuttonsminiXBO.png"><frame>72 24 24 24</frame></sprite>

<sprite name="+" texture="gui/controllerbuttonsmini.png"><frame>0 48 24 24</frame></sprite>
<sprite name="-" texture="gui/controllerbuttonsmini.png"><frame>24 48 24 24</frame></sprite>
%endif