# ObjectTheme

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/donate/?cmd=_s-xclick&hosted_button_id=9WZ5EDAMPH6SE)

This library will add and apply a theme color for All Windows and Gadgets<br/>
And for All possible color attributes (BackColor, FrontColor, TitleBackColor,...) for each of them<br/>
All gadgets will still work in the same way as PureBasic Gadget<br/>
<br/><br/>
**Supported Gadget**<br/>
   Window, Button, ButtonImage, Calendar, CheckBox, ComboBox, Container, Date, Editor, ExplorerList, ExplorerTree,Frame, HyperLink,        
   ListIcon, ListView, Option, Panel, ProgressBar, ScrollArea, ScrollBar, Spin, Splitter, String, Text, TrackBar, Tree<br/>          

**How tu use:**<br/>
   Add: XIncludeFile "ObjectTheme.pbi"<br/>
   And apply a theme with the function:<br/>
      - SetObjectTheme(#ObjectTheme [, WindowColor])<br/>
         - With #ObjectTheme = #ObjectTheme_DarkBlue, #ObjectTheme_LightBlue or #ObjectTheme_Auto<br/>
  Easy ;) That's all :)<br/>
<br/>
**Note that** you can SetObjectTheme(Theme [, WindowColor]) anywhere you like in your source, before or after creating the window, gadget's and buttons.<br/>
   **But note** the special case for the ComboBox Gadget:<br/> 
         - Either you call the SetObjectTheme() function at the beginning of the program before creating the windows And ComboBoxes<br/>
         - Or add the flags To the ComboBoxes (but Not To the Combox Images) so that the drop-down List is painted<br/>
<br/>
 See ObjectTheme_DataSection.pbi for the theme color attribute for each GadgetType<br/>
<br/>
## Usage:
Add: XIncludeFile "ObjectTheme.pbi"<br>
 - **SetObjectTheme(#ObjectTheme [, WindowColor])**<br>
Apply or change a Theme. Optional WindowColor, the new color to use for the window background<br>
>  -- Ex: SetObjectTheme(#ObjectTheme_DarkBlue)<br>
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


