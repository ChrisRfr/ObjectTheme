# ObjectTheme for Dark or Light Theme

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/donate/?cmd=_s-xclick&hosted_button_id=9WZ5EDAMPH6SE)

This library will add and apply a theme color for All Windows and Gadgets<br>
And for All possible color attributes (BackColor, FrontColor, TitleBackColor,...) for each of them<br>
All gadgets will still work in the same way as PureBasic Gadget<br>
     
**How tu use:**<br>
   Add: XIncludeFile "ObjectTheme.pbi"<br>
   And apply a theme with the function:<br>
      - - SetObjectTheme(#ObjectTheme [, WindowColor])<br>
         - - - With #ObjectTheme = #ObjectTheme_DarkBlue, #ObjectTheme_LightBlue or #ObjectTheme_Auto<br>
   Easy ;) That's all :)<br>
<br>
SetObjectTheme(#ObjectTheme_DarkBlue):<br>
<br>
![Alt text](/Images/ObjectTheme_DarkBlue.png?raw=true "ObjectTheme_DarkBlue")<br>
<br>
SetObjectTheme(#ObjectTheme_LightBlue):<br>
<br>
![Alt text](/Images/ObjectTheme_LightBlue.png?raw=true "ObjectTheme_LightBlue")<br>
<br>
SetObjectTheme(#SetObjectTheme(#ObjectTheme_Auto, #Black)):<br>
<br>
![Alt text](/Images/ObjectTheme_Auto_Black.png?raw=true "ObjectTheme_LightBlue")<br>

**Supported Gadget**<br>
   Window, Button, ButtonImage, Calendar, CheckBox, ComboBox, Container, Date, Editor, ExplorerList, ExplorerTree, Frame, HyperLink, ListIcon, ListView, Option, Panel, ProgressBar, ScrollArea, ScrollBar, Spin, Splitter, String, Text, TrackBar, Tree<br>   
  
**Note that** you can SetObjectTheme(Theme [, WindowColor]) anywhere you like in your source, before or after creating the window, gadget's<br>
   **But note** the special case for the ComboBox Gadget:<br> 
         - Either you call the SetObjectTheme() function at the beginning of the program before creating the Windows and ComboBoxes<br>
         - Or add the flags #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED to the ComboBoxes (but Not for the ComboBox_Image) so that the drop-down List is painted<br>

 See ObjectTheme_DataSection.pbi for the theme color attribute for each GadgetType<br>
- It uses the same attributes as SetGadgetColor()<br>
#PB_Gadget_FrontColor, #PB_Gadget_BackColor, #PB_Gadget_LineColor, #PB_Gadget_TitleFrontColor, #PB_Gadget_TitleBackColor, #PB_Gadget_GrayTextColor<br>

- With new attributes<br>
#PB_Gadget_DarkMode, #PB_Gadget_ActiveTab, #PB_Gadget_InactiveTab, #PB_Gadget_HighLightColor, #PB_Gadget_EditBoxColor, #PB_Gadget_OuterColor, #PB_Gadget_CornerColor, #PB_Gadget_GrayBackColor, #PB_Gadget_EnableShadow, #PB_Gadget_ShadowColor, #PB_Gadget_BorderColor, #PB_Gadget_RoundX, #PB_Gadget_RoundY, #PB_Gadget_SplitterBorder, #PB_Gadget_SplitterBorderColor, #PB_Gadget_UseUxGripper, #PB_Gadget_GripperColor, #PB_Gadget_LargeGripper<br>

## Usage:
Add: XIncludeFile "ObjectTheme.pbi"<br>
 - **SetObjectTheme(#ObjectTheme [, WindowColor])**<br>
Apply or change a Theme. Optional WindowColor, the new color to use for the window background<br>
>  -- Ex: SetObjectTheme(#ObjectTheme_DarkBlue)<br>
>  -- Ex: SetObjectTheme(#ObjectTheme_LightBlue)<br>
>  -- Ex: SetObjectTheme(#ObjectTheme_Auto, #Black)<br>

 - **GetObjectTheme()**<br>
Get the current theme<br>

 - **IsObjectTheme(#Gadget)**<br>
Is the Gadget included in ObjectTheme ?<br>

 - **SetObjectThemeAttribute(ObjectType, #Attribut, Value)**<br>
Changes a theme color attribute value<br>
Dependent color attributes with #PB_Default value, will be recalculated according to this new color<br>
>  -- Ex: SetObjectThemeAttribute(#PB_GadgetType_Button, #PB_Gadget_BackColor, #Blue) to change the theme Button back color attribute in blue<br>

 - **GetObjectThemeAttribute(ObjectType, #Attribut)**<br>
Returns a theme color attribute value<br>
>  -- Ex: GetObjectThemeAttribute(#PB_GadgetType_Button, #PB_Gadget_BackColor)<br>

 - **SetObjectTypeColor(ObjectType, Attribute, Value)**<br>
Changes a color attribute value for a gadget type. The Theme color attribute value is preserved<br>
>  -- Ex: SetObjectTypeColor(#PB_GadgetType_Button, #PB_Gadget_BackColor, #Blue) to change the back color for each Button in blue<br>

 - **SetObjectColor(#Gadget, #Attribut, Value)**<br>
Changes a color attribute on the given gadget<br>
>  -- Ex: SetObjectColor(#Gadget, #PB_Gadget_BackColor, #Blue) to change the Gadget back color in blue<br>

 - **GetObjectColor(#Gadget, #Attribut)**<br>
Returns a Gadget color attribute value<br>
>  -- Ex: GetObjectColor(#Gadget, #PB_Gadget_BackColor)<br>
