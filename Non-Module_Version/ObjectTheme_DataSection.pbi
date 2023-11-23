;- Top
;  -------------------------------------------------------------------------------------------------------------------------------------------------
;             Title: Include File for Object Theme Library (for Dark or Light Theme)
;       Description: This library will add and apply a theme color for All Windows and Gadgets.
;                    And for All possible color attributes (BackColor, FrontColor, TitleBackColor,...) for each of them
;                    All gadgets will still work in the same way as PureBasic Gadget
;       Source Name: ObjectTheme_CreatzeGadget.pbi
;            Author: ChrisR
;     Creation Date: 2023-11-06
; modification Date: 2023-11-23
;           Version: 1.3
;        PB-Version: 6.0 or other
;                OS: Windows Only
;             Forum: https://www.purebasic.fr/english/viewtopic.php?t=82890
;  -------------------------------------------------------------------------------------------------------------------------------------------------

CompilerIf Defined(PB_WindowType, #PB_Constant)
  ;
  ; -----------------------------------------------------------------------------
  ;- ----- Define Themes in DataSection -----
  ; -----------------------------------------------------------------------------
  ;
  
  DataSection
    ; -------------------------------------------------------------------------------------------------------------------
    ;- DarkBlue Theme
    ; -------------------------------------------------------------------------------------------------------------------
    DarkBlue:
    Data.l #PB_WindowType,                 #PB_Gadget_BackColor,             $292521         ; Back Window Color: Color | #PB_Default = SetObjectTheme(Theme, WindowColor) else GetSysColor_(#COLOR_WINDOW)
    Data.l #PB_WindowType,                 #PB_Gadget_DarkMode,              #PB_Default     ; Enable Dark Mode: 0 | 1 | #PB_Default = If IsDarkColor Window, DarkMode_Explorer Theme else Explorer Theme
    
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_TitleBackColor,        #PB_Default     ; Title Back Color: Color | #PB_Default = BackColor
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_CheckBox,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_CheckBox,        #PB_Gadget_FrontColor,            #White          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_CheckBox,        #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_HighLightColor,        #PB_Default     ; HighLight Color: Color | #PB_Default = GetSysColor_(#COLOR_HIGHLIGHT)
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_EditBoxColor,          $382521         ; Back Color: Color | #PB_Default = If IsDarkColor BackColor, Accentolor(15) else Accentolor(-15)
    
    Data.l #PB_GadgetType_Container,       #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    
    Data.l #PB_GadgetType_Date,            #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Date,            #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Date,            #PB_Gadget_TitleBackColor,        #PB_Default     ; Title Back Color: Color | #PB_Default = BackColor
    Data.l #PB_GadgetType_Date,            #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_Editor,          #PB_Gadget_BackColor,             $382521         ; Back Color: Color | #PB_Default = If IsDarkColor Window BackColor, Accentolor(15) else Accentolor(-15)
    Data.l #PB_GadgetType_Editor,          #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Blackault
    
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_TitleBackColor,        $603421         ; Title Back Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) else AccentColor(-40)
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_ExplorerTree,    #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ExplorerTree,    #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ExplorerTree,    #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    
    Data.l #PB_GadgetType_Frame,           #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Frame,           #PB_Gadget_FrontColor,            #White          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Frame,           #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_HyperLink,       #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_HyperLink,       #PB_Gadget_FrontColor,            #White          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_TitleBackColor,        $603421         ; Title Back Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) else AccentColor(-40)
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_ListView,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ListView,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_Option,          #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Option,          #PB_Gadget_FrontColor,            #White          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Option,          #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_ActiveTabColor,        $603421         ; Active Tab Color: Color | #PB_Default = BackColor
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_InactiveTabColor,      #PB_Default     ; Inactive Tab Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) else AccentColor(-40)
    
    Data.l #PB_GadgetType_ProgressBar,     #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ProgressBar,     #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_ScrollArea,      #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    
    Data.l #PB_GadgetType_Spin,            #PB_Gadget_BackColor,             $382521         ; Back Color: Color | #PB_Default = If IsDarkColor Window BackColor, Accentolor(15) else Accentolor(-15)
    Data.l #PB_GadgetType_Spin,            #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_BackColor,             $603421         ; Back Color: Color | #PB_Default = If IsDarkColor Window BackColor, Accentolor(30) else Accentolor(-30)
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_FrontColor,            $6EFD0D         ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_SplitterBorder,        #True           ; Enable Splitter Border: 0 | 1 | #PB_Default = 1
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_SplitterBorderColor,   $BA9E74         ; Splitter Border Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(60) Else AccentColor(-60)
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_UseUxGripper,          #False          ; Splitter Gripper:  0 = Custom | 1 = Uxtheme | #PB_Default = #False        ; #False = Custom, #True = Uxtheme. For Splitter
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_GripperColor,          $7C4D09         ; Splitter Gripper Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) Else AccentColor(-40)
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_LargeGripper,          #True           ; Large Splitter Gripper: 0 | 1 | #PB_Default = 1
    
    Data.l #PB_GadgetType_String,          #PB_Gadget_BackColor,             $382521         ; Back Color: Color | #PB_Default = If IsDarkColor Window BackColor, Accentolor(15) Else Accentolor(-15)
    Data.l #PB_GadgetType_String,          #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_Text,            #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Text,            #PB_Gadget_FrontColor,            #White          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Text,            #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_TrackBar,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_TrackBar,        #PB_Gadget_FrontColor,            #White          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_TrackBar,        #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_Tree,            #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Tree,            #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Tree,            #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    
    Data.l #PB_GadgetType_Button,          #PB_Gadget_BackColor,             $FD6E0D         ; Border Color: Color | #PB_Default = Window BackColor. If IsDarkColor AccentColor 80
    Data.l #PB_GadgetType_Button,          #PB_Gadget_OuterColor,            $292521         ; Outer Color: Color | #PB_Default = Window BackColor. If not IsDarkColor AccentColor 80
    Data.l #PB_GadgetType_Button,          #PB_Gadget_CornerColor,           #PB_Default     ; Corner Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_GrayBackColor,         #PB_Default     ; Gray Back Color: Color | #PB_Default = Disabled Button BackColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_FrontColor,            #White          ; Text Color: Color | #PB_Default = If IsDarkColor Button BackColor White else Black
    Data.l #PB_GadgetType_Button,          #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disabled Button FrontColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_EnableShadow,          1               ; Enable Shadow Color 0 | 1 | #PB_Default = 0
    Data.l #PB_GadgetType_Button,          #PB_Gadget_ShadowColor,           $292521         ; Shadow Color: Color | #PB_Default = If IsDarkColor Button FrontColor White else Black
    Data.l #PB_GadgetType_Button,          #PB_Gadget_BorderColor,           #PB_Default     ; Border Color: Color | #PB_Default = if IsDarkColor(Window) Button BackColor else Button OuterColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_RoundX,                8               ; The radius of the RoundBox corners in the x direction
    Data.l #PB_GadgetType_Button,          #PB_Gadget_RoundY,                8               ; The radius of the RoundBox corners in the y direction
    
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_BackColor,             $FD6E0D         ; Border Color: Color | #PB_Default = Window BackColor. If IsDarkColor AccentColor 80
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_OuterColor,            $292521         ; Outer Color: Color | #PB_Default = Window BackColor. If not IsDarkColor AccentColor 80
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_CornerColor,           #PB_Default     ; Corner Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_GrayBackColor,         #PB_Default     ; Gray Back Color: Color | #PB_Default = Disabled Button BackColor
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_FrontColor,            #White          ; Text Color: Color | #PB_Default = If IsDarkColor Button BackColor White else Black
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disabled Button FrontColor
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_EnableShadow,          1               ; Enable Shadow Color 0 | 1 | #PB_Default = 0
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_ShadowColor,           $292521         ; Shadow Color: Color | #PB_Default = If IsDarkColor Button FrontColor White else Black
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_BorderColor,           #PB_Default     ; Border Color: Color | #PB_Default = if IsDarkColor(Window) Button BackColor else Button OuterColor
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_RoundX,                8               ; The radius of the RoundBox corners in the x direction
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_RoundY,                8               ; The radius of the RoundBox corners in the y direction
    Data.l #PB_Gadget_END
    
    ; -------------------------------------------------------------------------------------------------------------------
    ;- DarkRed Theme
    ; -------------------------------------------------------------------------------------------------------------------
    DarkRed:
    Data.l #PB_WindowType,                 #PB_Gadget_BackColor,             $060928         ; Back Window Color: Color | #PB_Default = SetObjectTheme(Theme, WindowColor) else GetSysColor_(#COLOR_WINDOW)
    Data.l #PB_WindowType,                 #PB_Gadget_DarkMode,              #PB_Default     ; Enable Dark Mode: 0 | 1 | #PB_Default = If IsDarkColor Window, DarkMode_Explorer Theme else Explorer Theme
    
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_TitleBackColor,        #PB_Default     ; Title Back Color: Color | #PB_Default = BackColor
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_CheckBox,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_CheckBox,        #PB_Gadget_FrontColor,            #White          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_CheckBox,        #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_HighLightColor,        #PB_Default     ; HighLight Color: Color | #PB_Default = GetSysColor_(#COLOR_HIGHLIGHT)
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_EditBoxColor,          $080C3A         ; Back Color: Color | #PB_Default = If IsDarkColor BackColor, Accentolor(15) else Accentolor(-15)
    
    Data.l #PB_GadgetType_Container,       #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    
    Data.l #PB_GadgetType_Date,            #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Date,            #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Date,            #PB_Gadget_TitleBackColor,        #PB_Default     ; Title Back Color: Color | #PB_Default = BackColor
    Data.l #PB_GadgetType_Date,            #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_Editor,          #PB_Gadget_BackColor,             $080C3A         ; Back Color: Color | #PB_Default = If IsDarkColor Window BackColor, Accentolor(15) else Accentolor(-15)
    Data.l #PB_GadgetType_Editor,          #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Blackault
    
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_TitleBackColor,        $0E1560         ; Title Back Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) else AccentColor(-40)
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_ExplorerTree,    #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ExplorerTree,    #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ExplorerTree,    #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    
    Data.l #PB_GadgetType_Frame,           #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Frame,           #PB_Gadget_FrontColor,            #White          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Frame,           #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_HyperLink,       #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_HyperLink,       #PB_Gadget_FrontColor,            #White          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_TitleBackColor,        $0E1560         ; Title Back Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) else AccentColor(-40)
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_ListView,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ListView,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_Option,          #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Option,          #PB_Gadget_FrontColor,            #White          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Option,          #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_ActiveTabColor,        $0E1560         ; Active Tab Color: Color | #PB_Default = BackColor
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_InactiveTabColor,      #PB_Default     ; Inactive Tab Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) else AccentColor(-40)
    
    Data.l #PB_GadgetType_ProgressBar,     #PB_Gadget_BackColor,             $2E3150         ; Back Color: Color | #PB_Default = If IsDarkColor BackColor, Accentolor(40) else Accentolor(-40)
    Data.l #PB_GadgetType_ProgressBar,     #PB_Gadget_FrontColor,            $283FB8         ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, Accentolor(100) else Accentolor(-100)
    
    Data.l #PB_GadgetType_ScrollArea,      #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    
    Data.l #PB_GadgetType_Spin,            #PB_Gadget_BackColor,             $080C3A         ; Back Color: Color | #PB_Default = If IsDarkColor Window BackColor, Accentolor(15) else Accentolor(-15)
    Data.l #PB_GadgetType_Spin,            #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_BackColor,             $0E1560         ; Back Color: Color | #PB_Default = If IsDarkColor Window BackColor, Accentolor(30) else Accentolor(-30)
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_FrontColor,            $0DFD6E         ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_SplitterBorder,        #True           ; Enable Splitter Border: 0 | 1 | #PB_Default = 1
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_SplitterBorderColor,   $749EBA         ; Splitter Border Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(60) Else AccentColor(-60)
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_UseUxGripper,          #False          ; Splitter Gripper:  0 = Custom | 1 = Uxtheme | #PB_Default = #False        ; #False = Custom, #True = Uxtheme. For Splitter
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_GripperColor,          $094D7C         ; Splitter Gripper Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) Else AccentColor(-40)
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_LargeGripper,          #True           ; Large Splitter Gripper: 0 | 1 | #PB_Default = 1
    
    Data.l #PB_GadgetType_String,          #PB_Gadget_BackColor,             $080C3A         ; Back Color: Color | #PB_Default = If IsDarkColor Window BackColor, Accentolor(15) Else Accentolor(-15)
    Data.l #PB_GadgetType_String,          #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_Text,            #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Text,            #PB_Gadget_FrontColor,            #White          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Text,            #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_TrackBar,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_TrackBar,        #PB_Gadget_FrontColor,            #White          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_TrackBar,        #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_Tree,            #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Tree,            #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Tree,            #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    
    Data.l #PB_GadgetType_Button,          #PB_Gadget_BackColor,             $2D47CB         ; Border Color: Color | #PB_Default = Window BackColor. If IsDarkColor AccentColor 80
    Data.l #PB_GadgetType_Button,          #PB_Gadget_OuterColor,            $060928         ; Outer Color: Color | #PB_Default = Window BackColor. If not IsDarkColor AccentColor 80
    Data.l #PB_GadgetType_Button,          #PB_Gadget_CornerColor,           #PB_Default     ; Corner Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_GrayBackColor,         #PB_Default     ; Gray Back Color: Color | #PB_Default = Disabled Button BackColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_FrontColor,            #White          ; Text Color: Color | #PB_Default = If IsDarkColor Button BackColor White else Black
    Data.l #PB_GadgetType_Button,          #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disabled Button FrontColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_EnableShadow,          1               ; Enable Shadow Color 0 | 1 | #PB_Default = 0
    Data.l #PB_GadgetType_Button,          #PB_Gadget_ShadowColor,           $060928         ; Shadow Color: Color | #PB_Default = If IsDarkColor Button FrontColor White else Black
    Data.l #PB_GadgetType_Button,          #PB_Gadget_BorderColor,           #PB_Default     ; Border Color: Color | #PB_Default = if IsDarkColor(Window) Button BackColor else Button OuterColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_RoundX,                8               ; The radius of the RoundBox corners in the x direction
    Data.l #PB_GadgetType_Button,          #PB_Gadget_RoundY,                8               ; The radius of the RoundBox corners in the y direction
    
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_BackColor,             $2D47CB         ; Border Color: Color | #PB_Default = Window BackColor. If IsDarkColor AccentColor 80
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_OuterColor,            $060928         ; Outer Color: Color | #PB_Default = Window BackColor. If not IsDarkColor AccentColor 80
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_CornerColor,           #PB_Default     ; Corner Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_GrayBackColor,         #PB_Default     ; Gray Back Color: Color | #PB_Default = Disabled Button BackColor
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_FrontColor,            #White          ; Text Color: Color | #PB_Default = If IsDarkColor Button BackColor White else Black
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disabled Button FrontColor
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_EnableShadow,          1               ; Enable Shadow Color 0 | 1 | #PB_Default = 0
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_ShadowColor,           $060928         ; Shadow Color: Color | #PB_Default = If IsDarkColor Button FrontColor White else Black
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_BorderColor,           #PB_Default     ; Border Color: Color | #PB_Default = if IsDarkColor(Window) Button BackColor else Button OuterColor
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_RoundX,                8               ; The radius of the RoundBox corners in the x direction
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_RoundY,                8               ; The radius of the RoundBox corners in the y direction
    Data.l #PB_Gadget_END
    
    ; -------------------------------------------------------------------------------------------------------------------
    ;- LightBlue Theme
    ; -------------------------------------------------------------------------------------------------------------------
    LightBlue:
    Data.l #PB_WindowType,                 #PB_Gadget_BackColor,             $FFD7C9         ; Back Window Color: Color | #PB_Default = SetObjectTheme(Theme, WindowColor) else GetSysColor_(#COLOR_WINDOW)
    Data.l #PB_WindowType,                 #PB_Gadget_DarkMode,              #PB_Default     ; Enable Dark Mode: 0 | 1 | #PB_Default = If IsDarkColor Window, DarkMode_Explorer Theme else Explorer Theme
    
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_TitleBackColor,        #PB_Default     ; Title Back Color: Color | #PB_Default = BackColor
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_CheckBox,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_CheckBox,        #PB_Gadget_FrontColor,            #Black          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_CheckBox,        #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_FrontColor,            #Black          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_HighLightColor,        #PB_Default     ; HighLight Color: Color | #PB_Default = GetSysColor_(#COLOR_HIGHLIGHT)
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_EditBoxColor,          #PB_Default     ; Back Color: Color | #PB_Default = If IsDarkColor BackColor, Accentolor(15) else Accentolor(-15)
    
    Data.l #PB_GadgetType_Container,       #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    
    Data.l #PB_GadgetType_Date,            #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Date,            #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Date,            #PB_Gadget_TitleBackColor,        #PB_Default     ; Title Back Color: Color | #PB_Default = BackColor
    Data.l #PB_GadgetType_Date,            #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_Editor,          #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = If IsDarkColor Window BackColor, Accentolor(15) else Accentolor(-15)
    Data.l #PB_GadgetType_Editor,          #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_TitleBackColor,        $FEA36B         ; Title Back Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) else AccentColor(-40)
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_ExplorerTree,    #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ExplorerTree,    #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ExplorerTree,    #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    
    Data.l #PB_GadgetType_Frame,           #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Frame,           #PB_Gadget_FrontColor,            #Black          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Frame,           #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_HyperLink,       #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_HyperLink,       #PB_Gadget_FrontColor,            #Black          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_TitleBackColor,        $FEA36B         ; Title Back Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) else AccentColor(-40)
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_ListView,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ListView,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_Option,          #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Option,          #PB_Gadget_FrontColor,            #Black          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Option,          #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_ActiveTabColor,        $FEA36B         ; Active Tab Color: Color | #PB_Default = BackColor
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_InactiveTabColor,      #PB_Default     ; Inactive Tab Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) else AccentColor(-40)
    
    Data.l #PB_GadgetType_ProgressBar,     #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = If IsDarkColor BackColor, Accentolor(40) else Accentolor(-40)
    Data.l #PB_GadgetType_ProgressBar,     #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, Accentolor(100) else Accentolor(-100)
    
    Data.l #PB_GadgetType_ScrollArea,      #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    
    Data.l #PB_GadgetType_Spin,            #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = If IsDarkColor Window BackColor, Accentolor(15) else Accentolor(-15)
    Data.l #PB_GadgetType_Spin,            #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_BackColor,             $FEA36B         ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_FrontColor,            $73B24C         ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_SplitterBorder,        #True           ; Enable Splitter Border: 0 | 1 | #PB_Default = 1
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_SplitterBorderColor,   $B2734C         ; Splitter Border Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(60) Else AccentColor(-60)
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_UseUxGripper,          #False          ; Splitter Gripper:  0 = Custom | 1 = Uxtheme | #PB_Default = #False
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_GripperColor,          $724130         ; Splitter Gripper Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) Else AccentColor(-40)
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_LargeGripper,          #True           ; Large Splitter Gripper: 0 | 1 | #PB_Default = 1
    
    Data.l #PB_GadgetType_String,          #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = If IsDarkColor Window BackColor, Accentolor(15) else Accentolor(-15)
    Data.l #PB_GadgetType_String,          #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_Text,            #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Text,            #PB_Gadget_FrontColor,            #Black          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Text,            #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_TrackBar,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_TrackBar,        #PB_Gadget_FrontColor,            #Black          ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_TrackBar,        #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_Tree,            #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Tree,            #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Tree,            #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    
    Data.l #PB_GadgetType_Button,          #PB_Gadget_BackColor,             $FFD8CA         ; Border Color: Color | #PB_Default = Window BackColor. If IsDarkColor AccentColor 80
    Data.l #PB_GadgetType_Button,          #PB_Gadget_OuterColor,            $FD6E0D         ; Outer Color: Color | #PB_Default = Window BackColor. If not IsDarkColor AccentColor 80
    Data.l #PB_GadgetType_Button,          #PB_Gadget_CornerColor,           #PB_Default     ; Corner Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_GrayBackColor,         #PB_Default     ; Gray Back Color: Color | #PB_Default = Disabled Button BackColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_FrontColor,            #Black          ; Text Color: Color | #PB_Default = If IsDarkColor Button BackColor White else Black
    Data.l #PB_GadgetType_Button,          #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disabled Button FrontColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_EnableShadow,          1               ; Enable Shadow Color 0 | 1 | #PB_Default = 0
    Data.l #PB_GadgetType_Button,          #PB_Gadget_ShadowColor,           $FFB47F         ; Shadow Color: Color | #PB_Default = If IsDarkColor Button FrontColor White else Black
    Data.l #PB_GadgetType_Button,          #PB_Gadget_BorderColor,           $FD6E0D         ; Border Color: Color | #PB_Default = if IsDarkColor(Window) Button BackColor else Button OuterColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_RoundX,                8               ; The radius of the RoundBox corners in the x direction
    Data.l #PB_GadgetType_Button,          #PB_Gadget_RoundY,                8               ; The radius of the RoundBox corners in the y direction
    
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_BackColor,             $FFD8CA         ; Border Color: Color | #PB_Default = Window BackColor. If IsDarkColor AccentColor 80  
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_OuterColor,            $FD6E0D         ; Outer Color: Color | #PB_Default = Window BackColor. If not IsDarkColor AccentColor 80
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_CornerColor,           #PB_Default     ; Corner Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_GrayBackColor,         #PB_Default     ; Gray Back Color: Color | #PB_Default = Disabled Button BackColor
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_FrontColor,            #Black          ; Text Color: Color | #PB_Default = If IsDarkColor Button BackColor White else Black
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disabled Button FrontColor
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_EnableShadow,          1               ; Enable Shadow Color 0 | 1 | #PB_Default = 0
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_ShadowColor,           $FFB47F         ; Shadow Color: Color | #PB_Default = If IsDarkColor Button FrontColor White else Black
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_BorderColor,           $FD6E0D         ; Border Color: Color | #PB_Default = if IsDarkColor(Window) Button BackColor else Button OuterColor 
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_RoundX,                8               ; The radius of the RoundBox corners in the x direction
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_RoundY,                8               ; The radius of the RoundBox corners in the y direction
    Data.l #PB_Gadget_END
    
    ; -------------------------------------------------------------------------------------------------------------------
    ;- Auto Theme
    ; -------------------------------------------------------------------------------------------------------------------
    Auto:
    Data.l #PB_WindowType,                 #PB_Gadget_BackColor,             #PB_Default     ; Back Window Color: Color | #PB_Default = SetObjectTheme(Theme, WindowColor) else GetSysColor_(#COLOR_WINDOW)
    Data.l #PB_WindowType,                 #PB_Gadget_DarkMode,              #PB_Default     ; Enable Dark Mode: 0 | 1 | #PB_Default = If IsDarkColor Window, DarkMode_Explorer Theme else Explorer Theme
    
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_TitleBackColor,        #PB_Default     ; Title Back Color: Color | #PB_Default = BackColor
    Data.l #PB_GadgetType_Calendar,        #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_CheckBox,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_CheckBox,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_CheckBox,        #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_HighLightColor,        #PB_Default     ; HighLight Color: Color | #PB_Default = GetSysColor_(#COLOR_HIGHLIGHT)
    Data.l #PB_GadgetType_ComboBox,        #PB_Gadget_EditBoxColor,          #PB_Default     ; Back Color: Color | #PB_Default = If IsDarkColor BackColor, Accentolor(15) else Accentolor(-15)
    
    Data.l #PB_GadgetType_Container,       #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    
    Data.l #PB_GadgetType_Date,            #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Date,            #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Date,            #PB_Gadget_TitleBackColor,        #PB_Default     ; Title Back Color: Color | #PB_Default = BackColor
    Data.l #PB_GadgetType_Date,            #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_Editor,          #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = If IsDarkColor Window BackColor, Accentolor(15) else Accentolor(-15)
    Data.l #PB_GadgetType_Editor,          #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_TitleBackColor,        #PB_Default     ; Title Back Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) else AccentColor(-40)
    Data.l #PB_GadgetType_ExplorerList,    #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_ExplorerTree,    #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ExplorerTree,    #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ExplorerTree,    #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    
    Data.l #PB_GadgetType_Frame,           #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Frame,           #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Frame,           #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_HyperLink,       #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_HyperLink,       #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_TitleBackColor,        #PB_Default     ; Title Back Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) else AccentColor(-40)
    Data.l #PB_GadgetType_ListIcon,        #PB_Gadget_TitleFrontColor,       #PB_Default     ; Title Front Color: Color | #PB_Default = If IsDarkColor TitleBackColor, #White else #Black
    
    Data.l #PB_GadgetType_ListView,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ListView,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_Option,          #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Option,          #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Option,          #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_ActiveTabColor,        #PB_Default     ; Active Tab Color: Color | #PB_Default = BackColor
    Data.l #PB_GadgetType_Panel,           #PB_Gadget_InactiveTabColor,      #PB_Default     ; Inactive Tab Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) else AccentColor(-40)
    
    Data.l #PB_GadgetType_ProgressBar,     #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = If IsDarkColor BackColor, Accentolor(40) else Accentolor(-40)
    Data.l #PB_GadgetType_ProgressBar,     #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, Accentolor(100) else Accentolor(-100)
    
    Data.l #PB_GadgetType_ScrollArea,      #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    
    Data.l #PB_GadgetType_Spin,            #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = If IsDarkColor Window BackColor, Accentolor(15) else Accentolor(-15)
    Data.l #PB_GadgetType_Spin,            #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = If IsDarkColor Window BackColor, Accentolor(30) else Accentolor(-30)
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_SplitterBorder,        #True           ; Enable Splitter Border: 0 | 1 | #PB_Default = 1
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_SplitterBorderColor,   #PB_Default     ; Splitter Border Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(60) Else AccentColor(-60)
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_UseUxGripper,          #False          ; Splitter Gripper:  0 = Custom | 1 = Uxtheme | #PB_Default = #False
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_GripperColor,          #PB_Default     ; Splitter Gripper Color: Color | #PB_Default = If IsDarkColor BackColor, AccentColor(40) Else AccentColor(-40)
    Data.l #PB_GadgetType_Splitter,        #PB_Gadget_LargeGripper,          #True           ; Large Splitter Gripper: 0 | 1 | #PB_Default = 1
    
    Data.l #PB_GadgetType_String,          #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = If IsDarkColor Window BackColor, Accentolor(15) else Accentolor(-15)
    Data.l #PB_GadgetType_String,          #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    
    Data.l #PB_GadgetType_Text,            #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Text,            #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Text,            #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_TrackBar,        #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_TrackBar,        #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_TrackBar,        #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disable color filter on FrontColor
    
    Data.l #PB_GadgetType_Tree,            #PB_Gadget_BackColor,             #PB_Default     ; Back Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Tree,            #PB_Gadget_FrontColor,            #PB_Default     ; Front or Text Color: Color | #PB_Default = If IsDarkColor BackColor, #White else #Black
    Data.l #PB_GadgetType_Tree,            #PB_Gadget_LineColor,             #PB_Default     ; Line Color: Color | #PB_Default = If IsDarkColor BackColor White else Black
    
    Data.l #PB_GadgetType_Button,          #PB_Gadget_BackColor,             #PB_Default     ; Border Color: Color | #PB_Default = Window BackColor. If IsDarkColor AccentColor 80
    Data.l #PB_GadgetType_Button,          #PB_Gadget_OuterColor,            #PB_Default     ; Outer Color: Color | #PB_Default = Window BackColor. If not IsDarkColor AccentColor 80
    Data.l #PB_GadgetType_Button,          #PB_Gadget_CornerColor,           #PB_Default     ; Corner Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_GrayBackColor,         #PB_Default     ; Gray Back Color: Color | #PB_Default = Disabled Button BackColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_FrontColor,            #PB_Default     ; Text Color: Color | #PB_Default = If IsDarkColor Button BackColor White else Black
    Data.l #PB_GadgetType_Button,          #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disabled Button FrontColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_EnableShadow,          #PB_Default     ; Enable Shadow Color 0 | 1 | #PB_Default = 0
    Data.l #PB_GadgetType_Button,          #PB_Gadget_ShadowColor,           #PB_Default     ; Shadow Color: Color | #PB_Default = If IsDarkColor Button FrontColor White else Black
    Data.l #PB_GadgetType_Button,          #PB_Gadget_BorderColor,           #PB_Default     ; Border Color: Color | #PB_Default = if IsDarkColor(Window) Button BackColor else Button OuterColor
    Data.l #PB_GadgetType_Button,          #PB_Gadget_RoundX,                #PB_Default     ; The radius of the RoundBox corners in the x direction
    Data.l #PB_GadgetType_Button,          #PB_Gadget_RoundY,                #PB_Default     ; The radius of the RoundBox corners in the y direction
    
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_BackColor,             #PB_Default     ; Border Color: Color | #PB_Default = Window BackColor. If IsDarkColor AccentColor 80
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_OuterColor,            #PB_Default     ; Outer Color: Color | #PB_Default = Window BackColor. If not IsDarkColor AccentColor 80
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_CornerColor,           #PB_Default     ; Corner Color: Color | #PB_Default = Window BackColor
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_GrayBackColor,         #PB_Default     ; Gray Back Color: Color | #PB_Default = Disabled Button BackColor
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_FrontColor,            #PB_Default     ; Text Color: Color | #PB_Default = If IsDarkColor Button BackColor White else Black
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_GrayTextColor,         #PB_Default     ; Gray Text Color: Color | #PB_Default = Disabled Button FrontColor
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_EnableShadow,          #PB_Default     ; Enable Shadow Color 0 | 1 | #PB_Default = 0
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_ShadowColor,           #PB_Default     ; Shadow Color: Color | #PB_Default = If IsDarkColor Button FrontColor White else Black
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_BorderColor,           #PB_Default     ; Border Color: Color | #PB_Default = if IsDarkColor(Window) Button BackColor else Button OuterColor
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_RoundX,                #PB_Default     ; The radius of the RoundBox corners in the x direction
    Data.l #PB_GadgetType_ButtonImage,     #PB_Gadget_RoundY,                #PB_Default     ; The radius of the RoundBox corners in the y direction
    Data.l #PB_Gadget_END
  EndDataSection
  
CompilerEndIf

; IDE Options = PureBasic 6.03 LTS (Windows - x64)
; EnableXP