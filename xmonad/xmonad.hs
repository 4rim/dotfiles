import XMonad
import System.IO

-- Hooks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageDocks

-- Utils
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Util.Loggers

-- Layout
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral

-- Actions
import XMonad.Actions.FloatKeys

-- Prompts/Extras
import XMonad.Prompt.Pass
import Graphics.X11.ExtraTypes.XF86
import XMonad.ManageHook

myModMask :: KeyMask
myModMask = mod4Mask -- binds mod key to "windows" key

myTerminal :: String
myTerminal = "alacritty"

myNormalBorderColor :: String
myNormalBorderColor = "#998A45"

myFocusedBorderColor :: String
-- myFocusedBorderColor = "#D0CFA3"
myFocusedBorderColor = "#8FBC8F"

myBrowser :: String
myBrowser = "firefox"

xmobarToggleCommand :: String
xmobarToggleCommand = "dbus-send --session --dest=org.Xmobar.Control --type=method_call '/org/Xmobar/Control' org.Xmobar.Control.SendSignal \"string:Toggle 0\""


myKeys :: [(String, X ())]
myKeys =
    [ ("M-x", passPrompt def)
    , ("M-C-s", spawn "scrot -s")
    , ("M-f", spawn myBrowser) -- Firefox
    , ("M-w", spawn "chromium")
    , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 5%-")
    , ("<XF86MonBrightnessUp>", spawn "brightnessctl set +5%")
    , ("M-<XF86MonBrightnessDown>", spawn "brightnessctl --device='tpacpi::kbd_backlight' set 1-")
    , ("M-<XF86MonBrightnessUp>", spawn "brightnessctl --device='tpacpi::kbd_backlight' set +1")
    , ("<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 3000+")
    , ("<XF86AudioLowerVolume>", spawn "amixer -q sset Master 3000-")
    , ("<XF86AudioMute>", spawn "amixer sset Master toggle")
    , (("M-d"), withFocused (keysResizeWindow (-10,-10) (1,1)))
    , (("M-s"), withFocused (keysResizeWindow (10,10) (1,1)))
    , (("M-b"), spawn xmobarToggleCommand)
    , (("M-<Escape>"), spawn "/home/arim/.scripts/xkbmap.sh") -- toggle US-Russian keyboards
    , (("M-t"), spawn "/home/arim/.scripts/bcn.sh") -- connect to a Bluetooth device
    , (("M-v"), spawn "/home/arim/.scripts/bluetoothvolume.sh")
    ]

myLayout = avoidStruts $ spacingWithEdge 3 tiled ||| spacingWithEdge 3 (Mirror tiled) ||| spacingWithEdge 0 (noBorders Full) ||| spacingWithEdge 3 (spiral (6/7))
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1      -- Default number of windows in the master pane
    ratio   = 1/2    -- Default proportion of screen occupied by master pane
    delta   = 3/100  -- Percent of screen to increment by when resizing panes

myManageHook :: ManageHook
myManageHook = className =? "Anki" --> doFloat

newManageHook = myManageHook <> manageHook def

myXmobarPP :: PP
myXmobarPP = def { ppCurrent = rev . wrap "-" "-"
                 , ppTitle   = shorten' "" 0 -- Suppress output.
                 , ppLayout  = (\x -> pad $ case x of
                 "Spacing Tall" -> "[]"
                 "Spacing Mirror Tall" -> "[]="
                 "Spacing Full" -> "[ ]"
                 "Spacing Spiral" -> " ❦ "
                 _ -> x
                 )
                 , ppSep     = ""
                 , ppWsSep   = " "
                 }
    where
                  norm, rev :: String -> String
                  norm = xmobarColor "#7C7143" "#271103"
                  rev = xmobarColor "#271103" "#7C7143"

mySB = statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)

main :: IO ()
main = do
    xmonad
    . ewmhFullscreen
    . ewmh
    . docks
    . withEasySB mySB toggleStrutsKey
    $ myConfig
    where
    toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
    toggleStrutsKey XConfig{ modMask = m } = (m, xK_m)

myConfig = def
    { modMask = myModMask
    , layoutHook = myLayout
    , borderWidth = 1
    , terminal = myTerminal
    , normalBorderColor = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , manageHook = newManageHook
    } `additionalKeysP` myKeys
