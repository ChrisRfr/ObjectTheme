;- Top
;  -------------------------------------------------------------------------------------------------------------------------------------------------
;             Title: Object Theme Library (for Dark or Light Theme)
;       Description: This library will add and apply a theme color for All Windows and Gadgets.
;                    And for All possible color attributes (BackColor, FrontColor, TitleBackColor,...) for each of them
;                    All gadgets will still work in the same way as PureBasic Gadget
;       Source Name: ObjectTheme.pbi
;            Author: ChrisR
;     Creation Date: 2023-11-06
; modification Date: 2023-11-25
;           Version: 1.4
;        PB-Version: 6.0 or other
;                OS: Windows Only
;             Forum: https://www.purebasic.fr/english/viewtopic.php?t=82890
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
;
;   Note that you can SetObjectTheme(Theme [, WindowColor]) anywhere you like in your source, before or after creating the Window, Gadget's
;   But note the special case for the ComboBox Gadget: 
;         Either you call the SetObjectTheme() function at the beginning of the program before creating the Windows and ComboBoxes
;         Or add the flags #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED to the ComboBoxes (but Not to the Combox Images) so that the drop-down List is painted
;
; See ObjectTheme_DataSection.pbi for the theme color attribute for each GadgetType
; . It uses the same attributes as SetGadgetColor():
;     #PB_Gadget_FrontColor, #PB_Gadget_BackColor, #PB_Gadget_LineColor, #PB_Gadget_TitleFrontColor, #PB_Gadget_TitleBackColor, #PB_Gadget_GrayTextColor
; . With new attributes:
;     #PB_Gadget_DarkMode, #PB_Gadget_ActiveTabColor , #PB_Gadget_InactiveTabColor , #PB_Gadget_HighLightColor, #PB_Gadget_EditBoxColor, #PB_Gadget_OuterColor,
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

CompilerIf (#PB_Compiler_IsMainFile)
  EnableExplicit
CompilerEndIf

CompilerIf #PB_Compiler_Debugger = #False
  #EnableOnError = #True   ; #False | #True. Disable if you are already using OnError
CompilerEndIf

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
  #PB_Gadget_DarkMode              ; Enable or disable DarkMode Explorer theme
  #PB_Gadget_ActiveTabColor        ; Panel: active tab color
  #PB_Gadget_InactiveTabColor      ; Panel: inactive tab color
  #PB_Gadget_HighLightColor        ; ComboBox: high-light color of the item selected in the drop-down list
  #PB_Gadget_EditBoxColor          ; ComboBox: editable box color
  #PB_Gadget_OuterColor            ; Button & ButtonImage: outer gradient color. Gradient from the current background color to the Outer Color
  #PB_Gadget_CornerColor           ; Button & ButtonImage: color of the 4 corners outside the RoundBox border, usually the window color
  #PB_Gadget_GrayBackColor         ; Button & ButtonImage: gray background color
  #PB_Gadget_EnableShadow          ; Button & ButtonImage: enable or disable shadow for texts
  #PB_Gadget_ShadowColor           ; Button & ButtonImage: Texts shadow color 
  #PB_Gadget_BorderColor           ; Button & ButtonImage: border color
  #PB_Gadget_RoundX                ; Button & ButtonImage: Radius of rounded corners of buttons in X direction
  #PB_Gadget_RoundY                ; Button & ButtonImage: Radius of rounded corners of buttons in Y direction
  #PB_Gadget_SplitterBorder        ; Splitter: enable or disable border
  #PB_Gadget_SplitterBorderColor   ; Splitter: border color
  #PB_Gadget_UseUxGripper          ; Splitter: #False = Custom, #True = Uxtheme. For Splitter
  #PB_Gadget_GripperColor          ; Splitter: gripper color
  #PB_Gadget_LargeGripper          ; Splitter: large or small gripper
EndEnumeration

#PB_Gadget_END = 99

Structure ObjectBTN_INFO
  sButtonText.s
  bButtonState.b
  bButtonEnable.b
  lButtonBackColor.l
  lButtonOuterColor.l
  lButtonCornerColor.l
  lGrayBackColor.l
  iActiveFont.i
  lFrontColor.l
  lGrayTextColor.l
  bEnableShadow.b
  lShadowColor.l
  lBorderColor.l
  iButtonImage.i
  iButtonImageID.i
  iButtonPressedImage.i
  iButtonPressedImageID.i
  lRoundX.l
  lRoundY.l
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
  lBackColor.l
  lBrushBackColor.l
  lGrayBackColor.l
  lFrontColor.l
  lGrayTextColor.l
  lLineColor.l
  lTitleBackColor.l
  hBrushTitleBackColor.i
  lTitleFrontColor.l
  lActiveTabColor.l
  hBrushActiveTabColor.i
  lInactiveTabColor.l
  hBrushInactiveTabColor.i
  lHighLightColor.l
  hBrushHighLightColor.i
  lEditBoxColor.l
  hBrushEditBoxColor.i
  hObjSplitterGripper.i
  bSplitterBorder.b
  lSplitterBorderColor.l
  bUseUxGripper.b
  lGripperColor.l
  bLargeGripper.b
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
Declare EditProc(hWnd, uMsg, wParam, lParam)
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

  ;
  ; -----------------------------------------------------------------------------
  ;- ----- Internal Macros -----
  ; -----------------------------------------------------------------------------
  ;
  
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
    Protected TmpBackColor = GetObjectThemeAttribute(#PB_WindowType, #PB_Gadget_BackColor)
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

  ;
  ; -----------------------------------------------------------------------------
  ;- ----- ErrorHandler -----
  ; -----------------------------------------------------------------------------
  ;
  
CompilerIf #PB_Compiler_Debugger = #False
  CompilerIf #EnableOnError
    
    CompilerIf Not #PB_Compiler_LineNumbering
      If MessageRequester("ObjectTheme OnError warning", "Enable OnError line numbering support in the compiler options." +#CRLF$+ "To get the source file name and error line number." +#CRLF$+#CRLF$+ "Continue?", #PB_MessageRequester_YesNo | #PB_MessageRequester_Warning) = #PB_MessageRequester_No
        End
      EndIf
    CompilerEndIf
    
    Declare ErrorHandler()
    
    Procedure ErrorHandler()
      Protected EventID, SystemInfo.SYSTEM_INFO, ErrorMessage.s
      Protected ErrorHandler_Window, ErrorHandler_ExitBtn, ErrorHandler_clipboardBtn
      
      #PROCESSOR_ARCHITECTURE_INTEL = 0
      #PROCESSOR_ARCHITECTURE_AMD64 = 9   ; AMD or Intel 64bit processor (std defined by AMD)
      
      ;Protected FileVersion = GetFileProperty(ProgramFilename(), "FileVersion")   ;"FileVersion","FileDescription","LegalCopyright","InternalName","OriginalFilename","ProductName","ProductVersion","CompanyName","LegalTrademarks","SpecialBuild","PrivateBuild","Comments","Language","Email","Website","Special"
      ;ErrorMessage + "ObjecTheme Version: " + FileVersion +#CRLF$
      ErrorMessage + "ObjecTheme" +#CRLF$+#CRLF$
      
      Select OSVersion()
        Case #PB_OS_Windows_8_1            : ErrorMessage + "Windows: 8.1"
        Case #PB_OS_Windows_8              : ErrorMessage + "Windows: 8"
        Case #PB_OS_Windows_XP             : ErrorMessage + "Windows: XP"
        Case #PB_OS_Windows_Vista          : ErrorMessage + "Windows: Vista"
        Case #PB_OS_Windows_7              : ErrorMessage + "Windows: 7"
        Case #PB_OS_Windows_2000           : ErrorMessage + "Windows: 2000"
        Case #PB_OS_Windows_95             : ErrorMessage + "Windows: 95"
        Case #PB_OS_Windows_98             : ErrorMessage + "Windows: 98"
        Case #PB_OS_Windows_Future         : ErrorMessage + "Windows: Future"
        Case #PB_OS_Windows_ME             : ErrorMessage + "Windows: ME"
        Case #PB_OS_Windows_NT3_51         : ErrorMessage + "Windows: NT3_51"
        Case #PB_OS_Windows_NT_4           : ErrorMessage + "Windows: NT_4"
        Case #PB_OS_Windows_Server_2003    : ErrorMessage + "Windows: Server_2003"
        Case #PB_OS_Windows_Server_2008    : ErrorMessage + "Windows: Server_2008"
        Case #PB_OS_Windows_Server_2008_R2 : ErrorMessage + "Windows: Server_2008_R2"
        Case #PB_OS_Windows_Server_2012    : ErrorMessage + "Windows: Server_2012"
        Case #PB_OS_Windows_Server_2012_R2 : ErrorMessage + "Windows: Server_2012_R2"
        Case #PB_OS_Windows_10             : ErrorMessage + "Windows: 10"
        Case #PB_OS_Windows_11             : ErrorMessage + "Windows: 11"
      EndSelect
      
      GetSystemInfo_(SystemInfo)
      Select SystemInfo\wProcessorArchitecture
        Case #PROCESSOR_ARCHITECTURE_AMD64 : ErrorMessage + " x64" +#CRLF$
        Case #PROCESSOR_ARCHITECTURE_INTEL : ErrorMessage + " x86" +#CRLF$
      EndSelect
      
      CompilerIf #PB_Compiler_LineNumbering
        ErrorMessage + "Source Code File: " + GetFilePart(ErrorFile()) +#CRLF$
        ErrorMessage + "Source Code Line: " + Str(ErrorLine()) +#CRLF$
      CompilerEndIf
      
      ErrorMessage +#CRLF$+ "Error Message: " + ErrorMessage()  +#CRLF$
      If ErrorCode() = #PB_OnError_InvalidMemory   
        ErrorMessage + "Target Address: " + Str(ErrorTargetAddress()) +#CRLF$
      EndIf
      
      ErrorHandler_Window = OpenWindow(#PB_Any, 0, 0, DesktopScaledX(520), DesktopScaledY(230), "ObjectTheme: an Error Occured, Sorry!", #PB_Window_ScreenCentered)
      If ErrorHandler_Window
        TextGadget(#PB_Any,   DesktopScaledX(10),  DesktopScaledY(10),  DesktopScaledX(500), DesktopScaledY(17), "Please Send this Information by PM or on ObjectTheme Topic, in Purebasic Forum.")
        TextGadget(#PB_Any,   DesktopScaledX(10),  DesktopScaledY(27),  DesktopScaledX(500), DesktopScaledY(17), "If You Remember the Last Manipulations Done, Please Pass Them on to Try to Reproduce.")
        
        StringGadget(#PB_Any, DesktopScaledX(10),  DesktopScaledY(50),  DesktopScaledX(500), DesktopScaledY(140), ErrorMessage, #ES_MULTILINE|#WS_VSCROLL)
        
        ErrorHandler_clipboardBtn = ButtonGadget(#PB_Any, DesktopScaledX(10),  DesktopScaledY(195), DesktopScaledX(120), DesktopScaledY(30), "Copy to Clipboard")
        ErrorHandler_ExitBtn      = ButtonGadget(#PB_Any, DesktopScaledX(390), DesktopScaledY(195), DesktopScaledX(120), DesktopScaledY(30), "Exit")
        
        Repeat
          Select WaitWindowEvent()
            Case #PB_Event_CloseWindow
              Break
            Case #PB_Event_Gadget
              Select EventGadget()
                Case ErrorHandler_ExitBtn
                  CloseWindow(ErrorHandler_Window)
                  Break
                Case  ErrorHandler_clipboardBtn 
                  SetClipboardText(ErrorMessage)
              EndSelect
          EndSelect
        ForEver
      EndIf
      
    EndProcedure
  CompilerEndIf
CompilerEndIf
  
;
; -----------------------------------------------------------------------------
;- ----- Color & Filter -----
; -----------------------------------------------------------------------------
;

Procedure IsDarkColorOT(Color)
  If Red(Color)*0.299 + Green(Color)*0.587 + Blue(Color)*0.114 < 128   ; Based on Human perception of color, following the RGB values (0.299, 0.587, 0.114)
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
  With *ObjectTheme\ObjectInfo
    If \bSplitterBorder
      SetDCBrushColor_(hdc, \lSplitterBorderColor)
    Else
      SetDCBrushColor_(hdc, \lBackColor)
    EndIf
    FrameRect_(hdc, *rc, GetStockObject_(#DC_BRUSH))
    InflateRect_(*rc, -1, -1)
    SetDCBrushColor_(hdc, \lBackColor)
    FillRect_(hdc, *rc, GetStockObject_(#DC_BRUSH))
    
    If \bUseUxGripper
      Protected htheme = OpenThemeData_(hWnd, "Rebar")
      If htheme
        If *rc\right-*rc\left < *rc\bottom-*rc\top
          If \bLargeGripper
            InflateRect_(*rc, (*rc\bottom-*rc\top-DesktopScaledX(5))/2, -(*rc\bottom-*rc\top-1)/2 +DesktopScaledY(11))
          Else
            InflateRect_(*rc, (*rc\bottom-*rc\top-DesktopScaledX(5))/2, -(*rc\bottom-*rc\top-1)/2 +DesktopScaledY(7))
          EndIf
          DrawThemeBackground_(htheme, hdc, 1, 0, *rc, 0)
        Else
          If \bLargeGripper
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
        If \bLargeGripper
          InflateRect_(*rc, (*rc\right-*rc\left-DesktopScaledX(5))/2, -(*rc\bottom-*rc\top-1)/2 +DesktopScaledY(11))
        Else
          InflateRect_(*rc, (*rc\right-*rc\left-DesktopScaledX(5))/2, -(*rc\bottom-*rc\top-1)/2 +DesktopScaledY(7))
        EndIf
      Else
        If \bLargeGripper
          InflateRect_(*rc, -(*rc\right-*rc\left-1)/2 +DesktopScaledX(11), (*rc\bottom-*rc\top-DesktopScaledY(5))/2)
        Else
          InflateRect_(*rc, -(*rc\right-*rc\left-1)/2 +DesktopScaledX(7),  (*rc\bottom-*rc\top-DesktopScaledY(5))/2)
        EndIf
      EndIf
      SetBrushOrgEx_(hdc, *rc\left, *rc\top, 0)
      FillRect_(hdc, *rc, \hObjSplitterGripper)
      SetBrushOrgEx_(hdc, 0, 0, 0)
    EndIf
  EndWith
EndProcedure

Procedure SplitterProc(hWnd, uMsg, wParam, lParam)
  
  If FindMapElement(ObjectTheme(), Str(hWnd))
    Protected *ObjectTheme.ObjectTheme_INFO = @ObjectTheme()
    Protected OldProc = *ObjectTheme\OldProc
  Else
    ProcedureReturn DefWindowProc_(hWnd, uMsg, wParam, lParam)
  EndIf
  Protected SplitterGripper, ps.PAINTSTRUCT
  
  With *ObjectTheme
    Select uMsg
      Case #WM_NCDESTROY
        ; Delete map element for all children's gadgets that no longer exist
        ForEach ObjectTheme()
          *ObjectTheme = @ObjectTheme()
          If Not IsGadget(\PBGadget)
            If \OldProc
              SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, \OldProc)
            EndIf
            If \ObjectInfo\hObjSplitterGripper : DeleteObject_(\ObjectInfo\hObjSplitterGripper) : EndIf
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
  
  If FindMapElement(ObjectTheme(), Str(hWnd))
    Protected *ObjectTheme.ObjectTheme_INFO = @ObjectTheme()
    Protected OldProc = *ObjectTheme\OldProc
  Else
    ProcedureReturn DefWindowProc_(hWnd, uMsg, wParam, lParam)
  EndIf
  Protected *DrawItem.DRAWITEMSTRUCT, Rect.Rect
  
  With *ObjectTheme
    Select uMsg
      Case #WM_NCDESTROY
        ; Delete map element for all children's gadgets that no longer exist
        ForEach ObjectTheme()
          *ObjectTheme = @ObjectTheme()
          If Not IsGadget(\PBGadget)
            If \OldProc
              SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, \OldProc)
            EndIf
            If \ObjectInfo\hObjSplitterGripper : DeleteObject_(\ObjectInfo\hObjSplitterGripper) : EndIf
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
        
      Case #WM_ENABLE
        InvalidateRect_(hWnd, #Null, #True)
        ProcedureReturn #True
        
      Case #WM_ERASEBKGND
        *DrawItem.DRAWITEMSTRUCT = wParam
        GetClientRect_(hWnd, Rect)
        FillRect_(wParam, @Rect, \ObjectInfo\lBrushBackColor)
        Rect\top = 0 : Rect\bottom = GetGadgetAttribute(\PBGadget, #PB_Panel_TabHeight)
        FillRect_(wParam, @Rect, \ObjectInfo\lBrushBackColor)
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
      Protected SavBackColor = \ObjectInfo\lBackColor
      Protected SavTitleBackColor = \ObjectInfo\lTitleBackColor
      If \OldProc
        SetWindowLongPtr_(hWnd, #GWLP_WNDPROC, \OldProc)
      EndIf
      FreeMemory(\ObjectInfo)
      DeleteMapElement(ObjectTheme())
      If SavBackColor      : DeleteUnusedBrush(SavBackColor)      : EndIf
      If SavTitleBackColor : DeleteUnusedBrush(SavTitleBackColor) : EndIf
        
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
              FillRect_(*pnmCDraw\hdc, *pnmCDraw\rc, \ObjectInfo\hBrushTitleBackColor)
              SetTextColor_(*pnmCDraw\hdc, \ObjectInfo\lTitleFrontColor)
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
        
      Case #WM_ENABLE    
        If wParam = #False
          Protected TextColor = \ObjectInfo\lGrayTextColor
        Else
          TextColor = \ObjectInfo\lFrontColor
        EndIf
        SendMessage_(hWnd, #MCM_SETCOLOR, #MCSC_TEXT, TextColor)
        SendMessage_(hWnd, #MCM_SETCOLOR, #MCSC_TITLETEXT, TextColor)
        SendMessage_(hWnd, #MCM_SETCOLOR, #MCSC_TRAILINGTEXT, TextColor)
        ProcedureReturn #False
        
    EndSelect
  EndWith
  
  ProcedureReturn CallWindowProc_(OldProc, hWnd, uMsg, wParam, lParam)
EndProcedure

Procedure EditProc(hWnd, uMsg, wParam, lParam)
  
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
        
      Case #WM_ENABLE
        If wParam
          SetGadgetColor(\PBGadget, #PB_Gadget_BackColor, \ObjectInfo\lBackColor)
          SetGadgetColor(\PBGadget, #PB_Gadget_FrontColor, \ObjectInfo\lFrontColor)
        Else
          SetGadgetColor(\PBGadget, #PB_Gadget_BackColor, \ObjectInfo\lGrayBackColor)
          SetGadgetColor(\PBGadget, #PB_Gadget_FrontColor, \ObjectInfo\lGrayTextColor)
        EndIf
        ProcedureReturn #False
        
      Case #WM_ERASEBKGND
        Protected Rect.RECT
        GetClientRect_(hWnd, Rect)
        FillRect_(wParam, @Rect, \ObjectInfo\lBrushBackColor)
        ProcedureReturn #True
        
    EndSelect
  EndWith
  
  ProcedureReturn CallWindowProc_(OldProc, hWnd, uMsg, wParam, lParam)
EndProcedure

Procedure WinCallback(hWnd, uMsg, wParam, lParam)
  Protected Result = #PB_ProcessPureBasicEvents
  Protected *ObjectTheme.ObjectTheme_INFO
  
  Protected ParentGadget, Buffer.s, Text.s
  Protected *DrawItem.DRAWITEMSTRUCT, *lvCD.NMLVCUSTOMDRAW 
  
  With *ObjectTheme
    Select uMsg
      Case #WM_CLOSE
        PostEvent(#PB_Event_Gadget, GetDlgCtrlID_(hWnd), 0, #PB_Event_CloseWindow)   ; Required to manage it with #PB_Event_CloseWindow event, if the window is minimized and closed from the taskbar (Right CLick)
        
      Case #WM_NCDESTROY
        ; Delete map element for all children's gadgets that no longer exist after CloseWindow()
        ForEach ObjectTheme()
          *ObjectTheme = @ObjectTheme()
          If Not IsGadget(\PBGadget)
            If \OldProc
              SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, \OldProc)
            EndIf
            If \ObjectInfo\hObjSplitterGripper : DeleteObject_(\ObjectInfo\hObjSplitterGripper) : EndIf
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
        
      ; ---------- Static: CheckBoxGadget, FrameGadget, OptionGadget, TextGadget, TrackBarGadget ----------
      Case #WM_CTLCOLORSTATIC
        If FindMapElement(ObjectTheme(), Str(lparam))
          *ObjectTheme = @ObjectTheme()
        Else
          ProcedureReturn Result
        EndIf
        
        Select *ObjectTheme\PBGadgetType
          Case #PB_GadgetType_CheckBox, #PB_GadgetType_Frame, #PB_GadgetType_Option, #PB_GadgetType_Text, #PB_GadgetType_TrackBar
            If IsWindowEnabled_(\IDGadget)
              SetTextColor_(wParam, \ObjectInfo\lFrontColor)
            Else
              SetTextColor_(wParam, \ObjectInfo\lGrayTextColor)
            EndIf
            SetBkMode_(wParam, #TRANSPARENT)
            ProcedureReturn \ObjectInfo\lBrushBackColor
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
              Protected low, high
              SendMessage_(lParam, #EM_GETSEL, @low, @high)
              If low <> high
                SendMessage_(lParam, #EM_SETSEL, -1, 0)   ; Deselect the ComboBox editable string if not the active Gadget
              EndIf
            EndIf
            If IsWindowEnabled_(\IDGadget) = #False
              SetTextColor_(wParam, \ObjectInfo\lGrayTextColor)
            Else
              SetTextColor_(wParam, \ObjectInfo\lFrontColor)
            EndIf
            SetBkMode_(wParam, #TRANSPARENT)
            ProcedureReturn \ObjectInfo\hBrushEditBoxColor
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
                FillRect_(*DrawItem\hDC, *DrawItem\rcitem, \ObjectInfo\hBrushHighLightColor)
              Else
                FillRect_(*DrawItem\hDC, *DrawItem\rcitem, \ObjectInfo\lBrushBackColor)
              EndIf
              
              SetBkMode_(*DrawItem\hDC, #TRANSPARENT)
              If IsWindowEnabled_(\IDGadget) = #False
                SetTextColor_(*DrawItem\hDC, \ObjectInfo\lGrayTextColor)
              Else
                SetTextColor_(*DrawItem\hDC, \ObjectInfo\lFrontColor)
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
            FillRect_(*DrawItem\hDC, *DrawItem\rcItem, \ObjectInfo\hBrushActiveTabColor)
          Else
            *DrawItem\rcItem\top + 2 : *DrawItem\rcItem\bottom + 3   ; Default: \rcItem\bottom + 2 . +3 to decrease the size of the bottom line
            FillRect_(*DrawItem\hDC, *DrawItem\rcItem, \ObjectInfo\hBrushInactiveTabColor)
          EndIf
          
          SetBkMode_(*DrawItem\hDC, #TRANSPARENT)
          If IsWindowEnabled_(\IDGadget) = #False
            SetTextColor_(*DrawItem\hDC, \ObjectInfo\lGrayTextColor)
          Else
            SetTextColor_(*DrawItem\hDC, \ObjectInfo\lFrontColor)
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
                      FillRect_(*lvCD\nmcd\hDC, *lvCD\nmcd\rc, \ObjectInfo\lBrushBackColor)
                      ProcedureReturn #CDRF_NOTIFYITEMDRAW
                    Case #CDDS_ITEMPREPAINT
                      ;DrawIconEx_(*lvCD\nmcd\hDC, subItemRect\left + 5, (subItemRect\top + subItemRect\bottom - GetSystemMetrics_(#SM_CYSMICON)) / 2, hIcon, 16, 16, 0, 0, #DI_NORMAL)
                      If IsWindowEnabled_(\IDGadget) = #False
                        *lvCD\clrText   = \ObjectInfo\lGrayTextColor
                      Else
                        *lvCD\clrText   = \ObjectInfo\lFrontColor
                      EndIf
                      *lvCD\clrTextBk = \ObjectInfo\lBackColor
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
      Read.l Buffer
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
      
      If FindMapElement(ThemeAttribute(), Str(#PB_WindowType) + "|" + Str(#PB_Gadget_DarkMode))
        If ThemeAttribute() = #PB_Default
          SetWindowThemeColor(*ObjectTheme, #PB_Gadget_DarkMode, #PB_Default)
        EndIf
      EndIf
      
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
    
    \ObjectInfo\lBackColor   = ThemeAttribute(ObjectType + Str(#PB_Gadget_BackColor))
    SetWindowColor(Window, \ObjectInfo\lBackColor)
    
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
          Case \lBrushBackColor, \hBrushActiveTabColor, \hBrushInactiveTabColor, \hBrushHighLightColor, \hBrushEditBoxColor, \hBrushTitleBackColor
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
    If FindMapElement(ObjectBrush(), Str(Color))
      BrushColor = ObjectBrush()
    Else
      ObjectBrush(Str(Color)) = CreateSolidBrush_(Color)
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
  
  If Not FindMapElement(ThemeAttribute(), Str(*ObjectTheme\PBGadgetType) + "|" + Str(Attribute))
    ProcedureReturn ReturnValue
  EndIf
  
  With *ObjectTheme\ObjectInfo
    Select Attribute
      ; ---------- BackColor ----------  
      Case #PB_Gadget_BackColor
        SavBackColor = \lBackColor
        If Value = #PB_Default
          \lBackColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
          Select *ObjectTheme\PBGadgetType
            Case #PB_GadgetType_Editor, #PB_GadgetType_Spin, #PB_GadgetType_String
              If IsDarkColorOT(\lBackColor) : \lBackColor = AccentColorOT(\lBackColor, 15) : Else : \lBackColor = AccentColorOT(\lBackColor, -15) : EndIf
            Case #PB_GadgetType_ProgressBar
              If IsDarkColorOT(\lBackColor) : \lBackColor = AccentColorOT(\lBackColor, 40) : Else : \lBackColor = AccentColorOT(\lBackColor, -40) : EndIf
            Case #PB_GadgetType_Splitter
              If IsDarkColorOT(\lBackColor) : \lBackColor = AccentColorOT(\lBackColor, 30) : Else : \lBackColor = AccentColorOT(\lBackColor, -30) : EndIf 
          EndSelect
        Else
          \lBackColor        = Value
        EndIf
        
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_GrayBackColor)
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_FrontColor)
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_LineColor)
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_TitleBackColor)
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_ActiveTabColor )
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_InactiveTabColor )
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_EditBoxColor)
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_SplitterBorderColor)
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_UseUxGripper)
        
        Select *ObjectTheme\PBGadgetType
          Case #PB_GadgetType_CheckBox, #PB_GadgetType_ComboBox, #PB_GadgetType_Frame, #PB_GadgetType_Option, #PB_GadgetType_Panel, #PB_GadgetType_Text, #PB_GadgetType_TrackBar
            _SetObjectBrush(\lBackColor, \lBrushBackColor, SavBackColor)
          Case #PB_GadgetType_ExplorerList, #PB_GadgetType_ListIcon
            _SetObjectBrush(\lBackColor, \lBrushBackColor, SavBackColor)
            SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_BackColor, \lBackColor)
          Case #PB_GadgetType_Calendar, #PB_GadgetType_Container, #PB_GadgetType_Date, #PB_GadgetType_Editor, #PB_GadgetType_HyperLink, #PB_GadgetType_ProgressBar,
               #PB_GadgetType_ExplorerTree, #PB_GadgetType_ListView, #PB_GadgetType_ScrollArea, #PB_GadgetType_Spin, #PB_GadgetType_String, #PB_GadgetType_Tree
            SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_BackColor, \lBackColor)
        EndSelect  
        ReturnValue = #True
        
        ; ---------- GrayBackColor ----------
      Case #PB_Gadget_GrayBackColor
        If Value = #PB_Default
          If IsDarkColorOT(\lBackColor) : \lGrayBackColor = DisabledDarkColorOT(\lBackColor) : Else : \lGrayBackColor = DisabledLightColorOT(\lBackColor) : EndIf
        Else
          \lGrayBackColor = Value
        EndIf
        ReturnValue = #True
        
        ; ---------- ActiveTabColor ----------
      Case #PB_Gadget_ActiveTabColor 
        SavBackColor = \lActiveTabColor
        If Value = #PB_Default
          \lActiveTabColor = \lBackColor
        Else
          \lActiveTabColor = Value
        EndIf
        _SetObjectBrush(\lActiveTabColor, \hBrushActiveTabColor, SavBackColor)
        ReturnValue = #True
                
      ; ---------- InactiveTabColor ----------
      Case #PB_Gadget_InactiveTabColor 
        SavBackColor = \lInactiveTabColor
        If Value = #PB_Default
          If IsDarkColorOT(\lBackColor) : \lInactiveTabColor = AccentColorOT(\lBackColor, 40) : Else : \lInactiveTabColor = AccentColorOT(\lBackColor, -40) : EndIf
        Else
          \lInactiveTabColor = Value
        EndIf
        _SetObjectBrush(\lInactiveTabColor, \lInactiveTabColor, SavBackColor)
        ReturnValue = #True
        
      ; ---------- HighLightColor ----------
      Case #PB_Gadget_HighLightColor
        SavBackColor = \lHighLightColor
        If Value = #PB_Default
          \lHighLightColor = GetSysColor_(#COLOR_HIGHLIGHT)
        Else
          \lHighLightColor = Value
        EndIf
        _SetObjectBrush(\lHighLightColor, \hBrushHighLightColor, SavBackColor)
        ReturnValue = #True
        
      ; ---------- EditBoxColor ----------
      Case #PB_Gadget_EditBoxColor
        SavBackColor = \lEditBoxColor
        If Value = #PB_Default
          If IsDarkColorOT(\lBackColor) : \lEditBoxColor = AccentColorOT(\lBackColor, 15) : Else : \lEditBoxColor = AccentColorOT(\lBackColor, -15) : EndIf
        Else
          \lEditBoxColor = Value
        EndIf
        _SetObjectBrush(\lEditBoxColor, \hBrushEditBoxColor, SavBackColor)
        ReturnValue = #True
        
        ; ---------- SplitterBorderColor ----------
      Case #PB_Gadget_SplitterBorderColor
        If Value = #PB_Default
          If IsDarkColorOT(\lBackColor) : \lSplitterBorderColor = AccentColorOT(\lBackColor, 60) : Else : \lSplitterBorderColor = AccentColorOT(\lBackColor, -60) : EndIf
        Else
          \lSplitterBorderColor = Value
        EndIf
        ReturnValue = #True
        
      ; ---------- FrontColor ----------
      Case #PB_Gadget_FrontColor
        If Value = #PB_Default
          Select *ObjectTheme\PBGadgetType
            Case #PB_GadgetType_ProgressBar
              If IsDarkColorOT(\lBackColor) : \lFrontColor = AccentColorOT(\lBackColor, 100) : Else : \lFrontColor = AccentColorOT(\lBackColor, -100) : EndIf
            Default
              If IsDarkColorOT(\lBackColor) : \lFrontColor = #White : Else : \lFrontColor = #Black : EndIf
          EndSelect
        Else
          \lFrontColor = Value
        EndIf
        
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_GrayTextColor)
        
        Select *ObjectTheme\PBGadgetType
          Case #PB_GadgetType_Calendar, #PB_GadgetType_Date, #PB_GadgetType_Editor, #PB_GadgetType_ExplorerList, #PB_GadgetType_ExplorerTree, 
             #PB_GadgetType_HyperLink, #PB_GadgetType_ListIcon, #PB_GadgetType_ListView, #PB_GadgetType_ProgressBar, #PB_GadgetType_Spin,
             #PB_GadgetType_String, #PB_GadgetType_Tree
            SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_FrontColor, \lFrontColor)
        EndSelect
        ReturnValue = #True
        
      ; ---------- GrayTextColor ----------
      Case #PB_Gadget_GrayTextColor
        If Value = #PB_Default
          If IsDarkColorOT(\lFrontColor) : \lGrayTextColor = DisabledDarkColorOT(\lFrontColor) : Else : \lGrayTextColor = DisabledLightColorOT(\lFrontColor) : EndIf
        Else
          \lGrayTextColor = Value
        EndIf
        ReturnValue = #True
        
      ; ---------- LineColor ----------
      Case #PB_Gadget_LineColor
        If Value = #PB_Default
          If IsDarkColorOT(\lBackColor) : \lLineColor = #White : Else : \lLineColor = #Black : EndIf
        Else
          \lLineColor = Value
        EndIf
        SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_LineColor, \lLineColor)   ; Display if #PB_Explorer_GridLines used
        ReturnValue = #True
        
      ; ---------- TitleBackColor ----------
      Case #PB_Gadget_TitleBackColor
        If Value = #PB_Default
          Select *ObjectTheme\PBGadgetType
            Case #PB_GadgetType_ExplorerList, #PB_GadgetType_ListIcon
              If IsDarkColorOT(\lBackColor) : \lTitleBackColor = AccentColorOT(\lBackColor, 40) : Else : \lTitleBackColor = AccentColorOT(\lBackColor, -40) : EndIf
            Case #PB_GadgetType_Calendar, #PB_GadgetType_Date
              \lTitleBackColor = \lBackColor
          EndSelect
        Else
          \lTitleBackColor = Value
        EndIf
        Select *ObjectTheme\PBGadgetType
          Case #PB_GadgetType_ExplorerList, #PB_GadgetType_ListIcon
            _SetObjectBrush(\lTitleBackColor, \hBrushTitleBackColor, SavBackColor)
          Case #PB_GadgetType_Calendar, #PB_GadgetType_Date
            SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_TitleBackColor, \lTitleBackColor)   ; Display if #PB_Explorer_GridLines used
        EndSelect
        
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_TitleFrontColor)
        ReturnValue = #True
        
      ; ---------- TitleFrontColor ----------
      Case #PB_Gadget_TitleFrontColor
        If Value = #PB_Default
          If IsDarkColorOT(\lTitleBackColor) : \lTitleFrontColor = #White : Else : \lTitleFrontColor = #Black : EndIf
        Else
          \lTitleFrontColor = Value
        EndIf
        SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_TitleFrontColor, \lTitleFrontColor)   ; Display if #PB_Explorer_GridLines used
        ReturnValue = #True
        
        ; ---------- SplitterBorder ----------
      Case #PB_Gadget_SplitterBorder
        If Value = #PB_Default
          \bSplitterBorder = #True
        Else
          \bSplitterBorder = Value
        EndIf
        ReturnValue = #True
        
        ; ---------- LargeGripper ----------
      Case #PB_Gadget_LargeGripper
        If Value = #PB_Default
          \bLargeGripper = #True
        Else
          \bLargeGripper = Value
        EndIf
        ReturnValue = #True
        
        ; ---------- GripperColor ----------
      Case  #PB_Gadget_GripperColor
        If Value = #PB_Default
          \lGripperColor = #True
          If IsDarkColorOT(\lBackColor): \lGripperColor = AccentColorOT(\lBackColor, 40) : Else : \lGripperColor = AccentColorOT(\lBackColor, -40) : EndIf
        Else
          \lGripperColor = Value
        EndIf
        _SubSetObjectThemeColor(*ObjectTheme\PBGadgetType, #PB_Gadget_UseUxGripper)
        ReturnValue = #True
        
        ; ---------- UseUxGripper ----------
      Case #PB_Gadget_UseUxGripper
        If Value = #PB_Default
          \bUseUxGripper = #False
        Else
          \bUseUxGripper = Value
        EndIf
        If \bUseUxGripper = #False
          Protected SplitterImg
          If \hObjSplitterGripper : DeleteObject_(\hObjSplitterGripper) : EndIf   ; Delete the previous Pattern Brush stored
          If \bSplitterBorder
            SplitterImg = CreateImage(#PB_Any, DesktopScaledX(5), DesktopScaledY(5), 24, \lGripperColor)
          Else
            SplitterImg = CreateImage(#PB_Any, DesktopScaledX(5), DesktopScaledY(5), 24, \lBackColor)
          EndIf
          If StartDrawing(ImageOutput(SplitterImg))
            RoundBox(DesktopScaledX(1), DesktopScaledY(1), DesktopScaledX(3), DesktopScaledY(3), DesktopScaledX(1), DesktopScaledY(1), \lFrontColor)
            StopDrawing()
          EndIf
          \hObjSplitterGripper = CreatePatternBrush_(ImageID(SplitterImg))
          FreeImage(SplitterImg)
        EndIf
        ReturnValue = #True 
        
    EndSelect
  EndWith
  
  If InitLevel
    With *ObjectTheme
      Select \PBGadgetType
        Case #PB_GadgetType_CheckBox, #PB_GadgetType_Option, #PB_GadgetType_TrackBar
          SetWindowTheme_(\IDGadget, "", "")
        Case #PB_GadgetType_Calendar
          SetWindowTheme_(\IDGadget, "", "")
        Case #PB_GadgetType_ComboBox
          InvalidateRect_(\IDGadget, 0, 1)
        Case #PB_GadgetType_Editor, #PB_GadgetType_Spin, #PB_GadgetType_String
          SendMessage_(\IDGadget, #WM_ENABLE, IsWindowEnabled_(\IDGadget), 0)
        Case  #PB_GadgetType_Splitter
          RedrawWindow_(\IDGadget, #Null, #Null, #RDW_INVALIDATE | #RDW_ERASE | #RDW_UPDATENOW)
      EndSelect
    EndWith
  EndIf
  
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
  
  _ToolTipHandleOT()
  
  With *ObjectTheme\ObjectInfo
    ; ---------- BackColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_BackColor))
      SavBackColor  = \lBackColor
      \lBackColor   = ThemeAttribute()
      If \lBackColor = #PB_Default
        \lBackColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
        Select *ObjectTheme\PBGadgetType
          Case #PB_GadgetType_Editor, #PB_GadgetType_Spin, #PB_GadgetType_String
            If IsDarkColorOT(\lBackColor) : \lBackColor = AccentColorOT(\lBackColor, 15) : Else : \lBackColor = AccentColorOT(\lBackColor, -15) : EndIf
          Case #PB_GadgetType_ProgressBar
            If IsDarkColorOT(\lBackColor) : \lBackColor = AccentColorOT(\lBackColor, 40) : Else : \lBackColor = AccentColorOT(\lBackColor, -40) : EndIf
          Case #PB_GadgetType_Splitter
            If IsDarkColorOT(\lBackColor) : \lBackColor = AccentColorOT(\lBackColor, 30) : Else : \lBackColor = AccentColorOT(\lBackColor, -30) : EndIf
        EndSelect
      EndIf
      
      ; ----- Brush BackColor -----
      Select *ObjectTheme\PBGadgetType
        Case #PB_GadgetType_CheckBox, #PB_GadgetType_ComboBox, #PB_GadgetType_Frame, #PB_GadgetType_Option, #PB_GadgetType_Panel, #PB_GadgetType_Text, #PB_GadgetType_TrackBar
          _SetObjectBrush(\lBackColor, \lBrushBackColor, SavBackColor)
          
        Case #PB_GadgetType_ExplorerList, #PB_GadgetType_ListIcon
          _SetObjectBrush(\lBackColor, \lBrushBackColor, SavBackColor)
          SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_BackColor, \lBackColor)
          
        Case #PB_GadgetType_Calendar, #PB_GadgetType_Container, #PB_GadgetType_Date, #PB_GadgetType_Editor , #PB_GadgetType_HyperLink, #PB_GadgetType_ProgressBar,
             #PB_GadgetType_ExplorerTree, #PB_GadgetType_ListView, #PB_GadgetType_ScrollArea, #PB_GadgetType_Spin, #PB_GadgetType_String, #PB_GadgetType_Tree
          SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_BackColor, \lBackColor)
      EndSelect
    EndIf
    
    ; ---------- GrayBackColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_GrayBackColor))
      \lGrayBackColor = ThemeAttribute()
      If \lGrayBackColor = #PB_Default
        If IsDarkColorOT(\lBackColor) : \lGrayBackColor = DisabledDarkColorOT(\lBackColor) : Else : \lGrayBackColor = DisabledLightColorOT(\lBackColor) : EndIf
      EndIf
    EndIf
    
    ; ---------- ActiveTabColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_ActiveTabColor ))
      SavBackColor  = \lActiveTabColor
      \lActiveTabColor = ThemeAttribute()
      If \lActiveTabColor = #PB_Default
        \lActiveTabColor = \lBackColor
      EndIf
      _SetObjectBrush(\lActiveTabColor, \hBrushActiveTabColor, SavBackColor)
    EndIf
    
    ; ---------- InactiveTabColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_InactiveTabColor ))
      SavBackColor  = \lInactiveTabColor
      \lInactiveTabColor = ThemeAttribute()
      If \lInactiveTabColor = #PB_Default
        If IsDarkColorOT(\lBackColor) : \lInactiveTabColor = AccentColorOT(\lBackColor, 40) : Else : \lInactiveTabColor = AccentColorOT(\lBackColor, -40) : EndIf
      EndIf
      _SetObjectBrush(\lInactiveTabColor, \hBrushInactiveTabColor, SavBackColor)
    EndIf
    
    ; ---------- HighLightColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_HighLightColor))
      SavBackColor  = \lHighLightColor
      \lHighLightColor = ThemeAttribute()
      If \lHighLightColor = #PB_Default
        \lHighLightColor = GetSysColor_(#COLOR_HIGHLIGHT)
      EndIf
      _SetObjectBrush(\lHighLightColor, \hBrushHighLightColor, SavBackColor)
    EndIf
    
    ; ---------- EditBoxColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_EditBoxColor))
      SavBackColor  = \lEditBoxColor
      \lEditBoxColor = ThemeAttribute()
      If \lEditBoxColor = #PB_Default
        If IsDarkColorOT(\lBackColor) : \lEditBoxColor = AccentColorOT(\lBackColor, 15) : Else : \lEditBoxColor = AccentColorOT(\lBackColor, -15) : EndIf
      EndIf
      _SetObjectBrush(\lEditBoxColor, \hBrushEditBoxColor, SavBackColor)
    EndIf
    
    ; ---------- SplitterBorderColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_SplitterBorderColor))
      \lSplitterBorderColor = ThemeAttribute()
      If \lSplitterBorderColor = #PB_Default
        If IsDarkColorOT(\lBackColor) : \lSplitterBorderColor = AccentColorOT(\lBackColor, 60) : Else : \lSplitterBorderColor = AccentColorOT(\lBackColor, -60) : EndIf
      EndIf
    EndIf
    
    ; ---------- FrontColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_FrontColor))
      \lFrontColor = ThemeAttribute()
      If \lFrontColor = #PB_Default
        Select *ObjectTheme\PBGadgetType
          Case #PB_GadgetType_ProgressBar
            If IsDarkColorOT(\lBackColor) : \lFrontColor = AccentColorOT(\lBackColor, 100) : Else : \lFrontColor = AccentColorOT(\lBackColor, -100) : EndIf
          Default
            If IsDarkColorOT(\lBackColor) : \lFrontColor = #White : Else : \lFrontColor = #Black : EndIf
        EndSelect
      EndIf
      
      Select *ObjectTheme\PBGadgetType
        Case #PB_GadgetType_Calendar, #PB_GadgetType_Date, #PB_GadgetType_Editor, #PB_GadgetType_ExplorerList, #PB_GadgetType_ExplorerTree, 
             #PB_GadgetType_HyperLink, #PB_GadgetType_ListIcon, #PB_GadgetType_ListView, #PB_GadgetType_ProgressBar, #PB_GadgetType_Spin,
             #PB_GadgetType_String, #PB_GadgetType_Tree
          SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_FrontColor, \lFrontColor)
      EndSelect
    EndIf
    
    ; ---------- GrayTextColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_GrayTextColor))
      \lGrayTextColor = ThemeAttribute()
      If \lGrayTextColor = #PB_Default
        If IsDarkColorOT(\lFrontColor) : \lGrayTextColor = DisabledDarkColorOT(\lFrontColor) : Else : \lGrayTextColor = DisabledLightColorOT(\lFrontColor) : EndIf
      EndIf
    EndIf
    
    ; ---------- LineColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_LineColor))
      \lLineColor = ThemeAttribute()
      If \lLineColor = #PB_Default
        If IsDarkColorOT(\lBackColor) : \lLineColor = #White : Else : \lLineColor = #Black : EndIf
      EndIf
      SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_LineColor, \lLineColor)   ; Display if #PB_Explorer_GridLines used
    EndIf
    
    ; ---------- TitleBackColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_TitleBackColor))
      \lTitleBackColor = ThemeAttribute()
      If \lTitleBackColor = #PB_Default
        Select *ObjectTheme\PBGadgetType
          Case #PB_GadgetType_ListIcon, #PB_GadgetType_ExplorerList
            If IsDarkColorOT(\lBackColor) : \lTitleBackColor = AccentColorOT(\lBackColor, 40) : Else : \lTitleBackColor = AccentColorOT(\lBackColor, -40) : EndIf
          Case #PB_GadgetType_Calendar, #PB_GadgetType_Date
            \lTitleBackColor = \lBackColor
        EndSelect
      EndIf
      Select *ObjectTheme\PBGadgetType
        Case #PB_GadgetType_ListIcon, #PB_GadgetType_ExplorerList
          _SetObjectBrush(\lTitleBackColor, \hBrushTitleBackColor, SavBackColor)
        Case #PB_GadgetType_Calendar, #PB_GadgetType_Date
          SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_TitleBackColor, \lTitleBackColor)   ; Display if #PB_Explorer_GridLines used
      EndSelect
    EndIf    
    
    ; ---------- TitleFrontColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_TitleFrontColor))
      \lTitleFrontColor = ThemeAttribute()
      If \lTitleFrontColor = #PB_Default
        If IsDarkColorOT(\lTitleBackColor) : \lTitleFrontColor = #White : Else : \lTitleFrontColor = #Black : EndIf
      EndIf
      SetGadgetColor(*ObjectTheme\PBGadget, #PB_Gadget_TitleFrontColor, \lTitleFrontColor)   ; Display if #PB_Explorer_GridLines used
    EndIf 
     
    ; ---------- SplitterBorder ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_SplitterBorder))
      \bSplitterBorder = ThemeAttribute()
      If \bSplitterBorder = #PB_Default
        \bSplitterBorder = #True
      EndIf
    EndIf

    ; ---------- LargeGripper ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_LargeGripper))
      \bLargeGripper = ThemeAttribute()
      If \bLargeGripper = #PB_Default
        \bLargeGripper = #True
      EndIf
    EndIf
    
    ; ---------- GripperColor ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_GripperColor))
      \lGripperColor = ThemeAttribute()
      If \lGripperColor = #PB_Default
        If IsDarkColorOT(\lBackColor): \lGripperColor = AccentColorOT(\lBackColor, 40) : Else : \lGripperColor = AccentColorOT(\lBackColor, -40) : EndIf
      EndIf
    EndIf
    
    ; ---------- UseUxGripper ----------
    If FindMapElement(ThemeAttribute(), ObjectType + Str(#PB_Gadget_UseUxGripper))
      \bUseUxGripper = ThemeAttribute()
      If \bUseUxGripper = #PB_Default
        \bUseUxGripper = #False
      EndIf
      If \bUseUxGripper = #False
        Protected SplitterImg
        If \hObjSplitterGripper : DeleteObject_(\hObjSplitterGripper) : EndIf   ; Delete the previous Pattern Brush stored
        If \bSplitterBorder
          SplitterImg = CreateImage(#PB_Any, DesktopScaledX(5), DesktopScaledY(5), 24, \lGripperColor)
        Else
          SplitterImg = CreateImage(#PB_Any, DesktopScaledX(5), DesktopScaledY(5), 24, \lBackColor)
        EndIf
        If StartDrawing(ImageOutput(SplitterImg))
          RoundBox(DesktopScaledX(1), DesktopScaledY(1), DesktopScaledX(3), DesktopScaledY(3), DesktopScaledX(1), DesktopScaledY(1), \lFrontColor)
          StopDrawing()
        EndIf
        \hObjSplitterGripper = CreatePatternBrush_(ImageID(SplitterImg))
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
        SendMessage_(\IDGadget, #WM_ENABLE, IsWindowEnabled_(\IDGadget), 0)
        Select \PBGadgetType
          Case #PB_GadgetType_CheckBox, #PB_GadgetType_Option, #PB_GadgetType_TrackBar
            SetWindowTheme_(\IDGadget, "", "")
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
        
      Case #PB_GadgetType_Editor, #PB_GadgetType_Spin, #PB_GadgetType_String
        If Not UpdateTheme
          \OldProc = GetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC)
          SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, @EditProc())
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
  Protected cX, cY, Margin = 6, Xofset, Yofset, HFlag, VFlag, Text.s, TextLen, TxtHeight, In_Button_Rect, hDC_to_use
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
      ;*ObjectTheme\BtnInfo\hRgn  = CreateRoundRectRgn_(0, 0, DesktopScaledX(GadgetWidth(*ObjectTheme\PBGadget)), DesktopScaledY(GadgetHeight(*ObjectTheme\PBGadget)), *ObjectTheme\BtnInfo\lRoundX, *ObjectTheme\BtnInfo\lRoundY)
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
        SetTextColor_(ps\hdc, *ObjectTheme\BtnInfo\lFrontColor)
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
        Else                                                                                                        : HFlag | #DT_CENTER
        EndIf
        If (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & (#BS_TOP | #BS_BOTTOM) = (#BS_TOP | #BS_BOTTOM)) : VFlag | #DT_VCENTER
        ElseIf (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_TOP = #BS_TOP)                           : VFlag | #DT_TOP
        ElseIf (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_BOTTOM = #BS_BOTTOM)                     : VFlag | #DT_BOTTOM
        Else                                                                                                        : VFlag | #DT_VCENTER
        EndIf
        If (GetWindowLongPtr_(*ObjectTheme\IDGadget, #GWL_STYLE) & #BS_MULTILINE = #BS_MULTILINE) 
          VFlag | #DT_WORDBREAK
        Else  
          VFlag | #DT_SINGLELINE
        EndIf
        
        SelectObject_(ps\hdc, *ObjectTheme\BtnInfo\iActiveFont)
        SetBkMode_(ps\hdc, #TRANSPARENT)
        
        If ObjectTheme()\BtnInfo\bEnableShadow
          SetTextColor_(ps\hdc, *ObjectTheme\BtnInfo\lShadowColor)
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
          SetTextColor_(ps\hdc, *ObjectTheme\BtnInfo\lFrontColor)
        Else
          SetTextColor_(ps\hdc, *ObjectTheme\BtnInfo\lGrayTextColor)
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
        SetTextColor_(wParam, *ObjectTheme\BtnInfo\lFrontColor)
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
          SetTextColor_(wParam, *ObjectTheme\BtnInfo\lShadowColor)
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
          SetTextColor_(wParam, *ObjectTheme\BtnInfo\lFrontColor)
        Else
          SetTextColor_(wParam, *ObjectTheme\BtnInfo\lGrayTextColor)
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
    Protected ButtonBackColor.l = \lButtonBackColor
    
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
          ButtonBackColor = \lGrayBackColor
      EndSelect
      
      If StartDrawing(ImageOutput(*ThisImage))
        
        Box(0, 0, cX, cY, \lButtonCornerColor)
        RoundBox(0, 0, cX, cY, \lRoundX, \lRoundY, ButtonBackColor | $80000000)
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
        GradientColor(1.0,  \lButtonOuterColor | $BE000000)
        RoundBox(0, 0, cX, cY, \lRoundX, \lRoundY)
        
        ; Border drawn with button color and an inner 1 px border with background color (full inside or top left or bottom right)
        DrawingMode(#PB_2DDrawing_Outlined)
        RoundBox(0, 0, cX, cY, \lRoundX, \lRoundY, \lBorderColor)
        Select I
          Case 0, 4     ; imgRegular, imgDisabled
            RoundBox(1, 1, cX-2, cY-2, \lRoundX, \lRoundY, \lButtonOuterColor)
          Case 1, 3     ; imgHilite, imgHiPressed
            RoundBox(1, 1, cX-2, cY-2, \lRoundX, \lRoundY, \lBorderColor)
            RoundBox(2, 2, cX-4, cY-4, \lRoundX, \lRoundY, \lButtonOuterColor)
          Case 2        ; imgPressed
            RoundBox(1, 1, cX-2, cY-2, \lRoundX, \lRoundY, \lBorderColor)
            RoundBox(2, 2, cX-4, cY-4, \lRoundX, \lRoundY, \lBorderColor)
            RoundBox(3, 3, cX-6, cY-6, \lRoundX, \lRoundY, \lButtonOuterColor)
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
    Protected ButtonBackColor.l = \lButtonBackColor
    
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
          ButtonBackColor = \lGrayBackColor
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
            GradientColor(1.0, \lButtonOuterColor | $14000000)
            ;GradientColor(1.0, \lButtonCornerColor | $14000000) 
            RoundBox(0, 0, cX, cY, \lRoundX, \lRoundY)
        EndSelect
        
        ; Fill outside RoundBox border, corner with background color
        DrawingMode(#PB_2DDrawing_Outlined)
        RoundBox(1, 1, cX-2, cY-2, \lRoundX, \lRoundY, $B200FF)
        FillArea(0, 0, $B200FF, \lButtonOuterColor)
        RoundBox(1, 1, cX-2, cY-2, \lRoundX, \lRoundY, #Black)
        FillArea(0, 0, #Black, \lButtonCornerColor)
        
        ; Border drawn with button color and an inner 1 px border with background color (full inside or top left or bottom right)
        RoundBox(0, 0, cX, cY, \lRoundX, \lRoundY, \lBorderColor)
        Select I
          Case 0, 4     ; imgRegular, imgDisabled
            RoundBox(1, 1, cX-2, cY-2, \lRoundX, \lRoundY, \lButtonOuterColor)
          Case 1, 3     ; imgHilite, imgHiPressed
            RoundBox(1, 1, cX-2, cY-2, \lRoundX, \lRoundY, \lBorderColor)
            RoundBox(2, 2, cX-4, cY-4, \lRoundX, \lRoundY, \lButtonOuterColor)
          Case 2        ; imgPressed
            RoundBox(1, 1, cX-2, cY-2, \lRoundX, \lRoundY, \lBorderColor)
            RoundBox(2, 2, cX-4, cY-4, \lRoundX, \lRoundY, \lBorderColor)
            RoundBox(3, 3, cX-6, cY-6, \lRoundX, \lRoundY, \lButtonOuterColor)
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
          \lButtonBackColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
          If \lButtonBackColor = #PB_Default
            \lButtonBackColor = GetSysColor_(#COLOR_WINDOW)
          EndIf
          If IsDarkColorOT(\lButtonBackColor) : \lButtonBackColor = AccentColorOT(\lButtonBackColor, 80) : EndIf
        Else
          \lButtonBackColor     = Value
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
          \lButtonOuterColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
          If \lButtonOuterColor = #PB_Default
            \lButtonOuterColor = GetSysColor_(#COLOR_WINDOW)
          EndIf
          If Not IsDarkColorOT(\lButtonOuterColor) : \lButtonOuterColor = AccentColorOT(\lButtonOuterColor, -80) : EndIf
        Else
          \lButtonOuterColor     = Value
        EndIf
        ReturnValue = #True
        
      ; ---------- CornerColor ----------
      Case #PB_Gadget_CornerColor
        If Value = #PB_Default
          \lButtonCornerColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
          If \lButtonCornerColor = #PB_Default
            \lButtonCornerColor = GetSysColor_(#COLOR_WINDOW)
          EndIf
        Else
          \lButtonCornerColor     = Value
        EndIf
        ReturnValue = #True
        
      ; ---------- GrayBackColor ----------
      Case #PB_Gadget_GrayBackColor
        If Value = #PB_Default
          If IsDarkColorOT(\lButtonBackColor)
            \lGrayBackColor = DisabledDarkColorOT(\lButtonBackColor)
          Else
            \lGrayBackColor =  DisabledLightColorOT(\lButtonBackColor)
          EndIf
        Else
          \lGrayBackColor    = Value
        EndIf
        ReturnValue = #True
        
      ; ---------- FrontColor ----------
      Case #PB_Gadget_FrontColor
        If Value = #PB_Default
          If IsDarkColorOT(\lButtonBackColor)
            \lFrontColor = #White
          Else
            \lFrontColor = #Black
          EndIf
        Else
          \lFrontColor   = Value
        EndIf
        
        _SubSetObjectButtonColor(*ObjectTheme\PBGadgetType, #PB_Gadget_GrayTextColor)
        _SubSetObjectButtonColor(*ObjectTheme\PBGadgetType, #PB_Gadget_ShadowColor)
        ReturnValue = #True
        
      ; ---------- GrayTextColor ----------
      Case #PB_Gadget_GrayTextColor
        If Value = #PB_Default
          If IsDarkColorOT(\lFrontColor)
            \lGrayTextColor    = DisabledDarkColorOT(\lFrontColor)
          Else
            \lGrayTextColor    = DisabledLightColorOT(\lFrontColor)
          EndIf
        Else
          \lGrayTextColor      = Value
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
          If IsDarkColorOT(\lFrontColor)
            \lShadowColor          = #White
          Else
            \lShadowColor          = #Black
          EndIf
        Else
          \lShadowColor            = Value
        EndIf
        ReturnValue = #True
        
      ; ---------- BorderColor ----------
      Case #PB_Gadget_BorderColor
        If Value = #PB_Default
          If IsDarkColorOT(ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor)))
            \lBorderColor = \lButtonBackColor
          Else
            \lBorderColor = \lButtonOuterColor
          EndIf
        Else
          \lBorderColor            = Value
        EndIf
        ReturnValue = #True
        
      ; ---------- RoundX ----------
      Case #PB_Gadget_RoundX
        If Value = #PB_Default : Value = 8 : EndIf
        \lRoundX                   = Value
        ReturnValue = #True
        
      ; ---------- RoundY ----------
      Case #PB_Gadget_RoundY
        If Value = #PB_Default : Value = 8 : EndIf
        \lRoundY                   = Value
        ReturnValue = #True
        
    EndSelect
  EndWith
  
  If InitLevel = #True And Not UpdateButtonTheme(*ObjectTheme)
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
    \lButtonBackColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_BackColor)) 
    If \lButtonBackColor = #PB_Default
      \lButtonBackColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
      If \lButtonBackColor = #PB_Default
        \lButtonBackColor = GetSysColor_(#COLOR_WINDOW)
      EndIf
      If IsDarkColorOT(\lButtonBackColor) : \lButtonBackColor = AccentColorOT(\lButtonBackColor, 80) : EndIf  
    EndIf
    
    ; ---------- OuterColor ----------
    \lButtonOuterColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_OuterColor))
    If \lButtonOuterColor = #PB_Default
      \lButtonOuterColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
      If \lButtonOuterColor = #PB_Default
        \lButtonOuterColor = GetSysColor_(#COLOR_WINDOW)
      EndIf
      If Not IsDarkColorOT(\lButtonOuterColor) : \lButtonOuterColor = AccentColorOT(\lButtonOuterColor, -80) : EndIf
    EndIf
    
    ; ---------- CornerColor ----------
    \lButtonCornerColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_CornerColor))
    If \lButtonCornerColor = #PB_Default
      \lButtonCornerColor = ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor))
      If \lButtonCornerColor = #PB_Default
        \lButtonCornerColor = GetSysColor_(#COLOR_WINDOW)
      EndIf
    EndIf
    
    ; ---------- GrayBackColor ----------
    \lGrayBackColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_GrayBackColor))
    If \lGrayBackColor = #PB_Default
      If IsDarkColorOT(\lButtonBackColor)
        \lGrayBackColor = DisabledDarkColorOT(\lButtonBackColor)
      Else
        \lGrayBackColor =  DisabledLightColorOT(\lButtonBackColor)
      EndIf
    EndIf
    
    \iActiveFont  = SendMessage_(*ObjectTheme\IDGadget, #WM_GETFONT, 0, 0)
    
    ; ---------- FrontColor ----------
    \lFrontColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_FrontColor))
    If \lFrontColor = #PB_Default
      If IsDarkColorOT(\lButtonBackColor)
        \lFrontColor = #White
      Else
        \lFrontColor = #Black
      EndIf
    EndIf
    
    ; ---------- GrayTextColor ----------
    \lGrayTextColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_GrayTextColor))
    If \lGrayTextColor = #PB_Default
      If IsDarkColorOT(\lFrontColor)
        \lGrayTextColor = DisabledDarkColorOT(\lFrontColor)
      Else
        \lGrayTextColor = DisabledLightColorOT(\lFrontColor)
      EndIf
    EndIf
    
    ; ---------- EnableShadow ----------
    \bEnableShadow = ThemeAttribute(ObjectType + Str(#PB_Gadget_EnableShadow))
    If \bEnableShadow = #PB_Default : \bEnableShadow = 0 : EndIf
    
    ; ---------- ShadowColor ----------
    \lShadowColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_ShadowColor))
    If \lShadowColor = #PB_Default
      If IsDarkColorOT(\lFrontColor)
        \lShadowColor = #White
      Else
        \lShadowColor = #Black
      EndIf
    EndIf
    
    ; ---------- BorderColor ----------
    \lBorderColor = ThemeAttribute(ObjectType + Str(#PB_Gadget_BorderColor))
    If \lBorderColor = #PB_Default
      If IsDarkColorOT(ThemeAttribute(Str(#PB_WindowType) + "|" + Str(#PB_Gadget_BackColor)))
        \lBorderColor = \lButtonBackColor
      Else
        \lBorderColor = \lButtonOuterColor
      EndIf
    EndIf
    
    ; ---------- RoundX ----------
    \lRoundX = ThemeAttribute(ObjectType + Str(#PB_Gadget_RoundX))
    If \lRoundX = #PB_Default : \lRoundX = 8 : EndIf
    
    ; ---------- RoundY ----------
    \lRoundY = ThemeAttribute(ObjectType + Str(#PB_Gadget_RoundY))
    If \lRoundY = #PB_Default : \lRoundY = 8 : EndIf
    
    If \hRgn : DeleteObject_(\hRgn) : EndIf
    ;\hRgn         = CreateRoundRectRgn_(0, 0, DesktopScaledX(GadgetWidth(Gadget)), DesktopScaledY(GadgetHeight(Gadget)), \lRoundX, \lRoundY)
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
; -----------------------------------------------------------------------------
;- ----- IncludeFile -----
;    Positioned here after all SetWindowColor(), SetGadgetColor() to be done without calling macros and avoid an endless loop 
; -----------------------------------------------------------------------------
;

XIncludeFile "ObjectTheme_CreateGadget.pbi"
XIncludeFile "ObjectTheme_DataSection.pbi"

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
            ReturnValue = \lButtonBackColor
          Case #PB_Gadget_OuterColor
            ReturnValue = \lButtonOuterColor
          Case #PB_Gadget_CornerColor
            ReturnValue = \lButtonCornerColor
          Case #PB_Gadget_GrayBackColor
            ReturnValue = \lGrayBackColor
          Case #PB_Gadget_FrontColor
            ReturnValue = \lFrontColor
          Case #PB_Gadget_GrayTextColor
            ReturnValue = \lGrayTextColor
          Case #PB_Gadget_EnableShadow
            ReturnValue = \bEnableShadow
          Case #PB_Gadget_ShadowColor
            ReturnValue = \lShadowColor
          Case #PB_Gadget_BorderColor
            ReturnValue = \lBorderColor
          Case #PB_Gadget_RoundX
            ReturnValue = \lRoundX
          Case #PB_Gadget_RoundY
            ReturnValue = \lRoundY
        EndSelect
      EndWith
      
    Default  
      With *ObjectTheme\ObjectInfo
        Select Attribute
          Case #PB_Gadget_BackColor
            ReturnValue = \lBackColor
          Case #PB_Gadget_FrontColor
            ReturnValue = \lFrontColor
          Case #PB_Gadget_GrayTextColor
            ReturnValue = \lGrayTextColor
          Case #PB_Gadget_LineColor
            ReturnValue = \lLineColor
          Case #PB_Gadget_TitleBackColor 
            ReturnValue = \lTitleBackColor
          Case #PB_Gadget_TitleFrontColor
            ReturnValue = \lTitleFrontColor
          Case #PB_Gadget_ActiveTabColor 
            ReturnValue = \lActiveTabColor
          Case #PB_Gadget_InactiveTabColor 
            ReturnValue = \lInactiveTabColor
          Case #PB_Gadget_HighLightColor
            ReturnValue = \lHighLightColor
          Case #PB_Gadget_EditBoxColor
            ReturnValue = \lEditBoxColor
          Case #PB_Gadget_SplitterBorder
            ReturnValue = \bSplitterBorder
          Case #PB_Gadget_SplitterBorderColor
            ReturnValue = \lSplitterBorderColor
          Case #PB_Gadget_UseUxGripper
            ReturnValue = \bUseUxGripper
          Case #PB_Gadget_LargeGripper
            ReturnValue = \bLargeGripper
          Case #PB_Gadget_GripperColor
            ReturnValue = \lGripperColor
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
             #PB_GadgetType_Calendar, #PB_GadgetType_ExplorerList, #PB_GadgetType_ListIcon
          If \OldProc : SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, \OldProc) : EndIf          
          SetWindowTheme_(\IDGadget, 0, 0)
          FreeMemory(\ObjectInfo)
          DeleteMapElement(ObjectTheme())
          ReturnValue = #True
          
        Case #PB_GadgetType_Panel, #PB_GadgetType_Editor, #PB_GadgetType_Spin, #PB_GadgetType_String  
          SetWindowLongPtr_(\IDGadget, #GWL_STYLE, GetWindowLongPtr_(\IDGadget, #GWL_STYLE) &~ #TCS_OWNERDRAWFIXED)
          If \OldProc : SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, \OldProc) : EndIf   
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
          If \ObjectInfo\hObjSplitterGripper : DeleteObject_(\ObjectInfo\hObjSplitterGripper) : EndIf
          SetClassLongPtr_(\IDGadget, #GCL_STYLE, GetClassLongPtr_(\IDGadget, #GCL_STYLE) &~ #CS_DBLCLKS)
          SetWindowLongPtr_(\IDGadget, #GWL_STYLE, GetWindowLongPtr_(\IDGadget, #GWL_STYLE) &~ #WS_CLIPCHILDREN)
          If \OldProc : SetWindowLongPtr_(\IDGadget, #GWLP_WNDPROC, \OldProc) : EndIf 
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
  Protected Window, Object, ReturnValue, ObjectID, Buffer.s = Space(64) 
  
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
        CompilerIf Defined(Is_JellyButton, #PB_Procedure)
          If Not Is_JellyButton(Object)
            _AddButtonTheme(Object)
          EndIf
	CompilerElse
	  _AddButtonTheme(Object)
	CompilerEndIf
        
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
  
  CompilerIf #PB_Compiler_Debugger = #False
    CompilerIf #EnableOnError : OnErrorCall(@ErrorHandler()) : CompilerEndIf
  CompilerEndIf
  
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
            ; ----- Test OnError (Enable OnError line numbering support in the compiler options) -----
            ;Define DivBy0 = 2 : DivBy0 = DivBy0/0
            ; ----- Test ObjectTheme function -----
            ;SetObjectThemeAttribute(#PB_WindowType, #PB_Gadget_BackColor, #Cyan)
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
; EnableOnError