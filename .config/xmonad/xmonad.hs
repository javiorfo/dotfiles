import XMonad
import System.Exit
import qualified XMonad.StackSet as W
import Data.List
import Data.Monoid
import qualified Data.Map as M
import System.IO (hPutStrLn)
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.WithAll (killAll)
import XMonad.Prompt (XPPosition(Top), alwaysHighlight, font, position, promptBorderWidth)
import XMonad.Prompt.Shell (shellPrompt)
import qualified XMonad.Util.Settings as S

myPrompt = def
  { position          = Top
  , alwaysHighlight   = True
  , promptBorderWidth = 0
  , font              = S.xmobarDefaultFont
  }

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,               xK_p     ), shellPrompt myPrompt)
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
    , ((modm,               xK_Tab   ), windows W.focusDown)
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusUp  )
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm .|. shiftMask, xK_a     ), killAll)
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    , ((modm .|. shiftMask, xK_s     ), spawn "shutdown now")
    , ((modm .|. shiftMask, xK_b     ), spawn "brave")
    , ((modm .|. shiftMask, xK_t     ), spawn "thunar")
    ]
    ++

    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++

    if S.volumeKeyBound then [ ((0                 , xF86XK_AudioMute),        spawn "pamixer -t")
                             , ((0                 , xF86XK_AudioLowerVolume), spawn "pamixer -d 1")
                             , ((0                 , xF86XK_AudioRaiseVolume), spawn "pamixer -i 1")
                             ] else []
    ++

    if S.brightKeyBound then [ ((0                 , xF86XK_MonBrightnessUp),   spawn "lux -a 10%")
                             , ((0                 , xF86XK_MonBrightnessDown), spawn "lux -s 10%")
                             ] else []




myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

xmobarConf = "xmobar -f '" ++ S.xmobarDefaultFont ++ ":antialias=true' \
                \ -N '" ++ S.xmobarFirstFont ++ "' -N '" ++ S.xmobarSecondFont ++ "' \
                \ -B '" ++ S.xmobarBgColor ++ "' \
                \ -F '" ++ S.xmobarFgColor ++ "' \
                \ -p '" ++ S.xmobarPosition ++ "' \
                \ -t '" ++ S.template ++ "' \
                \ -C '[Run UnsafeStdinReader]' " ++ S.commands ++ " \
                \ -C '[Run Com \"echo\"[\"<fc=" ++ S.xmobarArchLogoColor ++ "><fn=2>\\xf303</fn></fc> \"] \"archlogo\" 360000000]' \
                \ -s '%' -a '}{' "

main = do
        xmproc <- spawnPipe xmobarConf
        xmonad $ docks def
            {
             manageHook           = manageDocks <+> composeAll
                                    [ className =? "MPlayer"        --> doFloat
                                    , className =? "Gimp"           --> doFloat
                                    , title     =? "Microsoft Teams Notification" --> doFloat
                                    , resource  =? "desktop_window" --> doIgnore
                                    , resource  =? "kdesktop"       --> doIgnore ]
             , terminal           = S.terminal
             , focusFollowsMouse  = False
             , clickJustFocuses   = False
             , borderWidth        = fromIntegral S.borderWidth
             , modMask            = mod4Mask
             , workspaces         = S.workspaces
             , normalBorderColor  = S.normalBorderColor
             , focusedBorderColor = S.focusedBorderColor
             , keys               = myKeys
             , mouseBindings      = myMouseBindings
             , layoutHook         = let tiled = Tall 1 (3/100) (1/2)
                                    in avoidStruts (tiled ||| Mirror tiled ||| Full)
             , handleEventHook    = mempty
             , logHook            = dynamicLogWithPP xmobarPP
                                    { ppOutput = hPutStrLn xmproc
                                    , ppCurrent = xmobarColor S.xmobarWSCurrentColor ""
                                    , ppHidden = xmobarColor S.xmobarWSHiddenColor "" . wrap "\xf069" ""
                                    , ppHiddenNoWindows = xmobarColor S.xmobarWSHiddenNoWindowsColor ""
                                    , ppTitle = xmobarColor S.xmobarWSTitleColor "" . shorten 50
                                    , ppOrder = \(ws:_:t:_) -> [ws]
                                    }
             , startupHook        = do
                                    spawnOnce S.stringToSpawn
            }
