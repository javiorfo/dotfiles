Config {
     font =             "xft:UbuntuMono Nerd Font Mono:size=11:antialias=true"
   , additionalFonts =  [ "xft:UbuntuMono Nerd Font Mono:size=18" , "xft:UbuntuMono Nerd Font Mono:bold:size=22"]
   , bgColor =          "#303030"
   , fgColor =          "#ffffff"
   , position =         TopH 25
   , border =           BottomB
   , borderColor =      "#646464"
   , lowerOnStart =     True    -- send to bottom of window stack on start
   , hideOnStart =      False   -- start with window unmapped (hidden)
   , allDesktops =      True    -- show on all desktops
   , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
   , pickBroadest =     False   -- choose widest display (multi-monitor)
   , persistent =       True    -- enable/disable hiding (True = disabled)
   , commands =
        [ Run WeatherX "SADF" [
                                ("clear", "<fc=#ffff00><fn=1>\xfaa7</fn></fc>")
                                , ("sunny", "<fc=#ffff00><fn=1>\xe30d</fn></fc>")
                                , ("mostly clear", "<fc=#ffff00><fn=1>\xfaa7</fn></fc>")
                                , ("mostly sunny", "<fc=#ffff00><fn=1>\xfaa7</fn></fc>")
                                , ("partly sunny", "<fc=#ffff00><fn=1>\xe30d</fn></fc>")
                                , ("fair", "<fc=#ffff00><fn=1>\xe30d</fn></fc>")
                                , ("cloudy","<fc=#c0c0c0><fn=1>\xe312</fn></fc>")
                                , ("overcast","<fc=#ffff5f><fn=1>\xe30c</fn></fc>")
                                , ("partly cloudy", "<fc=#c0c0c0><fn=1>\xe312</fn></fc>")
                                , ("mostly cloudy", "<fc=#c0c0c0><fn=1>\xe312</fn></fc>")
                                , ("considerable cloudiness", "<fc=#c0c0c0><fn=1>\xe312</fn></fc>")
                             ]
                             [ "-t", "<skyConditionS> <tempC>° <fc=#00ffff>\xe373</fc> <rh>%" ] 18000

        , Run DynNetwork     [ "-t" , "<fn=1>\xf0aa</fn> <tx>KB <fn=1>\xf0ab</fn> <rx>KB"] 10

        , Run Volume "default" "Master" [ "-t", "<status> <volume>%"
                                         , "--", "-O", "<fc=#ffffff><fn=1>\xfa7d</fn></fc>"
                                         , "-o", "<fc=#ffffff><fn=1>\xfa80</fn></fc>"
                                        ] 10

        , Run MultiCpu       [ "-t" , "<fn=1>\xf878</fn> <total>%"
                             , "-L" , "50"
                             , "-H" , "85"
                             , "-l" , "lightblue"
                             , "-n" , "lightgreen"
                             , "-h" , "red"
                             ] 10

        , Run MultiCoreTemp  [ "-t", "<fn=1>\xf8c7</fn> <avg>°"
                             , "-L", "60", "-H", "80"
                             , "-l", "lightgreen", "-n", "yellow", "-h", "red"
                             , "--", "--mintemp", "20", "--maxtemp", "85"
                             ] 50

        , Run Memory         [ "-t" ,"<fn=1>\xf85a</fn> <usedratio>%"
                             , "-L" , "20"
                             , "-H" , "90"
                             , "-l" , "lightblue"
                             , "-n" , "lightgreen"
                             , "-h" , "red"
                             ] 10

        , Run DiskU          [ ("/", "<fn=1>\xf7c9</fn> <usedp>% <free>") ] [] 20

        , Run DateZone       "<fn=1>\xf133</fn> %a %d/%m <fn=1>\xf017</fn> %H:%M" "es_AR.UTF-8" "America/Argentina/Buenos_Aires" "argTime" 10

        , Run Kbd            [ ("latam"      , "<fn=2>\xf11c</fn> LT")
                             , ("us"         , "<fn=2>\xf11c</fn> US")
                             , ("es"         , "<fn=2>\xf11c</fn> ES")
                             ]
        
        , Run Battery        [ "-t", "<acstatus>"
                             , "-L", "15"
                             , "-H", "80"
                             , "-l", "red"
                             , "-n", "white"
                             , "-h", "white"
                             , "--"
                             , "-o", "\xf580 <left>%"
                             , "-O", "\xf583 <left>%"
                             , "-i", "\xf578 <left>%"
                             ] 50

        , Run UnsafeStdinReader

        , Run Com "echo" ["<fc=#1793d1><fn=2>\xf303</fn></fc> "] "archlogo" 360000000
        ]
    , sepChar =  "%"
    , alignSep = "}{"
    , template = " %archlogo% %UnsafeStdinReader% }{ %multicpu% <fc=#949494>|</fc> %multicoretemp% <fc=#949494>|</fc> %memory% <fc=#949494>|</fc> %disku% <fc=#949494>|</fc> %dynnetwork% <fc=#949494>|</fc> %SADF% <fc=#949494>|</fc> %argTime% <fc=#949494>|</fc> %default:Master% <fc=#949494>|</fc> %battery% <fc=#949494>|</fc> %kbd% "
   }