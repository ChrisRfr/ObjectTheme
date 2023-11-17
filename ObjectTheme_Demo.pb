;- Top
;  -------------------------------------------------------------------------------------------------------------------------------------------------
;          Title: Demo for Object Theme Library (for Dark or Light Theme)
;    Description: This library will add and apply a theme color for All Windows and Gadgets.
;                 And for All possible color attributes (BackColor, FrontColor, TitleBackColor,...) for each of them
;                 All gadgets will still work in the same way as PureBasic Gadget
;    Source Name: ObjectTheme_Demo.pb
;         Author: ChrisR
;  Creation Date: 2023-11-06
;        Version: 1.0
;     PB-Version: 6.0 or other
;             OS: Windows Only
;          Forum: https://www.purebasic.fr/english/viewtopic.php?t=82592
;  -------------------------------------------------------------------------------------------------------------------------------------------------

EnableExplicit

;- ---> Add XIncludeFile "ObjectTheme.pbi"
XIncludeFile "ObjectTheme.pbi"

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
EndEnumeration

LoadImage(#Imag, #PB_Compiler_Home + "examples/sources/Data/world.png")

Procedure ProgressBarDemo(Gadget)
  If GadgetType(Gadget) <> #PB_GadgetType_ProgressBar : ProcedureReturn : EndIf
  Protected I
  For I = 0 To 100
    SetGadgetState(Gadget, I)
    Delay(10)
  Next
  SetGadgetState(Gadget, 66)
EndProcedure

Procedure Open_Window_1(X = 20, Y = 20, Width = 580, Height = 460)
  Protected I
  If OpenWindow(#Window_1, X, Y, Width, Height, "Demo ObjectTheme Window_1", #PB_Window_MinimizeGadget | #PB_Window_SystemMenu)
    
    ButtonGadget(#ApplyTheme_1, 20, 390, 540, 50, "Apply Dark Blue Theme", #PB_Button_Default)
    
    ContainerGadget(#Cont_1, 20, 20, 320, 70, #PB_Container_Flat)
    TextGadget(#Txt_2, 5, 5, 150, 20, "Container")
    CheckBoxGadget(#Check_1, 20, 20, 130, 30, "Disable Gadgets")
    OptionGadget(#Opt_1, 170, 10, 130, 24, "Option_1")
    OptionGadget(#Opt_2, 170, 35, 130, 24, "Option_2")
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
    
    ComboBoxGadget(#Combo_1, 20, 102, 180, 28, #PB_ComboBox_Editable | #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED)
    SendMessage_(GadgetID(#Combo_1), #CB_SETMINVISIBLE, 5, 0)   ; Only 5 elements visible to display the ScrollBar for the Dark or Explorer theme
    For I = 1 To 10 : AddGadgetItem(#Combo_1, -1, "Combo Editable Element " + Str(I)) : Next
    SetGadgetState(#Combo_1, 0)
    
    AddGadgetItem(#Panel_1, -1, "Tab_1", ImageID(#Imag))
    AddGadgetItem(#Panel_1, -1, "Tab_2", ImageID(#Imag))
    CloseGadgetList()   ; #Panel_1
  EndIf
EndProcedure

Procedure Open_Window_2(X = 620, Y = 20, Width = 420, Height = 460)
  Protected I
  If OpenWindow(#Window_2, X, Y, Width, Height, "Demo ObjectTheme Window_2", #PB_Window_MinimizeGadget | #PB_Window_SystemMenu)
    
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
    
    ComboBoxGadget(#Combo_3, 200, 112, 150, 28, #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED)
    SendMessage_(GadgetID(#Combo_3), #CB_SETMINVISIBLE, 5, 0)   ; Only 5 elements visible to display the ScrollBar for the Dark or Explorer theme
    For I = 1 To 10 : AddGadgetItem(#Combo_3, -1, "Combo Element " + Str(I)) : Next
    SetGadgetState(#Combo_3, 0)
    
    CloseGadgetList()   ; #ScrlArea_1
  EndIf
EndProcedure

; Uncomment for Testing with a Font 
; SetGadgetFont(#PB_Default, FontID(#Font))

;- ---> Add SetObjectTheme()
; If it is at the beginning before the combobox creation, you don't need to add the 2 constants #CBS_HASSTRINGS | #CBS_OWNERDRAWFIXED for ComboBoxGadget(), it's auto done
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
          ; For Testing
          ;SetObjectThemeAttribute(0, #PB_Gadget_BackColor,  #Red)
          ;SetObjectTypeColor(#PB_GadgetType_Button, #PB_Gadget_FrontColor, #Red)
          ;SetObjectColor(#Progres_1, #PB_Gadget_BackColor,  #Yellow)
          ;SetObjectColor(#Progres_1, #PB_Gadget_FrontColor, #Red)
          ; For Testing Disabled Gadgets
          If GetGadgetState(#Check_1) = #PB_Checkbox_Checked
            If IsWindow(#Window_1)
              DisableGadget(#Txt_1, #True) : DisableGadget(#Txt_2, #True) : DisableGadget(#Opt_1, #True) : DisableGadget(#Opt_2, #True) : DisableGadget(#Edit_1, #True)
              DisableGadget(#Date_1, #True) : DisableGadget(#Frame_1, #True) : DisableGadget(#ListIcon_1, #True) : DisableGadget(#Hyper_1, #True)
              DisableGadget(#Progres_1, #True) : DisableGadget(#Spin_1, #True) : DisableGadget(#String_1, #True) : DisableGadget(#Splitter_1, #True)
              DisableGadget(#Panel_1, #True) : DisableGadget(#Calend_1, #True) : DisableGadget(#Combo_1, #True) : DisableGadget(#ApplyTheme_1, #True)
            EndIf
            If IsWindow(#Window_2)
              DisableGadget(#ExpList_1, #True) : DisableGadget(#ExpTree_1, #True) : DisableGadget(#ListView_1, #True) : DisableGadget(#Splitter_2, #True) : DisableGadget(#Combo_2, #True)
              DisableGadget(#ScrlArea_1, #True) : DisableGadget(#Cont_2, #True) : DisableGadget(#Track_1, #True) : DisableGadget(#Scrlbar_1, #True)
              DisableGadget(#Tree_1, #True) : DisableGadget(#String_2, #True) : DisableGadget(#Combo_3, #True) : DisableGadget(#ApplyTheme_2, #True)
            EndIf
          Else
            If IsWindow(#Window_1)
              DisableGadget(#Txt_1, #False) : DisableGadget(#Txt_2, #False) : DisableGadget(#Opt_1, #False) : DisableGadget(#Opt_2, #False) : DisableGadget(#Edit_1, #False)
              DisableGadget(#Date_1, #False) : DisableGadget(#Frame_1, #False) : DisableGadget(#ListIcon_1, #False) : DisableGadget(#Hyper_1, #False)
              DisableGadget(#Progres_1, #False) : DisableGadget(#Spin_1, #False) : DisableGadget(#String_1, #False) : DisableGadget(#Splitter_1, #False)
              DisableGadget(#Panel_1, #False) : DisableGadget(#Calend_1, #False) : DisableGadget(#Combo_1, #False) : DisableGadget(#ApplyTheme_1, #False)
            EndIf
            If IsWindow(#Window_2)
              DisableGadget(#ExpList_1, #False) : DisableGadget(#ExpTree_1, #False) : DisableGadget(#ListView_1, #False) : DisableGadget(#Splitter_2, #False) : DisableGadget(#Combo_2, #False)
              DisableGadget(#ScrlArea_1, #False) : DisableGadget(#Cont_2, #False) : DisableGadget(#Track_1, #False) : DisableGadget(#Scrlbar_1, #False)
              DisableGadget(#Tree_1, #False) : DisableGadget(#String_2, #False) : DisableGadget(#Combo_3, #False) : DisableGadget(#ApplyTheme_2, #False)
            EndIf
          EndIf
          
        Case #ApplyTheme_1
          Select GetGadgetText(#ApplyTheme_1)
            Case "Apply Light Blue Theme"
              SetGadgetText(#ApplyTheme_1, "Apply Dark Blue Theme")
              SetObjectTheme(#ObjectTheme_LightBlue)
            Case "Apply Dark Blue Theme"
              SetGadgetText(#ApplyTheme_1, "Apply Light Blue Theme")
              SetObjectTheme(#ObjectTheme_DarkBlue)
          EndSelect
          
        Case #ApplyTheme_2
          Define Color = ColorRequester(GetWindowColor(#Window_2))
          SetObjectTheme(#ObjectTheme_Auto, Color)
          
      EndSelect
  EndSelect
ForEver

; IDE Options = PureBasic 6.03 LTS (Windows - x64)
; EnableXP
; DPIAware