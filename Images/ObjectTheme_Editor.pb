;- Top
; -------------------------------------------------------------------------------------------------------------------------------------------------
; Title:       ObjectTheme Custom Theme Editor
; Description: A GUI editor to create and customize a theme for ObjectTheme library.
;              Allows editing color attributes for each GadgetType and generates
;              the DataSection code for the Custom theme.
; Author:      Generated for ChrisRfr / ObjectTheme
; Version:     1.0.0
; PB-Version:  6.0 or higher
; OS:          Windows Only
; Requires:    ObjectTheme.pbi (XIncludeFile "ObjectTheme.pbi" + UseModule ObjectTheme)
; -------------------------------------------------------------------------------------------------------------------------------------------------
;
; HOW TO USE:
;   1. Place this file next to ObjectTheme.pbi
;   2. Compile and run
;   3. Select a GadgetType in the ComboBox
;   4. Click on a color swatch (Canvas) to open a ColorRequester and change the color
;   5. Right-click a color to toggle it back to #PB_Default
;   6. Click "Generate Code" to see the DataSection code ready to paste
;   7. Click "Copy to Clipboard" to copy the generated code
;   8. Click "Save to File" to save it as ObjectTheme_Custom.pbi
;
; -------------------------------------------------------------------------------------------------------------------------------------------------

EnableExplicit

;- ---> Uncomment to use with ObjectTheme module (apply current theme to this editor too)
; XIncludeFile "ObjectTheme.pbi"
; UseModule ObjectTheme

; =====================================================================
;  CONSTANTS
; =====================================================================

; PureBasic GadgetType constants (from PureBasic internal values)
; #PB_GadgetType_Button       = 1
; #PB_GadgetType_ButtonImage  = 19
; #PB_GadgetType_Calendar     = 18
; #PB_GadgetType_CheckBox     = 4
; #PB_GadgetType_ComboBox     = 8
; #PB_GadgetType_Container    = 24
; #PB_GadgetType_Date         = 22
; #PB_GadgetType_Editor       = 11
; #PB_GadgetType_ExplorerList = 29
; #PB_GadgetType_ExplorerTree = 30
; #PB_GadgetType_Frame        = 15
; #PB_GadgetType_HyperLink    = 20
; #PB_GadgetType_ListIcon     = 14
; #PB_GadgetType_ListView     = 6
; #PB_GadgetType_Option       = 5
; #PB_GadgetType_Panel        = 25
; #PB_GadgetType_ProgressBar  = 16
; #PB_GadgetType_ScrollArea   = 26
; #PB_GadgetType_ScrollBar    = 17
; #PB_GadgetType_Spin         = 21
; #PB_GadgetType_Splitter     = 23
; #PB_GadgetType_String       = 7
; #PB_GadgetType_Text         = 3
; #PB_GadgetType_TrackBar     = 27
; #PB_GadgetType_Tree         = 13
#PB_WindowType              = 0     ; Special: Window type

; PureBasic Color Attribute constants
; #PB_Gadget_BackColor          = 1
; #PB_Gadget_FrontColor         = 2
; #PB_Gadget_LineColor          = 8
; #PB_Gadget_TitleFrontColor    = 4
; #PB_Gadget_TitleBackColor     = 5
; #PB_Gadget_GrayTextColor      = 9

; Extended ObjectTheme attributes
#PB_Gadget_DarkMode           = 100
#PB_Gadget_BrushBackground    = 101
#PB_Gadget_ActiveTabColor     = 102
#PB_Gadget_InactiveTabColor   = 103
#PB_Gadget_HighLightColor     = 104
#PB_Gadget_EditBoxColor       = 105
#PB_Gadget_OuterColor         = 106
#PB_Gadget_CornerColor        = 107
#PB_Gadget_GrayBackColor      = 108
#PB_Gadget_EnableShadow       = 109
#PB_Gadget_ShadowColor        = 110
#PB_Gadget_BorderColor        = 111
#PB_Gadget_RoundX             = 112
#PB_Gadget_RoundY             = 113
#PB_Gadget_SplitterBorder     = 114
#PB_Gadget_SplitterBorderColor= 115
#PB_Gadget_UseUxGripper       = 116
#PB_Gadget_GripperColor       = 117
#PB_Gadget_LargeGripper       = 118

#PB_Default = -1

; UI Constants
#Max_ColorRows  = 20   ; max attributes per gadget type
#Swatch_W       = 60
#Swatch_H       = 24
#Row_H          = 32
#LabelW         = 220
#EditorW        = 80
#MarginX        = 10
#MarginY        = 10
#ColGap         = 8

; =====================================================================
;  STRUCTURES
; =====================================================================

Structure ColorAttr
  AttrConstant.i     ; e.g. #PB_Gadget_BackColor
  AttrName.s         ; e.g. "#PB_Gadget_BackColor"
  Value.i            ; current color value or #PB_Default or 0/1
  IsBoolean.b        ; True if the attribute is 0/1 (not a color)
  IsDefault.b        ; True if value == #PB_Default
  Canvas.i           ; Canvas gadget handle for this row
  TextGadget.i       ; Text gadget (label)
  ValueText.i        ; StringGadget or Text for value display
EndStructure

Structure GadgetTypeDef
  TypeConstant.i     ; e.g. #PB_GadgetType_Button
  TypeName.s         ; e.g. "#PB_GadgetType_Button"
  DisplayName.s      ; e.g. "Button"
  List Attrs.ColorAttr()
EndStructure

; =====================================================================
;  GLOBAL DATA
; =====================================================================

Global NewList ThemeTypes.GadgetTypeDef()

; Map: Key = "TypeConst_AttrConst" -> color value
Global NewMap ThemeMap.i()

; =====================================================================
;  PROCEDURES: Define the attribute schema for each GadgetType
; =====================================================================

Macro AddAttr(_attrConst, _attrName, _defaultVal, _boolFlag)
  AddElement(ThemeTypes()\Attrs())
  ThemeTypes()\Attrs()\AttrConstant = _attrConst
  ThemeTypes()\Attrs()\AttrName     = _attrName
  ThemeTypes()\Attrs()\Value        = _defaultVal
  ThemeTypes()\Attrs()\IsBoolean    = _boolFlag
  ThemeTypes()\Attrs()\IsDefault    = Bool(_defaultVal = #PB_Default)
  ThemeTypes()\Attrs()\Canvas       = 0
  ThemeTypes()\Attrs()\TextGadget   = 0
  ThemeTypes()\Attrs()\ValueText    = 0
EndMacro

Macro AddType(_typeConst, _typeName, _dispName)
  AddElement(ThemeTypes())
  ThemeTypes()\TypeConstant = _typeConst
  ThemeTypes()\TypeName     = _typeName
  ThemeTypes()\DisplayName  = _dispName
EndMacro

Procedure InitThemeSchema()
  ; --- Window (#PB_WindowType = 0) ---
  AddType(#PB_WindowType, "#PB_WindowType", "Window")
  AddAttr(#PB_Gadget_BackColor,       "#PB_Gadget_BackColor",       $1C2333, #False)
  AddAttr(#PB_Gadget_FrontColor,      "#PB_Gadget_FrontColor",      $D0D0D0, #False)
  AddAttr(#PB_Gadget_TitleFrontColor, "#PB_Gadget_TitleFrontColor", #PB_Default, #False)
  AddAttr(#PB_Gadget_TitleBackColor,  "#PB_Gadget_TitleBackColor",  #PB_Default, #False)
  AddAttr(#PB_Gadget_DarkMode,        "#PB_Gadget_DarkMode",        1, #True)
  AddAttr(#PB_Gadget_BrushBackground, "#PB_Gadget_BrushBackground", 0, #True)

  ; --- Button ---
  AddType(#PB_GadgetType_Button, "#PB_GadgetType_Button", "Button")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      $2D3A50, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     $D0D0D0, #False)
  AddAttr(#PB_Gadget_EnableShadow,   "#PB_Gadget_EnableShadow",   1,       #True)
  AddAttr(#PB_Gadget_ShadowColor,    "#PB_Gadget_ShadowColor",    $000000, #False)
  AddAttr(#PB_Gadget_BorderColor,    "#PB_Gadget_BorderColor",    #PB_Default, #False)
  AddAttr(#PB_Gadget_OuterColor,     "#PB_Gadget_OuterColor",     #PB_Default, #False)
  AddAttr(#PB_Gadget_CornerColor,    "#PB_Gadget_CornerColor",    #PB_Default, #False)
  AddAttr(#PB_Gadget_GrayBackColor,  "#PB_Gadget_GrayBackColor",  #PB_Default, #False)
  AddAttr(#PB_Gadget_GrayTextColor,  "#PB_Gadget_GrayTextColor",  #PB_Default, #False)
  AddAttr(#PB_Gadget_RoundX,         "#PB_Gadget_RoundX",         8,       #True)
  AddAttr(#PB_Gadget_RoundY,         "#PB_Gadget_RoundY",         8,       #True)

  ; --- ButtonImage ---
  AddType(#PB_GadgetType_ButtonImage, "#PB_GadgetType_ButtonImage", "ButtonImage")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      #PB_Default, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     #PB_Default, #False)

  ; --- Calendar ---
  AddType(#PB_GadgetType_Calendar, "#PB_GadgetType_Calendar", "Calendar")
  AddAttr(#PB_Gadget_BackColor,       "#PB_Gadget_BackColor",       $2D3A50, #False)
  AddAttr(#PB_Gadget_FrontColor,      "#PB_Gadget_FrontColor",      $D0D0D0, #False)
  AddAttr(#PB_Gadget_TitleFrontColor, "#PB_Gadget_TitleFrontColor", $D0D0D0, #False)
  AddAttr(#PB_Gadget_TitleBackColor,  "#PB_Gadget_TitleBackColor",  $1C2333, #False)
  AddAttr(#PB_Gadget_HighLightColor,  "#PB_Gadget_HighLightColor",  #PB_Default, #False)
  AddAttr(#PB_Gadget_GrayTextColor,   "#PB_Gadget_GrayTextColor",   #PB_Default, #False)

  ; --- CheckBox ---
  AddType(#PB_GadgetType_CheckBox, "#PB_GadgetType_CheckBox", "CheckBox")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      #PB_Default, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     $D0D0D0, #False)
  AddAttr(#PB_Gadget_GrayTextColor,  "#PB_Gadget_GrayTextColor",  #PB_Default, #False)

  ; --- ComboBox ---
  AddType(#PB_GadgetType_ComboBox, "#PB_GadgetType_ComboBox", "ComboBox")
  AddAttr(#PB_Gadget_BackColor,       "#PB_Gadget_BackColor",       $2D3A50, #False)
  AddAttr(#PB_Gadget_FrontColor,      "#PB_Gadget_FrontColor",      $D0D0D0, #False)
  AddAttr(#PB_Gadget_EditBoxColor,    "#PB_Gadget_EditBoxColor",    #PB_Default, #False)
  AddAttr(#PB_Gadget_HighLightColor,  "#PB_Gadget_HighLightColor",  #PB_Default, #False)
  AddAttr(#PB_Gadget_GrayTextColor,   "#PB_Gadget_GrayTextColor",   #PB_Default, #False)

  ; --- Container ---
  AddType(#PB_GadgetType_Container, "#PB_GadgetType_Container", "Container")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      #PB_Default, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     #PB_Default, #False)

  ; --- Date ---
  AddType(#PB_GadgetType_Date, "#PB_GadgetType_Date", "Date")
  AddAttr(#PB_Gadget_BackColor,       "#PB_Gadget_BackColor",       $2D3A50, #False)
  AddAttr(#PB_Gadget_FrontColor,      "#PB_Gadget_FrontColor",      $D0D0D0, #False)
  AddAttr(#PB_Gadget_TitleFrontColor, "#PB_Gadget_TitleFrontColor", $D0D0D0, #False)
  AddAttr(#PB_Gadget_TitleBackColor,  "#PB_Gadget_TitleBackColor",  $1C2333, #False)
  AddAttr(#PB_Gadget_HighLightColor,  "#PB_Gadget_HighLightColor",  #PB_Default, #False)
  AddAttr(#PB_Gadget_GrayTextColor,   "#PB_Gadget_GrayTextColor",   #PB_Default, #False)

  ; --- Editor ---
  AddType(#PB_GadgetType_Editor, "#PB_GadgetType_Editor", "Editor")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      $1C2333, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     $D0D0D0, #False)
  AddAttr(#PB_Gadget_HighLightColor, "#PB_Gadget_HighLightColor", #PB_Default, #False)
  AddAttr(#PB_Gadget_GrayTextColor,  "#PB_Gadget_GrayTextColor",  #PB_Default, #False)

  ; --- ExplorerList ---
  AddType(#PB_GadgetType_ExplorerList, "#PB_GadgetType_ExplorerList", "ExplorerList")
  AddAttr(#PB_Gadget_BackColor,       "#PB_Gadget_BackColor",       $1C2333, #False)
  AddAttr(#PB_Gadget_FrontColor,      "#PB_Gadget_FrontColor",      $D0D0D0, #False)
  AddAttr(#PB_Gadget_TitleFrontColor, "#PB_Gadget_TitleFrontColor", #PB_Default, #False)
  AddAttr(#PB_Gadget_TitleBackColor,  "#PB_Gadget_TitleBackColor",  #PB_Default, #False)
  AddAttr(#PB_Gadget_HighLightColor,  "#PB_Gadget_HighLightColor",  #PB_Default, #False)
  AddAttr(#PB_Gadget_LineColor,       "#PB_Gadget_LineColor",       #PB_Default, #False)
  AddAttr(#PB_Gadget_GrayTextColor,   "#PB_Gadget_GrayTextColor",   #PB_Default, #False)

  ; --- ExplorerTree ---
  AddType(#PB_GadgetType_ExplorerTree, "#PB_GadgetType_ExplorerTree", "ExplorerTree")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      $1C2333, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     $D0D0D0, #False)
  AddAttr(#PB_Gadget_HighLightColor, "#PB_Gadget_HighLightColor", #PB_Default, #False)
  AddAttr(#PB_Gadget_LineColor,      "#PB_Gadget_LineColor",      #PB_Default, #False)
  AddAttr(#PB_Gadget_GrayTextColor,  "#PB_Gadget_GrayTextColor",  #PB_Default, #False)

  ; --- Frame ---
  AddType(#PB_GadgetType_Frame, "#PB_GadgetType_Frame", "Frame")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      #PB_Default, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     $D0D0D0, #False)

  ; --- HyperLink ---
  AddType(#PB_GadgetType_HyperLink, "#PB_GadgetType_HyperLink", "HyperLink")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      #PB_Default, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     $FF7800, #False)

  ; --- ListIcon ---
  AddType(#PB_GadgetType_ListIcon, "#PB_GadgetType_ListIcon", "ListIcon")
  AddAttr(#PB_Gadget_BackColor,       "#PB_Gadget_BackColor",       $1C2333, #False)
  AddAttr(#PB_Gadget_FrontColor,      "#PB_Gadget_FrontColor",      $D0D0D0, #False)
  AddAttr(#PB_Gadget_TitleFrontColor, "#PB_Gadget_TitleFrontColor", #PB_Default, #False)
  AddAttr(#PB_Gadget_TitleBackColor,  "#PB_Gadget_TitleBackColor",  #PB_Default, #False)
  AddAttr(#PB_Gadget_HighLightColor,  "#PB_Gadget_HighLightColor",  #PB_Default, #False)
  AddAttr(#PB_Gadget_LineColor,       "#PB_Gadget_LineColor",       #PB_Default, #False)
  AddAttr(#PB_Gadget_GrayTextColor,   "#PB_Gadget_GrayTextColor",   #PB_Default, #False)

  ; --- ListView ---
  AddType(#PB_GadgetType_ListView, "#PB_GadgetType_ListView", "ListView")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      $1C2333, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     $D0D0D0, #False)
  AddAttr(#PB_Gadget_HighLightColor, "#PB_Gadget_HighLightColor", #PB_Default, #False)
  AddAttr(#PB_Gadget_GrayTextColor,  "#PB_Gadget_GrayTextColor",  #PB_Default, #False)

  ; --- Option ---
  AddType(#PB_GadgetType_Option, "#PB_GadgetType_Option", "Option")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      #PB_Default, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     $D0D0D0, #False)
  AddAttr(#PB_Gadget_GrayTextColor,  "#PB_Gadget_GrayTextColor",  #PB_Default, #False)

  ; --- Panel ---
  AddType(#PB_GadgetType_Panel, "#PB_GadgetType_Panel", "Panel")
  AddAttr(#PB_Gadget_BackColor,          "#PB_Gadget_BackColor",          #PB_Default, #False)
  AddAttr(#PB_Gadget_FrontColor,         "#PB_Gadget_FrontColor",         $D0D0D0, #False)
  AddAttr(#PB_Gadget_ActiveTabColor,     "#PB_Gadget_ActiveTabColor",     #PB_Default, #False)
  AddAttr(#PB_Gadget_InactiveTabColor,   "#PB_Gadget_InactiveTabColor",   #PB_Default, #False)
  AddAttr(#PB_Gadget_HighLightColor,     "#PB_Gadget_HighLightColor",     #PB_Default, #False)
  AddAttr(#PB_Gadget_GrayTextColor,      "#PB_Gadget_GrayTextColor",      #PB_Default, #False)

  ; --- ProgressBar ---
  AddType(#PB_GadgetType_ProgressBar, "#PB_GadgetType_ProgressBar", "ProgressBar")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      $1C2333, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     #PB_Default, #False)
  AddAttr(#PB_Gadget_LineColor,      "#PB_Gadget_LineColor",      #PB_Default, #False)
  AddAttr(#PB_Gadget_GrayBackColor,  "#PB_Gadget_GrayBackColor",  #PB_Default, #False)

  ; --- ScrollArea ---
  AddType(#PB_GadgetType_ScrollArea, "#PB_GadgetType_ScrollArea", "ScrollArea")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      #PB_Default, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     #PB_Default, #False)

  ; --- ScrollBar ---
  AddType(#PB_GadgetType_ScrollBar, "#PB_GadgetType_ScrollBar", "ScrollBar")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      #PB_Default, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     #PB_Default, #False)

  ; --- Spin ---
  AddType(#PB_GadgetType_Spin, "#PB_GadgetType_Spin", "Spin")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      $1C2333, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     $D0D0D0, #False)
  AddAttr(#PB_Gadget_HighLightColor, "#PB_Gadget_HighLightColor", #PB_Default, #False)
  AddAttr(#PB_Gadget_GrayTextColor,  "#PB_Gadget_GrayTextColor",  #PB_Default, #False)

  ; --- Splitter ---
  AddType(#PB_GadgetType_Splitter, "#PB_GadgetType_Splitter", "Splitter")
  AddAttr(#PB_Gadget_BackColor,            "#PB_Gadget_BackColor",            #PB_Default, #False)
  AddAttr(#PB_Gadget_FrontColor,           "#PB_Gadget_FrontColor",           #PB_Default, #False)
  AddAttr(#PB_Gadget_SplitterBorder,       "#PB_Gadget_SplitterBorder",       0, #True)
  AddAttr(#PB_Gadget_SplitterBorderColor,  "#PB_Gadget_SplitterBorderColor",  #PB_Default, #False)
  AddAttr(#PB_Gadget_UseUxGripper,         "#PB_Gadget_UseUxGripper",         1, #True)
  AddAttr(#PB_Gadget_GripperColor,         "#PB_Gadget_GripperColor",         #PB_Default, #False)
  AddAttr(#PB_Gadget_LargeGripper,         "#PB_Gadget_LargeGripper",         1, #True)

  ; --- String ---
  AddType(#PB_GadgetType_String, "#PB_GadgetType_String", "String")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      $1C2333, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     $D0D0D0, #False)
  AddAttr(#PB_Gadget_HighLightColor, "#PB_Gadget_HighLightColor", #PB_Default, #False)
  AddAttr(#PB_Gadget_GrayTextColor,  "#PB_Gadget_GrayTextColor",  #PB_Default, #False)

  ; --- Text ---
  AddType(#PB_GadgetType_Text, "#PB_GadgetType_Text", "Text")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      #PB_Default, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     $D0D0D0, #False)
  AddAttr(#PB_Gadget_GrayTextColor,  "#PB_Gadget_GrayTextColor",  #PB_Default, #False)

  ; --- TrackBar ---
  AddType(#PB_GadgetType_TrackBar, "#PB_GadgetType_TrackBar", "TrackBar")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      #PB_Default, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     #PB_Default, #False)
  AddAttr(#PB_Gadget_LineColor,      "#PB_Gadget_LineColor",      #PB_Default, #False)

  ; --- Tree ---
  AddType(#PB_GadgetType_Tree, "#PB_GadgetType_Tree", "Tree")
  AddAttr(#PB_Gadget_BackColor,      "#PB_Gadget_BackColor",      $1C2333, #False)
  AddAttr(#PB_Gadget_FrontColor,     "#PB_Gadget_FrontColor",     $D0D0D0, #False)
  AddAttr(#PB_Gadget_HighLightColor, "#PB_Gadget_HighLightColor", #PB_Default, #False)
  AddAttr(#PB_Gadget_LineColor,      "#PB_Gadget_LineColor",      #PB_Default, #False)
  AddAttr(#PB_Gadget_GrayTextColor,  "#PB_Gadget_GrayTextColor",  #PB_Default, #False)

EndProcedure

; =====================================================================
;  UTILITY PROCEDURES
; =====================================================================

Procedure.s ColorToHex(Color.i)
  ; Returns color in PureBasic BGR hex format like $RRGGBB (stored as BGR)
  ; PB colors are in RGB format, hex shown as $RRGGBB
  ProcedureReturn "$" + RSet(Hex(Color, #PB_Long), 6, "0")
EndProcedure

Procedure.s ColorToRGB(Color.i)
  ProcedureReturn "RGB(" + Str(Red(Color)) + ", " + Str(Green(Color)) + ", " + Str(Blue(Color)) + ")"
EndProcedure

Procedure.b IsDarkColor(Color.i)
  ; Returns #True if color is dark (luminance < 128)
  ProcedureReturn Bool(Red(Color) * 0.299 + Green(Color) * 0.587 + Blue(Color) * 0.114 < 128)
EndProcedure

Procedure DrawSwatch(CanvasGadget.i, Color.i, IsDefault.b, IsBoolean.b, BoolValue.i)
  Protected TextColor.i, DisplayText.s
  
  If StartDrawing(CanvasOutput(CanvasGadget))
    If IsDefault
      ; Striped / gray pattern to indicate "#PB_Default"
      Box(0, 0, OutputWidth(), OutputHeight(), $505050)
      FrontColor($909090)
      DrawingMode(#PB_2DDrawing_Transparent)
      DrawText(4, 4, "#PB_Default", $FFFFFF)
    ElseIf IsBoolean
      ; Boolean: show 0 or 1
      Box(0, 0, OutputWidth(), OutputHeight(), $2D3A50)
      FrontColor($FFFFFF)
      DrawingMode(#PB_2DDrawing_Transparent)
      DrawText(OutputWidth()/2 - 4, 4, Str(BoolValue))
    Else
      Box(0, 0, OutputWidth(), OutputHeight(), Color)
      ; Border
      FrontColor($808080)
      DrawingMode(#PB_2DDrawing_Outlined)
      Box(0, 0, OutputWidth(), OutputHeight())
      ; Show hex value
      DrawingMode(#PB_2DDrawing_Transparent)
      If IsDarkColor(Color)
        TextColor = $FFFFFF
      Else
        TextColor = $000000
      EndIf
      FrontColor(TextColor)
      DrawText(3, 4, ColorToHex(Color))
    EndIf
    StopDrawing()
  EndIf
EndProcedure

; =====================================================================
;  WINDOW & UI
; =====================================================================

Enumeration Window
  #Win_Main    = 0
  #Win_Code    = 1
EndEnumeration

Enumeration Gadgets
  #Text_1
  #Text_2
  #Text_3
  #Text_4
  #Combo_Type
  #Btn_Generate
  #Btn_Copy
  #Btn_Save
  #Btn_Reset
  #ScrollArea
  #Editor_Code
EndEnumeration

Enumeration Font
  #Font_Label
  #Font_Code
EndEnumeration

; Global state
Global CurrentTypeIndex.i = 0
Global WinW.i = 700
Global WinH.i = 560
Global ScrollAreaH.i = 400

; Dynamic Canvas gadgets stored per row
#MaxRows = 25
Global Dim RowCanvas(#MaxRows)
Global Dim RowLabel(#MaxRows)

Procedure GetCurrentType(*TypeDef.GadgetTypeDef)
  Protected i.i = 0
  ForEach ThemeTypes()
    If i = CurrentTypeIndex
      CopyStructure(ThemeTypes(), *TypeDef, GadgetTypeDef)
      ProcedureReturn #True
    EndIf
    i + 1
  Next
  ProcedureReturn #False
EndProcedure

Procedure RefreshScrollArea()
  Protected i.i, Y.i, Row.i
  Protected CanvasW.i = #Swatch_W + 4
  Protected TotalW.i  = #LabelW + CanvasW + #EditorW + #MarginX * 3

  ; Destroy old child gadgets inside scroll area
  For i = 0 To #MaxRows - 1
    If IsGadget(RowCanvas(i))    : FreeGadget(RowCanvas(i))    : EndIf
    If IsGadget(RowLabel(i))     : FreeGadget(RowLabel(i))     : EndIf
  Next

  ; Find current type in list
  Protected TypeIdx.i = 0
  ForEach ThemeTypes()
    If TypeIdx = CurrentTypeIndex
      Break
    EndIf
    TypeIdx + 1
  Next
  
  If Not ListSize(ThemeTypes()) : ProcedureReturn : EndIf

  ; Get the inner size of scroll area
  Protected InnerW.i = GetGadgetAttribute(#ScrollArea, #PB_ScrollArea_InnerWidth)

  OpenGadgetList(#ScrollArea)
  
  Y = #MarginY
  Row = 0
  
  ForEach ThemeTypes()\Attrs()
    Protected Attr.ColorAttr
    CopyStructure(ThemeTypes()\Attrs(), Attr, ColorAttr)
    
    ; Label
    Protected LblID.i = #PB_Any
    LblID = TextGadget(#PB_Any, #MarginX, Y + 4, #LabelW, 20, Attr\AttrName)
    SetGadgetFont(LblID, FontID(#Font_Label))
    RowLabel(Row) = LblID
    
    ; Canvas swatch (click = change color, right-click = reset to default)
    Protected CanvID.i = #PB_Any
    CanvID = CanvasGadget(#PB_Any, #LabelW + #MarginX * 2, Y, #Swatch_W + 60, #Swatch_H)
    RowCanvas(Row) = CanvID
    
    DrawSwatch(CanvID, Attr\Value, Attr\IsDefault, Attr\IsBoolean, Attr\Value)
    
    Y + #Row_H
    Row + 1
    
    If Row >= #MaxRows : Break : EndIf
  Next
  
  CloseGadgetList()
  
  ; Resize scroll area inner height
  ResizeGadget(#ScrollArea, #PB_Ignore, #PB_Ignore, #PB_Ignore, #PB_Ignore)
  SetGadgetAttribute(#ScrollArea, #PB_ScrollArea_InnerHeight, Y + #MarginY)

EndProcedure

; Find attr index by canvas gadget ID
Procedure FindAttrByCanvas(CanvasID.i, *Row.Integer)
  Protected Row.i = 0
  For Row = 0 To #MaxRows - 1
    If RowCanvas(Row) = CanvasID
      *Row\i = Row
      ProcedureReturn #True
    EndIf
  Next
  ProcedureReturn #False
EndProcedure

Procedure SetAttrValueAtRow(Row.i, NewValue.i, IsDefault.b)
  Protected TypeIdx.i = 0
  Protected AttrRow.i = 0
  
  ForEach ThemeTypes()
    If TypeIdx = CurrentTypeIndex
      ForEach ThemeTypes()\Attrs()
        If AttrRow = Row
          ThemeTypes()\Attrs()\Value     = NewValue
          ThemeTypes()\Attrs()\IsDefault = IsDefault
          ProcedureReturn
        EndIf
        AttrRow + 1
      Next
      Break
    EndIf
    TypeIdx + 1
  Next
EndProcedure

Procedure GetAttrAtRow(Row.i, *Attr.ColorAttr)
  Protected TypeIdx.i = 0, AttrRow.i = 0
  
  ForEach ThemeTypes()
    If TypeIdx = CurrentTypeIndex
      ForEach ThemeTypes()\Attrs()
        If AttrRow = Row
          CopyStructure(ThemeTypes()\Attrs(), *Attr, ColorAttr)
          ProcedureReturn #True
        EndIf
        AttrRow + 1
      Next
      Break
    EndIf
    TypeIdx + 1
  Next
  ProcedureReturn #False
EndProcedure

; =====================================================================
;  CODE GENERATION
; =====================================================================

Procedure.s GenerateDataSectionCode()
  Protected Code.s, TypeIdx.i, AttrRow.i
  Protected ValueStr.s
  
  Code = "; =============================================================" + #CRLF$
  Code + "; ObjectTheme Custom Theme - DataSection" + #CRLF$
  Code + "; Generated by ObjectTheme Editor" + #CRLF$
  Code + "; =============================================================" + #CRLF$
  Code + ";" + #CRLF$
  Code + "; Paste this DataSection into ObjectTheme_DataSection.pbi" + #CRLF$
  Code + "; under the label: ObjectTheme_Custom:" + #CRLF$
  Code + ";" + #CRLF$
  Code + #CRLF$
  Code + "DataSection" + #CRLF$
  Code + "  ObjectTheme_Custom:" + #CRLF$
  
  ForEach ThemeTypes()
    Code + #CRLF$
    Code + "  ; --- " + ThemeTypes()\DisplayName + " ---" + #CRLF$
    Code + "  Data.i " + ThemeTypes()\TypeName + #CRLF$
    
    ForEach ThemeTypes()\Attrs()
      If ThemeTypes()\Attrs()\IsDefault
        ValueStr = "#PB_Default"
      Else
        If ThemeTypes()\Attrs()\IsBoolean
          ValueStr = Str(ThemeTypes()\Attrs()\Value)
        Else
          ValueStr = ColorToHex(ThemeTypes()\Attrs()\Value)
        EndIf
      EndIf
      Code + "  Data.i " + ThemeTypes()\Attrs()\AttrName + ", " + ValueStr + #CRLF$
    Next
    
    ; End-of-type marker
    Code + "  Data.i 0, 0" + #CRLF$
  Next
  
  Code + #CRLF$
  Code + "  ; --- End of theme ---" + #CRLF$
  Code + "  Data.i -1" + #CRLF$
  Code + "EndDataSection" + #CRLF$
  
  ProcedureReturn Code
EndProcedure

; =====================================================================
;  OPEN WINDOWS
; =====================================================================

Procedure OpenMainWindow()
  Protected I.i, Idx.i
  
  LoadFont(#Font_Label, "Segoe UI", 9)
  LoadFont(#Font_Code,  "Consolas", 9)
  
  If OpenWindow(#Win_Main, 100, 80, WinW, WinH, "ObjectTheme - Custom Theme Editor",
                #PB_Window_SystemMenu | #PB_Window_MinimizeGadget | #PB_Window_SizeGadget)
    
    ; ---- Top toolbar ----
    TextGadget(#Text_1, #MarginX, 14, 100, 20, "Gadget Type:")
    SetGadgetFont(#Text_1, FontID(#Font_Label))
    
    ComboBoxGadget(#Combo_Type, 115, 10, 280, 24)
    SetGadgetFont(#Combo_Type, FontID(#Font_Label))
    
    ForEach ThemeTypes()
      AddGadgetItem(#Combo_Type, -1, ThemeTypes()\TypeName + "  (" + ThemeTypes()\DisplayName + ")")
    Next
    SetGadgetState(#Combo_Type, 0)
    
    ButtonGadget(#Btn_Generate, 410, 8, 110, 28, "Generate Code")
    ButtonGadget(#Btn_Copy,     530, 8, 80,  28, "Clipboard")
    ButtonGadget(#Btn_Reset,    620, 8, 70,  28, "Reset All")
    
    ; ---- Separator line ----
    TextGadget(#Text_2, 0, 44, WinW, 2, "")
    
    ; ---- Column headers ----
    TextGadget(#Text_3, #MarginX,         50, #LabelW,    16, "Attribute")
    TextGadget(#Text_4, #LabelW + #MarginX * 2, 50, 160, 16, "Color / Value  (click=edit, right-click=default)")
    SetGadgetFont(#Text_4, FontID(#Font_Label))
    
    ; ---- Scroll area for attribute rows ----
    ScrollAreaGadget(#ScrollArea, 0, 68, WinW, WinH - 68, WinW - 20, 800, 10, #PB_ScrollArea_Flat)
    CloseGadgetList()
    
    RefreshScrollArea()
    
  EndIf
EndProcedure

Procedure OpenCodeWindow(Code.s)
  If Not IsWindow(#Win_Code)
    OpenWindow(#Win_Code, 200, 100, 680, 560, "Generated DataSection Code",
               #PB_Window_SystemMenu | #PB_Window_SizeGadget)
    
    EditorGadget(#Editor_Code, 0, 0, 680, 510, #PB_Editor_ReadOnly)
    SetGadgetFont(#Editor_Code, FontID(#Font_Code))
    
    ButtonGadget(#Btn_Copy, 10, 520, 120, 30, "Copy to Clipboard")
    ButtonGadget(#Btn_Save, 140, 520, 120, 30, "Save to File...")
    
    SetGadgetText(#Editor_Code, Code)
  Else
    SetGadgetText(#Editor_Code, Code)
    SetWindowTitle(#Win_Code, "Generated DataSection Code")
  EndIf
EndProcedure

; =====================================================================
;  MAIN PROGRAM
; =====================================================================

InitThemeSchema()
OpenMainWindow()

Define Event.i, EventGadget.i, EventType.i, EventWindow.i
Define Attr.ColorAttr
Define Row.Integer
Define NewColor.i
Define Code.s

Repeat
  Event       = WaitWindowEvent()
  EventWindow = EventWindow()
  EventGadget = EventGadget()
  EventType   = EventType()
  
  Select Event
    
    Case #PB_Event_CloseWindow
      If EventWindow = #Win_Main
        Break
      ElseIf EventWindow = #Win_Code
        CloseWindow(#Win_Code)
      EndIf
    
    Case #PB_Event_SizeWindow
      If EventWindow = #Win_Main
        WinW = WindowWidth(#Win_Main)
        WinH = WindowHeight(#Win_Main)
        ResizeGadget(#ScrollArea, 0, 68, WinW, WinH - 68)
      ElseIf EventWindow = #Win_Code
        ResizeGadget(#Editor_Code, 0, 0, WindowWidth(#Win_Code), WindowHeight(#Win_Code) - 50)
        ResizeGadget(#Btn_Copy, 10, WindowHeight(#Win_Code) - 38, 120, 30)
        ResizeGadget(#Btn_Save, 140, WindowHeight(#Win_Code) - 38, 120, 30)
      EndIf
    
    Case #PB_Event_Gadget
      Select EventWindow
        
        ; ============================================================
        ;  MAIN WINDOW EVENTS
        ; ============================================================
        Case #Win_Main
          Select EventGadget
            
            Case #Combo_Type
              CurrentTypeIndex = GetGadgetState(#Combo_Type)
              RefreshScrollArea()
            
            Case #Btn_Generate
              Code = GenerateDataSectionCode()
              OpenCodeWindow(Code)
            
            Case #Btn_Reset
              ; Reset all values of current type to schema defaults
              ForEach ThemeTypes()
                If ListIndex(ThemeTypes()) = CurrentTypeIndex
                  ForEach ThemeTypes()\Attrs()
                    ; We can't easily restore original defaults without re-init
                    ; So we just set all non-boolean to #PB_Default, boolean untouched
                    If Not ThemeTypes()\Attrs()\IsBoolean
                      ThemeTypes()\Attrs()\IsDefault = #True
                      ThemeTypes()\Attrs()\Value     = #PB_Default
                    EndIf
                  Next
                  Break
                EndIf
              Next
              RefreshScrollArea()
            
            Default
              ; Check if it's one of our dynamic Canvas rows
              If FindAttrByCanvas(EventGadget, @Row)
                If GetAttrAtRow(Row\i, @Attr)
                  
                  If EventType = #PB_EventType_LeftClick
                    If Attr\IsBoolean
                      ; Toggle boolean
                      Define NewBool.i = 1 - Attr\Value
                      SetAttrValueAtRow(Row\i, NewBool, #False)
                      DrawSwatch(EventGadget, NewBool, #False, #True, NewBool)
                    Else
                      ; Open color picker
                      Define StartColor.i
                      If Attr\IsDefault
                        StartColor = $2D3A50
                      Else
                        StartColor = Attr\Value
                      EndIf
                      NewColor = ColorRequester(StartColor)
                      If NewColor <> -1
                        SetAttrValueAtRow(Row\i, NewColor, #False)
                        DrawSwatch(EventGadget, NewColor, #False, #False, 0)
                      EndIf
                    EndIf
                    
                  ElseIf EventType = #PB_EventType_RightClick
                    ; Reset to #PB_Default
                    If Not Attr\IsBoolean
                      SetAttrValueAtRow(Row\i, #PB_Default, #True)
                      DrawSwatch(EventGadget, #PB_Default, #True, #False, 0)
                    EndIf
                  EndIf
                  
                EndIf
              EndIf
              
          EndSelect
        
        ; ============================================================
        ;  CODE WINDOW EVENTS
        ; ============================================================
        Case #Win_Code
          Select EventGadget
            
            Case #Btn_Copy
              Define ClipCode.s = GetGadgetText(#Editor_Code)
              SetClipboardText(ClipCode)
              MessageRequester("ObjectTheme Editor", "Code copied to clipboard!", #PB_MessageRequester_Info)
            
            Case #Btn_Save
              Define FilePath.s = SaveFileRequester("Save Custom Theme DataSection",
                                                        "ObjectTheme_Custom.pbi",
                                                        "PureBasic Include (*.pbi)|*.pbi|All Files (*.*)|*.*", 0)
              If FilePath <> ""
                Define FileID.i = CreateFile(#PB_Any, FilePath)
                If FileID
                  Define SaveCode.s = GetGadgetText(#Editor_Code)
                  WriteStringN(FileID, SaveCode)
                  CloseFile(FileID)
                  MessageRequester("ObjectTheme Editor", "File saved:" + #CRLF$ + FilePath, #PB_MessageRequester_Info)
                Else
                  MessageRequester("ObjectTheme Editor", "Error saving file!", #PB_MessageRequester_Error)
                EndIf
              EndIf
              
          EndSelect
          
      EndSelect
      
  EndSelect

ForEver

End

; IDE Options = PureBasic 6.30 (Windows - x64)
; CursorPosition = 817
; FirstLine = 800
; Folding = ---
; EnableXP
; DPIAware