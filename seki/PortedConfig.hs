{-# LANGUAGE OverloadedStrings #-}

{- | A port of the maintainer's xmonad.hs, the M2 acceptance oracle, against
the public API alone. It differs from the original in these ways:

* @className =?@ becomes 'appId' '=?'. Wayland clients report an app_id, and
  Xwayland clients report their class through the same field.
* @focusFollowsMouse = False@ and @clickJustFocuses = False@ need no setting.
  seki has no focus-follows-mouse, and a click on a window both focuses it and
  reaches the client, since river delivers an unbound press to the window and
  only tells seki that it was interacted with.
* @avoidStruts@, @docks@, and @manageDocks@ are dropped. Layouts tile river's
  non-exclusive area, so a bar's exclusive zone is already avoided, and bars
  are layer surfaces that seki never manages.
* @ewmh@ and @disableEwmhManageDesktopViewport@ are dropped. Bars read
  workspace state from seki's IPC instead, as @examples/waybar@ does.
* @ewmhFullscreen@ needs nothing: seki honors client fullscreen requests
  natively.
* 'defaultManageHook' stays last to float dialogs, as xmonad floats transient
  windows outside its manageHook.
* A held media or brightness key runs its command once and does not repeat,
  unlike xmonad on X11.
* 'spawnOnce' history survives a restart through seki's restore file.

'dailyConfig' is the port the maintainer runs every day on river. It keeps
everything above and differs from xmonad.hs in these further ways:

* @~/.config/polybar/launch.sh@ becomes @waybar@. Install
  @examples/waybar@ as Waybar's configuration to show seki's state.
* @nitrogen --restore@ becomes @swaybg@ with the same wallpaper. Nitrogen's
  saved mode 5, zoom fill, is swaybg's @fill@ mode.
* @xscreensaver --no-splash@ becomes @swayidle@, which runs @swaylock@ after
  10 minutes idle. xscreensaver blanked the screen without locking it. The
  port locks on purpose.
* Mod-Shift-l runs @swaylock@ instead of @xscreensaver-command --lock@.
* Mod-grave toggles a terminal scratchpad that xmonad.hs does not have.
  alacritty's @--class@ sets the Wayland app_id the pad matches.
* The keyboard and touchpad settings come from xorg.conf.d and xset and move
  into input rules. Compile the keymap file 'dailyConfig' is given from the
  X11 settings with @xkbcli compile-keymap --rules evdev --model pc105 --layout
  us --options ctrl:nocaps@.
* Automatic client urgency is unavailable. seki has no compositor signal for
  it.
-}
module PortedConfig (portedConfig, dailyConfig) where

import Data.Bifunctor (first)
import Seki

portedConfig :: Config StdLayouts
portedConfig =
  additionalKeys
    def
      { modMask = Mod4
      , terminal = "alacritty -o font.size=13.33"
      , workspaces = ["term", "emacs", "Web", "4", "5", "6", "7", "8", "9"]
      , borders = BorderConfig{borderWidth = 1, focusedBorderColor = opaque 0xff 0 0, unfocusedBorderColor = opaque 0 0 0xdd}
      , layoutHook = tiled ||| Mirror tiled ||| Full
      , manageHook =
          composeAll
            [ appId =? "Emacs" --> doShift "emacs"
            , appId =? "Discord" --> doShift "4"
            , appId =? "Steam" --> doShift "5"
            , defaultManageHook
            ]
      , startupHook = do
          spawnOnce "~/.config/polybar/launch.sh"
          spawnOnce "nitrogen --restore"
          spawnOnce "fcitx5"
          spawnOnce "xscreensaver --no-splash"
      }
    [ (KeyBinding (Mod4 .|. Shift) (Keysym 0x6c), spawn "xscreensaver-command --lock")
    , (KeyBinding (Mods 0) (Keysym 0x1008FF11), spawn "amixer -D pulse sset Master 2%-")
    , (KeyBinding (Mods 0) (Keysym 0x1008FF12), spawn "amixer -D pulse set Master toggle")
    , (KeyBinding (Mods 0) (Keysym 0x1008FF13), spawn "amixer -D pulse sset Master 2%+")
    , (KeyBinding (Mods 0) (Keysym 0x1008FF02), spawn "brightnessctl set 5%+")
    , (KeyBinding (Mods 0) (Keysym 0x1008FF03), spawn "brightnessctl set 5%-")
    ]
 where
  tiled = Tall 1 (3 / 100) (1 / 2)
  opaque r g b = BorderColor (channel r) (channel g) (channel b) maxBound
  channel byte = byte * 0x01010101

dailyConfig :: FilePath -> Either String (Config StdLayouts)
dailyConfig keymap = do
  let (padWidth, padHeight) = (1280, 800)
  padRect <- first show (mkSize padWidth padHeight >>= mkRect (Point ((1920 - padWidth) `div` 2) ((1200 - padHeight) `div` 2)))
  anyKeyboard <- first show (compileDevicePattern "*")
  touchpad <- first show (compileDevicePattern "ELAN06C7:00 04F3:3193 Touchpad")
  pure $
    additionalKeys
      portedConfig
        { startupHook = do
            spawnOnce "waybar"
            spawnOnce "swaybg -i /usr/share/backgrounds/archlinux/wave.png -m fill"
            spawnOnce "fcitx5"
            spawnOnce "swayidle -w timeout 600 'swaylock -f'"
        , scratchpads = [Scratchpad "term" "alacritty -o font.size=13.33 --class seki-scratchpad" (appId =? "seki-scratchpad") (OutputRect padRect)]
        , inputRules =
            [ InputRule anyKeyboard (Just Keyboard) [Keymap keymap, RepeatInfo 25 660]
            , InputRule touchpad (Just Pointer) [Tap True, ClickMethod ClickFinger, NaturalScroll True]
            ]
        }
      [ (KeyBinding (Mod4 .|. Shift) (Keysym 0x6c), spawn "swaylock")
      , (KeyBinding Mod4 (Keysym 0x60), toggleScratchpad "term")
      , (KeyBinding (Mod4 .|. Shift) (Keysym 0x71), spawn "loginctl terminate-session \"$XDG_SESSION_ID\" || pkill -x river")
      , (KeyBinding Mod4 (Keysym 0x70), spawn "wmenu-run || dmenu_run")
      , (KeyBinding (Mod4 .|. Shift) (Keysym 0x6a), windows swapDown)
      , (KeyBinding (Mod4 .|. Shift) (Keysym 0x6b), windows swapUp)
      , (KeyBinding Mod4 (Keysym 0xff09), windows focusDown)
      , (KeyBinding (Mod4 .|. Shift) (Keysym 0xff09), windows focusUp)
      ]
