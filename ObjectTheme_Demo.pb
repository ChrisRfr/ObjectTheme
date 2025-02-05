;- Top
;  -------------------------------------------------------------------------------------------------------------------------------------------------
;             Title: Demo for Object Theme Library (for Dark or Light Theme)
;       Description: This library will add and apply a theme color for All Windows and Gadgets.
;                    And for All possible color attributes (BackColor, FrontColor, TitleBackColor,...) for each of them
;                    All gadgets will still work in the same way as PureBasic Gadget
;       Source Name: ObjectTheme_Demo.pb
;            Author: ChrisR
;     Creation Date: 2023-11-06
; modification Date: 2025-01-09
;           Version: 1.6
;        PB-Version: 6.0 or other
;                OS: Windows Only
;             Forum: https://www.purebasic.fr/english/viewtopic.php?t=82890
;  -------------------------------------------------------------------------------------------------------------------------------------------------

EnableExplicit

;- ---> Add XIncludeFile "ObjectTheme.pbi"
XIncludeFile "ObjectTheme.pbi"

;- ---> UseModule ObjectTheme (Mandatory)
; To call macros directly (e.g. ButtonGadget) without having to change existing code and use ObjectTheme::ButtonGadget
UseModule ObjectTheme

UseJPEGImageDecoder()
UsePNGImageDecoder()

Enumeration Window
  #Window_1
  #Window_2
EndEnumeration

Enumeration Gadgets
  #Cont_1
  #Txt_2
  #Check_1
  #Opt_1
  #Opt_2
  #Edit_1
  #ExpList_1
  #ExpTree_1
  #Date_1
  #Frame_1
  #ListIcon_1
  #ListView_1
  #Hyper_1
  #Progres_1
  #Spin_1
  #String_1
  #Txt_1
  #Scrlbar_1
  #Splitter_1
  #Splitter_2
  #Track_1
  #Tree_1
  #String_2
  #Panel_1
  #ScrlArea_1
  #Cont_2
  #Calend_1
  #Combo_1
  #Combo_2
  #Combo_3
  #ApplyTheme_1
  #ApplyTheme_2
EndEnumeration

Enumeration Font
  #Font
EndEnumeration

LoadFont(#Font, "Consolas", 9)

Enumeration Image
  #Imag
  #Imag_Wood
  #Imag_clouds
EndEnumeration

LoadImage(#Imag_Wood,   #PB_Compiler_Home + "Examples\3D\Data\Textures\Wood.jpg")
LoadImage(#Imag_clouds, #PB_Compiler_Home + "Examples\3D\Data\Textures\clouds.jpg")
LoadImage(#Imag, #PB_Compiler_Home + "examples/sources/Data/world.png")

Procedure Open_Window_1(X = 20, Y = 20, Width = 580, Height = 460)
  Protected I, BrushBackground
  If OpenWindow(#Window_1, X, Y, Width, Height, "Demo ObjectTheme Window_1", #PB_Window_MinimizeGadget | #PB_Window_SystemMenu)
    
    ResizeImage(#Imag_Wood, DesktopScaledX(Width), DesktopScaledY(Height))
    BrushBackground = CreatePatternBrush_(ImageID(#Imag_Wood))
    If BrushBackground
      SetClassLongPtr_(WindowID(#Window_1), #GCL_HBRBACKGROUND, BrushBackground)
      InvalidateRect_(WindowID(#Window_1), #Null, #True)
    EndIf
    ButtonGadget(#ApplyTheme_1, 20, 390, 540, 50, "Apply Dark Blue Theme", #PB_Button_Default)
    
    ContainerGadget(#Cont_1, 20, 20, 320, 70, #PB_Container_Flat)
    TextGadget(#Txt_2, 5, 5, 150, 20, "Container")
    CheckBoxGadget(#Check_1, 20, 20, 160, 30, "Add Image Background")
    OptionGadget(#Opt_1, 180, 10, 120, 24, "Option_1")
    OptionGadget(#Opt_2, 180, 35, 120, 24, "Option_2")
    SetGadgetState(#Opt_1, #True)
    CloseGadgetList()   ; #Cont_1
    
    EditorGadget(#Edit_1, 360, 20, 200, 70)
    For I = 1 To 5 : AddGadgetItem(#Edit_1, -1, "Editor Line " + Str(I)) : Next
    ListViewGadget(#ListView_1, 360, 80, 200, 80)
    For I = 1 To 5 : AddGadgetItem(#ListView_1, -1, "ListView Element " + Str(I)) : Next
    SplitterGadget(#Splitter_1, 360, 20, 200, 160, #Edit_1, #ListView_1, #PB_Splitter_Separator)
    SetGadgetState(#Splitter_1, 70)
    
    FrameGadget(#Frame_1, 20, 110, 150, 60, "Frame_1");  : DisableGadget(#Frame_1, #True)
    TextGadget(#Txt_1, 40, 135, 100, 20, "This is a Text"); : DisableGadget(#Txt_1, #True)
    HyperLinkGadget(#Hyper_1, 190, 110, 160, 20, "https://www.purebasic.com/", $FF2600, #PB_HyperLink_Underline)
    DateGadget(#Date_1, 190, 140, 110, 30, "%yyyy-%mm-%dd", 0)
    CalendarGadget(#Calend_1, 20, 195, 240, 180)
    
    PanelGadget(#Panel_1, 280, 195, 280, 180)
    AddGadgetItem(#Panel_1, -1, "Tab_0", ImageID(#Imag))
    ProgressBarGadget(#Progres_1, 20, 20, 160, 16, 0, 100)
    SetGadgetState(#Progres_1, 66)
    SpinGadget(#Spin_1, 20, 56, 80, 26, 0, 100, #PB_Spin_Numeric)
    SetGadgetState(#Spin_1, 66)
    StringGadget(#String_1, 110, 56, 150, 26, "String_1")
    
    ComboBoxGadget(#Combo_1, 20, 102, 180, 28, #PB_ComboBox_Editable)   ; #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED flags will be auto added with SetObjectTheme() done before the combobox creation
    SendMessage_(GadgetID(#Combo_1), #CB_SETMINVISIBLE, 5, 0)   ; Only 5 elements visible to display the ScrollBar for the Dark or Explorer theme
    For I = 1 To 10 : AddGadgetItem(#Combo_1, -1, "Combo Editable Element " + Str(I)) : Next
    SetGadgetState(#Combo_1, 0)
    
    AddGadgetItem(#Panel_1, -1, "Tab_1", ImageID(#Imag))
    AddGadgetItem(#Panel_1, -1, "Tab_2", ImageID(#Imag))
    CloseGadgetList()   ; #Panel_1
  EndIf
EndProcedure

Procedure Open_Window_2(X = 620, Y = 20, Width = 420, Height = 460)
  Protected I, BrushBackground
  If OpenWindow(#Window_2, X, Y, Width, Height, "Demo ObjectTheme Window_2", #PB_Window_MinimizeGadget | #PB_Window_SystemMenu)
    ResizeImage(#Imag_clouds, DesktopScaledX(Width), DesktopScaledY(Height))
    BrushBackground = CreatePatternBrush_(ImageID(#Imag_clouds))
    If BrushBackground
      SetClassLongPtr_(WindowID(#Window_2), #GCL_HBRBACKGROUND, BrushBackground)
      InvalidateRect_(WindowID(#Window_1), #Null, #True)
    EndIf
    
    ButtonGadget(#ApplyTheme_2, 20, 390, 380, 50, "Apply Auto Theme With Selected Color", #PB_Button_Default)
    
    ListIconGadget(#ListIcon_1, 20, 20, 180, 90, "ListIcon", 120)
    AddGadgetColumn(#ListIcon_1, 1, "Column 2", 240)
    For I = 1 To 5 : AddGadgetItem(#ListIcon_1, -1, "ListIcon Element " + Str(I) +Chr(10)+ "Column 2 Element " + Str(I)) : Next
    ExplorerListGadget(#ExpList_1, 220, 20, 180, 90, "")
    SplitterGadget(#Splitter_2, 20, 20, 380, 90, #ListIcon_1, #ExpList_1, #PB_Splitter_Vertical | #PB_Splitter_Separator)
    SetGadgetState(#Splitter_2, 180)
    ExplorerTreeGadget(#ExpTree_1, 20, 120, 180, 60, "")
    
    ComboBoxGadget(#Combo_2, 220, 137, 180, 28, #PB_ComboBox_Image)   ; Partially Draw: Only the selected item is drawn but not the drop-down list
    SendMessage_(GadgetID(#Combo_2), #CB_SETMINVISIBLE, 5, 0)
    For I = 1 To 10 : AddGadgetItem(#Combo_2, -1, "Combo Image Elem " + Str(I), ImageID(#Imag)) : Next
    SetGadgetState(#Combo_2, 0)
    
    ScrollAreaGadget(#ScrlArea_1, 20, 195, 380, 180, 540, 300, 10, #PB_ScrollArea_Flat)
    ContainerGadget(#Cont_2, 10, 15, 340, 50, #PB_Container_Flat)
    TrackBarGadget(#Track_1, 10, 10, 150, 30, 0, 100)
    SetGadgetState(#Track_1, 66)
    ScrollBarGadget(#Scrlbar_1, 170, 10, 150, 20, 0, 100, 10)
    CloseGadgetList()   ; #Cont_2
    TreeGadget(#Tree_1, 10, 80, 180, 60)
    AddGadgetItem(#Tree_1, -1, "Element 1", 0,  0)
    AddGadgetItem(#Tree_1, -1, "Node", 0,  0)
    AddGadgetItem(#Tree_1, -1, "Sub-element", 0,  1)
    AddGadgetItem(#Tree_1, -1, "Element 2", 0,  0)
    SetGadgetItemState(#Tree_1, 1, #PB_Tree_Expanded)
    StringGadget(#String_2, 200, 80, 150, 25, "String_2")
    
    ComboBoxGadget(#Combo_3, 200, 112, 150, 28)   ; #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED flags will be auto added with SetObjectTheme() done before the combobox creation
    SendMessage_(GadgetID(#Combo_3), #CB_SETMINVISIBLE, 5, 0)   ; Only 5 elements visible to display the ScrollBar for the Dark or Explorer theme
    For I = 1 To 10 : AddGadgetItem(#Combo_3, -1, "Combo Element " + Str(I)) : Next
    SetGadgetState(#Combo_3, 0)
    
    CloseGadgetList()   ; #ScrlArea_1
  EndIf
EndProcedure

; Uncomment for Testing with a Font 
; SetGadgetFont(#PB_Default, FontID(#Font))

;- ---> Add SetObjectTheme()
; It can be positioned anywhere in the code
; If it is at the beginning before the combobox creation, you don't need to add the 2 constants #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED for ComboBoxGadget()
SetObjectTheme(#ObjectTheme_LightBlue)

Open_Window_1()
Open_Window_2()

Repeat
  Select WaitWindowEvent()
    Case #PB_Event_CloseWindow
      CloseWindow(EventWindow())
      If Not (IsWindow(#Window_1) Or IsWindow(#Window_2))
        Break
      EndIf
      
    Case #PB_Event_Gadget
      Select EventGadget()
        Case #Check_1                             
          If GetGadgetState(#Check_1)
            SetObjectThemeAttribute(#PB_WindowType, #PB_Gadget_BrushBackground, #True)
          Else
            SetObjectThemeAttribute(#PB_WindowType, #PB_Gadget_BrushBackground, #False)
          EndIf
          ; For Testing
          ;SetObjectThemeAttribute(0, #PB_Gadget_BackColor,  #Red)
          ;SetWindowColor(#Window_1, #Red)
          ;SetObjectTypeColor(#PB_GadgetType_Button, #PB_Gadget_FrontColor, #Red)
          ;SetObjectColor(#Progres_1, #PB_Gadget_BackColor,  #Yellow)
          ;SetObjectColor(#Progres_1, #PB_Gadget_FrontColor, #Red)
          ;SetGadgetColor(#Progres_1, #PB_Gadget_BackColor,  #Yellow)
          ;SetGadgetColor(#Progres_1, #PB_Gadget_FrontColor, #Red)
          
        Case #ApplyTheme_1
          Select GetGadgetText(#ApplyTheme_1)
            Case "Apply Dark Blue Theme"
              SetGadgetText(#ApplyTheme_1, "Apply Dark Red Theme")
              SetObjectTheme(#ObjectTheme_DarkBlue)
            Case "Apply Light Blue Theme"
              SetGadgetText(#ApplyTheme_1, "Apply Dark Blue Theme")
              SetObjectTheme(#ObjectTheme_LightBlue)
            Case "Apply Dark Red Theme"
              SetGadgetText(#ApplyTheme_1, "Apply Light Blue Theme")
              SetObjectTheme(#ObjectTheme_DarkRed)
          EndSelect
          If GetGadgetState(#Check_1)
            SetObjectThemeAttribute(#PB_WindowType, #PB_Gadget_BrushBackground, #True)
          Else
            SetObjectThemeAttribute(#PB_WindowType, #PB_Gadget_BrushBackground, #False)
          EndIf
          
        Case #ApplyTheme_2
          Define Color = ColorRequester(GetWindowColor(#Window_2))
          SetObjectTheme(#ObjectTheme_Auto, Color)
          If GetGadgetState(#Check_1)
            SetObjectThemeAttribute(#PB_WindowType, #PB_Gadget_BrushBackground, #True)
          Else
            SetObjectThemeAttribute(#PB_WindowType, #PB_Gadget_BrushBackground, #False)
          EndIf
          
      EndSelect
  EndSelect
ForEver
