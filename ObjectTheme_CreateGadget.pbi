;- Top
;  -------------------------------------------------------------------------------------------------------------------------------------------------
;          Title: Include File for Object Theme Library (for Dark or Light Theme)
;    Description: This library will add and apply a theme color for All Windows and Gadgets.
;                 And for All possible color attributes (BackColor, FrontColor, TitleBackColor,...) for each of them
;                 All gadgets will still work in the same way as PureBasic Gadget
;    Source Name: ObjectTheme_CreateGadget.pbi
;         Author: ChrisR
;  Creation Date: 2023-11-06
; modification Date: 2023-11-25
;        Version: 1.4
;     PB-Version: 6.0 or other
;             OS: Windows Only
;          Forum: https://www.purebasic.fr/english/viewtopic.php?t=82890
;  -------------------------------------------------------------------------------------------------------------------------------------------------

CompilerIf Defined(PB_WindowType, #PB_Constant)
  
Procedure _OpenWindow(Window, X, Y, Width, Height, Title$, Flags, ParentID)
  Protected RetVal
  
  If Window = #PB_Any
    Window = _PB(OpenWindow)(#PB_Any, X, Y, Width, Height, Title$, Flags, ParentID)
    RetVal = Window
  Else
    RetVal = _PB(OpenWindow)(Window, X, Y, Width, Height, Title$, Flags, ParentID)
  EndIf
  
  _AddWindowTheme(Window)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _ButtonGadget(Gadget, X, Y, Width, Height, Text$, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = _PB(ButtonGadget)(#PB_Any, X, Y, Width, Height, Text$, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(ButtonGadget)(Gadget, X, Y, Width, Height, Text$, Flags)
  EndIf
  
  _AddButtonTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _ButtonImageGadget(Gadget, X, Y, Width, Height, IDImage, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = _PB(ButtonImageGadget)(#PB_Any, X, Y, Width, Height, IDImage, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(ButtonImageGadget)(Gadget, X, Y, Width, Height, IDImage, Flags)
  EndIf
  
  _AddButtonTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _CalendarGadget(Gadget, X, Y, Width, Height, Date, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = _PB(CalendarGadget)(#PB_Any, X, Y, Width, Height, Date, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(CalendarGadget)(Gadget, X, Y, Width, Height, Date, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _CheckBoxGadget(Gadget, X, Y, Width, Height, Text$, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = _PB(CheckBoxGadget)(#PB_Any, X, Y, Width, Height, Text$, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(CheckBoxGadget)(Gadget, X, Y, Width, Height, Text$, Flags)
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
    Gadget = _PB(ComboBoxGadget)(#PB_Any, X, Y, Width, Height, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(ComboBoxGadget)(Gadget, X, Y, Width, Height, Flags)
  EndIf
      
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _ContainerGadget(Gadget, X, Y, Width, Height, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = _PB(ContainerGadget)(#PB_Any, X, Y, Width, Height, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(ContainerGadget)(Gadget, X, Y, Width, Height, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _DateGadget(Gadget, X, Y, Width, Height, Mask$, Date, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = _PB(DateGadget)(#PB_Any, X, Y, Width, Height, Mask$, Date, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(DateGadget)(Gadget, X, Y, Width, Height, Mask$, Date, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _EditorGadget(Gadget, X, Y, Width, Height, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = _PB(EditorGadget)(#PB_Any, X, Y, Width, Height, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(EditorGadget)(Gadget, X, Y, Width, Height, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _ExplorerListGadget(Gadget, X, Y, Width, Height, Folder$, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = _PB(ExplorerListGadget)(#PB_Any, X, Y, Width, Height, Folder$, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(ExplorerListGadget)(Gadget, X, Y, Width, Height, Folder$, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _ExplorerTreeGadget(Gadget, X, Y, Width, Height, Folder$, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = _PB(ExplorerTreeGadget)(#PB_Any, X, Y, Width, Height, Folder$, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(ExplorerTreeGadget)(Gadget, X, Y, Width, Height, Folder$, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _FrameGadget(Gadget, X, Y, Width, Height, Text$, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = _PB(FrameGadget)(#PB_Any, X, Y, Width, Height, Text$, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(FrameGadget)(Gadget, X, Y, Width, Height, Text$, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal  
EndProcedure

Procedure _HyperLinkGadget(Gadget, X, Y, Width, Height, Text$, Color, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = _PB(HyperLinkGadget)(#PB_Any, X, Y, Width, Height, Text$, Color, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(HyperLinkGadget)(Gadget, X, Y, Width, Height, Text$, Color, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _ListIconGadget(Gadget, X, Y, Width, Height, Title$, TitleWidth, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = _PB(ListIconGadget)(#PB_Any, X, Y, Width, Height, Title$, TitleWidth, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(ListIconGadget)(Gadget, X, Y, Width, Height, Title$, TitleWidth, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _ListViewGadget(Gadget, X, Y, Width, Height, Flags)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = _PB(ListViewGadget)(#PB_Any, X, Y, Width, Height, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(ListViewGadget)(Gadget, X, Y, Width, Height, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _OptionGadget(Gadget, X, Y, Width, Height, Text$)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = _PB(OptionGadget)(#PB_Any, X, Y, Width, Height, Text$)
    RetVal = Gadget
  Else
    RetVal = _PB(OptionGadget)(Gadget, X, Y, Width, Height, Text$)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _PanelGadget(Gadget, X, Y, Width, Height)
  Protected RetVal

  If Gadget = #PB_Any
    Gadget = _PB(PanelGadget)(#PB_Any, X, Y, Width, Height)
    RetVal = Gadget
  Else
    RetVal = _PB(PanelGadget)(Gadget, X, Y, Width, Height)
  EndIf
  
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _ProgressBarGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = _PB(ProgressBarGadget)(#PB_Any, X, Y, Width, Height, Minimum, Maximum, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(ProgressBarGadget)(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _ScrollBarGadget(Gadget, X, Y, Width, Height, Min, Max, PageLength, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = _PB(ScrollBarGadget)(#PB_Any, X, Y, Width, Height, Min, Max, PageLength, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(ScrollBarGadget)(Gadget, X, Y, Width, Height, Min, Max, PageLength, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _ScrollAreaGadget(Gadget, X, Y, Width, Height, InnerWidth, InnerHeight, ScrollStep, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = _PB(ScrollAreaGadget)(#PB_Any, X, Y, Width, Height, InnerWidth, InnerHeight, ScrollStep, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(ScrollAreaGadget)(Gadget, X, Y, Width, Height, InnerWidth, InnerHeight, ScrollStep, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _SpinGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = _PB(SpinGadget)(#PB_Any, X, Y, Width, Height, Minimum, Maximum, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(SpinGadget)(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _SplitterGadget(Gadget, X, Y, Width, Height, Gadget1, Gadget2, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = _PB(SplitterGadget)(#PB_Any, X, Y, Width, Height, Gadget1, Gadget2, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(SplitterGadget)(Gadget, X, Y, Width, Height, Gadget1, Gadget2, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _StringGadget(Gadget, X, Y, Width, Height, Text$, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = _PB(StringGadget)(#PB_Any, X, Y, Width, Height, Text$, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(StringGadget)(Gadget, X, Y, Width, Height, Text$, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _TextGadget(Gadget, X, Y, Width, Height, Text$, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = _PB(TextGadget)(#PB_Any, X, Y, Width, Height, Text$, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(TextGadget)(Gadget, X, Y, Width, Height, Text$, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _TrackBarGadget(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
    Protected RetVal

  If Gadget = #PB_Any
    Gadget = _PB(TrackBarGadget)(#PB_Any, X, Y, Width, Height, Minimum, Maximum, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(TrackBarGadget)(Gadget, X, Y, Width, Height, Minimum, Maximum, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)

  ProcedureReturn RetVal
EndProcedure

Procedure _TreeGadget(Gadget, X, Y, Width, Height, Flags)
  Protected RetVal
  
  If Gadget = #PB_Any
    Gadget = _PB(TreeGadget)(#PB_Any, X, Y, Width, Height, Flags)
    RetVal = Gadget
  Else
    RetVal = _PB(TreeGadget)(Gadget, X, Y, Width, Height, Flags)
  EndIf
  
  _AddObjectTheme(Gadget)
  
  ProcedureReturn RetVal
EndProcedure

Procedure _SetGadgetAttribute(Gadget, Attribute, Value)
  _ProcedureReturnIf(Not IsGadget(Gadget))
  
  If MapSize(ThemeAttribute()) > 0
    If GadgetType(Gadget) = #PB_GadgetType_ButtonImage
      If FindMapElement(ObjectTheme(), Str(GadgetID(Gadget)))
        Select Attribute
          Case #PB_Button_Image
            ObjectTheme()\BtnInfo\iButtonImageID = Value
            If Value
              ObjectTheme()\BtnInfo\iButtonImage = ImagePB(Value)
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
              ObjectTheme()\BtnInfo\iButtonPressedImage = ImagePB(Value)
            Else
              ObjectTheme()\BtnInfo\iButtonPressedImage = 0
            EndIf
            ChangeButtonTheme(ObjectTheme()\PBGadget)
        EndSelect
      EndIf
    EndIf
  EndIf
  
  _PB(SetGadgetAttribute)(Gadget, Attribute, Value)
EndProcedure


Procedure _SetWindowColor(Window, Color)
  _ProcedureReturnIf(Not IsWindow(Window))
  
  If MapSize(ThemeAttribute()) > 0
    If FindMapElement(ObjectTheme(), Str(WindowID(Window)))
      If Color = #PB_Default
        Color = GetSysColor_(#COLOR_WINDOW)
      EndIf
      ProcedureReturn SetWindowThemeColor(ObjectTheme(), #PB_Gadget_BackColor, Color)
    EndIf
  EndIf
  
  _PB(SetWindowColor)(Window, Color)
EndProcedure

Procedure _SetGadgetColor(Gadget, Attribute, Color)
  _ProcedureReturnIf(Not IsGadget(Gadget))
  
  With ObjectTheme()\ObjectInfo
    If FindMapElement(ThemeAttribute(), Str(GadgetType(Gadget)) + "|" + Str(Attribute))
      If FindMapElement(ObjectTheme(), Str(GadgetID(Gadget)))
        Select ObjectTheme()\PBGadgetType
          Case #PB_GadgetType_Button, #PB_GadgetType_ButtonImage
            ProcedureReturn SetObjectButtonColor(ObjectTheme(), Attribute, Color)
          Default
            ProcedureReturn SetObjectThemeColor(ObjectTheme(), Attribute, Color)
        EndSelect
      EndIf 
    EndIf
  EndWith
  
  _PB(SetGadgetColor)(Gadget, Attribute, Color)
EndProcedure

CompilerEndIf

; IDE Options = PureBasic 6.03 LTS (Windows - x64)
; EnableXP