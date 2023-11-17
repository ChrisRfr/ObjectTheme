;- Top
;  -------------------------------------------------------------------------------------------------------------------------------------------------
;          Title: Include File for Object Theme Library (for Dark or Light Theme)
;    Description: This library will add and apply a theme color for All Windows and Gadgets.
;                 And for All possible color attributes (BackColor, FrontColor, TitleBackColor,...) for each of them
;                 All gadgets will still work in the same way as PureBasic Gadget
;    Source Name: ObjectTheme_CreateGadget.pbi
;         Author: ChrisR
;  Creation Date: 2023-11-06
;        Version: 1.0
;     PB-Version: 6.0 or other
;             OS: Windows Only
;          Forum: https://www.purebasic.fr/english/viewtopic.php?t=82592
;  -------------------------------------------------------------------------------------------------------------------------------------------------

CompilerIf Defined(PB_WindowType, #PB_Constant)
  
Declare _OpenWindow(Window, X, Y, Width, Height, Title$, Flags, ParentID)
Declare _ButtonGadget(Gadget, X, Y, Width, Height, Text$, Flags)
Declare _ButtonImageGadget(Gadget, X, Y, Width, Height, IDImage, Flags)
Declare _CalendarGadget(Gadget, X, Y, Width, Height, Date, Flags)
Declare _CheckBoxGadget(Gadget, X, Y, Width, Height, Text$, Flags)
Declare _ComboBoxGadget(Gadget, X, Y, Width, Height, Flags)
Declare _ContainerGadget(Gadget, X, Y, Width, Height, Flags)
Declare _DateGadget(Gadget, X, Y, Width, Height, Mask$, Date, Flags)
Declare _EditorGadget(Gadget, X, Y, Width, Height, Flags)
Declare _ExplorerListGadget(Gadget, X, Y, Width, Height, Folder$, Flags)
Declare _ExplorerTreeGadget(Gadget, X, Y, Width, Height, Folder$, Flags)
Declare _FrameGadget(Gadget, X, Y, Width, Height, Text$, Flags)
Declare _HyperLinkGadget(Gadget, X, Y, Width, Height, Text$, Color, Flags)
Declare _ListIconGadget(Gadget, X, Y, Width, Height, Title$, TitleWidth, Flags)
Declare _ListViewGadget(Gadget, X, Y, Width, Height, Flags)
Declare _OptionGadget(Gadget, X, Y, Width, Height, Text$)
Declare _PanelGadget(Gadget, X, Y, Width, Height)
Declare _ProgressBarGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
Declare _ScrollBarGadget(Gadget, X, Y, Width, Height, Min, Max, PageLength, Flags)
Declare _ScrollAreaGadget(Gadget, X, Y, Width, Height, InnerWidth, InnerHeight, ScrollStep, Flags)
Declare _SpinGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
Declare _SplitterGadget(Gadget, X, Y, Width, Height, Gadget1, Gadget2, Flags)
Declare _StringGadget(Gadget, X, Y, Width, Height, Text$, Flags)
Declare _TextGadget(Gadget, X, Y, Width, Height, Text$, Flags)
Declare _TrackBarGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
Declare _TreeGadget(Gadget, X, Y, Width, Height, Flags)
Declare _SetGadgetAttribute(Gadget, Attribute, Value)
Declare _SetWindowColor(Window, Color)
Declare _SetGadgetColor(Gadget, Attribute, Color)
  
Procedure _OpenWindow(Window, X, Y, Width, Height, Title$, Flags, ParentID)
  Protected RetVal
  
  If Window = #PB_Any
    Window = OpenWindow(#PB_Any, X, Y, Width, Height, Title$, Flags, ParentID)
    RetVal = Window
  Else
    RetVal = OpenWindow(Window, X, Y, Width, Height, Title$, Flags, ParentID)
  EndIf
  
  _AddWindowTheme(Window)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _ButtonGadget(Gadget, X, Y, Width, Height, Text$, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = ButtonGadget(#PB_Any, X, Y, Width, Height, Text$, Flags)
    RetVal = Gadget
  Else
    RetVal = ButtonGadget(Gadget, X, Y, Width, Height, Text$, Flags)
  EndIf
  
  _AddButtonTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _ButtonImageGadget(Gadget, X, Y, Width, Height, IDImage, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = ButtonImageGadget(#PB_Any, X, Y, Width, Height, IDImage, Flags)
    RetVal = Gadget
  Else
    RetVal = ButtonImageGadget(Gadget, X, Y, Width, Height, IDImage, Flags)
  EndIf
  
  _AddButtonTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _CalendarGadget(Gadget, X, Y, Width, Height, Date, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = CalendarGadget(#PB_Any, X, Y, Width, Height, Date, Flags)
    RetVal = Gadget
  Else
    RetVal = CalendarGadget(Gadget, X, Y, Width, Height, Date, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _CheckBoxGadget(Gadget, X, Y, Width, Height, Text$, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = CheckBoxGadget(#PB_Any, X, Y, Width, Height, Text$, Flags)
    RetVal = Gadget
  Else
    RetVal = CheckBoxGadget(Gadget, X, Y, Width, Height, Text$, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _ComboBoxGadget(Gadget, X, Y, Width, Height, Flags)
  Protected RetVal
  
  If Flags & #PB_ComboBox_Image = #PB_ComboBox_Image
    Flags &~ (#CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED)
  Else
    If MapSize(ThemeAttribute()) > 0
      Flags | #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED
    EndIf
  EndIf
  
  If Gadget = #PB_Any
    Gadget = ComboBoxGadget(#PB_Any, X, Y, Width, Height, Flags)
    RetVal = Gadget
  Else
    RetVal = ComboBoxGadget(Gadget, X, Y, Width, Height, Flags)
  EndIf
      
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _ContainerGadget(Gadget, X, Y, Width, Height, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = ContainerGadget(#PB_Any, X, Y, Width, Height, Flags)
    RetVal = Gadget
  Else
    RetVal = ContainerGadget(Gadget, X, Y, Width, Height, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _DateGadget(Gadget, X, Y, Width, Height, Mask$, Date, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = DateGadget(#PB_Any, X, Y, Width, Height, Mask$, Date, Flags)
    RetVal = Gadget
  Else
    RetVal = DateGadget(Gadget, X, Y, Width, Height, Mask$, Date, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _EditorGadget(Gadget, X, Y, Width, Height, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = EditorGadget(#PB_Any, X, Y, Width, Height, Flags)
    RetVal = Gadget
  Else
    RetVal = EditorGadget(Gadget, X, Y, Width, Height, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _ExplorerListGadget(Gadget, X, Y, Width, Height, Folder$, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = ExplorerListGadget(#PB_Any, X, Y, Width, Height, Folder$, Flags)
    RetVal = Gadget
  Else
    RetVal = ExplorerListGadget(Gadget, X, Y, Width, Height, Folder$, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _ExplorerTreeGadget(Gadget, X, Y, Width, Height, Folder$, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = ExplorerTreeGadget(#PB_Any, X, Y, Width, Height, Folder$, Flags)
    RetVal = Gadget
  Else
    RetVal = ExplorerTreeGadget(Gadget, X, Y, Width, Height, Folder$, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _FrameGadget(Gadget, X, Y, Width, Height, Text$, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = FrameGadget(#PB_Any, X, Y, Width, Height, Text$, Flags)
    RetVal = Gadget
  Else
    RetVal = FrameGadget(Gadget, X, Y, Width, Height, Text$, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal  
EndProcedure

Procedure _HyperLinkGadget(Gadget, X, Y, Width, Height, Text$, Color, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = HyperLinkGadget(#PB_Any, X, Y, Width, Height, Text$, Color, Flags)
    RetVal = Gadget
  Else
    RetVal = HyperLinkGadget(Gadget, X, Y, Width, Height, Text$, Color, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _ListIconGadget(Gadget, X, Y, Width, Height, Title$, TitleWidth, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = ListIconGadget(#PB_Any, X, Y, Width, Height, Title$, TitleWidth, Flags)
    RetVal = Gadget
  Else
    RetVal = ListIconGadget(Gadget, X, Y, Width, Height, Title$, TitleWidth, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _ListViewGadget(Gadget, X, Y, Width, Height, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = ListViewGadget(#PB_Any, X, Y, Width, Height, Flags)
    RetVal = Gadget
  Else
    RetVal = ListViewGadget(Gadget, X, Y, Width, Height, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _OptionGadget(Gadget, X, Y, Width, Height, Text$)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = OptionGadget(#PB_Any, X, Y, Width, Height, Text$)
    RetVal = Gadget
  Else
    RetVal = OptionGadget(Gadget, X, Y, Width, Height, Text$)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _PanelGadget(Gadget, X, Y, Width, Height)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = PanelGadget(#PB_Any, X, Y, Width, Height)
    RetVal = Gadget
  Else
    RetVal = PanelGadget(Gadget, X, Y, Width, Height)
  EndIf
  
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _ProgressBarGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = ProgressBarGadget(#PB_Any, X, Y, Width, Height, Minimum, Maximum, Flags)
    RetVal = Gadget
  Else
    RetVal = ProgressBarGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _ScrollBarGadget(Gadget, X, Y, Width, Height, Min, Max, PageLength, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = ScrollBarGadget(#PB_Any, X, Y, Width, Height, Min, Max, PageLength, Flags)
    RetVal = Gadget
  Else
    RetVal = ScrollBarGadget(Gadget, X, Y, Width, Height, Min, Max, PageLength, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _ScrollAreaGadget(Gadget, X, Y, Width, Height, InnerWidth, InnerHeight, ScrollStep, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = ScrollAreaGadget(#PB_Any, X, Y, Width, Height, InnerWidth, InnerHeight, ScrollStep, Flags)
    RetVal = Gadget
  Else
    RetVal = ScrollAreaGadget(Gadget, X, Y, Width, Height, InnerWidth, InnerHeight, ScrollStep, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _SpinGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = SpinGadget(#PB_Any, X, Y, Width, Height, Minimum, Maximum, Flags)
    RetVal = Gadget
  Else
    RetVal = SpinGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _SplitterGadget(Gadget, X, Y, Width, Height, Gadget1, Gadget2, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = SplitterGadget(#PB_Any, X, Y, Width, Height, Gadget1, Gadget2, Flags)
    RetVal = Gadget
  Else
    RetVal = SplitterGadget(Gadget, X, Y, Width, Height, Gadget1, Gadget2, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _StringGadget(Gadget, X, Y, Width, Height, Text$, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = StringGadget(#PB_Any, X, Y, Width, Height, Text$, Flags)
    RetVal = Gadget
  Else
    RetVal = StringGadget(Gadget, X, Y, Width, Height, Text$, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _TextGadget(Gadget, X, Y, Width, Height, Text$, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = TextGadget(#PB_Any, X, Y, Width, Height, Text$, Flags)
    RetVal = Gadget
  Else
    RetVal = TextGadget(Gadget, X, Y, Width, Height, Text$, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _TrackBarGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
    Protected RetVal

  If Gadget = #PB_Any
    Gadget = TrackBarGadget(#PB_Any, X, Y, Width, Height, Minimum, Maximum, Flags)
    RetVal = Gadget
  Else
    RetVal = TrackBarGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _TreeGadget(Gadget, X, Y, Width, Height, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = TreeGadget(#PB_Any, X, Y, Width, Height, Flags)
    RetVal = Gadget
  Else
    RetVal = TreeGadget(Gadget, X, Y, Width, Height, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _SetGadgetAttribute(Gadget, Attribute, Value)
  
  If MapSize(ThemeAttribute()) > 0
    If GadgetType(Gadget) = #PB_GadgetType_ButtonImage
      If FindMapElement(ObjectTheme(), Str(GadgetID(Gadget)))
        Select Attribute
          Case #PB_Button_Image
            ObjectTheme()\BtnInfo\iButtonImageID = Value
            If Value
              ObjectTheme()\BtnInfo\iButtonImage = ImagePBOT(Value)
            Else
              ObjectTheme()\BtnInfo\iButtonImage = 0
            EndIf
            If ObjectTheme()\BtnInfo\iButtonPressedImageID = 0
              ObjectTheme()\BtnInfo\iButtonPressedImageID = Value
              ObjectTheme()\BtnInfo\iButtonPressedImage = ObjectTheme()\BtnInfo\iButtonImage
            EndIf
            ChangeButtonTheme(ObjectTheme()\PBGadget)
          Case #PB_Button_PressedImage
            ObjectTheme()\BtnInfo\iButtonPressedImageID = Value
            If Value
              ObjectTheme()\BtnInfo\iButtonPressedImage = ImagePBOT(Value)
            Else
              ObjectTheme()\BtnInfo\iButtonPressedImage = 0
            EndIf
            ChangeButtonTheme(ObjectTheme()\PBGadget)
        EndSelect
      EndIf
    EndIf
  EndIf
  
  SetGadgetAttribute(Gadget, Attribute, Value)
EndProcedure


Procedure _SetWindowColor(Window, Color)
  
  If MapSize(ThemeAttribute()) > 0
    If FindMapElement(ObjectTheme(), Str(WindowID(Window)))
      If Color = #PB_Default
        Color = GetSysColor_(#COLOR_WINDOW)
      EndIf
      ObjectTheme()\ObjectInfo\iBackColor = Color
    EndIf
  EndIf
  
  SetWindowColor(Window, Color)
EndProcedure

Procedure _SetGadgetColor(Gadget, Attribute, Color)
  
  ; Useful only if called externally, not from ObjectTheme.pbi, the color is already written in this case
  With ObjectTheme()\ObjectInfo
    If FindMapElement(ThemeAttribute(), Str(GadgetType(Gadget)) + "|" + Str(Attribute))
      If FindMapElement(ObjectTheme(), Str(GadgetID(Gadget)))
        Select ObjectTheme()\PBGadgetType
          Case #PB_Gadget_FrontColor
            \iFrontColor      = Color
          Case #PB_Gadget_BackColor
            \iBackColor       = Color
          Case #PB_Gadget_LineColor
            \iLineColor       = Color
          Case #PB_Gadget_TitleFrontColor
            \iTitleFrontColor = Color
          Case #PB_Gadget_TitleBackColor
            \iTitleBackColor  = Color
          Case #PB_Gadget_GrayTextColor
            \iGrayTextColor   = Color
        EndSelect
      EndIf 
    EndIf
  EndWith
  
  SetGadgetColor(Gadget, Attribute, Color)
EndProcedure

;-> Macros for Procedures associates
; Macro for Create Gadget written after Create Gadget Procedures, not to be extended at compile time (1 pass)
Macro OpenWindow(Window, X, Y, Width, Height, Title, Flags = #PB_Window_SystemMenu, ParentID = 0)
  _OpenWindow(Window, X, Y, Width, Height, Title, Flags, ParentID)
EndMacro

Macro ButtonGadget(Gadget, X, Y, Width, Height, Text, Flags = 0)
  _ButtonGadget(Gadget, X, Y, Width, Height, Text, Flags)
EndMacro

Macro ButtonImageGadget(Gadget, X, Y, Width, Height, IDImage, Flags = 0)
  _ButtonImageGadget(Gadget, X, Y, Width, Height, IDImage, Flags)
EndMacro

Macro CheckBoxGadget(Gadget, X, Y, Width, Height, Text, Flags = 0)
  _CheckBoxGadget(Gadget, X, Y, Width, Height, Text, Flags)
EndMacro

Macro CalendarGadget(Gadget, X, Y, Width, Height, Date = 0, Flags = 0)
  _CalendarGadget(Gadget, X, Y, Width, Height, Date, Flags)
EndMacro

Macro ContainerGadget(Gadget, X, Y, Width, Height, Flags = 0)
  _ContainerGadget(Gadget, X, Y, Width, Height, Flags)
EndMacro

Macro ComboBoxGadget(Gadget, X, Y, Width, Height, Flags = 0)
  _ComboBoxGadget(Gadget, X, Y, Width, Height, Flags)
EndMacro

Macro DateGadget(Gadget, X, Y, Width, Height, Mask = "", Date = 0, Flags = 0)
  _DateGadget(Gadget, X, Y, Width, Height, Mask, Date, Flags)
EndMacro

Macro EditorGadget(Gadget, X, Y, Width, Height, Flags = 0)
  _EditorGadget(Gadget, X, Y, Width, Height, Flags)
EndMacro

Macro ExplorerListGadget(Gadget, X, Y, Width, Height, Folder, Flags = 0)
  _ExplorerListGadget(Gadget, X, Y, Width, Height, Folder, Flags)
EndMacro

Macro ExplorerTreeGadget(Gadget, X, Y, Width, Height, Folder, Flags = 0)
  _ExplorerTreeGadget(Gadget, X, Y, Width, Height, Folder, Flags)
EndMacro

Macro FrameGadget(Gadget, X, Y, Width, Height, Text, Flags = 0)
  _FrameGadget(Gadget, X, Y, Width, Height, Text, Flags)
EndMacro

Macro HyperLinkGadget(Gadget, X, Y, Width, Height, Text, Color, Flags = 0)
  _HyperLinkGadget(Gadget, X, Y, Width, Height, Text, Color, Flags)
EndMacro

Macro ListIconGadget(Gadget, X, Y, Width, Height, Title, TitleWidth, Flags = 0)
  _ListIconGadget(Gadget, X, Y, Width, Height, Title, TitleWidth, Flags)
EndMacro

Macro ListViewGadget(Gadget, X, Y, Width, Height, Flags = 0)
  _ListViewGadget(Gadget, X, Y, Width, Height, Flags)
EndMacro

Macro OptionGadget(Gadget, X, Y, Width, Height, Text)
  _OptionGadget(Gadget, X, Y, Width, Height, Text)
EndMacro

Macro PanelGadget(Gadget, X, Y, Width, Height)
  _PanelGadget(Gadget, X, Y, Width, Height)
EndMacro

Macro ProgressBarGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags = 0)
  _ProgressBarGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
EndMacro

Macro ScrollBarGadget(Gadget, X, Y, Width, Height, Min, Max, PageLength, Flags = 0)
  _ScrollBarGadget(Gadget, X, Y, Width, Height, Min, Max, PageLength, Flags)
EndMacro

Macro ScrollAreaGadget(Gadget, X, Y, Width, Height, InnerWidth, InnerHeight, ScrollStep = 10, Flags = 0)
  _ScrollAreaGadget(Gadget, X, Y, Width, Height, InnerWidth, InnerHeight, ScrollStep, Flags)
EndMacro

Macro SpinGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags = 0)
  _SpinGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
EndMacro

Macro SplitterGadget(Gadget, X, Y, Width, Height, Gadget1, Gadget2, Flags = 0)
  _SplitterGadget(Gadget, X, Y, Width, Height, Gadget1, Gadget2, Flags)
EndMacro

Macro StringGadget(Gadget, X, Y, Width, Height, Text, Flags = 0)
  _StringGadget(Gadget, X, Y, Width, Height, Text, Flags)
EndMacro

Macro TextGadget(Gadget, X, Y, Width, Height, Text, Flags = 0)
  _TextGadget(Gadget, X, Y, Width, Height, Text, Flags)
EndMacro

Macro TrackBarGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags = 0)
  _TrackBarGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
EndMacro

Macro TreeGadget(Gadget, X, Y, Width, Height, Flags = 0)
  _TreeGadget(Gadget, X, Y, Width, Height, Flags)
EndMacro

Macro SetGadgetAttribute(Gadget, Attribute, Value)
  _SetGadgetAttribute(Gadget, Attribute, Value)
EndMacro

Macro SetWindowColor(Window, Color)
  _SetWindowColor(Window, Color)
EndMacro

Macro SetGadgetColor(Gadget, Attribute, Color)
  _SetGadgetColor(Gadget, Attribute, Color)
EndMacro

CompilerEndIf

; IDE Options = PureBasic 6.03 LTS (Windows - x64)
; EnableXP