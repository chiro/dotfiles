--
-- My xmonad config file.
--

import XMonad
import Data.Monoid
import System.Exit
import System.IO

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.WorkspaceCompare

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.List

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces = ["term","emacs","Web","music","5","6","7","8","9"]

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "killall trayer; xmonad --recompile; xmonad --restart")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

myLayout = tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Downloads"      --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , className =? "Firefox"        --> doShift "Web"
    , fmap ("Chromium" `isInfixOf`) className --> doShift "Web"
    , className =? "emacs"          --> doShift "emacs"
    , className =? "Emacs"          --> doShift "emacs"
    , fmap ("quodlibet" `isInfixOf`) className --> doShift "music"
    , manageDocks
    ]

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP PP {
  ppCurrent         = xmobarColor "#f33" "",
  ppVisible         = xmobarColor "#cc0" "",
  ppHidden          = id,
  ppHiddenNoWindows = xmobarColor "#666" "",
  ppUrgent          = xmobarColor "#f33" "#ff0",
  ppSep             = wrap " " " " $ xmobarColor "" "#fff" " ",
  ppWsSep           = " ",
  ppTitle           = xmobarColor "#0f0" "" . shorten 60,
  ppTitleSanitize   = id,
  ppLayout          = \s -> "", --id,
  ppOrder           = id,
  ppSort            = getSortByIndex,
  ppExtras          = [],
  ppOutput          = hPutStrLn h }

-- Main
main = do
  xmobarHandle <- spawnPipe "xmobar"
  trayerHandle <- spawnPipe "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --padding 0 --transparent true --tint 0x000000 --height 26 --distance 2"
  spawn "emacs"
  xmonad (defaults xmobarHandle)

defaults xmobar = defaultConfig {
      -- simple stuff
        terminal           = "urxvtc -fn \"xft:Ricty:pixelsize=16\"",
        focusFollowsMouse  = False,
        borderWidth        = 1,

        -- I use Muhenkan as modMask.
        -- See also .xmodmap.
        modMask            = mod4Mask,

        workspaces         = myWorkspaces,

        normalBorderColor  = "#dddddd", -- gray
        focusedBorderColor = "#ff0000", -- red

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = avoidStruts $ myLayout,
        manageHook         = myManageHook,
        handleEventHook    = mempty,
        logHook            = myLogHook xmobar,
        startupHook        = return () -- do nothing.
    }
