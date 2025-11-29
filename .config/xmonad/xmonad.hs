import Data.Bits
import qualified Data.Map as M
import System.Exit

import Graphics.X11.ExtraTypes.XF86

import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing
import XMonad.Hooks.InsertPosition

import XMonad.Actions.Navigation2D

import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Spacing
import XMonad.Layout.MultiToggle
import XMonad.Layout.Reflect

import qualified XMonad.StackSet as W


main :: IO ()
main = xmonad
    $ withNavigation2DConfig def
    $ ewmh'
    $ statusbar'
    $ def'

ewmh' = ewmhFullscreen . ewmh

statusbar' = withEasySB xmobar' xmobarToggle

def' = def
    { modMask = mod4Mask
    , layoutHook = layout'
    , startupHook = startupHook'
    , manageHook = manageHook'
    , borderWidth = borderWidth'
    , normalBorderColor = normalBorderColor'
    , focusedBorderColor = focusedBorderColor'
    , terminal = terminal'
    , keys = keys'
    , handleEventHook = handleEventHook'
    }

terminal' :: String
terminal' = "kitty"

normalBorderColor' :: String
normalBorderColor' = "#274675"

focusedBorderColor' :: String
focusedBorderColor' = "#22b0e3"

borderWidth' :: Dimension
borderWidth' = 4

handleEventHook' = swallowEventHook (className =? "Alacritty" <||> className =? "kitty") (return True)

startupHook' :: X ()
startupHook' = do
    spawnOnce "find ~/Wallpapers -type f | shuf -n 1 | xargs feh --bg-fill --no-fehbg"
    spawnOnce "DISPLAY=':0' picom -b --xrender-sync --xrender-sync-fence"
    spawnOnce "reorder-screens"


manageHook' :: ManageHook
manageHook' = insertPosition' <+> floatingRules

    where
        insertPosition' = insertPosition Below Newer
        floatingRules = composeAll
            [ isDialog                    --> doFloat
            , className =? "Gimp"         --> doFloat
            , className =? "confirmreset" --> doFloat
            , className =? "makebranch"   --> doFloat
            , className =? "maketag"      --> doFloat
            , className =? "ssh-askpass"  --> doFloat
            , className =? "MPlayer"      --> doFloat
            , className =? "mplayer2"     --> doFloat
            , title =? "branchdialog"     --> doFloat
            , title =? "pinentry"         --> doFloat
            , title =? "Monadcraft"       --> doFloat
            ]


layout' = mkToggle (single REFLECTX) $ layouts
    where
        spacing' = spacingRaw False (Border 8 0 8 0) True (Border 0 8 0 8) True

        layouts =   (spacing' tiled)
                ||| (spacing' emptyBSP)
                ||| full

        tiled = Tall 1 (3/100) (1/2)
        full = Full



runDmenu = spawn "dmenu_run -l 0 -fn 'Roboto-15' -p '> ' -nb '#212733' -nf '#f8f8f8' -sb '#1be1f7' -sf '#212733'"

takeScreenshot = unGrab *> spawn "flameshot gui"

restartXMonad = spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi"

volumeDown = spawn "pamixer -d 5"
volumeDownSmall = spawn "pamixer -d 1"

volumeUp = spawn "pamixer -i 5"
volumeUpSmall = spawn "pamixer -i 1"

volumeMute = spawn "pamixer -t"

brightnessDown = spawn "light -U 5"
brightnessUp = spawn "light -A 5"

keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask, xK_t), spawn $ XMonad.terminal conf)
    , ((modMask, xK_r), runDmenu)
    , ((modMask, xK_s), takeScreenshot)
    , ((modMask, xK_q), kill)

    -- Layout Management
    , ((modMask,                 xK_Tab), sendMessage NextLayout)
    , ((modMask .|. shiftMask,   xK_Tab), setLayout $ XMonad.layoutHook conf)
    , ((modMask .|. controlMask, xK_Tab), sendMessage $ Toggle REFLECTX)
    , ((modMask,                 xK_n  ), refresh)

    -- Go To Window
    , ((modMask , xK_l), windowGo R False)
    , ((modMask , xK_k), windowGo U False)
    , ((modMask , xK_h), windowGo L False)
    , ((modMask , xK_j), windowGo D False)

    -- Swap Windows
    , ((modMask .|. controlMask, xK_l), windowSwap R False)
    , ((modMask .|. controlMask, xK_k), windowSwap U False)
    , ((modMask .|. controlMask, xK_h), windowSwap L False)
    , ((modMask .|. controlMask, xK_j), windowSwap D False)

    -- Move Window
    -- , ((modMask .|. controlMask, xK_l), sendMessage MoveRight)
    -- , ((modMask .|. controlMask, xK_k), sendMessage MoveUp)
    -- , ((modMask .|. controlMask, xK_h), sendMessage MoveLeft)
    -- , ((modMask .|. controlMask, xK_j), sendMessage MoveDown)

    -- Resize Window
    , ((modMask .|. shiftMask, xK_l), sendMessage $ ExpandTowards R)
    , ((modMask .|. shiftMask, xK_k), sendMessage $ ExpandTowards U)
    , ((modMask .|. shiftMask, xK_h), sendMessage $ ExpandTowards L)
    , ((modMask .|. shiftMask, xK_j), sendMessage $ ExpandTowards D)

    -- Master/Stack traversing
    , ((modMask,                 xK_m), windows W.focusMaster)
    , ((modMask .|. controlMask, xK_m), windows W.swapMaster)

    -- Resize master/stack splits
    , ((modMask .|. shiftMask, xK_n), sendMessage Shrink)
    , ((modMask .|. shiftMask, xK_p), sendMessage Expand)

    -- Re-tile window
    , ((modMask,               xK_f), withFocused $ windows . W.sink)

    -- Master area size
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- Volume Control
    , ((0 :: KeyMask, xF86XK_AudioLowerVolume), volumeDown)
    , ((shiftMask,    xF86XK_AudioLowerVolume), volumeDownSmall)
    , ((0 :: KeyMask, xF86XK_AudioRaiseVolume), volumeUp)
    , ((shiftMask,    xF86XK_AudioRaiseVolume), volumeUpSmall)
    , ((0 :: KeyMask, xF86XK_AudioMute       ), volumeMute)

    -- Brightness Control
    , ((0 :: KeyMask, xF86XK_MonBrightnessUp), brightnessUp)
    , ((0 :: KeyMask, xF86XK_MonBrightnessDown), brightnessDown)

    -- Go To Workspace
    , ((modMask, xK_w), screenGo L False)
    , ((modMask, xK_e), screenGo R False)

    -- Quit or restart
    , ((modMask .|. shiftMask,   xK_q   ), io exitSuccess)
    , ((modMask .|. controlMask, xK_r   ), restartXMonad)
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]



---------------------------- xmobar ----------------------------



xmobar' = statusBarProp "xmobar ~/.config/xmobar/xmobarrc" $ pure xmobarPP'


xmobarToggle :: XConfig Layout -> (KeyMask, KeySym)
xmobarToggle XConfig { modMask = m } = (m, xK_v)


xmobarPP' :: PP
xmobarPP' = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""


