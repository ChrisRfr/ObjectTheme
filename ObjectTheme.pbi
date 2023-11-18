;- Top
;  -------------------------------------------------------------------------------------------------------------------------------------------------
;          Title: Object Theme Library (for Dark or Light Theme)
;    Description: This library will add and apply a theme color for All Windows and Gadgets.
;                 And for All possible color attributes (BackColor, FrontColor, TitleBackColor,...) for each of them
;                 All gadgets will still work in the same way as PureBasic Gadget
;    Source Name: ObjectTheme.pbi
;         Author: ChrisR
;  Creation Date: 2023-11-06
;        Version: 1.0
;     PB-Version: 6.0 or other
;             OS: Windows Only
;          Forum: https://www.purebasic.fr/english/viewtopic.php?t=82890
;  -------------------------------------------------------------------------------------------------------------------------------------------------
;
; Supported Gadget:
;   Window, Button, ButtonImage, Calendar, CheckBox, ComboBox, Container, Date, Editor, ExplorerList, ExplorerTree, Frame, HyperLink,         
;   ListIcon, ListView, Option, Panel, ProgressBar, ScrollArea, ScrollBar, Spin, Splitter, String, Text, TrackBar, Tree           
; 
; (*) How tu use: 
;     Add: XIncludeFile "ObjectTheme.pbi"
;     And apply a theme with the function:
;         - SetObjectTheme(#ObjectTheme [, WindowColor]) - With #ObjectTheme = #ObjectTheme_DarkBlue, #ObjectTheme_LightBlue or #ObjectTheme_Auto
;   Easy ;) That's all :) 

;   Note that you can SetObjectTheme(Theme [, WindowColor]) anywhere you like in your source, before or after creating the Window, Gadget's
;   But note the special case for the ComboBox Gadget: 
;         Either you call the SetObjectTheme() function at the beginning of the program before creating the Windows and ComboBoxes
;         Or add the flags #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED to the ComboBoxes (but Not to the Combox Images) so that the drop-down List is painted
;
; See ObjectTheme_DataSection.pbi for the theme color attribute for each GadgetType
; . It uses the same attributes as SetGadgetColor():
;     #PB_Gadget_FrontColor, #PB_Gadget_BackColor, #PB_Gadget_LineColor, #PB_Gadget_TitleFrontColor, #PB_Gadget_TitleBackColor, #PB_Gadget_GrayTextColor
; . With new attributes:
;     #PB_Gadget_DarkMode, #PB_Gadget_ActiveTab, #PB_Gadget_InactiveTab, #PB_Gadget_HighLightColor, #PB_Gadget_EditBoxColor, #PB_Gadget_OuterColor,
;     #PB_Gadget_CornerColor, #PB_Gadget_GrayBackColor, #PB_Gadget_EnableShadow, #PB_Gadget_ShadowColor, #PB_Gadget_BorderColor, #PB_Gadget_RoundX,
;     #PB_Gadget_RoundY, #PB_Gadget_SplitterBorder, #PB_Gadget_SplitterBorderColor, #PB_Gadget_UseUxGripper, #PB_Gadget_GripperColor, #PB_Gadget_LargeGripper
;
;  ----------------------------------------------------------------------------------------------------------------------------------------------------------------|
;  |             Public Functions                            |      Description                                                                                    |
;  |---------------------------------------------------------|-----------------------------------------------------------------------------------------------------| 
;  | SetObjectTheme(#Theme [, WindowColor])                  | Apply or change a Theme. Optional WindowColor, the new color to use for the window background       |
;  |     Ex: SetObjectTheme(#ObjectTheme_DarkBlue)           |                                                                                                     |
;  |     Ex: SetObjectTheme(#ObjectTheme_Auto, #Black)       |                                                                                                     |
;  |                                                         |                                                                                                     |
;  | GetObjectTheme()                                        | Get the current theme                                                                               |
;  |                                                         |                                                                                                     |
;  | IsObjectTheme(#Gadget)                                  | Is the Gadget included in ObjectTheme ?                                                             |
;  |                                                         |                                                                                                     |
;  | FreeObjectTheme()                                       | Free the theme, ObjectTheme and associated resources and return to the standard Gadget              |
;  |                                                         |                                                                                                     |
;  | SetObjectThemeAttribute(ObjectType, #Attribut, Value)   | Changes a theme color attribute value                                                               |
;  |                                                         | Dependent color attributes with #PB_Default value, will be recalculated according to this new color |
;  |   - Ex: SetObjectThemeAttribute(#PB_GadgetType_Button, #PB_Gadget_BackColor, #Blue) to change the theme Button back color attribute in blue                   |
;  |                                                         |                                                                                                     |
;  | GetObjectThemeAttribute(ObjectType, #Attribut)          | Returns a theme color attribute value                                                               |
;  |   - Ex: GetObjectThemeAttribute(#PB_GadgetType_Button, #PB_Gadget_BackColor)                                                                                  |
;  |                                                         |                                                                                                     |
;  | SetObjectTypeColor(ObjectType, Attribute, Value)        | Changes a color attribute value for a gadget type. The Theme color attribute value is preserved     |
;  |   - Ex: SetObjectTypeColor(#PB_GadgetType_Button, #PB_Gadget_BackColor, #Blue) to change the back color for each Button in blue                               |
;  |                                                         |                                                                                                     |
;  | SetObjectColor(#Gadget, #Attribut, Value)               | Changes a color attribute on the given gadget                                                       |
;  |   - Ex: SetObjectColor(#Gadget, #PB_Gadget_BackColor, #Blue) to change the Gadget back color in blue                                                          |
;  |                                                         |                                                                                                     |
;  | GetObjectColor(#Gadget, #Attribut)                      | Returns a Gadget color attribute value                                                              |
;  |   - Ex: GetObjectColor(#Gadget, #PB_Gadget_BackColor)   |                                                                                                     |
;  ----------------------------------------------------------------------------------------------------------------------------------------------------------------|

;EnableExplicit

Enumeration ObjectTheme 0
  #ObjectTheme
  #ObjectTheme_DarkBlue
  #ObjectTheme_DarkRed
  #ObjectTheme_LightBlue
  #ObjectTheme_Auto
EndEnumeration

#PB_WindowType = 0

; Same Attribute as SetGadgetColor() Attribute + New Attribute
;#PB_Gadget_FrontColor
;#PB_Gadget_BackColor 
;#PB_Gadget_LineColor
;#PB_Gadget_TitleFrontColor
;#PB_Gadget_TitleBackColor
;#PB_Gadget_GrayTextColor
Enumeration #PB_Gadget_GrayTextColor + 1
  #PB_Gadget_DarkMode
  #PB_Gadget_ActiveTab
  #PB_Gadget_InactiveTab
  #PB_Gadget_HighLightColor
  #PB_Gadget_EditBoxColor
  #PB_Gadget_OuterColor
  #PB_Gadget_CornerColor
  #PB_Gadget_GrayBackColor
  #PB_Gadget_EnableShadow
  #PB_Gadget_ShadowColor
  #PB_Gadget_BorderColor
  #PB_Gadget_RoundX
  #PB_Gadget_RoundY
  #PB_Gadget_SplitterBorder
  #PB_Gadget_SplitterBorderColor
  #PB_Gadget_UseUxGripper          ; #False = Custom, #True = Uxtheme. For Splitter
  #PB_Gadget_GripperColor
  #PB_Gadget_LargeGripper
EndEnumeration

#PB_Gadget_END = 99

Structure ObjectBTN_INFO
  sButtonText.s
  bButtonState.b
  bButtonEnable.b
  iButtonBackColor.i
  iButtonOuterColor.i
  iButtonCornerColor.i
  iGrayBackColor.i
  iActiveFont.i
  iFrontColor.i
  iGrayTextColor.i
  bEnableShadow.b
  iShadowColor.i
  iBorderColor.i
  iButtonImage.i
  iButtonImageID.i
  iButtonPressedImage.i
  iButtonPressedImageID.i
  iRoundX.i
  iRoundY.i
  bMouseOver.b
  bHiLiteTimer.b
  bClickTimer.b
  imgRegular.i
  imgHilite.i
  imgPressed.i
  imgHiPressed.i
  imgDisabled.i
  hRgn.i
  hDcRegular.i
  hDcHiLite.i
  hDcPressed.i
  hDcHiPressed.i
  hDcDisabled.i
  hObjRegular.i
  hObjHiLite.i
  hObjPressed.i
  hObjHiPressed.i
  hObjDisabled.i
EndStructure

Structure ObjectInfo_INFO
  iBackColor.i
  iBrushBackColor.i
  iFrontColor.i
  iGrayTextColor.i
  iLineColor.i
  iTitleBackColor.i
  iBrushTitleBackColor.i
  iTitleFrontColor.i
  iActiveTabColor.i
  iBrushActiveTabColor.i
  iInactiveTabColor.i
  iBrushInactiveTabColor.i
  iHighLightColor.i
  iBrushHighLightColor.i
  iEditBoxColor.i
  iBrushEditBoxColor.i
  iSplitterGripper.i
  iSplitterBorder.i
  iSplitterBorderColor.i
  iUseUxGripper.i
  iGripperColor.i
  iLargeGripper.i
EndStructure

Structure ObjectTheme_INFO
  PBGadget.i
  IDGadget.i
  IDParent.i
  PBGadgetType.i
  *BtnInfo.ObjectBTN_INFO
  *ObjectInfo.ObjectInfo_INFO
  *OldProc
EndStructure

Declare IsDarkColorOT(Color)
Declare AccentColorOT(Color, AddColorValue)
Declare ScaleGrayCallbackOT(x, y, SourceColor, TargetColor)
Declare DisabledDarkColorOT(Color)
Declare DisabledLightColorOT(Color)

Declare SplitterCalc(hWnd, *rc.RECT)
Declare SplitterPaint(hWnd, hdc, *rc.RECT, *ObjectTheme.ObjectTheme_INFO)
Declare SplitterProc(hWnd, uMsg, wParam, lParam)
Declare PanelProc(hWnd, uMsg, wParam, lParam)
Declare ListIconProc(hWnd, uMsg, wParam, lParam)
Declare CalendarProc(hWnd, uMsg, wParam, lParam)
Declare EditorProc(hWnd, uMsg, wParam, lParam)
Declare StaticProc(hWnd, uMsg, wParam, lParam)
Declare WinCallback(hWnd, uMsg, wParam, lParam)

Declare ToolTipHandleOT() 
Declare WindowPBOT(WindowID)
Declare ImagePBOT(ImageID)

Declare LoadThemeAttribute(Theme, WindowColor)
Declare SetWindowTheme(GadgetID, Theme.s)
Declare SetWindowThemeColor(*ObjectTheme.ObjectTheme_INFO, Attribute, Value, InitLevel = #True)
Declare AddWindowTheme(Window, *ObjectTheme.ObjectTheme_INFO, UpdateTheme = #False)

Declare IsBrushUsed(Brush)
Declare DeleteUnusedBrush(Color)
Declare SetObjectThemeColor(*ObjectTheme.ObjectTheme_INFO, Attribute, Value, InitLevel = #True)
Declare AddObjectTheme(Gadget, *ObjectTheme.ObjectTheme_INFO, UpdateTheme = #False)

Declare ButtonThemeProc(hWnd, uMsg, wParam, lParam)
Declare MakeButtonTheme(cX, cY, *ObjectTheme.ObjectTheme_INFO)
Declare MakeButtonImageTheme(cX, cY, *ObjectTheme.ObjectTheme_INFO)
Declare ChangeButtonTheme(Gadget)
Declare UpdateButtonTheme(*ObjectTheme.ObjectTheme_INFO)
Declare FreeButtonTheme(IDGadget)
Declare SetObjectButtonColor(*ObjectTheme.ObjectTheme_INFO, Attribute, Value, InitLevel = #True)
Declare AddButtonTheme(Gadget, *ObjectTheme.ObjectTheme_INFO, UpdateTheme = #False)

Declare IsObjectTheme(Gadget)
Declare GetObjectThemeAttribute(ObjectType, Attribute)
Declare SetObjectThemeAttribute(ObjectType, Attribute, Value)
Declare GetObjectColor(Gadget, Attribute)
Declare SetObjectTypeColor(ObjectType, Attribute, Value)
Declare SetObjectColor(Gadget, Attribute, Value)
Declare FreeObjectTheme()
Declare GetObjectTheme()
Declare SetObjectTheme(Theme, WindowColor = #PB_Default)

Global NewMap ThemeAttribute()
Global NewMap ObjectTheme.ObjectTheme_INFO()
Global NewMap ObjectBrush()
Global Tooltip

Macro _ProcedureReturnIfOT(Cond, ReturnValue = #False)
  If Cond
    ProcedureReturn ReturnValue
  EndIf
EndMacro

Macro _ObjectThemeID(pObjectTheme, IDGadget, ReturnValue = #False)
  PushMapPosition(ObjectTheme())
  If FindMapElement(ObjectTheme(), Str(IDGadget))
    pObjectTheme = @ObjectTheme()
  Else
    Debug "ObjectTheme Error: ObjectTheme not found in ObjectTheme Map."
    PopMapPosition(ObjectTheme())
    ProcedureReturn ReturnValue
  EndIf
  PopMapPosition(ObjectTheme())
EndMacro

Macro _AddWindowTheme(Window)
  If MapSize(ThemeAttribute()) > 0   ; SetObjectTheme() Done
    If FindMapElement(ObjectTheme(), Str(WindowID(Window)))
      AddWindowTheme(Window, ObjectTheme(), #True)  ; UpdateTheme = #True
    Else
      AddMapElement(ObjectTheme(), Str(WindowID(Window)))
      AddWindowTheme(Window, ObjectTheme())
    EndIf
  EndIf
EndMacro

Macro _AddObjectTheme(Gadget)
  If MapSize(ThemeAttribute()) > 0   ; SetObjectTheme() Done
    If FindMapElement(ObjectTheme(), Str(GadgetID(Gadget)))
      AddObjectTheme(Gadget, ObjectTheme(), #True)  ; UpdateTheme = #True
    Else
      AddMapElement(ObjectTheme(), Str(GadgetID(Gadget)))
      AddObjectTheme(Gadget, ObjectTheme())
    EndIf
  EndIf
EndMacro

Macro _AddButtonTheme(Gadget)
  If MapSize(ThemeAttribute()) > 0   ; SetObjectTheme() Done
    If FindMapElement(ObjectTheme(), Str(GadgetID(Gadget)))
      AddButtonTheme(Gadget, ObjectTheme(), #True)  ; UpdateTheme = #True
    Else
      AddMapElement(ObjectTheme(), Str(GadgetID(Gadget)))
      AddButtonTheme(Gadget, ObjectTheme())
    EndIf
  EndIf
EndMacro

Macro _ToolTipHandleOT()
  Tooltip = ToolTipHandleOT()
  If Tooltip
    SetWindowTheme_(Tooltip, @"", @"")
    ;SendMessage_(Tooltip, #TTM_SETDELAYTIME, #TTDT_INITIAL, 250) : SendMessage_(Tooltip, #TTM_SETDELAYTIME,#TTDT_AUTOPOP, 5000) : SendMessage_(Tooltip, #TTM_SETDELAYTIME,#TTDT_RESHOW, 250)
    Protected TmpBackColor = GetObjectThemeAttribute(#PB_GadgetType_Button, #PB_Gadget_CornerColor)
    SendMessage_(Tooltip, #TTM_SETTIPBKCOLOR, TmpBackColor, 0)
    If IsDarkColorOT(TmpBackColor)
      SendMessage_(Tooltip, #TTM_SETTIPTEXTCOLOR, #White, 0)
    Else
      SendMessage_(Tooltip, #TTM_SETTIPTEXTCOLOR, #Black, 0)
    EndIf
    SendMessage_(Tooltip, #WM_SETFONT, 0, 0)
    SendMessage_(Tooltip, #TTM_SETMAXTIPWIDTH, 0, 460)
  EndIf
EndMacro

Macro _SetDarkTheme(_GadgetID_)
  If OSVersion() >= #PB_OS_Windows_10
    SetWindowTheme(_GadgetID_, "DarkMode_Explorer")
  ElseIf OSVersion() >= #PB_OS_Windows_Vista
    SetWindowTheme(_GadgetID_, "Explorer")
  EndIf
EndMacro

Macro _SetExplorerTheme(_GadgetID_)
  If OSVersion() >= #PB_OS_Windows_Vista
    SetWindowTheme(_GadgetID_, "Explorer")
  EndIf
EndMacro

;- IncludeFile CreateGadget DataSection.pbi
XIncludeFile "ObjectTheme_CreateGadget.pbi"
XIncludeFile "ObjectTheme_DataSection.pbi"

;
; -----------------------------------------------------------------------------
;- ----- Color & Filter -----
; -----------------------------------------------------------------------------
;

Procedure IsDarkColorOT(Color)
  If Red(Color)*0.299 + Green(Color)*0.587 +Blue(Color)*0.114 < 128   ; Based on Human perception of color, following the RGB values (0.299, 0.587, 0.114)
    ProcedureReturn #True
  EndIf
  ProcedureReturn #False
EndProcedure

Procedure AccentColorOT(Color, AddColorValue)
  Protected R, G, B
  R = Red(Color)   + AddColorValue : If R > 255 : R = 255 : EndIf : If R < 0 : R = 0 : EndIf
  G = Green(Color) + AddColorValue : If G > 255 : G = 255 : EndIf : If G < 0 : G = 0 : EndIf
  B = Blue(Color)  + AddColorValue : If B > 255 : B = 255 : EndIf : If B < 0 : B = 0 : EndIf
  ProcedureReturn RGB(R, G, B)
EndProcedure

Procedure ScaleGrayCallbackOT(x, y, SourceColor, TargetColor)
  Protected light
  light = ((Red(TargetColor) * 30 + Green(TargetColor) * 59 + Blue(TargetColor) * 11) / 100)
  ProcedureReturn RGBA(light, light, light, 255)
EndProcedure

Procedure DisabledDarkColorOT(Color)
  Protected R, G, B
  R = Red(Color)   * 0.5 + (Red(Color)   + 80) * 0.5 : If R > 255 : R = 255 : EndIf
  G = Green(Color) * 0.5 + (Green(Color) + 80) * 0.5 : If G > 255 : G = 255 : EndIf
  B = Blue(Color)  * 0.5 + (Blue(Color)  + 80) * 0.5 : If B > 255 : B = 255 : EndIf
  ProcedureReturn RGBA(R, G, B, Alpha(Color))
EndProcedure

Procedure DisabledLightColorOT(Color)
  Protected R, G, B
  R = Red(Color)   * 0.5 + (Red(Color)   - 80) * 0.5 : If R > 255 : R = 255 : EndIf
  G = Green(Color) * 0.5 + (Green(Color) - 80) * 0.5 : If G > 255 : G = 255 : EndIf
  B = Blue(Color)  * 0.5 + (Blue(Color)  - 80) * 0.5 : If B > 255 : B = 255 : EndIf
  ProcedureReturn RGBA(R, G, B, Alpha(Color))
EndProcedure

;
; -----------------------------------------------------------------------------
;- ----- Callback Procedure -----
; -----------------------------------------------------------------------------
;

Procedure SplitterCalc(hWnd, *rc.RECT)
  Protected hWnd1, hWnd2, r1.RECT, r2.RECT
  hWnd1 = GadgetID(GetGadgetAttribute(GetDlgCtrlID_(hWnd), #PB_Splitter_FirstGadget))
  hWnd2 = GadgetID(GetGadgetAttribute(GetDlgCtrlID_(hWnd), #PB_Splitter_SecondGadget))
  GetWindowRect_(hWnd1, r1)
  OffsetRect_(r1, -r1\left, -r1\top)
  If IsRectEmpty_(r1) = 0
    MapWindowPoints_(hWnd1, hWnd, r1, 2)
    SubtractRect_(*rc, *rc, r1)
  EndIf
  GetWindowRect_(hWnd2, r2)
  OffsetRect_(r2, -r2\left, -r2\top)
  If IsRectEmpty_(r2) = 0
    MapWindowPoints_(hWnd2, hWnd, r2, 2)
    SubtractRect_(*rc, *rc, r2)
  EndIf
EndProcedure

Procedure SplitterPaint(hWnd, hdc, *rc.RECT, *ObjectTheme.ObjectTheme_INFO)
  ;\ObjectInfo\iBackColor, \ObjectInfo\iSplitterGripper, \ObjectInfo\iSplitterBorder, \ObjectInfo\iSplitterBorderColor, \ObjectInfo\iUseUxGripper, \ObjectInfo\iLargeGripper
  With *ObjectTheme\ObjectInfo
    If \iSplitterBorder
      SetDCBrushColor_(hdc, \iSplitterBorderColor)
    Else
      SetDCBrushColor_(hdc, \iBackColor)
    EndIf
    FrameRect_(hdc, *rc, GetStockObject_(#DC_BRUSH))
    InflateRect_(*rc, -1, -1)
    SetDCBrushColor_(hdc, \iBackColor)
    FillRect_(hdc, *rc, GetStockObject_(#DC_BRUSH))
    ;InflateRect_(*rc, -1, -1)
    ;Debug Str(*rc\left) + ", " + Str(*rc\top) + ", " + Str(*rc\right) + ", " + Str(*rc\bottom)
    
    
    If \iUseUxGripper
      Protected htheme = OpenThemeData_(hWnd, "Rebar")
      If htheme
        If *rc\right-*rc\left < *rc\bottom-*rc\top
          If \iLargeGripper
            InflateRect_(*rc, (*rc\bottom-*rc\top-DesktopScaledX(5))/2, -(*rc\bottom-*rc\top-1)/2 +DesktopScaledY(11))
          Else
            InflateRect_(*rc, (*rc\bottom-*rc\top-DesktopScaledX(5))/2, -(*rc\bottom-*rc\top-1)/2 +DesktopScaledY(7))
          EndIf
          DrawThemeBackground_(htheme, hdc, 1, 0, *rc, 0)
        Else
          If \iLargeGripper
            InflateRect_(*rc, -(*rc\right-*rc\left-1)/2 +DesktopScaledX(11), (*rc\bottom-*rc\top-DesktopScaledY(5))/2)
          Else
            InflateRect_(*rc, -(*rc\right-*rc\left-1)/2 +DesktopScaledX(7), (*rc\bottom-*rc\top-DesktopScaledY(5))/2)
          EndIf
          DrawThemeBackground_(htheme, hdc, 2, 0, *rc, 0)
        EndIf
        CloseThemeData_(htheme)
      EndIf
    Else
      If *rc\right-*rc\left < *rc\bottom-*rc\top
        If \iLargeGripper
          InflateRect_(*rc, (*rc\right-*rc\left-DesktopScaledX(5))/2, -(*rc\bottom-*rc\top-1)/2 +DesktopScaledY(11))
        Else
          InflateRect_(*rc, (*rc\right-*rc\left-DesktopScaledX(5))/2, -(*rc\bottom-*rc\top-1)/2 +DesktopScaledY(7))
        EndIf
      Else
        If \iLargeGripper
          InflateRect_(*rc, -(*rc\right-*rc\left-1)/2 +DesktopScaledX(11), (*rc\bottom-*rc\top-DesktopScaledY(5))/2)
        Else
          InflateRect_(*rc, -(*rc\right-*rc\left-1)/2 +DesktopScaledX(7),  (*rc\bottom-*rc\top-DesktopScaledY(5))/2)
        EndIf
      EndIf
      SetBrushOrgEx_(hdc, *rc\left, *rc\top, 0)
      FillRect_(hdc, *rc, \iSplitterGripper)
      SetBrushOrgEx_(hdc, 0, 0, 0)
    EndIf
  EndWith
EndProcedure

Procedure SplitterProc(hWnd, uMsg, wParam, lParam)
  Protected SplitterGripper, ps.PAINTSTRUCT
  
  If FindMapElement(ObjectTheme(), Str(hWnd))
    Protected *ObjectTheme.ObjectTheme_INFO = @ObjectTheme()
    Protected OldProc = *ObjectTheme\OldProc
  Else
    ProcedureReturn DefWindowProc_(hWnd, uMsg, wParam, lParam)
  EndIf
  
  With *ObjectTheme
    Select uMsg
      Case #WM_NCDESTROY
        ; Delete map element for all children's gadgets that no longer exist after CloseWindow(). Useful in case of multiple windows
        ForEach ObjectTheme()
          *ObjectTheme = @ObjectTheme()
          If Not IsGadget(\PBGadget)
            If \OldProc
              SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, \OldProc)
            EndIf
            If \ObjectInfo\iSplitterGripper : DeleteObject_(\ObjectInfo\iSplitterGripper) : EndIf
            FreeMemory(\ObjectInfo)
            DeleteMapElement(ObjectTheme())
          EndIf
        Next
        ; Delete all unused brushes and map element
        ForEach ObjectBrush()
          If Not IsBrushUsed(ObjectBrush())
            DeleteObject_(ObjectBrush())
            DeleteMapElement(ObjectBrush())
          EndIf
        Next
          
      Case #WM_PAINT
        ;SplitterGripper   = \ObjectInfo\iSplitterGripper
        BeginPaint_(hWnd, ps)
        SplitterCalc(hWnd, ps\rcPaint)
        SplitterPaint(hWnd, ps\hdc, ps\rcPaint, *ObjectTheme)
        EndPaint_(hWnd, ps)
        ProcedureReturn #False
        
      Case #WM_ERASEBKGND
        ProcedureReturn #True
        
      Case #WM_LBUTTONDBLCLK
        PostEvent(#PB_Event_Gadget, EventWindow(), \PBGadget, #PB_EventType_LeftDoubleClick)
        
    EndSelect
  EndWith
  
  ProcedureReturn CallWindowProc_(OldProc, hWnd, uMsg, wParam, lParam)
EndProcedure

Procedure PanelProc(hWnd, uMsg, wParam, lParam)
  Protected *DrawItem.DRAWITEMSTRUCT, Rect.Rect 
  
  If FindMapElement(ObjectTheme(), Str(hWnd))
    Protected *ObjectTheme.ObjectTheme_INFO = @ObjectTheme()
    Protected OldProc = *ObjectTheme\OldProc
  Else
    ProcedureReturn DefWindowProc_(hWnd, uMsg, wParam, lParam)
  EndIf
  
  With *ObjectTheme
    Select uMsg
      Case #WM_NCDESTROY
        ; Delete map element for all children's gadgets that no longer exist after CloseWindow(). Useful in case of multiple windows
        ForEach ObjectTheme()
          *ObjectTheme = @ObjectTheme()
          If Not IsGadget(\PBGadget)
            If \OldProc
              SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, \OldProc)
            EndIf
            If \ObjectInfo\iSplitterGripper : DeleteObject_(\ObjectInfo\iSplitterGripper) : EndIf
            FreeMemory(\ObjectInfo)
            DeleteMapElement(ObjectTheme())
          EndIf
        Next
        ; Delete all unused brushes and map element
        ForEach ObjectBrush()
          If Not IsBrushUsed(ObjectBrush())
            DeleteObject_(ObjectBrush())
            DeleteMapElement(ObjectBrush())
          EndIf
        Next
        
        ;ProcedureReturn #False
        
      Case #WM_ENABLE
        InvalidateRect_(hWnd, #Null, #True)
        ProcedureReturn #True
        
      Case #WM_ERASEBKGND
        *DrawItem.DRAWITEMSTRUCT = wParam
        GetClientRect_(hWnd, Rect)
        FillRect_(wParam, @Rect, \ObjectInfo\iBrushBackColor)
        ;Protected ParentBackColor  = GetParentBackColor(\PBGadget)
        Rect\top = 0 : Rect\bottom = GetGadgetAttribute(\PBGadget, #PB_Panel_TabHeight)
        FillRect_(wParam, @Rect, \ObjectInfo\iBrushBackColor)  ; ObjectCBrush(Str(ParentBackColor)))
        ProcedureReturn #True
        
    EndSelect
  EndWith
  
  ProcedureReturn CallWindowProc_(OldProc, hWnd, uMsg, wParam, lParam)
EndProcedure

Procedure ListIconProc(hWnd, uMsg, wParam, lParam)
  
  If FindMapElement(ObjectTheme(), Str(hWnd))
    Protected *ObjectTheme.ObjectTheme_INFO = @ObjectTheme()
    Protected Result = CallWindowProc_(*ObjectTheme\OldProc, hWnd, uMsg, wParam, lParam)
  Else
    ProcedureReturn DefWindowProc_(hWnd, uMsg, wParam, lParam)
  EndIf
  Protected *pnmHDR.NMHDR, *pnmCDraw.NMCUSTOMDRAW
  
  With *ObjectTheme
  Select uMsg
    Case #WM_NCDESTROY
      Protected SavBackColor = \ObjectInfo\iBackColor
      Protected SavTitleBackColor = \ObjectInfo\iTitleBackColor
      If \OldProc
        SetWindowLongPtr_(hWnd, #GWLP_WNDPROC, \OldProc)
      EndIf
      FreeMemory(\ObjectInfo)
      DeleteMapElement(ObjectTheme())
      If SavBackColor        : DeleteUnusedBrush(SavBackColor)        : EndIf
      If SavTitleBackColor   : DeleteUnusedBrush(SavTitleBackColor)   : EndIf
      ;ProcedureReturn #False
        
      Case #WM_NOTIFY
        *pnmHDR = lparam
        If *pnmHDR\code = #NM_CUSTOMDRAW   ; Get handle to ListIcon and ExplorerList Header Control
          *pnmCDraw = lparam
          Select *pnmCDraw\dwDrawStage     ; Determine drawing stage
            Case #CDDS_PREPAINT
              Result = #CDRF_NOTIFYITEMDRAW
              
            Case #CDDS_ITEMPREPAINT
              Protected Text.s = GetGadgetItemText(\PBGadget, -1, *pnmCDraw\dwItemSpec)
              If *pnmCDraw\uItemState & #CDIS_SELECTED
                DrawFrameControl_(*pnmCDraw\hdc, *pnmCDraw\rc, #DFC_BUTTON, #DFCS_BUTTONPUSH | #DFCS_PUSHED)
                *pnmCDraw\rc\left + 1 : *pnmCDraw\rc\top + 1
              Else
                DrawFrameControl_(*pnmCDraw\hdc, *pnmCDraw\rc, #DFC_BUTTON, #DFCS_BUTTONPUSH)
              EndIf
              *pnmCDraw\rc\bottom - 1 : *pnmCDraw\rc\right - 1
              SetBkMode_(*pnmCDraw\hdc, #TRANSPARENT)
              FillRect_(*pnmCDraw\hdc, *pnmCDraw\rc, \ObjectInfo\iBrushTitleBackColor)
              SetTextColor_(*pnmCDraw\hdc, \ObjectInfo\iTitleFrontColor)
              If *pnmCDraw\rc\right > *pnmCDraw\rc\left
                DrawText_(*pnmCDraw\hdc, @Text, Len(Text), *pnmCDraw\rc, #DT_CENTER | #DT_VCENTER | #DT_SINGLELINE | #DT_END_ELLIPSIS)
              EndIf
              Result = #CDRF_SKIPDEFAULT
              
          EndSelect
        EndIf
        
    EndSelect
  EndWith
  
  ProcedureReturn Result
EndProcedure

Procedure CalendarProc(hWnd, uMsg, wParam, lParam)
  
  If FindMapElement(ObjectTheme(), Str(hWnd))
    Protected *ObjectTheme.ObjectTheme_INFO = @ObjectTheme()
    Protected OldProc = *ObjectTheme\OldProc
  Else
    ProcedureReturn DefWindowProc_(hWnd, uMsg, wParam, lParam)
  EndIf
  
  With *ObjectTheme
    Select uMsg
      Case #WM_NCDESTROY
        If \OldProc
          SetWindowLongPtr_(hWnd, #GWLP_WNDPROC, \OldProc)
        EndIf
        FreeMemory(\ObjectInfo)
        DeleteMapElement(ObjectTheme())
        ;ProcedureReturn #False
        
      Case #WM_ENABLE    
        If wParam = #False
          Protected TextColor = \ObjectInfo\iGrayTextColor
        Else
          TextColor = \ObjectInfo\iFrontColor
        EndIf
        SendMessage_(hWnd, #MCM_SETCOLOR, #MCSC_TEXT, TextColor)
        SendMessage_(hWnd, #MCM_SETCOLOR, #MCSC_TITLETEXT, TextColor)
        SendMessage_(hWnd, #MCM_SETCOLOR, #MCSC_TRAILINGTEXT, TextColor)
        ProcedureReturn #False
        
    EndSelect
  EndWith
  
  ProcedureReturn CallWindowProc_(OldProc, hWnd, uMsg, wParam, lParam)
EndProcedure

Procedure EditorProc(hWnd, uMsg, wParam, lParam)
  
  If FindMapElement(ObjectTheme(), Str(hWnd))
    Protected *ObjectTheme.ObjectTheme_INFO = @ObjectTheme()
    Protected OldProc = *ObjectTheme\OldProc
  Else
    ProcedureReturn DefWindowProc_(hWnd, uMsg, wParam, lParam)
  EndIf
  
  With *ObjectTheme  
    Select uMsg
      Case #WM_NCDESTROY
        If \OldProc
          SetWindowLongPtr_(hWnd, #GWLP_WNDPROC, \OldProc)
        EndIf
        FreeMemory(\ObjectInfo)
        DeleteMapElement(ObjectTheme())
        ;ProcedureReturn #False
        
      Case #WM_ENABLE
        If wParam
          SetWindowLongPtr_(hWnd, #GWL_EXSTYLE, GetWindowLongPtr_(hWnd, #GWL_EXSTYLE) &~ #WS_EX_TRANSPARENT)
          SetGadgetColor(\PBGadget, #PB_Gadget_FrontColor, \ObjectInfo\iFrontColor)
        Else
          SetWindowLongPtr_(hWnd, #GWL_EXSTYLE, GetWindowLongPtr_(hWnd, #GWL_EXSTYLE) | #WS_EX_TRANSPARENT)
          SetGadgetColor(\PBGadget, #PB_Gadget_FrontColor, \ObjectInfo\iGrayTextColor)
        EndIf
        ProcedureReturn #False
        
      Case #WM_ERASEBKGND
        Protected Rect.RECT
        GetClientRect_(hWnd, Rect)
        FillRect_(wParam, @Rect, \ObjectInfo\iBrushBackColor)
        ProcedureReturn #True
        
    EndSelect
  EndWith
  
  ProcedureReturn CallWindowProc_(OldProc, hWnd, uMsg, wParam, lParam)
EndProcedure

Procedure StaticProc(hWnd, uMsg, wParam, lParam)
  
  If FindMapElement(ObjectTheme(), Str(hWnd))
    Protected *ObjectTheme.ObjectTheme_INFO = @ObjectTheme()
    Protected OldProc = *ObjectTheme\OldProc
  Else
    ProcedureReturn DefWindowProc_(hWnd, uMsg, wParam, lParam)
  EndIf
  
  With *ObjectTheme
    Select uMsg
      Case #WM_NCDESTROY
        Protected SavBackColor = \ObjectInfo\iBackColor
        If \OldProc
          SetWindowLongPtr_(hWnd, #GWLP_WNDPROC, \OldProc)
        EndIf
        FreeMemory(\ObjectInfo)
        DeleteMapElement(ObjectTheme())
        If SavBackColor        : DeleteUnusedBrush(SavBackColor)        : EndIf
        ;ProcedureReturn #False
        
      Case #WM_ENABLE
        Select \PBGadgetType
          Case #PB_GadgetType_CheckBox, #PB_GadgetType_Option, #PB_GadgetType_TrackBar
            If wParam
              SetWindowTheme_(hWnd, "", "")
            Else
              SetWindowTheme_(hWnd, "", 0)
            EndIf
            ;Case #PB_GadgetType_Frame, #PB_GadgetType_Text
        EndSelect
        ProcedureReturn #False
        
    EndSelect
  EndWith
  
  ProcedureReturn CallWindowProc_(OldProc, hWnd, uMsg, wParam, lParam)
EndProcedure

Procedure WinCallback(hWnd, uMsg, wParam, lParam)
  Protected Result = #PB_ProcessPureBasicEvents
  Protected *ObjectTheme.ObjectTheme_INFO
  
  Protected ParentGadget, Buffer.s, Text.s ;, Color_HightLight, FadeGrayColor, Found, I
  Protected *DrawItem.DRAWITEMSTRUCT, *lvCD.NMLVCUSTOMDRAW 
  
  With *ObjectTheme
    Select uMsg
      Case #WM_CLOSE
        PostEvent(#PB_Event_Gadget, GetDlgCtrlID_(hWnd), 0, #PB_Event_CloseWindow)   ; Required to manage it with #PB_Event_CloseWindow event, if the window is minimized and closed from the taskbar (Right CLick)
        
      Case #WM_NCDESTROY
        ; Delete map element for all children's gadgets that no longer exist after CloseWindow(). Useful in case of multiple windows
        ForEach ObjectTheme()
          *ObjectTheme = @ObjectTheme()
          If Not IsGadget(\PBGadget)
            If \OldProc
              SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, \OldProc)
            EndIf
            If \ObjectInfo\iSplitterGripper : DeleteObject_(\ObjectInfo\iSplitterGripper) : EndIf
            FreeMemory(\ObjectInfo)
            DeleteMapElement(ObjectTheme())
          EndIf
        Next
        ; Delete all unused brushes and map element
        ForEach ObjectBrush()
          If Not IsBrushUsed(ObjectBrush())
            DeleteObject_(ObjectBrush())
            DeleteMapElement(ObjectBrush())
          EndIf
        Next
        ;ProcedureReturn #False
        
      ; ---------- Static: CheckBoxGadget, FrameGadget, OptionGadget, TextGadget, TrackBarGadget ----------
      Case #WM_CTLCOLORSTATIC
        If FindMapElement(ObjectTheme(), Str(lparam))
          *ObjectTheme = @ObjectTheme()
        Else
          ProcedureReturn Result
        EndIf
        
        Select *ObjectTheme\PBGadgetType
          Case #PB_GadgetType_CheckBox, #PB_GadgetType_Frame, #PB_GadgetType_Option, #PB_GadgetType_Text, #PB_GadgetType_TrackBar
            If IsWindowEnabled_(\IDGadget) = #False
              SetTextColor_(wParam, \ObjectInfo\iGrayTextColor)
            Else
              SetTextColor_(wParam, \ObjectInfo\iFrontColor)
            EndIf
            SetBkMode_(wParam, #TRANSPARENT)
            ProcedureReturn \ObjectInfo\iBrushBackColor
        EndSelect
        
      ; ----------  BoxGadget ----------
      Case #WM_CTLCOLOREDIT
        ParentGadget = GetParent_(lParam)
        Buffer = Space(64)
        If GetClassName_(ParentGadget, @Buffer, 64)
          If Buffer = "ComboBox"
            If FindMapElement(ObjectTheme(), Str(ParentGadget))
              *ObjectTheme = @ObjectTheme()
            Else
              ProcedureReturn Result
            EndIf
            
            If \PBGadget <> GetActiveGadget()
              SendMessage_(lParam, #EM_SETSEL, 0, 0)   ; Deselect the ComboBox editable string if not the active Gadget
            EndIf
            If IsWindowEnabled_(\IDGadget) = #False
              SetTextColor_(wParam, \ObjectInfo\iGrayTextColor)
            Else
              SetTextColor_(wParam, \ObjectInfo\iFrontColor)
            EndIf
            SetBkMode_(wParam, #TRANSPARENT)
            ProcedureReturn \ObjectInfo\iBrushEditBoxColor
          EndIf
        EndIf
        
      Case #WM_DRAWITEM   ; For ComboBoxGadget and PanelGadget
        *DrawItem.DRAWITEMSTRUCT = lParam
        
        ; ---------- ComboBoxGadget ----------
        If *DrawItem\CtlType = #ODT_COMBOBOX
          If IsGadget(wParam)
            If FindMapElement(ObjectTheme(), Str(GadgetID(wParam)))
              *ObjectTheme = @ObjectTheme()
            Else
              ProcedureReturn Result
            EndIf
            
            If *DrawItem\itemID <> -1
              If *DrawItem\itemstate & #ODS_SELECTED
                FillRect_(*DrawItem\hDC, *DrawItem\rcitem, \ObjectInfo\iBrushHighLightColor)
              Else
                FillRect_(*DrawItem\hDC, *DrawItem\rcitem, \ObjectInfo\iBrushBackColor)
              EndIf
              
              SetBkMode_(*DrawItem\hDC, #TRANSPARENT)
              If IsWindowEnabled_(\IDGadget) = #False
                SetTextColor_(*DrawItem\hDC, \ObjectInfo\iGrayTextColor)
              Else
                SetTextColor_(*DrawItem\hDC, \ObjectInfo\iFrontColor)
              EndIf
              Text = GetGadgetItemText(*DrawItem\CtlID, *DrawItem\itemID)
              *DrawItem\rcItem\left + DesktopScaledX(4)
              DrawText_(*DrawItem\hDC, Text, Len(Text), *DrawItem\rcItem, #DT_LEFT | #DT_SINGLELINE | #DT_VCENTER)
            EndIf
          EndIf
        EndIf
        
        ; ---------- PanelGadget ----------
        If *DrawItem\CtlType = #ODT_TAB
          If FindMapElement(ObjectTheme(), Str(*DrawItem\hwndItem))
            *ObjectTheme = @ObjectTheme()
          Else
            ProcedureReturn Result
          EndIf
          
          If *DrawItem\itemState
            *DrawItem\rcItem\left + 2
            FillRect_(*DrawItem\hDC, *DrawItem\rcItem, \ObjectInfo\iBrushActiveTabColor)
          Else
            *DrawItem\rcItem\top + 2 : *DrawItem\rcItem\bottom + 3   ; Default: \rcItem\bottom + 2 . +3 to decrease the size of the bottom line
            FillRect_(*DrawItem\hDC, *DrawItem\rcItem, \ObjectInfo\iBrushInactiveTabColor)
          EndIf
          
          SetBkMode_(*DrawItem\hDC, #TRANSPARENT)
          If IsWindowEnabled_(\IDGadget) = #False
            SetTextColor_(*DrawItem\hDC, \ObjectInfo\iGrayTextColor)
          Else
            SetTextColor_(*DrawItem\hDC, \ObjectInfo\iFrontColor)
          EndIf
          Text = GetGadgetItemText(\PBGadget, *DrawItem\itemID)
          *DrawItem\rcItem\left + DesktopScaledX(4)
          ;TextOut_(*DrawItem\hDC, *DrawItem\rcItem\left, *DrawItem\rcItem\top, Text, Len(Text))
          DrawText_(*DrawItem\hDC, @Text, Len(Text), @*DrawItem\rcItem, #DT_LEFT | #DT_VCENTER | #DT_SINGLELINE)
          ProcedureReturn #True
        EndIf
        
      Case #WM_NOTIFY   
        ; ----------  DateGadget or use SetThemeAppProperties_(1) in AddObjectTheme ----------
        Protected *NMDATETIMECHANGE.NMDATETIMECHANGE = lParam
        If *NMDATETIMECHANGE\nmhdr\code = #DTN_DROPDOWN
          If FindMapElement(ObjectTheme(), Str(*NMDATETIMECHANGE\nmhdr\hwndfrom))
            If ObjectTheme()\PBGadgetType = #PB_GadgetType_Date
              Protected WinIDSysMonthCal32 = FindWindowEx_(FindWindow_("DropDown", 0), #Null, "SysMonthCal32", #Null)
              SetWindowTheme_(WinIDSysMonthCal32, "", "")          ; The size isn't good: https://www.purebasic.fr/english/viewtopic.php?p=519438
              ShowWindow_(WinIDSysMonthCal32, #SW_SHOWMAXIMIZED)   ; A little better but not perfect
            EndIf
          EndIf
        EndIf
        
        ; ---------- ListIcon and ExplorerList ----------
        *lvCD.NMLVCUSTOMDRAW = lParam
        If *lvCD\nmcd\hdr\code = #NM_CUSTOMDRAW
          ;Protected Gadget = GetDlgCtrlID_(*lvCD\nmcd\hdr\hWndFrom)
          If IsGadget(*lvCD\nmcd\hdr\idFrom)
            If IsWindowEnabled_(*lvCD\nmcd\hdr\hWndFrom) = #False
              Select GadgetType(*lvCD\nmcd\hdr\idFrom)
                Case #PB_GadgetType_ListIcon, #PB_GadgetType_ExplorerList
                  If FindMapElement(ObjectTheme(), Str(*lvCD\nmcd\hdr\hWndFrom))
                    *ObjectTheme = @ObjectTheme()
                  Else
                    ProcedureReturn Result
                  EndIf
                  
                  Select *lvCD\nmcd\dwDrawStage
                    Case #CDDS_PREPAINT
                      FillRect_(*lvCD\nmcd\hDC, *lvCD\nmcd\rc, \ObjectInfo\iBrushBackColor)
                      ProcedureReturn #CDRF_NOTIFYITEMDRAW
                    Case #CDDS_ITEMPREPAINT
                      ;DrawIconEx_(*lvCD\nmcd\hDC, subItemRect\left + 5, (subItemRect\top + subItemRect\bottom - GetSystemMetrics_(#SM_CYSMICON)) / 2, hIcon, 16, 16, 0, 0, #DI_NORMAL)
                      If IsWindowEnabled_(\IDGadget) = #False
                        *lvCD\clrText   = \ObjectInfo\iGrayTextColor
                      Else
                        *lvCD\clrText   = \ObjectInfo\iFrontColor
                      EndIf
                      *lvCD\clrTextBk = \ObjectInfo\iBackColor
                      ProcedureReturn #CDRF_DODEFAULT
                  EndSelect
              EndSelect
            EndIf
          EndIf
        EndIf
        
    EndSelect
  EndWith
  
  ProcedureReturn Result
EndProcedure

;
; -----------------------------------------------------------------------------
;- ----- ToolTip, WindowPB, ImagePB -----
; -----------------------------------------------------------------------------
;

CompilerIf Not Defined(PB_Globals, #PB_Structure)
  Structure PB_Globals
    CurrentWindow.i
    FirstOptionGadget.i
    DefaultFont.i
    *PanelStack
    PanelStackIndex.l
    PanelStackSize.l
    ToolTipWindow.i
  EndStructure
CompilerEndIf

Import ""
  CompilerIf Not Defined(PB_Object_EnumerateStart, #PB_Procedure)  : PB_Object_EnumerateStart(PB_Gadget_Objects)                 : CompilerEndIf
  CompilerIf Not Defined(PB_Object_EnumerateNext, #PB_Procedure)   : PB_Object_EnumerateNext(PB_Gadget_Objects, *Object.Integer) : CompilerEndIf
  CompilerIf Not Defined(PB_Object_EnumerateAbort, #PB_Procedure)  : PB_Object_EnumerateAbort(PB_Gadget_Objects)                 : CompilerEndIf
  CompilerIf Not Defined(PB_Object_GetThreadMemory, #PB_Procedure) : PB_Object_GetThreadMemory(*Mem)                             : CompilerEndIf
  CompilerIf Not Defined(PB_Window_Objects, #PB_Variable)          : PB_Window_Objects.i                                         : CompilerEndIf
  CompilerIf Not Defined(PB_Gadget_Objects, #PB_Variable)          : PB_Gadget_Objects.i                                         : CompilerEndIf
  CompilerIf Not Defined(PB_Image_Objects, #PB_Variable)           : PB_Image_Objects.i                                          : CompilerEndIf
  CompilerIf Not Defined(PB_Gadget_Globals, #PB_Variable)          : PB_Gadget_Globals.i                                         : CompilerEndIf
EndImport

Procedure ToolTipHandleOT() 
  Protected *PBGadget.PB_Globals 
  *PBGadget = PB_Object_GetThreadMemory(PB_Gadget_Globals) 
  ProcedureReturn *PBGadget\ToolTipWindow 
EndProcedure

Procedure WindowPBOT(WindowID) ; Find pb-id over handle
  Protected Result = -1, Window
  PB_Object_EnumerateStart(PB_Window_Objects)
  While PB_Object_EnumerateNext(PB_Window_Objects, @Window)
    If WindowID = WindowID(Window)
      Result = Window
      Break
    EndIf
  Wend
  PB_Object_EnumerateAbort(PB_Window_Objects)
  ProcedureReturn Result
EndProcedure

Procedure ImagePBOT(ImageID) ; Find pb-id over handle
  Protected result, image
  result = -1
  PB_Object_EnumerateStart(PB_Image_Objects)
  While PB_Object_EnumerateNext(PB_Image_Objects, @image)
    If ImageID = ImageID(image)
      result = image
      Break
    EndIf
  Wend
  PB_Object_EnumerateAbort(PB_Image_Objects)
  ProcedureReturn result
EndProcedure

;
; -----------------------------------------------------------------------------
;- ----- Load Theme Private -----
; -----------------------------------------------------------------------------
;

Procedure LoadThemeAttribute(Theme, WindowColor)
  Protected Buffer.i, ObjectType.s, ObjectAttribute.s, I.i, J.i 
  
  Select Theme
    Case #ObjectTheme_DarkBlue
      Restore DarkBlue
    Case #ObjectTheme_DarkRed
      Restore DarkRed
    Case #ObjectTheme_LightBlue
      Restore LightBlue
    Case #ObjectTheme_Auto
      Restore Auto
    Default
      Restore DarkBlue
  EndSelect
  ThemeAttribute(Str(#ObjectTheme)) = Theme
  For I = 1 To 99
    For J = 1 To 3
      Read.i Buffer
      Select J
        Case 1
          If Buffer = #PB_Gadget_END
            Break 2
          EndIf
          ObjectType = Str(Buffer) + "|"
        Case 2
          ObjectAttribute = ObjectType + Str(Buffer)
        Case 3
          If WindowColor <> #PB_Default And ObjectAttribute = Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor) 
            ThemeAttribute(ObjectAttribute) = WindowColor
          Else
            ThemeAttribute(ObjectAttribute) = Buffer
          EndIf
      EndSelect
    Next
  Next
EndProcedure

Procedure SetWindowTheme(GadgetID, Theme.s)
  Protected ChildGadget, Buffer.s
  If FindMapElement(ObjectTheme(), Str(GadgetID))
    With ObjectTheme()
      Select \PBGadgetType
        Case #PB_GadgetType_Editor, #PB_GadgetType_ExplorerList, #PB_GadgetType_ExplorerTree, #PB_GadgetType_ListIcon, #PB_GadgetType_ListView,
             #PB_GadgetType_ScrollArea, #PB_GadgetType_ScrollBar, #PB_GadgetType_Tree
          SetWindowTheme_(GadgetID, @Theme, 0)
          
        Case #PB_GadgetType_ComboBox
          Buffer = Space(64)
          If GetClassName_(GadgetID, @Buffer, 64)
            If Buffer = "ComboBox"
              If OSVersion() >= #PB_OS_Windows_10 And Theme = "DarkMode_Explorer"
                SetWindowTheme_(GadgetID, "DarkMode_CFD", "Combobox")
              Else
                SetWindowTheme_(GadgetID, @Theme, 0)
              EndIf
            EndIf
          EndIf
          ChildGadget = GetWindow_(GadgetID, #GW_CHILD)
          If ChildGadget
            Buffer = Space(64)
            If GetClassName_(ChildGadget, @Buffer, 64)
              If Buffer = "ComboBox"
                If OSVersion() >= #PB_OS_Windows_10 And Theme = "DarkMode_Explorer"
                  SetWindowTheme_(ChildGadget, "DarkMode_CFD", "Combobox")
                Else
                  SetWindowTheme_(ChildGadget, @Theme, 0)
                EndIf
              EndIf
            EndIf
          EndIf
          
      EndSelect
    EndWith
  EndIf
EndProcedure

;
; -----------------------------------------------------------------------------
;- ----- Window Private -----
; -----------------------------------------------------------------------------
;

Macro _SubSetWindowThemeColor(ObjectType, Attribute)
  If FindMapElement(ThemeAttribute(), Str(ObjectType) + "|" + Str(Attribute))
    If ThemeAttribute() = #PB_Default
      SetObjectTypeColor(ObjectType, Attribute, #PB_Default)
    EndIf
  EndIf
EndMacro

Procedure SetWindowThemeColor(*ObjectTheme.ObjectTheme_INFO, Attribute, Value, InitLevel = #True)
  Protected ReturnValue = #PB_Default
  
  Select Attribute
    Case #PB_Gadget_BackColor
      SetWindowColor(*ObjectTheme\PBGadget, Value)
      
      _SubSetWindowThemeColor(#PB_GadgetType_Button,       #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_Button,       #PB_Gadget_OuterColor)
      _SubSetWindowThemeColor(#PB_GadgetType_Button,       #PB_Gadget_CornerColor)
      _SubSetWindowThemeColor(#PB_GadgetType_ButtonImage,  #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_ButtonImage,  #PB_Gadget_OuterColor)
      _SubSetWindowThemeColor(#PB_GadgetType_ButtonImage,  #PB_Gadget_CornerColor)
      
      _SubSetWindowThemeColor(#PB_GadgetType_Calendar,     #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_CheckBox,     #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_ComboBox,     #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_Container,    #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_Date,         #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_Editor,       #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_ExplorerList, #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_ExplorerTree, #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_Frame,        #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_HyperLink,    #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_ListIcon,     #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_ListView,     #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_Option,       #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_Panel,        #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_ProgressBar,  #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_ScrollArea,   #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_Spin,         #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_Splitter,     #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_String,       #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_Text,         #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_TrackBar,     #PB_Gadget_BackColor)
      _SubSetWindowThemeColor(#PB_GadgetType_Tree,         #PB_Gadget_BackColor)
      ReturnValue = #True
      
    Case #PB_Gadget_DarkMode
      If Value = #PB_Default
        If IsDarkColorOT(GetObjectThemeAttribute(#PB_WindowType, #PB_Gadget_BackColor)) : Value = #True : Else : Value = #False : EndIf
      EndIf
      PushMapPosition(ObjectTheme())
      ForEach ObjectTheme()
        Select ObjectTheme()\PBGadgetType
            Case #PB_GadgetType_ComboBox, #PB_GadgetType_Editor, #PB_GadgetType_ExplorerList, #PB_GadgetType_ExplorerTree, #PB_GadgetType_ListIcon,
                 #PB_GadgetType_ListView, #PB_GadgetType_ScrollArea, #PB_GadgetType_ScrollBar, #PB_GadgetType_Tree
            If Value
              _SetDarkTheme(ObjectTheme()\IDGadget)
            Else
              _SetExplorerTheme(ObjectTheme()\IDGadget)
            EndIf
        EndSelect
      Next
      PopMapPosition(ObjectTheme())
      ReturnValue = #True
      
  EndSelect
  
  ;If InitLevel = #True
  ;EndIf
  
  ProcedureReturn ReturnValue
EndProcedure

Procedure AddWindowTheme(Window, *ObjectTheme.ObjectTheme_INFO, UpdateTheme = #False)
  _ProcedureReturnIfOT(Not IsWindow(Window)) 
  Protected ObjectType.s, ReturnValue
  
  With *ObjectTheme
    If Not UpdateTheme
      \PBGadget                = Window
      \IDGadget                = WindowID(Window)
      \IDParent                = \IDGadget
      \PBGadgetType            = #PB_WindowType
      \ObjectInfo              = AllocateMemory(SizeOf(ObjectInfo_INFO))
    EndIf
    ObjectType                 = Str(\PBGadgetType) + "|"
    
    \ObjectInfo\iBackColor   = ThemeAttribute(ObjectType + Str(#PB_Gadget_BackColor))
    SetWindowColor(Window, \ObjectInfo\iBackColor)
    
    If FindMapElement(ThemeAttribute(), Str(#PB_WindowType) + "|" + Str(#PB_Gadget_DarkMode))
      If ThemeAttribute() = #PB_Default
        SetWindowThemeColor(*ObjectTheme, #PB_Gadget_DarkMode, #PB_Default)
      EndIf
    EndIf
  EndWith
  
  ProcedureReturn ReturnValue
EndProcedure

;
; -----------------------------------------------------------------------------
;- ----- Object Theme Private -----
; -----------------------------------------------------------------------------
;

Procedure IsBrushUsed(Brush)
  Protected BrushUsed
  
  With ObjectTheme()\ObjectInfo
    ;PushMapPosition(ObjectTheme())
    ForEach ObjectTheme()
      If ObjectTheme()\ObjectInfo
        Select Brush
          Case \iBrushBackColor, \iBrushActiveTabColor, \iBrushInactiveTabColor, \iBrushHighLightColor, \iBrushEditBoxColor, \iBrushTitleBackColor
            BrushUsed = #True
            Break
        EndSelect
      EndIf
    Next
    ;PopMapPosition(ObjectTheme())
  EndWith
  
  ProcedureReturn BrushUsed
EndProcedure

Procedure DeleteUnusedBrush(Color)
  If FindMapElement(ObjectBrush(), Str(Color))
    ; Delete brushes and map brush element, if not used in an Object
    If Not IsBrushUsed(ObjectBrush())
      DeleteObject_(ObjectBrush())
      DeleteMapElement(ObjectBrush())
    EndIf
  EndIf
EndProcedure

Macro _SetObjectBrush(Color, BrushColor, SavColor)
  If SavColor <> Color
    If Not FindMapElement(ObjectBrush(), Str(Color))
      ObjectBrush(Str(Color)) = CreateSolidBrush_(Color)
      BrushColor = ObjectBrush()
    Else
      BrushColor = ObjectBrush()
    EndIf
    
    If SavColor
      DeleteUnusedBrush(SavColor)
    EndIf
  EndIf
EndMacro
            
Macro _SubSetObjectThemeColor(ObjectType, Attribute)
  If FindMapElement(ThemeAttribute(), Str(ObjectType) + "|" + Str(Attribute))
    If ThemeAttribute() = #PB_Default
      SetObjectThemeColor(*ObjectTheme, Attribute, #PB_Default, #False)
    EndIf
  EndIf
EndMacro

Procedure SetObjectThemeColor(*ObjectTheme.ObjectTheme_INFO, Attribute, Value, InitLevel = #True)
  Protected SavBackColor, ReturnValue = #PB_Default
  Protected ObjectType.s = Str(*ObjectTheme\PBGadgetType) + "|"
  
  If Not FindMapElement(ThemeAttribute(), ObjectType + Str(Attribute))
    ProcedureReturn ReturnValue
  EndIf
  
  With *ObjectTheme\ObjectInfo
    Select Attribute
      ; ---------- BackColor ----------  
      Case #PB_Gadget_BackColor
        SavBackColor = \iBackColor
        If Value = #PB_Default
          \iBackColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
          Select *ObjectTheme\PBGadgetType
            Case #PB_GadgetType_Editor, #PB_GadgetType_Spin, #PB_GadgetType_String
              If IsDarkColorOT(\iBackColor) : \iBackColor = AccentColorOT(\iBackColor, 15) : Else : \iBackColor = AccentColorOT(\iBackColor, -15) : EndIf
            Case #PB_GadgetType_ProgressBar
              If IsDarkColorOT(\iBackColor) : \iBackColor = AccentColorOT(\iBackColor, 40) : Else : \iBackColor = AccentColorOT(\iBackColor, -40) : EndIf
            Case #PB_GadgetType_Splitter
              If IsDarkColorOT(\iBackColor) : \iBackColor = AccentColorOT(\iBackColor, 30) : Else : \iBackColor = AccentColorOT(\iBackColor, -30) : EndIf 
          EndSelect
        Else
          \iBackColor        = Value
        EndIf
        
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_FrontColor)
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_LineColor)
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_TitleBackColor)
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_ActiveTab)
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_InactiveTab)
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_EditBoxColor)
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_SplitterBorderColor)
        
        Select *ObjectTheme\PBGadgetType
          Case #PB_GadgetType_CheckBox, #PB_GadgetType_ComboBox, #PB_GadgetType_Frame, #PB_GadgetType_Option, #PB_GadgetType_Panel, #PB_GadgetType_Text, #PB_GadgetType_TrackBar
            _SetObjectBrush(\iBackColor, \iBrushBackColor, SavBackColor)
            
          Case #PB_GadgetType_ExplorerList, #PB_GadgetType_ListIcon
            _SetObjectBrush(\iBackColor, \iBrushBackColor, SavBackColor)
            SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_BackColor, \iBackColor)
            
          Case #PB_GadgetType_Calendar, #PB_GadgetType_Container, #PB_GadgetType_Date, #PB_GadgetType_Editor, #PB_GadgetType_HyperLink, #PB_GadgetType_ProgressBar,
               #PB_GadgetType_ExplorerTree, #PB_GadgetType_ListView, #PB_GadgetType_ScrollArea, #PB_GadgetType_Spin, #PB_GadgetType_String, #PB_GadgetType_Tree
            SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_BackColor, \iBackColor)
            
        EndSelect  
        ReturnValue = #True
        
      ; ---------- ActiveTabColor ----------
      Case #PB_Gadget_ActiveTab
        SavBackColor = \iActiveTabColor
        If Value = #PB_Default
          \iActiveTabColor = \iBackColor
        Else
          \iActiveTabColor = Value
        EndIf
        
        _SetObjectBrush(\iActiveTabColor, \iBrushActiveTabColor, SavBackColor)
        ReturnValue = #True
                
      ; ---------- InactiveTabColor ----------
      Case #PB_Gadget_InactiveTab
        SavBackColor = \iInactiveTabColor
        If Value = #PB_Default
          If IsDarkColorOT(\iBackColor) : \iInactiveTabColor = AccentColorOT(\iBackColor, 40) : Else : \iInactiveTabColor = AccentColorOT(\iBackColor, -40) : EndIf
        Else
          \iInactiveTabColor = Value
        EndIf
        
        _SetObjectBrush(\iInactiveTabColor, \iInactiveTabColor, SavBackColor)
        ReturnValue = #True
        
      ; ---------- HighLightColor ----------
      Case #PB_Gadget_HighLightColor
        SavBackColor = \iHighLightColor
        If Value = #PB_Default
          \iHighLightColor = GetSysColor_(#COLOR_HIGHLIGHT)
        Else
          \iHighLightColor = Value
        EndIf
        
        _SetObjectBrush(\iHighLightColor, \iBrushHighLightColor, SavBackColor)
        ReturnValue = #True
        
      ; ---------- EditBoxColor ----------
      Case #PB_Gadget_EditBoxColor
        SavBackColor = \iEditBoxColor
        If Value = #PB_Default
          If IsDarkColorOT(\iBackColor) : \iEditBoxColor = AccentColorOT(\iBackColor, 15) : Else : \iEditBoxColor = AccentColorOT(\iBackColor, -15) : EndIf
        Else
          \iEditBoxColor = Value
        EndIf
        
        _SetObjectBrush(\iEditBoxColor, \iBrushEditBoxColor, SavBackColor)
        ReturnValue = #True
        
        ; ---------- SplitterBorderColor ----------
      Case #PB_Gadget_SplitterBorderColor
        If Value = #PB_Default
          If IsDarkColorOT(\iBackColor) : \iSplitterBorderColor = AccentColorOT(\iBackColor, 60) : Else : \iSplitterBorderColor = AccentColorOT(\iBackColor, -60) : EndIf
        Else
          \iSplitterBorderColor = Value
        EndIf
        ReturnValue = #True
        
      ; ---------- FrontColor ----------
      Case #PB_Gadget_FrontColor
        If Value = #PB_Default
          Select *ObjectTheme\PBGadgetType
            Case #PB_GadgetType_ProgressBar
              If IsDarkColorOT(\iBackColor) : \iFrontColor = AccentColorOT(\iBackColor, 100) : Else : \iFrontColor = AccentColorOT(\iBackColor, -100) : EndIf
            Default
              If IsDarkColorOT(\iBackColor) : \iFrontColor = #White : Else : \iFrontColor = #Black : EndIf
          EndSelect
        Else
          \iFrontColor = Value
        EndIf
        
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_GrayTextColor)
        
        Select *ObjectTheme\PBGadgetType
          Case #PB_GadgetType_Calendar, #PB_GadgetType_Date, #PB_GadgetType_Editor, #PB_GadgetType_ExplorerList, #PB_GadgetType_ExplorerTree, 
             #PB_GadgetType_HyperLink, #PB_GadgetType_ListIcon, #PB_GadgetType_ListView, #PB_GadgetType_ProgressBar, #PB_GadgetType_Spin,
             #PB_GadgetType_String, #PB_GadgetType_Tree
            SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_FrontColor, \iFrontColor)
        EndSelect
        ReturnValue = #True
        
      ; ---------- GrayTextColor ----------
      Case #PB_Gadget_GrayTextColor
        If Value = #PB_Default
          If IsDarkColorOT(\iFrontColor) : \iGrayTextColor = DisabledDarkColorOT(\iFrontColor) : Else : \iGrayTextColor = DisabledLightColorOT(\iFrontColor) : EndIf
        Else
          \iGrayTextColor = Value
        EndIf
        ReturnValue = #True
        
      ; ---------- LineColor ----------
      Case #PB_Gadget_LineColor
        If Value = #PB_Default
          If IsDarkColorOT(\iBackColor) : \iLineColor = #White : Else : \iLineColor = #Black : EndIf
        Else
          \iLineColor = Value
        EndIf
        SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_LineColor, \iLineColor)   ; Display if #PB_Explorer_GridLines used
        ReturnValue = #True
        
      ; ---------- TitleBackColor ----------
      Case #PB_Gadget_TitleBackColor
        If Value = #PB_Default
          Select *ObjectTheme\PBGadgetType
            Case #PB_GadgetType_ExplorerList, #PB_GadgetType_ListIcon
              If IsDarkColorOT(\iBackColor) : \iTitleBackColor = AccentColorOT(\iBackColor, 40) : Else : \iTitleBackColor = AccentColorOT(\iBackColor, -40) : EndIf
            Case #PB_GadgetType_Calendar, #PB_GadgetType_Date
              \iTitleBackColor = \iBackColor
          EndSelect
        Else
          \iTitleBackColor = Value
        EndIf
        Select *ObjectTheme\PBGadgetType
          Case #PB_GadgetType_ExplorerList, #PB_GadgetType_ListIcon
            _SetObjectBrush(\iTitleBackColor, \iBrushTitleBackColor, SavBackColor)
          Case #PB_GadgetType_Calendar, #PB_GadgetType_Date
            SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_TitleBackColor, \iTitleBackColor)   ; Display if #PB_Explorer_GridLines used
        EndSelect
        
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_TitleFrontColor)
        ReturnValue = #True
        
      ; ---------- TitleFrontColor ----------
      Case #PB_Gadget_TitleFrontColor
        If Value = #PB_Default
          If IsDarkColorOT(\iTitleBackColor) : \iTitleFrontColor = #White : Else : \iTitleFrontColor = #Black : EndIf
        Else
          \iTitleFrontColor = Value
        EndIf
        SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_TitleFrontColor, \iTitleFrontColor)   ; Display if #PB_Explorer_GridLines used
        ReturnValue = #True
        
        ; ---------- SplitterBorder ----------
      Case #PB_Gadget_SplitterBorder
        If Value = #PB_Default
          \iSplitterBorder = #True
        Else
          \iSplitterBorder = Value
        EndIf
        ReturnValue = #True
        
        ; ---------- LargeGripper ----------
      Case #PB_Gadget_LargeGripper
        If Value = #PB_Default
          \iLargeGripper = #True
        Else
          \iLargeGripper = Value
        EndIf
        ReturnValue = #True
        
        ; ---------- GripperColor ----------
      Case  #PB_Gadget_GripperColor
        If Value = #PB_Default
          \iGripperColor = #True
          If IsDarkColorOT(\iBackColor): \iGripperColor = AccentColorOT(\iBackColor, 40) : Else : \iGripperColor = AccentColorOT(\iBackColor, -40) : EndIf
        Else
          \iGripperColor = Value
        EndIf
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_UseUxGripper)
        ReturnValue = #True
        
        ; ---------- UseUxGripper ----------
      Case #PB_Gadget_UseUxGripper
        If Value = #PB_Default
          \iUseUxGripper = #False
        Else
          \iUseUxGripper = Value
        EndIf
        If \iUseUxGripper = #False
          Protected SplitterImg
          If \iSplitterGripper : DeleteObject_(\iSplitterGripper) : EndIf   ; Delete the  Pattern Brush stored in GParentObjectID field
          If \iSplitterBorder
            SplitterImg = CreateImage(#PB_Any, DesktopScaledX(5), DesktopScaledY(5), 24, \iGripperColor)
          Else
            SplitterImg = CreateImage(#PB_Any, DesktopScaledX(5), DesktopScaledY(5), 24, \iBackColor)
          EndIf
          If StartDrawing(ImageOutput(SplitterImg))
            RoundBox(DesktopScaledX(1), DesktopScaledY(1), DesktopScaledX(3), DesktopScaledY(3), DesktopScaledX(1), DesktopScaledY(1), \iFrontColor)
            StopDrawing()
          EndIf
          \iSplitterGripper = CreatePatternBrush_(ImageID(SplitterImg))
          FreeImage(SplitterImg)
        EndIf
        ReturnValue = #True 
        
    EndSelect
  EndWith
  
  ;   If *ObjectTheme\PBGadgetType = #PB_GadgetType_TrackBar And Attribut = #PB_Gadget_BackColor
  ;     ; Workaround! The TrackBar background color does not refresh and I don't know why, when using : SetObjectThemeAttribute(0, #PB_Gadget_BackColor, $F48E3A) to change the window background color Theme
  ;     DisableGadget(*ObjectTheme\PBGadget, IsWindowEnabled_(*ObjectTheme\IDGadget)) : DisableGadget(*ObjectTheme\PBGadget, IsWindowEnabled_(*ObjectTheme\IDGadget))
  ;   EndIf
  If InitLevel
    With *ObjectTheme
      Select \PBGadgetType
        Case #PB_GadgetType_CheckBox, #PB_GadgetType_Option, #PB_GadgetType_TrackBar
          If IsWindowEnabled_(\IDGadget)
            SetWindowTheme_(\IDGadget, "", "")
          Else
            SetWindowTheme_(\IDGadget, "", 0)
          EndIf
        Case #PB_GadgetType_Calendar
          SetWindowTheme_(\IDGadget, "", "")
        Case #PB_GadgetType_ComboBox
          InvalidateRect_(\IDGadget, 0, 1)
        Case #PB_GadgetType_Editor
          SendMessage_(\IDGadget, #WM_ENABLE, IsWindowEnabled_(\IDGadget), 0)
        Case  #PB_GadgetType_Splitter
          RedrawWindow_(\IDGadget, #Null, #Null, #RDW_INVALIDATE | #RDW_ERASE | #RDW_UPDATENOW)
      EndSelect
    EndWith
  EndIf
  
  ;InvalidateRect_(*ObjectTheme\IDGadget, 0, 1)
  ProcedureReturn ReturnValue
EndProcedure

Procedure AddObjectTheme(Gadget, *ObjectTheme.ObjectTheme_INFO, UpdateTheme = #False)
  _ProcedureReturnIfOT(Not IsGadget(Gadget)) 
  Protected ObjectType.s, SavBackColor, DarkMode, ReturnValue
  
  With *ObjectTheme
    If Not UpdateTheme
      \PBGadget                = Gadget
      \IDGadget                = GadgetID(Gadget)
      \IDParent                = GetParent_(\IDGadget)
      \PBGadgetType            = GadgetType(Gadget)
      \ObjectInfo              = AllocateMemory(SizeOf(ObjectInfo_INFO))
    EndIf
    ObjectType                 = Str(\PBGadgetType) + "|"
  EndWith
  
  ; ---------- SetWindowTheme  ----------
  Select *ObjectTheme\PBGadgetType
    Case #PB_GadgetType_ComboBox, #PB_GadgetType_Editor, #PB_GadgetType_ExplorerList, #PB_GadgetType_ExplorerTree, #PB_GadgetType_ListIcon,
         #PB_GadgetType_ListView, #PB_GadgetType_ScrollArea, #PB_GadgetType_ScrollBar, #PB_GadgetType_Tree 
      DarkMode = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_DarkMode))
      If DarkMode = #PB_Default
        If IsDarkColorOT(GetObjectThemeAttribute(#PB_WindowType, #PB_Gadget_BackColor)) : DarkMode = #True : Else : DarkMode = #False : EndIf
      EndIf
      If DarkMode
        _SetDarkTheme(*ObjectTheme\IDGadget)
      Else
        _SetExplorerTheme(*ObjectTheme\IDGadget)
      EndIf
  EndSelect
  
  With *ObjectTheme\ObjectInfo
    ; ---------- BackColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_BackColor))
      SavBackColor  = \iBackColor
      \iBackColor   = ThemeAttribute()
      If \iBackColor = #PB_Default
        \iBackColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
        Select *ObjectTheme\PBGadgetType
          Case #PB_GadgetType_Editor, #PB_GadgetType_Spin, #PB_GadgetType_String
            If IsDarkColorOT(\iBackColor) : \iBackColor = AccentColorOT(\iBackColor, 15) : Else : \iBackColor = AccentColorOT(\iBackColor, -15) : EndIf
          Case #PB_GadgetType_ProgressBar
            If IsDarkColorOT(\iBackColor) : \iBackColor = AccentColorOT(\iBackColor, 40) : Else : \iBackColor = AccentColorOT(\iBackColor, -40) : EndIf
          Case #PB_GadgetType_Splitter
            If IsDarkColorOT(\iBackColor) : \iBackColor = AccentColorOT(\iBackColor, 30) : Else : \iBackColor = AccentColorOT(\iBackColor, -30) : EndIf
        EndSelect
      EndIf
      
      ; ----- Brush BackColor -----
      Select *ObjectTheme\PBGadgetType
        Case #PB_GadgetType_CheckBox, #PB_GadgetType_ComboBox, #PB_GadgetType_Frame, #PB_GadgetType_Option, #PB_GadgetType_Panel, #PB_GadgetType_Text, #PB_GadgetType_TrackBar
          _SetObjectBrush(\iBackColor, \iBrushBackColor, SavBackColor)
          
        Case #PB_GadgetType_ExplorerList, #PB_GadgetType_ListIcon
          _SetObjectBrush(\iBackColor, \iBrushBackColor, SavBackColor)
          SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_BackColor, \iBackColor)
          
        Case #PB_GadgetType_Calendar, #PB_GadgetType_Container, #PB_GadgetType_Date, #PB_GadgetType_Editor , #PB_GadgetType_HyperLink, #PB_GadgetType_ProgressBar,
             #PB_GadgetType_ExplorerTree, #PB_GadgetType_ListView, #PB_GadgetType_ScrollArea, #PB_GadgetType_Spin, #PB_GadgetType_String, #PB_GadgetType_Tree
          SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_BackColor, \iBackColor)
      EndSelect
    EndIf
    
    ; ---------- ActiveTabColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_ActiveTab))
      SavBackColor  = \iActiveTabColor
      \iActiveTabColor = ThemeAttribute()
      If \iActiveTabColor = #PB_Default
        \iActiveTabColor = \iBackColor
      EndIf
      
      _SetObjectBrush(\iActiveTabColor, \iBrushActiveTabColor, SavBackColor)
    EndIf
    
    ; ---------- InactiveTabColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_InactiveTab))
      SavBackColor  = \iInactiveTabColor
      \iInactiveTabColor = ThemeAttribute()
      If \iInactiveTabColor = #PB_Default
        If IsDarkColorOT(\iBackColor) : \iInactiveTabColor = AccentColorOT(\iBackColor, 40) : Else : \iInactiveTabColor = AccentColorOT(\iBackColor, -40) : EndIf
      EndIf
      
      _SetObjectBrush(\iInactiveTabColor, \iBrushInactiveTabColor, SavBackColor)
    EndIf
    
    ; ---------- HighLightColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_HighLightColor))
      SavBackColor  = \iHighLightColor
      \iHighLightColor = ThemeAttribute()
      If \iHighLightColor = #PB_Default
        \iHighLightColor = GetSysColor_(#COLOR_HIGHLIGHT)
      EndIf
      
      _SetObjectBrush(\iHighLightColor, \iBrushHighLightColor, SavBackColor)
    EndIf
    
    ; ---------- EditBoxColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_EditBoxColor))
      SavBackColor  = \iEditBoxColor
      \iEditBoxColor = ThemeAttribute()
      If \iEditBoxColor = #PB_Default
        If IsDarkColorOT(\iBackColor) : \iEditBoxColor = AccentColorOT(\iBackColor, 15) : Else : \iEditBoxColor = AccentColorOT(\iBackColor, -15) : EndIf
      EndIf
      
      _SetObjectBrush(\iEditBoxColor, \iBrushEditBoxColor, SavBackColor)
    EndIf
    
    ; ---------- SplitterBorderColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_SplitterBorderColor))
      \iSplitterBorderColor = ThemeAttribute()
      If \iSplitterBorderColor = #PB_Default
        If IsDarkColorOT(\iBackColor) : \iSplitterBorderColor = AccentColorOT(\iBackColor, 60) : Else : \iSplitterBorderColor = AccentColorOT(\iBackColor, -60) : EndIf
      EndIf
    EndIf
    
    ; ---------- FrontColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_FrontColor))
      \iFrontColor = ThemeAttribute()
      If \iFrontColor = #PB_Default
        Select *ObjectTheme\PBGadgetType
          Case #PB_GadgetType_ProgressBar
            If IsDarkColorOT(\iBackColor) : \iFrontColor = AccentColorOT(\iBackColor, 100) : Else : \iFrontColor = AccentColorOT(\iBackColor, -100) : EndIf
          Default
            If IsDarkColorOT(\iBackColor) : \iFrontColor = #White : Else : \iFrontColor = #Black : EndIf
        EndSelect
      EndIf
      
      Select *ObjectTheme\PBGadgetType
        Case #PB_GadgetType_Calendar, #PB_GadgetType_Date, #PB_GadgetType_Editor, #PB_GadgetType_ExplorerList, #PB_GadgetType_ExplorerTree, 
             #PB_GadgetType_HyperLink, #PB_GadgetType_ListIcon, #PB_GadgetType_ListView, #PB_GadgetType_ProgressBar, #PB_GadgetType_Spin,
             #PB_GadgetType_String, #PB_GadgetType_Tree
          SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_FrontColor, \iFrontColor)
      EndSelect
    EndIf
    
    ; ---------- GrayTextColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_GrayTextColor))
      \iGrayTextColor = ThemeAttribute()
      If \iGrayTextColor = #PB_Default
        If IsDarkColorOT(\iFrontColor) :\iGrayTextColor = DisabledDarkColorOT(\iFrontColor) : Else : \iGrayTextColor = DisabledLightColorOT(\iFrontColor) : EndIf
      EndIf
    EndIf
    
    ; ---------- LineColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_LineColor))
      \iLineColor = ThemeAttribute()
      If \iLineColor = #PB_Default
        If IsDarkColorOT(\iBackColor) : \iLineColor = #White : Else : \iLineColor = #Black : EndIf
      EndIf
      SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_LineColor, \iLineColor)   ; Display if #PB_Explorer_GridLines used
    EndIf
    
    ; ---------- TitleBackColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_TitleBackColor))
      \iTitleBackColor = ThemeAttribute()
      If \iTitleBackColor = #PB_Default
        Select *ObjectTheme\PBGadgetType
          Case #PB_GadgetType_ListIcon, #PB_GadgetType_ExplorerList
            If IsDarkColorOT(\iBackColor) : \iTitleBackColor = AccentColorOT(\iBackColor, 40) : Else : \iTitleBackColor = AccentColorOT(\iBackColor, -40) : EndIf
          Case #PB_GadgetType_Calendar, #PB_GadgetType_Date
            \iTitleBackColor = \iBackColor
        EndSelect
      EndIf
      Select *ObjectTheme\PBGadgetType
        Case #PB_GadgetType_ListIcon, #PB_GadgetType_ExplorerList
          _SetObjectBrush(\iTitleBackColor, \iBrushTitleBackColor, SavBackColor)
        Case #PB_GadgetType_Calendar, #PB_GadgetType_Date
          SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_TitleBackColor, \iTitleBackColor)   ; Display if #PB_Explorer_GridLines used
      EndSelect
      
      SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_TitleBackColor, \iTitleBackColor)   ; Display if #PB_Explorer_GridLines used
    EndIf    
    
    ; ---------- TitleFrontColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_TitleFrontColor))
      \iTitleFrontColor = ThemeAttribute()
      If \iTitleFrontColor = #PB_Default
        If IsDarkColorOT(\iTitleBackColor) : \iTitleFrontColor = #White : Else : \iTitleFrontColor = #Black : EndIf
      EndIf
      SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_TitleFrontColor, \iTitleFrontColor)   ; Display if #PB_Explorer_GridLines used
    EndIf 
     
    ; ---------- SplitterBorder ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_SplitterBorder))
      \iSplitterBorder = ThemeAttribute()
      If \iSplitterBorder = #PB_Default
        \iSplitterBorder = #True
      EndIf
    EndIf

    ; ---------- LargeGripper ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_LargeGripper))
      \iLargeGripper = ThemeAttribute()
      If \iLargeGripper = #PB_Default
        \iLargeGripper = #True
      EndIf
    EndIf
    
    ; ---------- GripperColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_GripperColor))
      \iGripperColor = ThemeAttribute()
      If \iGripperColor = #PB_Default
        If IsDarkColorOT(\iBackColor): \iGripperColor = AccentColorOT(\iBackColor, 40) : Else : \iGripperColor = AccentColorOT(\iBackColor, -40) : EndIf
      EndIf
    EndIf
    
    ; ---------- UseUxGripper ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_UseUxGripper))
      \iUseUxGripper = ThemeAttribute()
      If \iUseUxGripper = #PB_Default
        \iUseUxGripper = #False
      EndIf
      If \iUseUxGripper = #False
        Protected SplitterImg
        If \iSplitterGripper : DeleteObject_(\iSplitterGripper) : EndIf   ; Delete the  Pattern Brush stored in GParentObjectID field
        If \iSplitterBorder
          SplitterImg = CreateImage(#PB_Any, DesktopScaledX(5), DesktopScaledY(5), 24, \iGripperColor)
        Else
          SplitterImg = CreateImage(#PB_Any, DesktopScaledX(5), DesktopScaledY(5), 24, \iBackColor)
        EndIf
        If StartDrawing(ImageOutput(SplitterImg))
          RoundBox(DesktopScaledX(1), DesktopScaledY(1), DesktopScaledX(3), DesktopScaledY(3), DesktopScaledX(1), DesktopScaledY(1), \iFrontColor)
          StopDrawing()
        EndIf
        \iSplitterGripper = CreatePatternBrush_(ImageID(SplitterImg))
        FreeImage(SplitterImg)
      EndIf
    EndIf
    
  EndWith
  
  ; -----------------------------------------------------------------------------
  ; ----- Window Procedure -----
  ; -----------------------------------------------------------------------------
  ;
  With *ObjectTheme
    Select \PBGadgetType
      Case #PB_GadgetType_CheckBox, #PB_GadgetType_Frame, #PB_GadgetType_Option, #PB_GadgetType_Text, #PB_GadgetType_TrackBar
        If Not UpdateTheme
          \OldProc = GetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC)
          SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, @StaticProc())
        EndIf
        SendMessage_(\IDGadget, #WM_ENABLE, IsWindowEnabled_(\IDGadget), 0)
        Select \PBGadgetType
          Case #PB_GadgetType_CheckBox, #PB_GadgetType_Option, #PB_GadgetType_TrackBar
            If IsWindowEnabled_(\IDGadget)
              SetWindowTheme_(\IDGadget, "", "")
            Else
              SetWindowTheme_(\IDGadget, "", 0)
            EndIf
          Case #PB_GadgetType_Frame
            SetWindowTheme_(\IDGadget, "", "")
          Case #PB_GadgetType_Text
            SetWindowTheme_(\IDGadget, "", 0)
        EndSelect
        
      Case #PB_GadgetType_Calendar
        If Not UpdateTheme
          \OldProc = GetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC)
          SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, @CalendarProc())
        EndIf
        SetWindowTheme_(\IDGadget, "", "")
        
      Case #PB_GadgetType_Editor
        If Not UpdateTheme
          \OldProc = GetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC)
          SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, @EditorProc())
        EndIf
        SendMessage_(\IDGadget, #WM_ENABLE, IsWindowEnabled_(\IDGadget), 0)
        
      Case #PB_GadgetType_ExplorerList, #PB_GadgetType_ListIcon
        If Not UpdateTheme
          \OldProc = GetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC)
          SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, @ListIconProc())
        EndIf
        
      Case #PB_GadgetType_Panel
        If Not UpdateTheme
          SetWindowLongPtr_(\IDGadget, #GWL_STYLE, GetWindowLongPtr_(\IDGadget, #GWL_STYLE) | #TCS_OWNERDRAWFIXED)
          \OldProc = GetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC)
          SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, @PanelProc())
        EndIf
      
      Case #PB_GadgetType_ComboBox
        ;InvalidateRect_(*ObjectTheme\IDGadget, 0, 1)   ; Not required here
        
      Case #PB_GadgetType_Date
        ;SetWindowTheme_(IDSysDateTimePick32, "", "")    ; Class "SysDateTimePick32"
        ;SetThemeAppProperties_(1)   ; No, otherwise the "DarkMode_Explorer" theme is not displayed for ScrollBars. Otherwise it's not too bad for the Date window size 
        
      Case #PB_GadgetType_ListView
        SetWindowLongPtr_(\IDGadget, #GWL_EXSTYLE, GetWindowLongPtr_(\IDGadget, #GWL_EXSTYLE) &~ #WS_EX_CLIENTEDGE)
        SetWindowLongPtr_(\IDGadget, #GWL_STYLE, GetWindowLongPtr_(\IDGadget, #GWL_STYLE) | #WS_BORDER)
        
      Case  #PB_GadgetType_Splitter
        If Not UpdateTheme
          SetClassLongPtr_(\IDGadget, #GCL_STYLE, GetClassLongPtr_(\IDGadget, #GCL_STYLE) | #CS_DBLCLKS)
          SetWindowLongPtr_(\IDGadget, #GWL_STYLE, GetWindowLongPtr_(\IDGadget, #GWL_STYLE) | #WS_CLIPCHILDREN)
          \OldProc = GetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC)
          SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, @SplitterProc())
        EndIf
        ;RedrawWindow_(\IDGadget, #Null, #Null, #RDW_INVALIDATE | #RDW_ERASE | #RDW_UPDATENOW) ; Not required here
            
      Case #PB_GadgetType_ProgressBar
        SetWindowTheme_(\IDGadget, "", "")
        
    EndSelect
  EndWith
  
  ProcedureReturn ReturnValue
EndProcedure

;
; -----------------------------------------------------------------------------
;- ----- Object Button Private -----
; -----------------------------------------------------------------------------
;

Procedure ButtonThemeProc(hWnd, uMsg, wParam, lParam)
  
  If FindMapElement(ObjectTheme(), Str(hWnd))
    Protected *ObjectTheme.ObjectTheme_INFO = @ObjectTheme()
    Protected OldProc = *ObjectTheme\OldProc
  Else
    ProcedureReturn DefWindowProc_(hWnd, uMsg, wParam, lParam)
  EndIf
  Protected cX, cY, Margin = 6, Xofset, Yofset, HFlag, VFlag, Text.s, TextLen, TxtHeight, In_Button_Rect, hDC_to_use, Change_Image
  Protected CursorPos.POINT, ps.PAINTSTRUCT, Rect.RECT
  
  Select uMsg
      
    Case #WM_DESTROY
      FreeButtonTheme(*ObjectTheme\IDGadget)
      
    Case #WM_TIMER
      Select wParam
        Case 124
          If GetAsyncKeyState_(#VK_LBUTTON) & $8000 <> $8000
            KillTimer_(hWnd, 124)
            *ObjectTheme\BtnInfo\bClickTimer = #False
            *ObjectTheme\BtnInfo\bHiLiteTimer = #False
            InvalidateRect_(hWnd, 0, 1)
          EndIf
        Case 123
          GetCursorPos_(@CursorPos)
          ScreenToClient_(*ObjectTheme\IDParent, @CursorPos)
          In_Button_Rect   = #True
          If CursorPos\x < DesktopScaledX(GadgetX(*ObjectTheme\PBGadget)) Or CursorPos\x > DesktopScaledX(GadgetX(*ObjectTheme\PBGadget) + GadgetWidth(*ObjectTheme\PBGadget))
            In_Button_Rect = #False
          EndIf
          If CursorPos\y < DesktopScaledY(GadgetY(*ObjectTheme\PBGadget)) Or CursorPos\y > DesktopScaledY(GadgetY(*ObjectTheme\PBGadget) + GadgetHeight(*ObjectTheme\PBGadget))
            In_Button_Rect = #False
          EndIf
          If Not In_Button_Rect
            KillTimer_(hWnd, 123)
            *ObjectTheme\BtnInfo\bMouseOver = #False
            *ObjectTheme\BtnInfo\bHiLiteTimer = #False
            InvalidateRect_(hWnd, 0, 1)
          Else
            Delay(1)
          EndIf
      EndSelect
      
    Case #WM_MOUSEMOVE
      GetCursorPos_(@CursorPos)
      ScreenToClient_(*ObjectTheme\IDParent, @CursorPos)
      In_Button_Rect     = #True
      If CursorPos\x < DesktopScaledX(GadgetX(*ObjectTheme\PBGadget)) Or CursorPos\x > DesktopScaledX(GadgetX(*ObjectTheme\PBGadget) + GadgetWidth(*ObjectTheme\PBGadget))
        In_Button_Rect   = #False
      EndIf
      If CursorPos\y < DesktopScaledY(GadgetY(*ObjectTheme\PBGadget)) Or CursorPos\y > DesktopScaledY(GadgetY(*ObjectTheme\PBGadget) + GadgetHeight(*ObjectTheme\PBGadget))
        In_Button_Rect   = #False
      EndIf
      If In_Button_Rect = #True And Not *ObjectTheme\BtnInfo\bMouseOver
        *ObjectTheme\BtnInfo\bMouseOver = #True
        *ObjectTheme\BtnInfo\bHiLiteTimer = #True
        SetTimer_(hWnd, 123, 50, #Null)
        InvalidateRect_(hWnd, 0, 1)
      EndIf
      
    Case #WM_LBUTTONDOWN
      If Not *ObjectTheme\BtnInfo\bClickTimer
        *ObjectTheme\BtnInfo\bClickTimer = #True
        SetTimer_(hWnd, 124, 100, #Null)
        If (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_PUSHLIKE = #BS_PUSHLIKE)
          *ObjectTheme\BtnInfo\bButtonState  = *ObjectTheme\BtnInfo\bButtonState ! 1
        EndIf
        InvalidateRect_(hWnd, 0, 1)
      EndIf
      
    Case #WM_ENABLE
      *ObjectTheme\BtnInfo\bButtonEnable = wParam
      InvalidateRect_(hWnd, 0, 1)
      ProcedureReturn 0
      
    Case #WM_WINDOWPOSCHANGED
      DeleteObject_(*ObjectTheme\BtnInfo\hRgn)
      ;*ObjectTheme\BtnInfo\hRgn  = CreateRoundRectRgn_(0, 0, DesktopScaledX(GadgetWidth(*ObjectTheme\PBGadget)), DesktopScaledY(GadgetHeight(*ObjectTheme\PBGadget)), *ObjectTheme\BtnInfo\iRoundX, *ObjectTheme\BtnInfo\iRoundY)
      *ObjectTheme\BtnInfo\hRgn = CreateRectRgn_(0, 0, DesktopScaledX(GadgetWidth(*ObjectTheme\PBGadget)), DesktopScaledY(GadgetHeight(*ObjectTheme\PBGadget)))
      ChangeButtonTheme(*ObjectTheme\PBGadget)   ; Or with UpdateButtonTheme(ObjectTheme())
      
    Case #WM_SETTEXT
      *ObjectTheme\BtnInfo\sButtonText = PeekS(lParam)
      DefWindowProc_(hWnd, uMsg, wParam, lParam)
      InvalidateRect_(hWnd, 0, 0)
      ProcedureReturn 1
      
    Case #BM_SETCHECK
      If (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_PUSHLIKE = #BS_PUSHLIKE)
        *ObjectTheme\BtnInfo\bButtonState = wParam
        InvalidateRect_(hWnd, 0, 0)
      EndIf
      
    Case #BM_GETCHECK
      ProcedureReturn *ObjectTheme\BtnInfo\bButtonState
      
    Case #WM_SETFONT
      *ObjectTheme\BtnInfo\iActiveFont = wParam
      InvalidateRect_(hWnd, 0, 0)
      
    Case #WM_PAINT
      cX                = DesktopScaledX(GadgetWidth(*ObjectTheme\PBGadget))
      cY                = DesktopScaledY(GadgetHeight(*ObjectTheme\PBGadget))
      Xofset            = 0
      Yofset            = 0
      
      GetCursorPos_(@CursorPos)
      ScreenToClient_(*ObjectTheme\IDParent, @CursorPos)
      In_Button_Rect     = #True
      If CursorPos\x < DesktopScaledX(GadgetX(*ObjectTheme\PBGadget)) Or CursorPos\x > DesktopScaledX(GadgetX(*ObjectTheme\PBGadget) + GadgetWidth(*ObjectTheme\PBGadget))
        In_Button_Rect   = #False
      EndIf
      If CursorPos\y < DesktopScaledY(GadgetY(*ObjectTheme\PBGadget)) Or CursorPos\y > DesktopScaledY(GadgetY(*ObjectTheme\PBGadget) + GadgetHeight(*ObjectTheme\PBGadget))
        In_Button_Rect   = #False
      EndIf
      
      If (*ObjectTheme\BtnInfo\bClickTimer And In_Button_Rect = #True)
        ; Invert Regular And pressed images during the Click Timer, to better see click action
        If *ObjectTheme\BtnInfo\bButtonState
          hDC_to_use    = *ObjectTheme\BtnInfo\hDcRegular
        Else
          hDC_to_use    = *ObjectTheme\BtnInfo\hDcPressed
        EndIf
        Xofset          = 1
        Yofset          = 1
      ElseIf *ObjectTheme\BtnInfo\bHiLiteTimer
        If *ObjectTheme\BtnInfo\bButtonState
          hDC_to_use      = *ObjectTheme\BtnInfo\hDcHiPressed
        Else
          hDC_to_use      = *ObjectTheme\BtnInfo\hDcHiLite
        EndIf
      Else
        If *ObjectTheme\BtnInfo\bButtonEnable  = 0
          hDC_to_use    = *ObjectTheme\BtnInfo\hDcDisabled
        ElseIf *ObjectTheme\BtnInfo\bButtonState
          hDC_to_use    = *ObjectTheme\BtnInfo\hDcPressed
        Else
          hDC_to_use    = *ObjectTheme\BtnInfo\hDcRegular
        EndIf
      EndIf
      
      BeginPaint_(hWnd, @ps.PAINTSTRUCT)
      
      ; Calculate text height for multiline buttons, then adapt rectangle to center text vertically (DT_VCenter doesn't do the trick)
      ; It must be done before BitBlt() to be overwritten
      If (*ObjectTheme\BtnInfo\sButtonText <> "") And (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_MULTILINE = #BS_MULTILINE) 
        Text  = *ObjectTheme\BtnInfo\sButtonText
        TextLen = Len(Text)
        SelectObject_(ps\hdc, *ObjectTheme\BtnInfo\iActiveFont)
        SetBkMode_(ps\hdc, #TRANSPARENT)
        SetTextColor_(ps\hdc, *ObjectTheme\BtnInfo\iFrontColor)
        Rect\left       = Xofset + Margin
        Rect\top        = Yofset + Margin
        Rect\right      = cX + Xofset - Margin
        Rect\bottom     = cY + Yofset - Margin
        TxtHeight = DrawText_(ps\hdc, @Text, TextLen, @Rect, #DT_CENTER | #DT_VCENTER | #DT_WORDBREAK)
      EndIf
      
      SelectClipRgn_(ps\hdc, *ObjectTheme\BtnInfo\hRgn)
      BitBlt_(ps\hdc, 0, 0, cX, cY, hDC_to_use, 0, 0, #SRCCOPY)
      
      If *ObjectTheme\BtnInfo\sButtonText <> ""
        Text  = *ObjectTheme\BtnInfo\sButtonText
        TextLen = Len(Text)
        If (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & (#BS_LEFT | #BS_RIGHT) = (#BS_LEFT | #BS_RIGHT)) : HFlag | #DT_CENTER
        ElseIf (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_LEFT = #BS_LEFT)                         : HFlag | #DT_LEFT
        ElseIf (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_RIGHT = #BS_RIGHT)                       : HFlag | #DT_RIGHT
        Else                                                                                                      : HFlag | #DT_CENTER
        EndIf
        If (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & (#BS_TOP | #BS_BOTTOM) = (#BS_TOP | #BS_BOTTOM)) : VFlag | #DT_VCENTER
        ElseIf (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_TOP = #BS_TOP)                           : VFlag | #DT_TOP
        ElseIf (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_BOTTOM = #BS_BOTTOM)                     : VFlag | #DT_BOTTOM
        Else                                                                                                      : VFlag | #DT_VCENTER
        EndIf
        If (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_MULTILINE = #BS_MULTILINE) 
          VFlag | #DT_WORDBREAK
        Else  
          VFlag | #DT_SINGLELINE
        EndIf
        
        SelectObject_(ps\hdc, *ObjectTheme\BtnInfo\iActiveFont)
        SetBkMode_(ps\hdc, #TRANSPARENT)
        
        If ObjectTheme()\BtnInfo\bEnableShadow
          SetTextColor_(ps\hdc, *ObjectTheme\BtnInfo\iShadowColor)
          Rect\left     = 1 + Xofset + Margin
          Rect\top      = 1 + Yofset + Margin
          Rect\right    = cX + 1 + Xofset - Margin
          Rect\bottom   = cY + 1 + Yofset - Margin
          If  VFlag & #DT_WORDBREAK = #DT_WORDBREAK
            If VFlag & #DT_VCENTER = #DT_VCENTER
              Rect\top + (Rect\bottom - Rect\top - TxtHeight) / 2 
              Rect\bottom - (Rect\bottom - Rect\top - TxtHeight)
            ElseIf VFlag & #DT_BOTTOM = #DT_BOTTOM
              Rect\top + (Rect\bottom - TxtHeight) - Margin
            EndIf
          EndIf
          DrawText_(ps\hdc, @Text, TextLen, @Rect, HFlag | VFlag)
        EndIf
        
        If *ObjectTheme\BtnInfo\bButtonEnable
          SetTextColor_(ps\hdc, *ObjectTheme\BtnInfo\iFrontColor)
        Else
          SetTextColor_(ps\hdc, *ObjectTheme\BtnInfo\iGrayTextColor)
        EndIf
        Rect\left       = Xofset + Margin
        Rect\top        = Yofset + Margin
        Rect\right      = cX + Xofset - Margin
        Rect\bottom     = cY + Yofset - Margin
        If  VFlag & #DT_WORDBREAK = #DT_WORDBREAK
          If VFlag & #DT_VCENTER = #DT_VCENTER
            Rect\top + (Rect\bottom - Rect\top - TxtHeight) / 2 
            Rect\bottom - (Rect\bottom - Rect\top - TxtHeight)
          ElseIf VFlag & #DT_BOTTOM = #DT_BOTTOM
            Rect\top + (Rect\bottom - TxtHeight) - Margin
          EndIf
        EndIf
        DrawText_(ps\hdc, @Text, TextLen, @Rect, HFlag | VFlag)
        
      EndIf
      EndPaint_(hWnd, @ps)
      ProcedureReturn #True
      
    Case #WM_PRINT
      cX                = DesktopScaledX(GadgetWidth(*ObjectTheme\PBGadget))
      cY                = DesktopScaledY(GadgetHeight(*ObjectTheme\PBGadget))
      
      If *ObjectTheme\BtnInfo\bButtonEnable  = 0
        hDC_to_use      = *ObjectTheme\BtnInfo\hDcDisabled
      ElseIf *ObjectTheme\BtnInfo\bButtonState
        hDC_to_use      = *ObjectTheme\BtnInfo\hDcPressed
      Else
        hDC_to_use      = *ObjectTheme\BtnInfo\hDcRegular
      EndIf
      
      ; Calculate text height for multiline buttons, then adapt rectangle to center text vertically (DT_VCenter doesn't do the trick)
      ; It must be done before BitBlt() to be overwritten
      If (*ObjectTheme\BtnInfo\sButtonText <> "") And (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_MULTILINE = #BS_MULTILINE) 
        Text  = *ObjectTheme\BtnInfo\sButtonText
        TextLen = Len(Text)
        SelectObject_(wParam, *ObjectTheme\BtnInfo\iActiveFont)
        SetBkMode_(wParam, #TRANSPARENT)
        SetTextColor_(wParam, *ObjectTheme\BtnInfo\iFrontColor)
        Rect\left       = Xofset + Margin
        Rect\top        = Yofset + Margin
        Rect\right      = cX + Xofset - Margin
        Rect\bottom     = cY + Yofset - Margin
        TxtHeight = DrawText_(wParam, @Text, TextLen, @Rect, #DT_CENTER | #DT_VCENTER | #DT_WORDBREAK)
      EndIf
      
      SelectClipRgn_(wParam, *ObjectTheme\BtnInfo\hRgn)
      BitBlt_(wParam, 0, 0, cX, cY, hDC_to_use, 0, 0, #SRCCOPY)
      
      If *ObjectTheme\BtnInfo\sButtonText <> ""
        Text           = *ObjectTheme\BtnInfo\sButtonText
        TextLen        = Len(Text)
        If (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & (#BS_LEFT | #BS_RIGHT) = (#BS_LEFT | #BS_RIGHT)) : HFlag | #DT_CENTER
        ElseIf (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_LEFT = #BS_LEFT)                         : HFlag | #DT_LEFT
        ElseIf (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_RIGHT = #BS_RIGHT)                       : HFlag | #DT_RIGHT
        Else                                                                                                      : HFlag | #DT_CENTER
        EndIf
        If (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & (#BS_TOP | #BS_BOTTOM) = (#BS_TOP | #BS_BOTTOM)) : VFlag | #DT_VCENTER
        ElseIf (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_TOP = #BS_TOP)                           : VFlag | #DT_TOP
        ElseIf (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_BOTTOM = #BS_BOTTOM)                     : VFlag | #DT_BOTTOM
        Else                                                                                                      : VFlag | #DT_VCENTER
        EndIf
        If (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_MULTILINE = #BS_MULTILINE) 
          VFlag | #DT_WORDBREAK
        Else  
          VFlag | #DT_SINGLELINE
        EndIf
        
        SelectObject_(wParam, *ObjectTheme\BtnInfo\iActiveFont)
        SetBkMode_(wParam, #TRANSPARENT)
        
        If ObjectTheme()\BtnInfo\bEnableShadow
          SetTextColor_(wParam, *ObjectTheme\BtnInfo\iShadowColor)
          Rect\left     = 1 + Xofset + Margin
          Rect\top      = 1 + Yofset + Margin
          Rect\right    = cX + 1 + Xofset - Margin
          Rect\bottom   = cY + 1 + Yofset - Margin
          If  VFlag & #DT_WORDBREAK = #DT_WORDBREAK
            If VFlag & #DT_VCENTER = #DT_VCENTER
              Rect\top + (Rect\bottom - Rect\top - TxtHeight) / 2 
              Rect\bottom - (Rect\bottom - Rect\top - TxtHeight)
            ElseIf VFlag & #DT_BOTTOM = #DT_BOTTOM
              Rect\top + (Rect\bottom - TxtHeight) - Margin
            EndIf
          EndIf
          DrawText_(wParam, @Text, TextLen, @Rect, HFlag | VFlag)
        EndIf
        
        If *ObjectTheme\BtnInfo\bButtonEnable
          SetTextColor_(wParam, *ObjectTheme\BtnInfo\iFrontColor)
        Else
          SetTextColor_(wParam, *ObjectTheme\BtnInfo\iGrayTextColor)
        EndIf
        Rect\left       = Xofset + Margin
        Rect\top        = Yofset + Margin
        Rect\right      = cX + Xofset - Margin
        Rect\bottom     = cY + Yofset - Margin
        If  VFlag & #DT_WORDBREAK = #DT_WORDBREAK
          If VFlag & #DT_VCENTER = #DT_VCENTER
            Rect\top + (Rect\bottom - Rect\top - TxtHeight) / 2 
            Rect\bottom - (Rect\bottom - Rect\top - TxtHeight)
          ElseIf VFlag & #DT_BOTTOM = #DT_BOTTOM
            Rect\top + (Rect\bottom - TxtHeight) - Margin
          EndIf
        EndIf
        DrawText_(wParam, @Text, TextLen, @Rect, HFlag | VFlag)
      EndIf
      ProcedureReturn #True
      
    Case #WM_ERASEBKGND
      ProcedureReturn #True
      
  EndSelect
  ProcedureReturn CallWindowProc_(OldProc, hWnd, uMsg, wParam, lParam)
EndProcedure

Procedure MakeButtonTheme(cX, cY, *ObjectTheme.ObjectTheme_INFO)
  Protected *ThisImage, I
  
  With *ObjectTheme\BtnInfo
    Protected ButtonBackColor = \iButtonBackColor
    
    ; DPIaware Images size. The image size must be greater than 0 To avoid an error when resizing  
    cX = DesktopScaledX(cX) : cY = DesktopScaledY(cY)
    If cX = 0 : cX = 1 : EndIf
    If cY = 0 : cY = 1 : EndIf
    
    If \imgRegular   And IsImage(\imgRegular)   : FreeImage(\imgRegular)   : EndIf
    If \imgHilite    And IsImage(\imgHilite)    : FreeImage(\imgHilite)    : EndIf
    If \imgPressed   And IsImage(\imgPressed)   : FreeImage(\imgPressed)   : EndIf
    If \imgHiPressed And IsImage(\imgHiPressed) : FreeImage(\imgHiPressed) : EndIf
    If \imgDisabled  And IsImage(\imgDisabled)  : FreeImage(\imgDisabled)  : EndIf
    
    \imgRegular   = CreateImage(#PB_Any, cX, cY, 32)
    \imgHilite    = CreateImage(#PB_Any, cX, cY, 32)
    \imgPressed   = CreateImage(#PB_Any, cX, cY, 32)
    \imgHiPressed = CreateImage(#PB_Any, cX, cY, 32)
    \imgDisabled  = CreateImage(#PB_Any, cX, cY, 32)
    
    For I = 0 To 4
      Select I
        Case 0
          *ThisImage  = \imgRegular
        Case 1
          *ThisImage  = \imgHilite
        Case 2
          *ThisImage  = \imgPressed
        Case 3
          *ThisImage  = \imgHiPressed
        Case 4
          *ThisImage  = \imgDisabled
          ButtonBackColor = \iGrayBackColor
      EndSelect
      
      If StartDrawing(ImageOutput(*ThisImage))
        
        Box(0, 0, cX, cY, \iButtonCornerColor)
        RoundBox(0, 0, cX, cY, \iRoundX, \iRoundY, ButtonBackColor | $80000000)
        DrawingMode(#PB_2DDrawing_Gradient | #PB_2DDrawing_AlphaBlend)
        
        ; Draw an ellipse a little wider than the button and slightly offset upwards, to have a gradient with the background color in the 4 corners and more important at the bottom
        EllipticalGradient(cX / 2, cY * 2 / 5, cX * 3 / 5, cY * 4 / 5)
        GradientColor(0.0, ButtonBackColor | $BE000000)
        Select I
          Case 0, 4   ; imgRegular, imgDisabled
            GradientColor(0.15, ButtonBackColor | $BE000000)
          Case 1, 3   ; imgHilite, imgHiPressed
            GradientColor(0.3,  ButtonBackColor | $BE000000)
          Case 2      ; imgPressed
            GradientColor(0.45, ButtonBackColor | $BE000000)
        EndSelect
        GradientColor(1.0,  \iButtonOuterColor | $BE000000)
        RoundBox(0, 0, cX, cY, \iRoundX, \iRoundY)
        
        ; Border drawn with button color and an inner 1 px border with background color (full inside or top left or bottom right)
        DrawingMode(#PB_2DDrawing_Outlined)
        RoundBox(0, 0, cX, cY, \iRoundX, \iRoundY, \iBorderColor)
        Select I
          Case 0, 4     ; imgRegular, imgDisabled
            RoundBox(1, 1, cX-2, cY-2, \iRoundX, \iRoundY, \iButtonOuterColor)
          Case 1, 3     ; imgHilite, imgHiPressed
            RoundBox(1, 1, cX-2, cY-2, \iRoundX, \iRoundY, \iBorderColor)
            RoundBox(2, 2, cX-4, cY-4, \iRoundX, \iRoundY, \iButtonOuterColor)
          Case 2        ; imgPressed
            RoundBox(1, 1, cX-2, cY-2, \iRoundX, \iRoundY, \iBorderColor)
            RoundBox(2, 2, cX-4, cY-4, \iRoundX, \iRoundY, \iBorderColor)
            RoundBox(3, 3, cX-6, cY-6, \iRoundX, \iRoundY, \iButtonOuterColor)
        EndSelect
        
        StopDrawing()
      EndIf
    Next
    
    SelectObject_(\hDcRegular,   ImageID(\imgRegular))
    SelectObject_(\hDcHiLite,    ImageID(\imgHilite))
    SelectObject_(\hDcPressed,   ImageID(\imgPressed))
    SelectObject_(\hDcHiPressed, ImageID(\imgHiPressed))
    SelectObject_(\hDcDisabled,  ImageID(\imgDisabled))
  EndWith
  
EndProcedure

Procedure MakeButtonImageTheme(cX, cY, *ObjectTheme.ObjectTheme_INFO)
  Protected *ThisImage, I
  
  With *ObjectTheme\BtnInfo
    Protected ButtonBackColor = \iButtonBackColor
    
    ; DPIaware Images size. The image size must be greater than 0 To avoid an error when resizing  
    cX = DesktopScaledX(cX) : cY = DesktopScaledY(cY)
    If cX = 0 : cX = 1 : EndIf
    If cY = 0 : cY = 1 : EndIf
    
    If \imgRegular   And IsImage(\imgRegular)   : FreeImage(\imgRegular)   : EndIf
    If \imgHilite    And IsImage(\imgHilite)    : FreeImage(\imgHilite)    : EndIf
    If \imgPressed   And IsImage(\imgPressed)   : FreeImage(\imgPressed)   : EndIf
    If \imgHiPressed And IsImage(\imgHiPressed) : FreeImage(\imgHiPressed) : EndIf
    If \imgDisabled  And IsImage(\imgDisabled)  : FreeImage(\imgDisabled)  : EndIf
    
    \imgRegular   = CreateImage(#PB_Any, cX, cY, 32)
    \imgHilite    = CreateImage(#PB_Any, cX, cY, 32)
    \imgPressed   = CreateImage(#PB_Any, cX, cY, 32)
    \imgHiPressed = CreateImage(#PB_Any, cX, cY, 32)
    \imgDisabled  = CreateImage(#PB_Any, cX, cY, 32)
    
    For I = 0 To 4
      Select I
        Case 0
          *ThisImage  = \imgRegular
        Case 1
          *ThisImage  = \imgHilite
        Case 2
          *ThisImage  = \imgPressed
        Case 3
          *ThisImage  = \imgHiPressed
        Case 4
          *ThisImage  = \imgDisabled
          ButtonBackColor = \iGrayBackColor
      EndSelect
      
      If StartDrawing(ImageOutput(*ThisImage))
        
        Select I
          Case 0, 1
            If \iButtonImageID And IsImage(\iButtonImage)
              DrawImage(\iButtonImageID, 0, 0, cX, cY)
            Else
              Box(0, 0, cX, cY, GetSysColor_(#COLOR_3DFACE))
            EndIf
          Case 2, 3
            If \iButtonPressedImageID And IsImage(\iButtonPressedImage)
              DrawImage(\iButtonPressedImageID, 0, 0, cX, cY)
            Else
              Box(0, 0, cX, cY, GetSysColor_(#COLOR_3DFACE))  
            EndIf
          Case 4
            If \iButtonImageID And IsImage(\iButtonImage)
              DrawImage(\iButtonImageID, 0, 0, cX, cY)
            Else
              Box(0, 0, cX, cY, GetSysColor_(#COLOR_3DFACE))
            EndIf
            DrawingMode(#PB_2DDrawing_CustomFilter)
            CustomFilterCallback(@ScaleGrayCallbackOT())
            Box(0, 0, cX, cY)
        EndSelect
        
        ; Draw a transparent ellipse a little wider than the button and slightly offset upwards, to have a gradient with the background color in the 4 corners and more important at the bottom
        Select I
          Case 1, 3     ; imgHilite, imgHiPressed
            DrawingMode(#PB_2DDrawing_Gradient | #PB_2DDrawing_AlphaBlend)
            EllipticalGradient(cX / 2, cY * 2 / 5, cX * 3 / 5, cY * 4 / 5)
            GradientColor(0.0, ButtonBackColor | $14000000)
            GradientColor(0.3, ButtonBackColor | $14000000)
            GradientColor(1.0, \iButtonOuterColor | $14000000)
            ;GradientColor(1.0, \iButtonCornerColor | $14000000) 
            RoundBox(0, 0, cX, cY, \iRoundX, \iRoundY)
        EndSelect
        
        ; Fill outside RoundBox border, corner with background color
        DrawingMode(#PB_2DDrawing_Outlined)
        RoundBox(1, 1, cX-2, cY-2, \iRoundX, \iRoundY, $B200FF)
        FillArea(0, 0, $B200FF, \iButtonOuterColor)
        RoundBox(1, 1, cX-2, cY-2, \iRoundX, \iRoundY, #Black)
        FillArea(0, 0, #Black, \iButtonCornerColor)
        
        ; Border drawn with button color and an inner 1 px border with background color (full inside or top left or bottom right)
        RoundBox(0, 0, cX, cY, \iRoundX, \iRoundY, \iBorderColor)
        Select I
          Case 0, 4     ; imgRegular, imgDisabled
            RoundBox(1, 1, cX-2, cY-2, \iRoundX, \iRoundY, \iButtonOuterColor)
          Case 1, 3     ; imgHilite, imgHiPressed
            RoundBox(1, 1, cX-2, cY-2, \iRoundX, \iRoundY, \iBorderColor)
            RoundBox(2, 2, cX-4, cY-4, \iRoundX, \iRoundY, \iButtonOuterColor)
          Case 2        ; imgPressed
            RoundBox(1, 1, cX-2, cY-2, \iRoundX, \iRoundY, \iBorderColor)
            RoundBox(2, 2, cX-4, cY-4, \iRoundX, \iRoundY, \iBorderColor)
            RoundBox(3, 3, cX-6, cY-6, \iRoundX, \iRoundY, \iButtonOuterColor)
        EndSelect
        
        StopDrawing()
      EndIf
    Next
    
    SelectObject_(\hDcRegular,   ImageID(\imgRegular))
    SelectObject_(\hDcHiLite,    ImageID(\imgHilite))
    SelectObject_(\hDcPressed,   ImageID(\imgPressed))
    SelectObject_(\hDcHiPressed, ImageID(\imgHiPressed))
    SelectObject_(\hDcDisabled,  ImageID(\imgDisabled))
  EndWith
  
EndProcedure

Procedure ChangeButtonTheme(Gadget)
  Protected ReturnValue
  Protected *ObjectTheme.ObjectTheme_INFO : _ObjectThemeID(*ObjectTheme, GadgetID(Gadget), #False)
  
  ; DesktopScaledX(Y) is done in MakeButtonTheme
  Select *ObjectTheme\PBGadgetType
    Case #PB_GadgetType_Button
      MakeButtonTheme(GadgetWidth(Gadget), GadgetHeight(Gadget), ObjectTheme())
    Case #PB_GadgetType_ButtonImage
      MakeButtonImageTheme(GadgetWidth(Gadget), GadgetHeight(Gadget), ObjectTheme())
  EndSelect
  
  With *ObjectTheme\BtnInfo
    SelectObject_(\hDcRegular,   ImageID(\imgRegular))
    SelectObject_(\hDcHiLite,    ImageID(\imgHilite))
    SelectObject_(\hDcPressed,   ImageID(\imgPressed))
    SelectObject_(\hDcHiPressed, ImageID(\imgHiPressed))
    SelectObject_(\hDcDisabled,  ImageID(\imgDisabled))
  EndWith
  InvalidateRect_(*ObjectTheme\IDGadget, 0, 0)
  ReturnValue = #True
  
  ProcedureReturn ReturnValue
EndProcedure

Procedure UpdateButtonTheme(*ObjectTheme.ObjectTheme_INFO)
  Protected hGenDC, CancelOut, ReturnValue
  
  With *ObjectTheme\BtnInfo
    SelectObject_(\hDcRegular,   \hObjRegular)   : DeleteDC_(\hDcRegular)
    SelectObject_(\hDcHiLite,    \hObjHiLite)    : DeleteDC_(\hDcHiLite)
    SelectObject_(\hDcPressed,   \hObjPressed)   : DeleteDC_(\hDcPressed)
    SelectObject_(\hDcHiPressed, \hObjHiPressed) : DeleteDC_(\hDcHiPressed)
    SelectObject_(\hDcDisabled,  \hObjDisabled)  : DeleteDC_(\hDcDisabled)
    
    ; DesktopScaledX(Y) is done in MakeObjectTheme()
    Select *ObjectTheme\PBGadgetType
      Case #PB_GadgetType_Button
        MakeButtonTheme(GadgetWidth(*ObjectTheme\PBGadget), GadgetHeight(*ObjectTheme\PBGadget), ObjectTheme())
      Case #PB_GadgetType_ButtonImage
        MakeButtonImageTheme(GadgetWidth(*ObjectTheme\PBGadget), GadgetHeight(*ObjectTheme\PBGadget), ObjectTheme())
    EndSelect
    
    If Not IsImage(\imgRegular)   : Debug "imgRegular is missing!"   : CancelOut = #True: EndIf
    If Not IsImage(\imgHilite)    : Debug "imgHilite is missing!"    : CancelOut = #True: EndIf
    If Not IsImage(\imgPressed)   : Debug "imgPressed is missing!"   : CancelOut = #True: EndIf
    If Not IsImage(\imgHiPressed) : Debug "imgHiPressed is missing!" : CancelOut = #True: EndIf
    If Not IsImage(\imgDisabled)  : Debug "imgDisabled is missing!"  : CancelOut = #True: EndIf
    
    If CancelOut = #True
      If \imgRegular   And IsImage(\imgRegular)   : FreeImage(\imgRegular)   : EndIf
      If \imgHilite    And IsImage(\imgHilite)    : FreeImage(\imgHilite)    : EndIf
      If \imgPressed   And IsImage(\imgPressed)   : FreeImage(\imgPressed)   : EndIf
      If \imgHiPressed And IsImage(\imgHiPressed) : FreeImage(\imgHiPressed) : EndIf
      If \imgDisabled  And IsImage(\imgDisabled)  : FreeImage(\imgDisabled)  : EndIf
      ProcedureReturn 0
    EndIf
    
    hGenDC         = GetDC_(#Null)
    \hDcRegular    = CreateCompatibleDC_(hGenDC)
    \hDcHiLite     = CreateCompatibleDC_(hGenDC)
    \hDcPressed    = CreateCompatibleDC_(hGenDC)
    \hDcHiPressed  = CreateCompatibleDC_(hGenDC)
    \hDcDisabled   = CreateCompatibleDC_(hGenDC)
    
    \hObjRegular   = SelectObject_(\hDcRegular,    ImageID(\imgRegular))
    \hObjHiLite    = SelectObject_(\hDcHiLite,     ImageID(\imgHilite))
    \hObjPressed   = SelectObject_(\hDcPressed,    ImageID(\imgPressed))
    \hObjHiPressed = SelectObject_(\hDcHiPressed,  ImageID(\imgHiPressed))
    \hObjDisabled  = SelectObject_(\hDcDisabled,   ImageID(\imgDisabled))
    
    ReleaseDC_(#Null, hGenDC)
    InvalidateRect_(*ObjectTheme\IDGadget, 0, 0)
    ReturnValue = #True
  EndWith
  
  ProcedureReturn ReturnValue
EndProcedure

Procedure FreeButtonTheme(IDGadget)
  Protected SavText.s, SavState.b, ReturnValue
  Protected *ObjectTheme.ObjectTheme_INFO : _ObjectThemeID(*ObjectTheme, IDGadget, #False)
  Protected Gadget = *ObjectTheme\PBGadget
  
  SetWindowLongPtr_(IDGadget, #GWLP_WNDPROC, ObjectTheme()\OldProc)
  
  With *ObjectTheme\BtnInfo
    SelectObject_(\hDcRegular,   \hObjRegular)   : DeleteDC_(\hDcRegular)
    SelectObject_(\hDcHiLite,    \hObjHiLite)    : DeleteDC_(\hDcHiLite)
    SelectObject_(\hDcPressed,   \hObjPressed)   : DeleteDC_(\hDcPressed)
    SelectObject_(\hDcHiPressed, \hObjHiPressed) : DeleteDC_(\hDcHiPressed)
    SelectObject_(\hDcDisabled,  \hObjDisabled)  : DeleteDC_(\hDcDisabled)
    
    If \imgRegular   And IsImage(\imgRegular)    : FreeImage(\imgRegular)   : EndIf
    If \imgHilite    And IsImage(\imgHilite)     : FreeImage(\imgHilite)    : EndIf
    If \imgPressed   And IsImage(\imgPressed)    : FreeImage(\imgPressed)   : EndIf
    If \imgHiPressed And IsImage(\imgHiPressed)  : FreeImage(\imgHiPressed) : EndIf
    If \imgDisabled  And IsImage(\imgDisabled)   : FreeImage(\imgDisabled)  : EndIf
  EndWith
  
  SavText  = *ObjectTheme\BtnInfo\sButtonText
  SavState = *ObjectTheme\BtnInfo\bButtonState
  
  If (GetWindowLongPtr_(IDGadget, #GWL_STYLE) & #BS_PUSHLIKE = #BS_PUSHLIKE)
    SetWindowLongPtr_(IDGadget, #GWL_STYLE, GetWindowLongPtr_(IDGadget, #GWL_STYLE) ! #BS_OWNERDRAW ! #BS_AUTOCHECKBOX | #BS_PUSHLIKE)
  Else
    SetWindowLongPtr_(IDGadget, #GWL_STYLE, GetWindowLongPtr_(IDGadget, #GWL_STYLE) ! #BS_OWNERDRAW)
  EndIf
  SetWindowPos_(IDGadget, #Null, 0, 0, 0, 0, #SWP_NOZORDER | #SWP_NOSIZE | #SWP_NOMOVE)
  
  FreeMemory(*ObjectTheme\BtnInfo)
  DeleteMapElement(ObjectTheme())
  
  If IsGadget(Gadget)
    SetGadgetText(Gadget, SavText)
    SetGadgetState(Gadget, SavState)
    InvalidateRect_(GadgetID(Gadget), 0, 0)
  EndIf
  ReturnValue = #True
  
  ProcedureReturn ReturnValue
EndProcedure

Macro _SubSetObjectButtonColor(ObjectType, Attribute)
  If FindMapElement(ThemeAttribute(), Str(ObjectType) + "|" + Str(Attribute))
    If ThemeAttribute() = #PB_Default
      SetObjectButtonColor(*ObjectTheme, Attribute, #PB_Default, #False)
    EndIf
  EndIf
EndMacro

Procedure SetObjectButtonColor(*ObjectTheme.ObjectTheme_INFO, Attribute, Value, InitLevel = #True)
  Protected ReturnValue = #PB_Default
  Protected ObjectType.s = Str(*ObjectTheme\PBGadgetType) + "|"
  
  With *ObjectTheme\BtnInfo
    Select Attribute
      ; ---------- BackColor ----------  
      Case #PB_Gadget_BackColor
        If Value = #PB_Default
          \iButtonBackColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
          If \iButtonBackColor = #PB_Default
            \iButtonBackColor = GetSysColor_(#COLOR_WINDOW)
          EndIf
          ;If IsDarkColorOT(\iButtonBackColor) : \iButtonBackColor = AccentColorOT(\iButtonBackColor, 80) : Else : \iButtonBackColor = AccentColorOT(\iButtonBackColor, -80) : EndIf
          If IsDarkColorOT(\iButtonBackColor) : \iButtonBackColor = AccentColorOT(\iButtonBackColor, 80) : EndIf
        Else
          \iButtonBackColor     = Value
        EndIf
        
        _SubSetObjectButtonColor(*ObjectTheme\PBGadgetType, #PB_Gadget_OuterColor)
        _SubSetObjectButtonColor(*ObjectTheme\PBGadgetType, #PB_Gadget_CornerColor)
        _SubSetObjectButtonColor(*ObjectTheme\PBGadgetType, #PB_Gadget_GrayBackColor)
        _SubSetObjectButtonColor(*ObjectTheme\PBGadgetType, #PB_Gadget_FrontColor)
        _SubSetObjectButtonColor(*ObjectTheme\PBGadgetType, #PB_Gadget_BorderColor)
        ReturnValue = #True
        
      ; ---------- OuterColor ----------
      Case #PB_Gadget_OuterColor
        If Value = #PB_Default
          \iButtonOuterColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
          If \iButtonOuterColor = #PB_Default
            \iButtonOuterColor = GetSysColor_(#COLOR_WINDOW)
          EndIf
          If Not IsDarkColorOT(\iButtonOuterColor) : \iButtonOuterColor = AccentColorOT(\iButtonOuterColor, -80) : EndIf
        Else
          \iButtonOuterColor     = Value
        EndIf
        ReturnValue = #True
        
      ; ---------- CornerColor ----------
      Case #PB_Gadget_CornerColor
        If Value = #PB_Default
          \iButtonCornerColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
          If \iButtonCornerColor = #PB_Default
            \iButtonCornerColor = GetSysColor_(#COLOR_WINDOW)
          EndIf
        Else
          \iButtonCornerColor     = Value
        EndIf
        ReturnValue = #True
        
      ; ---------- GrayBackColor ----------
      Case #PB_Gadget_GrayBackColor
        If Value = #PB_Default
          If IsDarkColorOT(\iButtonBackColor)
            \iGrayBackColor = DisabledDarkColorOT(\iButtonBackColor)
          Else
            \iGrayBackColor =  DisabledLightColorOT(\iButtonBackColor)
          EndIf
        Else
          \iGrayBackColor    = Value
        EndIf
        ReturnValue = #True
        
      ; ---------- FrontColor ----------
      Case #PB_Gadget_FrontColor
        If Value = #PB_Default
          If IsDarkColorOT(\iButtonBackColor)
            \iFrontColor = #White
          Else
            \iFrontColor = #Black
          EndIf
        Else
          \iFrontColor   = Value
        EndIf
        
        _SubSetObjectButtonColor(*ObjectTheme\PBGadgetType, #PB_Gadget_GrayTextColor)
        _SubSetObjectButtonColor(*ObjectTheme\PBGadgetType, #PB_Gadget_ShadowColor)
        ReturnValue = #True
        
      ; ---------- GrayTextColor ----------
      Case #PB_Gadget_GrayTextColor
        If Value = #PB_Default
          If IsDarkColorOT(\iFrontColor)
            \iGrayTextColor    = DisabledDarkColorOT(\iFrontColor)
          Else
            \iGrayTextColor    = DisabledLightColorOT(\iFrontColor)
          EndIf
        Else
          \iGrayTextColor      = Value
        EndIf
        ReturnValue = #True
        
      ; ---------- EnableShadow ----------
      Case #PB_Gadget_EnableShadow
        If Value = #PB_Default : Value = 0 : EndIf
        \bEnableShadow             = Value
        ReturnValue = #True
        
      ; ---------- ShadowColor ----------
      Case #PB_Gadget_ShadowColor
        If Value = #PB_Default
          If IsDarkColorOT(\iFrontColor)
            \iShadowColor          = #White
          Else
            \iShadowColor          = #Black
          EndIf
        Else
          \iShadowColor            = Value
        EndIf
        ReturnValue = #True
        
      ; ---------- BorderColor ----------
      Case #PB_Gadget_BorderColor
        If Value = #PB_Default
          If IsDarkColorOT(ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor)))
            \iBorderColor = \iButtonBackColor
          Else
            \iBorderColor = \iButtonOuterColor
          EndIf
        Else
          \iBorderColor            = Value
        EndIf
        ReturnValue = #True
        
      ; ---------- RoundX ----------
      Case #PB_Gadget_RoundX
        If Value = #PB_Default : Value = 8 : EndIf
        \iRoundX                   = Value
        ReturnValue = #True
        
      ; ---------- RoundY ----------
      Case #PB_Gadget_RoundY
        If Value = #PB_Default : Value = 8 : EndIf
        \iRoundY                   = Value
        ReturnValue = #True
        
    EndSelect
  EndWith
  
  If InitLevel = #True And Not UpdateButtonTheme(*ObjectTheme)   ; or ChangeButtonTheme(Gadget)
    FreeMemory(ObjectTheme()\BtnInfo)
    DeleteMapElement(ObjectTheme())
    ReturnValue = #PB_Default
  EndIf
  
  ProcedureReturn ReturnValue
EndProcedure

Procedure AddButtonTheme(Gadget, *ObjectTheme.ObjectTheme_INFO, UpdateTheme = #False)
  _ProcedureReturnIfOT(Not IsGadget(Gadget)) 
  Protected hGenDC, ObjectType.s, CancelOut, ReturnValue
  
  If UpdateTheme
    With *ObjectTheme\BtnInfo
      SelectObject_(\hDcRegular,   \hObjRegular)   : DeleteDC_(\hDcRegular)
      SelectObject_(\hDcHiLite,    \hObjHiLite)    : DeleteDC_(\hDcHiLite)
      SelectObject_(\hDcPressed,   \hObjPressed)   : DeleteDC_(\hDcPressed)
      SelectObject_(\hDcHiPressed, \hObjHiPressed) : DeleteDC_(\hDcHiPressed)
      SelectObject_(\hDcDisabled,  \hObjDisabled)  : DeleteDC_(\hDcDisabled)
      ; FreeImage() done in MakeObjectTheme()
    EndWith
  Else
    With *ObjectTheme
      \PBGadget              = Gadget
      \IDGadget              = GadgetID(Gadget)
      \IDParent              = GetParent_(\IDGadget)
      \PBGadgetType          = GadgetType(Gadget)
      \BtnInfo               = AllocateMemory(SizeOf(ObjectBTN_INFO))
      \OldProc            = GetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC)
      \BtnInfo\sButtonText   = GetGadgetText(Gadget)
    EndWith
  EndIf
  
  With *ObjectTheme
    ObjectType               = Str(\PBGadgetType) + "|"
    
    ; ---------- ButtonImage ----------
    If \PBGadgetType = #PB_GadgetType_ButtonImage
      \BtnInfo\iButtonImageID = GetGadgetAttribute(Gadget, #PB_Button_Image)
      \BtnInfo\iButtonImage   = ImagePBOT(\BtnInfo\iButtonImageID)
      \BtnInfo\iButtonPressedImageID   = GetGadgetAttribute(Gadget, #PB_Button_PressedImage)
      If \BtnInfo\iButtonPressedImageID = 0
        \BtnInfo\iButtonPressedImageID = \BtnInfo\iButtonImageID
        \BtnInfo\iButtonPressedImage   = \BtnInfo\iButtonImage
      Else
        \BtnInfo\iButtonPressedImage   = ImagePBOT(\BtnInfo\iButtonPressedImageID)
      EndIf
    EndIf
  EndWith
  
  With *ObjectTheme\BtnInfo
    If (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_PUSHLIKE = #BS_PUSHLIKE)
      \bButtonState = GetGadgetState(Gadget)
    EndIf
    
    _ToolTipHandleOT()
    
    \bButtonEnable = IsWindowEnabled_(*ObjectTheme\IDGadget)
    
    ; ---------- BackColor ----------
    \iButtonBackColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_BackColor)) 
    If \iButtonBackColor = #PB_Default
      \iButtonBackColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
      If \iButtonBackColor = #PB_Default
        \iButtonBackColor = GetSysColor_(#COLOR_WINDOW)
      EndIf
      ;If IsDarkColorOT(\iButtonBackColor) : \iButtonBackColor = AccentColorOT(\iButtonBackColor, 80) : Else : \iButtonBackColor = AccentColorOT(\iButtonBackColor, -80) : EndIf
      If IsDarkColorOT(\iButtonBackColor) : \iButtonBackColor = AccentColorOT(\iButtonBackColor, 80) : EndIf  
    EndIf
    
    ; ---------- OuterColor ----------
    \iButtonOuterColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_OuterColor))
    If \iButtonOuterColor = #PB_Default
      \iButtonOuterColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
      If \iButtonOuterColor = #PB_Default
        \iButtonOuterColor = GetSysColor_(#COLOR_WINDOW)
      EndIf
      If Not IsDarkColorOT(\iButtonOuterColor) : \iButtonOuterColor = AccentColorOT(\iButtonOuterColor, -80) : EndIf
    EndIf
    
    ; ---------- CornerColor ----------
    \iButtonCornerColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_CornerColor))
    If \iButtonCornerColor = #PB_Default
      \iButtonCornerColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
      If \iButtonCornerColor = #PB_Default
        \iButtonCornerColor = GetSysColor_(#COLOR_WINDOW)
      EndIf
    EndIf
    
    ; ---------- GrayBackColor ----------
    \iGrayBackColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_GrayBackColor))
    If \iGrayBackColor = #PB_Default
      If IsDarkColorOT(\iButtonBackColor)
        \iGrayBackColor = DisabledDarkColorOT(\iButtonBackColor)
      Else
        \iGrayBackColor =  DisabledLightColorOT(\iButtonBackColor)
      EndIf
    EndIf
    
    \iActiveFont  = SendMessage_(*ObjectTheme\IDGadget, #WM_GETFONT, 0, 0)
    
    ; ---------- FrontColor ----------
    \iFrontColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_FrontColor))
    If \iFrontColor = #PB_Default
      If IsDarkColorOT(\iButtonBackColor)
        \iFrontColor = #White
      Else
        \iFrontColor = #Black
      EndIf
    EndIf
    
    ; ---------- GrayTextColor ----------
    \iGrayTextColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_GrayTextColor))
    If \iGrayTextColor = #PB_Default
      If IsDarkColorOT(\iFrontColor)
        \iGrayTextColor = DisabledDarkColorOT(\iFrontColor)
      Else
        \iGrayTextColor = DisabledLightColorOT(\iFrontColor)
      EndIf
    EndIf
    
    ; ---------- EnableShadow ----------
    \bEnableShadow = ThemeAttribute(ObjectType + Str(#PB_Gadget_EnableShadow))
    If \bEnableShadow = #PB_Default : \bEnableShadow = 0 : EndIf
    
    ; ---------- ShadowColor ----------
    \iShadowColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_ShadowColor))
    If \iShadowColor = #PB_Default
      If IsDarkColorOT(\iFrontColor)
        \iShadowColor = #White
      Else
        \iShadowColor = #Black
      EndIf
    EndIf
    
    ; ---------- BorderColor ----------
    \iBorderColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_BorderColor))
    If \iBorderColor = #PB_Default
      If IsDarkColorOT(ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor)))
        \iBorderColor = \iButtonBackColor
      Else
        \iBorderColor = \iButtonOuterColor
      EndIf
    EndIf
    
    ; ---------- RoundX ----------
    \iRoundX = ThemeAttribute(ObjectType + Str(#PB_Gadget_RoundX))
    If \iRoundX = #PB_Default : \iRoundX = 8 : EndIf
    
    ; ---------- RoundY ----------
    \iRoundY = ThemeAttribute(ObjectType + Str(#PB_Gadget_RoundY))
    If \iRoundY = #PB_Default : \iRoundY = 8 : EndIf
    
    If \hRgn : DeleteObject_(\hRgn) : EndIf
    ;\hRgn         = CreateRoundRectRgn_(0, 0, DesktopScaledX(GadgetWidth(Gadget)), DesktopScaledY(GadgetHeight(Gadget)), \iRoundX, \iRoundY)
    \hRgn        = CreateRectRgn_(0, 0, DesktopScaledX(GadgetWidth(Gadget)), DesktopScaledY(GadgetHeight(Gadget)))
    
    ; DesktopScaledX(Y) is done in MakeButtonTheme()
    Select *ObjectTheme\PBGadgetType
      Case #PB_GadgetType_Button
        MakeButtonTheme(GadgetWidth(Gadget), GadgetHeight(Gadget), ObjectTheme())
      Case #PB_GadgetType_ButtonImage
        MakeButtonImageTheme(GadgetWidth(Gadget), GadgetHeight(Gadget), ObjectTheme())
    EndSelect
    
    If Not IsImage(\imgRegular)   : Debug "imgRegular is missing!"   : CancelOut = #True: EndIf
    If Not IsImage(\imgHilite)    : Debug "imgHilite is missing!"    : CancelOut = #True: EndIf
    If Not IsImage(\imgPressed)   : Debug "imgPressed is missing!"   : CancelOut = #True: EndIf
    If Not IsImage(\imgHiPressed) : Debug "imgHiPressed is missing!" : CancelOut = #True: EndIf
    If Not IsImage(\imgDisabled)  : Debug "imgDisabled is missing!"  : CancelOut = #True: EndIf
    
    If CancelOut = #True
      If \imgRegular   And IsImage(\imgRegular)   : FreeImage(\imgRegular)   : EndIf
      If \imgHilite    And IsImage(\imgHilite)    : FreeImage(\imgHilite)    : EndIf
      If \imgPressed   And IsImage(\imgPressed)   : FreeImage(\imgPressed)   : EndIf
      If \imgHiPressed And IsImage(\imgHiPressed) : FreeImage(\imgHiPressed) : EndIf
      If \imgDisabled  And IsImage(\imgDisabled)  : FreeImage(\imgDisabled)  : EndIf
      
      FreeMemory(ObjectTheme()\BtnInfo)
      DeleteMapElement(ObjectTheme())
      ProcedureReturn 0
    EndIf
    
    hGenDC         = GetDC_(#Null)
    \hDcRegular    = CreateCompatibleDC_(hGenDC)
    \hDcHiLite     = CreateCompatibleDC_(hGenDC)
    \hDcPressed    = CreateCompatibleDC_(hGenDC)
    \hDcHiPressed  = CreateCompatibleDC_(hGenDC)
    \hDcDisabled   = CreateCompatibleDC_(hGenDC)
    
    \hObjRegular   = SelectObject_(\hDcRegular,   ImageID(\imgRegular))
    \hObjHiLite    = SelectObject_(\hDcHiLite,    ImageID(\imgHilite))
    \hObjPressed   = SelectObject_(\hDcPressed,   ImageID(\imgPressed))
    \hObjHiPressed = SelectObject_(\hDcHiPressed, ImageID(\imgHiPressed))
    \hObjDisabled  = SelectObject_(\hDcDisabled,  ImageID(\imgDisabled))
    
    ReleaseDC_(#Null, hGenDC)
    InvalidateRect_(ObjectTheme()\IDGadget, 0, 0)
    
    If Not UpdateTheme
      SetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE, GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) | #BS_OWNERDRAW)
      
      SetWindowPos_(*ObjectTheme\IDGadget, #Null, 0, 0, 0, 0, #SWP_NOZORDER | #SWP_NOSIZE | #SWP_NOMOVE)
      
      SetWindowLongPtr_(*ObjectTheme\IDGadget, #GWLP_WNDPROC, @ButtonThemeProc())
    EndIf
    
    ReturnValue = #True
  EndWith
  
  ProcedureReturn ReturnValue
EndProcedure

;
;------------------------------------------------------------------------------
;- ----- Object Theme Public -----
;------------------------------------------------------------------------------
;

Procedure IsObjectTheme(Gadget)
  Protected ReturnValue
  If Not IsGadget(Gadget) : ProcedureReturn ReturnValue : EndIf
  
  If FindMapElement(ObjectTheme(), Str(GadgetID(Gadget)))
    ReturnValue = #True
  EndIf
  ProcedureReturn ReturnValue
EndProcedure

Procedure GetObjectThemeAttribute(ObjectType, Attribute)
  Protected ReturnValue = #PB_Default
  
  If FindMapElement(ThemeAttribute(), Str(ObjectType) + "|" + Str(Attribute))
    ReturnValue = ThemeAttribute()
  EndIf
  
  ProcedureReturn ReturnValue
EndProcedure

Procedure SetObjectThemeAttribute(ObjectType, Attribute, Value)
  Protected ReturnValue = #PB_Default
  
  If FindMapElement(ThemeAttribute(), Str(ObjectType) + "|" + Str(Attribute))
    ThemeAttribute() = Value
    ReturnValue = SetObjectTypeColor(ObjectType, Attribute, Value)
  EndIf
  
  ProcedureReturn ReturnValue
EndProcedure

Procedure GetObjectColor(Gadget, Attribute)
  _ProcedureReturnIfOT(Not IsGadget(Gadget), #PB_Default)
  Protected ReturnValue = #PB_Default
  
  If Not FindMapElement(ThemeAttribute(), Str(GadgetType(Gadget)) + "|" + Str(Attribute))
    ProcedureReturn ReturnValue
  EndIf
  Protected *ObjectTheme.ObjectTheme_INFO : _ObjectThemeID(*ObjectTheme, GadgetID(Gadget), #False)
  
  Select *ObjectTheme\PBGadgetType
    Case #PB_GadgetType_Button, #PB_GadgetType_ButtonImage
      With *ObjectTheme\BtnInfo
        Select Attribute
          Case #PB_Gadget_BackColor
            ReturnValue = \iButtonBackColor
          Case #PB_Gadget_OuterColor
            ReturnValue = \iButtonOuterColor
          Case #PB_Gadget_CornerColor
            ReturnValue = \iButtonCornerColor
          Case #PB_Gadget_GrayBackColor
            ReturnValue = \iGrayBackColor
          Case #PB_Gadget_FrontColor
            ReturnValue = \iFrontColor
          Case #PB_Gadget_GrayTextColor
            ReturnValue = \iGrayTextColor
          Case #PB_Gadget_EnableShadow
            ReturnValue = \bEnableShadow
          Case #PB_Gadget_ShadowColor
            ReturnValue = \iShadowColor
          Case #PB_Gadget_BorderColor
            ReturnValue = \iBorderColor
          Case #PB_Gadget_RoundX
            ReturnValue = \iRoundX
          Case #PB_Gadget_RoundY
            ReturnValue = \iRoundY
        EndSelect
      EndWith
      
    Default  
      ; Case #PB_GadgetType_CheckBox, #PB_GadgetType_Frame, #PB_GadgetType_Option, #PB_GadgetType_Text, #PB_GadgetType_TrackBar,
      ;      #PB_GadgetType_Container, #PB_GadgetType_ProgressBar, #PB_GadgetType_ScrollArea, #PB_GadgetType_HyperLink, #PB_GadgetType_Spin, #PB_GadgetType_String,
      ;      #PB_GadgetType_ExplorerList, #PB_GadgetType_ExplorerTree, #PB_GadgetType_ListIcon, #PB_GadgetType_ListView
      With *ObjectTheme\ObjectInfo
        Select Attribute
          Case #PB_Gadget_BackColor
            ReturnValue = \iBackColor
          Case #PB_Gadget_FrontColor
            ReturnValue = \iFrontColor
          Case #PB_Gadget_GrayTextColor
            ReturnValue = \iGrayTextColor
          Case #PB_Gadget_LineColor
            ReturnValue = \iLineColor
          Case #PB_Gadget_TitleBackColor 
            ReturnValue = \iTitleBackColor
          Case #PB_Gadget_TitleFrontColor
            ReturnValue = \iTitleFrontColor
          Case #PB_Gadget_ActiveTab
            ReturnValue = \iActiveTabColor
          Case #PB_Gadget_InactiveTab
            ReturnValue = \iInactiveTabColor
          Case #PB_Gadget_HighLightColor
            ReturnValue = \iHighLightColor
          Case #PB_Gadget_EditBoxColor
            ReturnValue = \iEditBoxColor
          Case #PB_Gadget_SplitterBorder
            ReturnValue = \iSplitterBorder
          Case #PB_Gadget_SplitterBorderColor
            ReturnValue = \iSplitterBorderColor
          Case #PB_Gadget_UseUxGripper
            ReturnValue = \iUseUxGripper
          Case #PB_Gadget_LargeGripper
            ReturnValue = \iLargeGripper
          Case #PB_Gadget_GripperColor
            ReturnValue = \iGripperColor
        EndSelect
      EndWith
      
  EndSelect
  
  ProcedureReturn ReturnValue
EndProcedure

Procedure SetObjectTypeColor(ObjectType, Attribute, Value)
  Protected ReturnValue = #PB_Default 
  
  If Not FindMapElement(ThemeAttribute(), Str(ObjectType) + "|" + Str(Attribute))
    ProcedureReturn ReturnValue
  EndIf
  
  ForEach ObjectTheme()
    If ObjectTheme()\PBGadgetType = ObjectType
      Select ObjectType
        Case #PB_WindowType
          PushMapPosition(ObjectTheme())
          ReturnValue = SetWindowThemeColor(ObjectTheme(), Attribute, Value)
          PopMapPosition(ObjectTheme())
          
        Case #PB_GadgetType_Calendar, #PB_GadgetType_CheckBox, #PB_GadgetType_ComboBox, #PB_GadgetType_Container, #PB_GadgetType_Date, #PB_GadgetType_Editor,
           #PB_GadgetType_ExplorerList, #PB_GadgetType_ExplorerTree, #PB_GadgetType_Frame, #PB_GadgetType_HyperLink, #PB_GadgetType_ListIcon, #PB_GadgetType_ListView,
           #PB_GadgetType_Option, #PB_GadgetType_Panel, #PB_GadgetType_ProgressBar, #PB_GadgetType_ScrollArea, #PB_GadgetType_ScrollBar, #PB_GadgetType_Spin,
           #PB_GadgetType_String, #PB_GadgetType_Splitter,#PB_GadgetType_Text, #PB_GadgetType_TrackBar, #PB_GadgetType_Tree
          PushMapPosition(ObjectTheme())
          ReturnValue = SetObjectThemeColor(ObjectTheme(), Attribute, Value)
          PopMapPosition(ObjectTheme())
          
        Case #PB_GadgetType_Button, #PB_GadgetType_ButtonImage
          PushMapPosition(ObjectTheme())
          ReturnValue = SetObjectButtonColor(ObjectTheme(), Attribute, Value)
          PopMapPosition(ObjectTheme())
      EndSelect
    EndIf
  Next
  
  ProcedureReturn ReturnValue
EndProcedure

Procedure SetObjectColor(Gadget, Attribute, Value)
  _ProcedureReturnIfOT(Not IsGadget(Gadget), #PB_Default)
  Protected ReturnValue = #PB_Default 
  
  If Not FindMapElement(ThemeAttribute(), Str(GadgetType(Gadget)) + "|" + Str(Attribute))
    ProcedureReturn ReturnValue
  EndIf
  
  If FindMapElement(ObjectTheme(), Str(GadgetID(Gadget)))
    Select ObjectTheme()\PBGadgetType
      Case #PB_GadgetType_Calendar, #PB_GadgetType_CheckBox, #PB_GadgetType_ComboBox, #PB_GadgetType_Container, #PB_GadgetType_Date, #PB_GadgetType_Editor,
           #PB_GadgetType_ExplorerList, #PB_GadgetType_ExplorerTree, #PB_GadgetType_Frame, #PB_GadgetType_HyperLink, #PB_GadgetType_ListIcon, #PB_GadgetType_ListView,
           #PB_GadgetType_Option, #PB_GadgetType_Panel, #PB_GadgetType_ProgressBar, #PB_GadgetType_ScrollArea, #PB_GadgetType_ScrollBar, #PB_GadgetType_Spin,
           #PB_GadgetType_String, #PB_GadgetType_Splitter,#PB_GadgetType_Text, #PB_GadgetType_TrackBar, #PB_GadgetType_Tree
        ReturnValue = SetObjectThemeColor(ObjectTheme(), Attribute, Value)
        
      Case #PB_GadgetType_Button, #PB_GadgetType_ButtonImage
        ReturnValue = SetObjectButtonColor(ObjectTheme(), Attribute, Value)
    EndSelect
  EndIf
  
  ProcedureReturn ReturnValue
EndProcedure

Procedure FreeObjectTheme()
  Protected ReturnValue
  
  With ObjectTheme()
    ForEach ObjectTheme()
      Select ObjectTheme()\PBGadgetType
        Case #PB_GadgetType_CheckBox, #PB_GadgetType_Frame, #PB_GadgetType_Option, #PB_GadgetType_Text, #PB_GadgetType_TrackBar,
          #PB_GadgetType_Calendar, #PB_GadgetType_Editor, #PB_GadgetType_ExplorerList, #PB_GadgetType_ListIcon
          SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, \OldProc)
          SetWindowTheme_(\IDGadget, 0, 0)
          FreeMemory(\ObjectInfo)
          DeleteMapElement(ObjectTheme())
          ReturnValue = #True
          
        Case #PB_GadgetType_Panel  
          SetWindowLongPtr_(\IDGadget, #GWL_STYLE, GetWindowLongPtr_(\IDGadget, #GWL_STYLE) &~ #TCS_OWNERDRAWFIXED)
          SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, \OldProc)
          FreeMemory(\ObjectInfo)
          DeleteMapElement(ObjectTheme())
          ReturnValue = #True
          
        Case #PB_GadgetType_Container, #PB_GadgetType_ProgressBar, #PB_GadgetType_ScrollArea, #PB_GadgetType_HyperLink, #PB_GadgetType_Spin, #PB_GadgetType_String,
             #PB_GadgetType_ExplorerTree, #PB_GadgetType_Tree, #PB_GadgetType_Date, #PB_GadgetType_ComboBox, #PB_GadgetType_ScrollBar
          FreeMemory(\ObjectInfo)
          DeleteMapElement(ObjectTheme())
          ReturnValue = #True
          
        Case #PB_GadgetType_ListView
          FreeMemory(\ObjectInfo)
          DeleteMapElement(ObjectTheme())
          SetWindowLongPtr_(\IDGadget, #GWL_STYLE, GetWindowLongPtr_(\IDGadget, #GWL_STYLE) &~ #WS_BORDER)
          SetWindowLongPtr_(\IDGadget, #GWL_EXSTYLE, GetWindowLongPtr_(\IDGadget, #GWL_EXSTYLE) | #WS_EX_CLIENTEDGE)
          ReturnValue = #True
          
        Case #PB_GadgetType_Splitter
          If \ObjectInfo\iSplitterGripper : DeleteObject_(\ObjectInfo\iSplitterGripper) : EndIf
          SetClassLongPtr_(\IDGadget, #GCL_STYLE, GetClassLongPtr_(\IDGadget, #GCL_STYLE) &~ #CS_DBLCLKS)
          SetWindowLongPtr_(\IDGadget, #GWL_STYLE, GetWindowLongPtr_(\IDGadget, #GWL_STYLE) &~ #WS_CLIPCHILDREN)
          SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, \OldProc)
          FreeMemory(\ObjectInfo)
          DeleteMapElement(ObjectTheme())
          ReturnValue = #True
          
        Case #PB_GadgetType_Button, #PB_GadgetType_ButtonImage
          FreeButtonTheme(\IDGadget)
          ReturnValue = #True
      EndSelect
    Next
  EndWith
  ClearMap(ObjectBrush())
  ClearMap(ThemeAttribute())
  
  ProcedureReturn ReturnValue
EndProcedure

Procedure GetObjectTheme()
  Protected ReturnValue = #PB_Default
  
  If FindMapElement(ThemeAttribute(), Str(#ObjectTheme))
    ReturnValue = ThemeAttribute()
  EndIf
  
  ProcedureReturn ReturnValue
EndProcedure

Procedure SetObjectTheme(Theme, WindowColor = #PB_Default)
  Protected Window, Object, IsJellyButton, ReturnValue, ObjectID, Buffer.s = Space(64) 
  
  If Theme = #PB_Default 
    If MapSize(ThemeAttribute()) = 0
      LoadThemeAttribute(Theme, WindowColor)
    EndIf
  Else  
    LoadThemeAttribute(Theme, WindowColor)
  EndIf
  
  ForEach ObjectTheme()
    If Not IsGadget(ObjectTheme()\PBGadget) Or Not IsWindow_(ObjectTheme()\IDGadget)
      DeleteMapElement(ObjectTheme())
    EndIf
  Next
  
  PB_Object_EnumerateStart(PB_Window_Objects)
  While PB_Object_EnumerateNext(PB_Window_Objects, @Window)
    _AddWindowTheme(Window)
  Wend
  PB_Object_EnumerateAbort(PB_Window_Objects)
  
  PB_Object_EnumerateStart(PB_Gadget_Objects)
  While PB_Object_EnumerateNext(PB_Gadget_Objects, @Object)
    Select GadgetType(Object)
      Case #PB_GadgetType_Calendar, #PB_GadgetType_CheckBox, #PB_GadgetType_Container, #PB_GadgetType_Date, #PB_GadgetType_Editor, #PB_GadgetType_ExplorerList,
           #PB_GadgetType_ExplorerTree, #PB_GadgetType_Frame, #PB_GadgetType_HyperLink, #PB_GadgetType_ListIcon, #PB_GadgetType_ListView, #PB_GadgetType_Option,
           #PB_GadgetType_Panel, #PB_GadgetType_ProgressBar, #PB_GadgetType_ScrollArea, #PB_GadgetType_ScrollBar, #PB_GadgetType_Spin, #PB_GadgetType_String,
           #PB_GadgetType_Splitter,#PB_GadgetType_Text, #PB_GadgetType_TrackBar, #PB_GadgetType_Tree
        _AddObjectTheme(Object)
        
      Case #PB_GadgetType_ComboBox
        ; Check ComboBox flags and _AddObjectTheme()
        ObjectID = GadgetID(Object)
        Buffer = Space(64) : GetClassName_(ObjectID, @Buffer, 64)
        Select Buffer
          Case "ComboBox"       ; Not a ComboBox Image
            If Not (GetWindowLongPtr_(ObjectID, #GWL_STYLE) & #CBS_OWNERDRAWFIXED = #CBS_OWNERDRAWFIXED)
              CompilerIf #PB_Compiler_Debugger
                Debug "The flags #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED should be added to the ComboBox number " + Str(Object) + " to have the drop-down list painted by ObjectTheme."
              CompilerElse
                MessageRequester("ComboBox flags warning!" ,"The flags #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED should be added To the ComboBox number " + Str(Object) + " to have the drop-down List painted by ObjectTheme.")
              CompilerEndIf
            EndIf
          Case "ComboBoxEx32"   ; A ComboBox Image
            If GetWindowLongPtr_(ObjectID, #GWL_STYLE) & #CBS_OWNERDRAWFIXED = #CBS_OWNERDRAWFIXED
              CompilerIf #PB_Compiler_Debugger
                Debug "The flags #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED should not be added to the ComboBox Image number " + Str(Object) + " to be able to be painted."
              CompilerElse
                MessageRequester("ComboBox flags warning!" ,"The flags #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED should not be added to the ComboBox Image number " + Str(Object) + " to be able to be painted.")
              CompilerEndIf
            EndIf
        EndSelect
        _AddObjectTheme(Object)
        
      Case #PB_GadgetType_Button, #PB_GadgetType_ButtonImage
        IsJellyButton = #False
        CompilerIf Defined(Is_JellyButton, #PB_Procedure)
          IsJellyButton = Is_JellyButton(Object)
        CompilerEndIf
        If IsJellyButton = #False
          _AddButtonTheme(Object)
        EndIf
        
    EndSelect
  Wend
  PB_Object_EnumerateAbort(PB_Gadget_Objects)
  
  SetWindowCallback(@WinCallback())
  
  ProcedureReturn ReturnValue
EndProcedure

;
;------------------------------------------------------------------------------
;- ----- Demo example -----
;------------------------------------------------------------------------------
;

CompilerIf #PB_Compiler_IsMainFile
  
  Enumeration Window
    #Window_0
  EndEnumeration
  
  Enumeration Gadgets
    #ScrollArea_1
    #Checkbox_1
    #Option_1
    #Option_2
    #Combo_1
    #Editor_1
    #ApplyTheme
  EndEnumeration
  
  Procedure Open_Window_0(X = 0, Y = 0, Width = 440, Height = 300)
    If OpenWindow(#Window_0, X, Y, Width, Height, "Simple Demo ObjectTheme", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
      SetWindowColor(#Window_0, RGB(8, 8, 64))
      ScrollAreaGadget(#ScrollArea_1, 20, 20, 400, 200, 1200, 800, 10, #PB_ScrollArea_Flat)
      CheckBoxGadget(#Checkbox_1, 20, 10, 170, 24, "Checkbox_1")
      OptionGadget(#Option_1, 240, 10, 110, 24, "Option_1")
      OptionGadget(#Option_2, 240, 40, 110, 24, "Option_2")      
      ComboBoxGadget(#Combo_1, 20, 40, 170, 28, #PB_ComboBox_Editable | #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED)   ;  <== Specific ComboBox, Add the 2 Constants to be drawn.
      AddGadgetItem(#Combo_1, -1, "Combo_Element_1") : AddGadgetItem(#Combo_1, -1, "Combo_Element_2")
      SetGadgetState(#Combo_1, 0)
      EditorGadget(#Editor_1, 20, 80, 330, 80)
      AddGadgetItem(#Editor_1, -1, "Editor Line 1")
      AddGadgetItem(#Editor_1, -1, "Editor Line 2")
      AddGadgetItem(#Editor_1, -1, "Editor Line 3")
      CloseGadgetList()   ; #ScrollArea_1
      ButtonGadget(#ApplyTheme, 20, 230, 400, 50, "Apply Light Blue Theme")
    EndIf
  EndProcedure

  Open_Window_0()
  
  ;- ---> Add SetObjectTheme() 
  ; It can be positioned anywhere in the code
  ; If it is at the beginning before the combobox creation, you don't need to add the 2 constants #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED for ComboBoxGadget()
  SetObjectTheme(#ObjectTheme_DarkBlue)
  
  ;- Event Loop
  Repeat
    Select WaitWindowEvent()
      Case #PB_Event_CloseWindow
        Break
      Case #PB_Event_Gadget
        Select EventGadget()
          Case #Checkbox_1
            ;SetObjectThemeAttribute(#PB_WindowType, #PB_Gadget_BackColor,  #Cyan)
            ;SetObjectColor(#Combo_1, #PB_Gadget_BackColor,  #Cyan)
            ;SetObjectColor(#Editor_1, #PB_Gadget_BackColor,  #Yellow)
            ;SetObjectColor(#ApplyTheme, #PB_Gadget_BackColor,  #Cyan)
            
          Case #ApplyTheme
            Select GetObjectTheme()
              Case #ObjectTheme_DarkBlue
                SetGadgetText(#ApplyTheme, "Apply Dark Red Theme")
                SetObjectTheme(#ObjectTheme_LightBlue)
              Case #ObjectTheme_LightBlue
                SetGadgetText(#ApplyTheme, "Apply Dark Blue Theme")
                SetObjectTheme(#ObjectTheme_DarkRed)
              Case #ObjectTheme_DarkRed
                SetGadgetText(#ApplyTheme, "Apply Light Blue Theme")
                SetObjectTheme(#ObjectTheme_DarkBlue)
            EndSelect
        EndSelect
    EndSelect
  ForEver
  
CompilerEndIf

; IDE Options = PureBasic 6.03 LTS (Windows - x64)
; EnableXP