--
-- My xmonad config file.
--

import XMonad
import XMonad.Config
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Layout
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.EZConfig (additionalKeys, additionalKeysP)

main = xmonad $ docks $ disableEwmhManageDesktopViewport . ewmhFullscreen . ewmh $ defaults

defaults = def {
  -- Super key for the mod
  modMask            = mod4Mask,

  -- Use alacritty as a default terminal
  terminal           = "alacritty",

  focusFollowsMouse  = False,
  clickJustFocuses   = False,

  -- border settings
  borderWidth        = 1,
  normalBorderColor  = "#0000dd", -- blue
  focusedBorderColor = "ff0000", -- red

  startupHook        = myStartupHook,
  layoutHook         = avoidStruts $ myLayoutHook,
  manageHook         = myManageHook,
  workspaces         = myWorkspaces
}
  `additionalKeysP`
  [ ("M-S-l", spawn "xscreensaver-command --lock") ]
  `additionalKeys`
  [ ((0, 0x1008FF11), spawn "amixer -D pulse sset Master 2%-"),
    ((0, 0x1008FF12), spawn "amixer -D pulse set Master toggle"),
    ((0, 0x1008FF13), spawn "amixer -D pulse sset Master 2%+") ]

myLayoutHook = tiled ||| Mirror tiled ||| Full
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by the master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "polybar"
  spawnOnce "nitrogen --restore"
  spawnOnce "fcitx5"
  spawnOnce "xscreensaver --no-splash"

myWorkspaces = ["term", "emacs", "Web", "Slack", "5", "6", "7", "8", "9"]

myManageHook = composeAll
  [ className =? "Emacs" --> doShift "emacs"
  , className =? "Slack" --> doShift "Slack"
  , manageDocks
  ]
