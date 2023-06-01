-- Author: Javier Orfo

module XMonad.Util.Settings
    ( terminal
    , xmobarBgColor
    , xmobarFgColor
    , xmobarWSCurrentColor
    , xmobarWSHiddenColor
    , xmobarWSHiddenNoWindowsColor
    , xmobarWSTitleColor
    , xmobarArchLogoColor
    , borderWidth
    , normalBorderColor
    , focusedBorderColor
    , xmobarDefaultFont
    , xmobarFirstFont
    , xmobarSecondFont
    , xmobarPosition
    , workspaces
    , stringToSpawn
    , volumeKeyBound
    , brightKeyBound
    , brightnessMaxFile
    , brightnessCurrentFile
    , template
    , commands
    ) where


import Data.List
-- __  ____  __                            _
-- \ \/ /  \/  | ___  _ __   __ _ _ __ ___| |__
--  \  /| |\/| |/ _ \| '_ \ / _` | '__/ __| '_ \
--  /  \| |  | | (_) | | | | (_| | | | (__| | | |
-- /_/\_\_|  |_|\___/|_| |_|\__,_|_|  \___|_| |_|

-- #############
-- # CHANGE ME #
-- #############

-- TERMINAL
terminal                     = "alacritty"

-- XMOBAR COLORS
xmobarBgColor                = "#303030"
xmobarFgColor                = "#FFFFFF"
xmobarWSCurrentColor         = "#FFFF5F"
xmobarWSHiddenColor          = "#00FFFF"
xmobarWSHiddenNoWindowsColor = "#FFFFFF"
xmobarWSTitleColor           = "#FFFFFF"
xmobarArchLogoColor          = "#1793D1"

-- XMOBAR SEPARATOR
xmobarSep                    = " <fc=#949494>|</fc> "

-- XMOBAR POSITION
xmobarPosition               = "TopH 25"

-- XMONAD WINDOWS
borderWidth                  = 2
normalBorderColor            = "#DDDDDD"
focusedBorderColor           = "#FF0000"

-- NERD FONT
fontDefault                  = "UbuntuMono Nerd Font Mono"
fontFirst                    = fontDefault
fontSecond                   = fontDefault
bold                         = False
fontSize                     = 11

-- XMOBAR COMMANDS
-- KBD
kbdVisible                   = True
kbdIcon                      = "<fn=2>\\xf11c</fn>"

-- DYN NETWORK
dynNetworkVisible            = True
dynNetworkUpIcon             = "<fn=1>\\xf0aa</fn>"
dynNetworkDownIcon           = "<fn=1>\\xf0ab</fn>"

-- DISK U
diskUVisible                 = True
diskUIcon                    = "<fn=1>\\xf7c9</fn>"

-- DATE
dateZoneVisible              = True
dateZoneLocale               = "es_AR.UTF-8"
dateZoneTimeZone             = "America/Argentina/Buenos_Aires"
dateZoneCalendarIcon         = "<fn=1>\\xf133</fn>"
dateZoneClockIcon            = "<fn=1>\\xf017</fn>"

-- WEATHER
weatherVisible               = True
weatherStationID             = "SADF"
weatherIcon                  = "<fc=#FFFF5F><fn=1>\\xe30c</fn></fc>"
weatherHumidityIcon          = "<fc=#00FFFF>\\xe373</fc>"

-- VOLUME
volumeVisible                = True
volumeOnIcon                 = "<fc=#FFFFFF><fn=1>\\xfa7d</fn></fc>"
volumeOffIcon                = "<fc=red><fn=1>\\xfa80</fn></fc>"

-- MULTI CPU
multiCpuVisible              = True
multiCpuIcon                 = "<fn=1>\\xf878</fn>"
multiCpuLowColor             = "#FFFFFF"
multiCpuNormalColor          = multiCpuLowColor
multiCpuHighColor            = "red"

-- MULTI CORE TEMP
multiCoreTempVisible         = True
multiCoreTempIcon            = "<fn=1>\\xf8c7</fn>"
multiCoreTempLowColor        = "#FFFFFF"
multiCoreTempNormalColor     = multiCoreTempLowColor
multiCoreTempHighColor       = "red"

-- MEMORY
memoryVisible                = True
memoryIcon                   = "<fn=1>\\xf85a</fn>"
memoryLowColor               = "#FFFFFF"
memoryNormalColor            = memoryLowColor
memoryHighColor              = "red"

-- BATTERY
batteryVisible               = False
batteryOnIcon                = "\\xf583"
batteryOffIcon               = "\\xf580"
batteryIdleIcon              = "\\xf578"
batteryLowColor              = "red"
batteryNormalColor           = "#FFFFFF"
batteryHighColor             = batteryNormalColor
--

-- WORKSPACES
workspaces                   = [ " <fn=1>\xe62b</fn> "
                               , " <fn=1>\xfa9e</fn> "
                               , " <fn=1>\xf1c0</fn> "
                               , " <fn=1>\xf724</fn> "
                               , " <fn=1>\xf075</fn> "
                               , " <fn=1>\xf001</fn> "
                               ]

-- EXECUTE AT START
spawns                       = [ "xset s off"
                               , "xset -dpms"
                               , "xset s noblank"
                               , "feh --bg-scale ~/.config/xmonad/images/background.jpg | xautolock -time 30 -locker 'systemctl suspend' &"
                               ]

-- XMONAD KEY BINDINGS
volumeKeyBound               = True
brightKeyBound               = False

-- ###################
-- # END OF SETTINGS #
-- ###################



-- ###################
-- # DON'T CHANGE ME #
-- ###################

stringToSpawn                = intercalate "; " spawns

xmobarDefaultFont            = xmobarFont fontDefault  fontSize
xmobarFirstFont              = xmobarFont fontFirst  $ fontSize + 7
xmobarSecondFont             = xmobarFont fontSecond $ fontSize + 11

template                     = " %archlogo% %UnsafeStdinReader% }{ "
                               ++ getStringIfVisible multiCpuVisible       ("%multicpu%"       ++ xmobarSep                           )
                               ++ getStringIfVisible multiCoreTempVisible  ("%multicoretemp%"  ++ xmobarSep                           )
                               ++ getStringIfVisible memoryVisible         ("%memory%"         ++ xmobarSep                           )
                               ++ getStringIfVisible diskUVisible          ("%disku%"          ++ xmobarSep                           )
                               ++ getStringIfVisible dynNetworkVisible     ("%dynnetwork%"     ++ xmobarSep                           )
                               ++ getStringIfVisible volumeVisible         ("%default:Master%" ++ xmobarSep                           )
                               ++ getStringIfVisible batteryVisible        ("%battery%"        ++ xmobarSep                           )
                               ++ getStringIfVisible weatherVisible        ("%"                ++ weatherStationID ++ "%" ++ xmobarSep)
                               ++ getStringIfVisible dateZoneVisible       ("%time%"           ++ xmobarSep                           )
                               ++ getStringIfVisible kbdVisible            ("%kbd% "                                                  )

commands                     =    getStringIfVisible multiCpuVisible      multiCpu
                               ++ getStringIfVisible multiCoreTempVisible multiCoreTemp
                               ++ getStringIfVisible memoryVisible        memory
                               ++ getStringIfVisible diskUVisible         diskU
                               ++ getStringIfVisible dynNetworkVisible    dynNetwork
                               ++ getStringIfVisible weatherVisible       weather
                               ++ getStringIfVisible dateZoneVisible      date
                               ++ getStringIfVisible volumeVisible        volume
                               ++ getStringIfVisible batteryVisible       battery
                               ++ getStringIfVisible kbdVisible           kbd

dynNetwork                   = " -C '[Run DynNetwork [\"-t\",\"" ++ dynNetworkUpIcon ++ " <tx>KB " ++ dynNetworkDownIcon ++ " <rx>KB\"] 10]' "

weather                      = " -C '[Run Weather \"" ++ weatherStationID ++ "\" [ \"-t\", \"" ++ weatherIcon ++ " \
                                \<tempC>\\xfa03 " ++ weatherHumidityIcon ++ " <rh>%\" ] 18000]' "

date                         = " -C '[Run DateZone \"" ++ dateZoneCalendarIcon ++ " %a %d/%m " ++ dateZoneClockIcon ++ " %H:%M\" \
                                \\"" ++ dateZoneLocale ++ "\" \"" ++ dateZoneTimeZone ++ "\" \"time\" 50]' "

volume                       = " -C '[Run Volume \"default\" \"Master\" [\"-t\",\"<status> \
                                \<volume>%\",\"--\",\"-O\",\"" ++ volumeOnIcon ++ "\",\"-o\",\"" ++ volumeOffIcon ++ "\"] 10]' "

multiCpu                     = " -C '[Run MultiCpu [\"-t\",\"" ++ multiCpuIcon ++ " \
                                \<total>%\",\"-L\",\"50\",\"-H\",\"85\",\"-l\",\"" ++ multiCpuLowColor ++ "\",\"-n\",\"" ++ multiCpuNormalColor ++ "\"\
                                \,\"-h\",\"" ++ multiCpuHighColor ++ "\"] 10]' "

multiCoreTemp                = " -C '[Run MultiCoreTemp [\"-t\",\"" ++ multiCoreTempIcon ++ " <avg>\\xfa03\",\"-L\",\"60\",\"-H\",\"80\",\"-l\",\"" ++ multiCoreTempLowColor ++ "\",\"-n\",\
                                \\"" ++ multiCoreTempNormalColor ++ "\",\"-h\",\"" ++ multiCoreTempHighColor ++ "\",\"--\",\"--mintemp\",\"20\",\"--maxtemp\",\"85\",\
                                \\"--\",\"--mintemp\",\"20\",\"--maxtemp\",\"85\"] 10]' "

memory                       = " -C '[Run Memory [\"-t\",\"" ++ memoryIcon ++ " <usedratio>%\
                                \\",\"-L\",\"20\",\"-H\",\"90\",\"-l\",\"" ++ memoryLowColor ++ "\",\"-n\",\"" ++ memoryNormalColor ++ "\",\"-h\",\
                                \\"" ++ memoryHighColor ++ "\"] 10]' "

diskU                        = " -C '[Run DiskU [ (\"/\", \"" ++ diskUIcon ++ " <usedp>% <free>\") ] [] 20]' "

kbd                          = " -C '[Run Kbd [ (\"latam\",\"" ++ kbdIcon ++ " LT\"),(\"us\",\"" ++ kbdIcon ++ " US\"),(\"es\",\"" ++ kbdIcon ++ " ES\")]]' "

battery                      = " -C '[Run Battery [\"-t\",\"<acstatus>\",\"-L\",\"15\",\"-H\",\"80\",\"-l\",\"" ++ batteryLowColor ++ "\",\"-n\",\
                                \\"" ++ batteryNormalColor ++ "\",\"-h\",\"" ++ batteryHighColor ++ "\",\"--\",\"-o\",\
                                \\"" ++ batteryOffIcon ++ " <left>%\",\"-O\",\"" ++ batteryOnIcon ++ " <left>%\",\"-i\",\"" ++ batteryIdleIcon ++ " <left>%\"] 50]' "


-- FUNCTIONS
xmobarFont :: String -> Integer -> String
xmobarFont fo fs = "xft:" ++ fo ++ (if bold then ":bold" else "") ++ ":size=" ++ show fs

getStringIfVisible :: Bool -> String -> String
getStringIfVisible visible command = if visible then command else ""
