;- Top
;  -------------------------------------------------------------------------------------------------------------------------------------------------
;             Title: Demo Button for Object Theme Library (for Dark or Light Theme)
;       Description: This library will add and apply a theme color for All Windows and Gadgets.
;                    And for All possible color attributes (BackColor, FrontColor, TitleBackColor,...) for each of them
;                    All gadgets will still work in the same way as PureBasic Gadget
;       Source Name: ObjectTheme_DemoButton.pb
;            Author: ChrisR
;     Creation Date: 2023-11-06
; modification Date: 2023-11-25
;           Version: 1.4
;        PB-Version: 6.0 or other
;                OS: Windows Only
;             Forum: https://www.purebasic.fr/english/viewtopic.php?t=82890
;  -------------------------------------------------------------------------------------------------------------------------------------------------

;- ---> Add XIncludeFile "ObjectTheme.pbi"
XIncludeFile "ObjectTheme.pbi"

;- ---> UseModule ObjectTheme (Mandatory)
; To call macros directly (e.g. ButtonGadget) without having to change existing code and use ObjectTheme::ButtonGadget
UseModule ObjectTheme

Procedure Blue2RedColor(image)
  If StartDrawing( ImageOutput(image))
    Protected X, Y
    Protected WidthImage = ImageWidth(image)-1, HeightImage = ImageHeight(image)-1
    For X = 1 To WidthImage
      For Y = 1 To HeightImage
        If Point(X, Y) = 8613207
          Plot(X, Y, $4F3CA0)   ;RGB(160,60,79))
        EndIf
      Next
    Next
    StopDrawing()
  EndIf
EndProcedure

Procedure Resize_Window()
  Protected ScaleX.f, ScaleY.f
  Static Window_WidthIni, Window_HeightIni
  If Window_WidthIni = 0
    Window_WidthIni = WindowWidth(0) : Window_HeightIni = WindowHeight(0)
  EndIf
  
  ScaleX = WindowWidth(0) / Window_WidthIni : ScaleY = WindowHeight(0) / Window_HeightIni
  ResizeGadget(0, ScaleX * 40, ScaleY * 20 , ScaleX * 240, ScaleY * 60)
  ResizeGadget(1, ScaleX * 40, ScaleY * 100, ScaleX * 240, ScaleY * 60)
  ResizeGadget(2, ScaleX * 40, ScaleY * 180, ScaleX * 240, ScaleY * 60)
  ResizeGadget(3, ScaleX * 40, ScaleY * 260, ScaleX * 240, ScaleY * 60)
  
  ResizeGadget(4, ScaleX * 320, ScaleY * 20 , ScaleX * 240, ScaleY * 60)
  ResizeGadget(5, ScaleX * 320, ScaleY * 100, ScaleX * 240, ScaleY * 60)
  ResizeGadget(6, ScaleX * 320, ScaleY * 180, ScaleX * 240, ScaleY * 60)
  ResizeGadget(7, ScaleX * 320, ScaleY * 260, ScaleX * 240, ScaleY * 60)
EndProcedure

LoadFont(0, "", 9)
LoadFont(1, "", 9, #PB_Font_Italic)

LoadImage(0, #PB_Compiler_Home + "Examples/Sources/Data/PureBasic.bmp")
CopyImage(0, 1)
Blue2RedColor(1)
LoadImage(2, #PB_Compiler_Home + "Examples/Sources/Data/Background.bmp")

; ---> Add SetObjectTheme()
; It can be positioned anywhere in the code
; If it is at the beginning before the combobox creation, you don't need to add the 2 constants #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED for ComboBoxGadget()
;SetObjectTheme(#ObjectTheme_DarkBlue)

;- OpenWindow
If OpenWindow(0, 0, 0, 600, 340, "Button Demo ObjectTheme", #PB_Window_SystemMenu | #PB_Window_MinimizeGadget | #PB_Window_MaximizeGadget | #PB_Window_SizeGadget | #PB_Window_ScreenCentered)
  SetGadgetFont(#PB_Default, FontID(0))
  ButtonGadget(0, 40, 20,  240, 60, "Apply Light Blue Theme")
  ButtonGadget(1, 40, 100, 240, 60, "Change Text Color and RoundXY for this  MultiLine ObjectTheme Gadget",  #PB_Button_MultiLine)
  ButtonGadget(2, 40, 180, 240, 60, "Toggle Button (ON)", #PB_Button_Toggle)
  SetGadgetState(2, #True)
  GadgetToolTip(2, "Toggle CheckBox (ON/OFF)")
  ButtonGadget(3, 40, 260, 240, 60, "Disabled CheckBox")
  DisableGadget(3, #True)
  
  ButtonImageGadget(4, 320, 20,  240, 60, ImageID(0))
  ButtonImageGadget(5, 320, 100, 240, 60, 0)
  SetGadgetAttribute(5, #PB_Button_Image, ImageID(2))
  SetWindowLongPtr_(GadgetID(5), #GWL_STYLE, GetWindowLongPtr_(GadgetID(5), #GWL_STYLE) | #BS_MULTILINE)
  SetGadgetText(5, "Change Text Color and RoundXY for this  MultiLine ObjectThemeImage Gadget")
  ButtonImageGadget(6, 320, 180, 240, 60, ImageID(0), #PB_Button_Toggle)
  SetGadgetAttribute(6, #PB_Button_PressedImage, ImageID(1))
  SetGadgetState(6, #True)
  ButtonImageGadget(7, 320, 260, 240, 60, ImageID(0))
  DisableGadget(7, #True)
  
  ;- ---> Add SetObjectTheme()
  ; It can be positioned anywhere in the code
  ; If it is at the beginning before the combobox creation, you don't need to add the 2 constants #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED for ComboBoxGadget()
  SetObjectTheme(#ObjectTheme_DarkBlue)
  
  BindEvent(#PB_Event_SizeWindow, @Resize_Window(), 0)
  PostEvent(#PB_Event_SizeWindow, 0, 0)
  
  WindowBounds(0, 480, 300, #PB_Ignore, #PB_Ignore)
  
  ;- Event loop
  Repeat
    Select WaitWindowEvent()
      Case #PB_Event_CloseWindow
        Break
        
      Case #PB_Event_Gadget
        Select EventGadget()
          Case 0   ; Apply Dark or Light Blue theme
            Select GetObjectTheme()
              Case #ObjectTheme_DarkBlue
                SetGadgetText(0, "Apply Dark Blue Theme")
                SetObjectTheme(#ObjectTheme_LightBlue)
                ; ---------------------------------------------------------------------------------------------------
                ;   Comment/Uncomment for Testing: SetObjectThemeAttribute, SetObjectColor, FreeObjectTheme,...
                ; ---------------------------------------------------------------------------------------------------
                ;SetObjectThemeAttribute(#PB_WindowType, #PB_Gadget_BackColor, $3838FF)
                ;SetObjectThemeAttribute(#PB_GadgetType_Button, #PB_Gadget_BackColor, $2880FC)
                ;SetObjectTypeColor(#PB_GadgetType_Button, #PB_Gadget_FrontColor, #Red)
                ;FreeObjectTheme()
              Case #ObjectTheme_LightBlue
                SetGadgetText(0, "Apply Light Blue tTheme")
                SetObjectTheme(#ObjectTheme_DarkBlue)
            EndSelect
            
          Case 1, 5   ; Change Text Button Color in Red or with the Text color from the theme attribute. And Change RoundXY
            If GetObjectColor(EventGadget(), #PB_Gadget_FrontColor) = #Red
              SetGadgetFont(EventGadget(), FontID(0))
              SetObjectColor(EventGadget(), #PB_Gadget_FrontColor, GetObjectThemeAttribute(#PB_GadgetType_Button, #PB_Gadget_FrontColor))
              SetObjectColor(EventGadget(), #PB_Gadget_RoundX, GetObjectThemeAttribute(#PB_GadgetType_Button, #PB_Gadget_RoundX))
              SetObjectColor(EventGadget(), #PB_Gadget_RoundY, GetObjectThemeAttribute(#PB_GadgetType_Button, #PB_Gadget_RoundY))
            Else
              SetGadgetFont(EventGadget(), FontID(1))
              SetObjectColor(EventGadget(), #PB_Gadget_FrontColor, #Red)
              SetObjectColor(EventGadget(), #PB_Gadget_RoundX, 24)
              SetObjectColor(EventGadget(), #PB_Gadget_RoundY, 24)
            EndIf
            ;Define Color = GetObjectColor(EventGadget(), #PB_Gadget_FrontColor)
            ;Debug "ObjectTheme RoundXY = " + Str(GetObjectColor(EventGadget(), #PB_Gadget_RoundX)) + " * " + Str(GetObjectColor(EventGadget(), #PB_Gadget_RoundY)) + " - Text Color RGB(" + Str(Red(Color)) + ", " + Str(Green(Color)) + ", " + Str(Blue(Color)) + ") - Font Italic"
            
          Case 2   ; Toggle Button (ON/OFF)
            If GetGadgetState(2)
              SetGadgetText(2, "Toggle Button (ON)")
            Else
              SetGadgetText(2, "Toggle Button (OFF)")
            EndIf
            
        EndSelect
    EndSelect
  ForEver
  
EndIf

; IDE Options = PureBasic 6.03 LTS (Windows - x64)
; EnableXP
; DPIAware