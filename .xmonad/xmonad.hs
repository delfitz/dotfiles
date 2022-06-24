import XMonad
import System.Directory
import System.IO (hClose, hPutStr, hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

    -- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote

    -- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)

    -- Layouts
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ThreeColumns

    -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.WindowNavigation

   -- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP, mkNamedKeymap)
import XMonad.Util.NamedActions
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

-- import Colors.DoomOne

myFont :: String
myFont = "xft:Hack Nerd Font Complete:weight=regular:size=12:antialias=true:hinting=true"
myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key
myTerminal :: String
myTerminal = "kitty"    -- Sets default terminal
myBrowser :: String
myBrowser = "firefox"  -- Sets qutebrowser as browser
myBorderWidth :: Dimension
myBorderWidth = 2           -- Sets border width for windows
myNormColor :: String       -- Border color of normal windows
myNormColor   = "#778899"   -- This variable is imported from Colors.THEME
myFocusColor :: String      -- Border color of focused windows
myFocusColor  = "#55bbbb"     -- This variable is imported from Colors.THEME
logColor :: String
logColor = "#223355"

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook :: X ()
myStartupHook = do
    spawn "kill perfpipe"
    spawnOnce "picom"
    spawn "~/.fehbg"
    spawn "perfpipe --all"


threeColMid = renamed [Replace "threeColMid"]
            $ smartBorders
            $ windowNavigation
            $ ThreeColMid 1 (3/100) (2/5)

myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
  { swn_font              = "xft:Hack Nerd Font Complete:bold:size=60"
  , swn_fade              = 1.0
  , swn_bgcolor           = "#1c1f24"
  , swn_color             = "#ffffff"
  }

myLayoutHook = spacingWithEdge 20
            $ avoidStruts
            $ myDefaultLayout
        where
            myDefaultLayout = withBorder myBorderWidth threeColMid
                      -- ||| magnify
myWorkspaces = [" dev ", " www ", " sys "]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
  h <- spawnPipe $ "yad --text-info --fontname=\"Hack Nerd Font Complete 12\" --fore=#46d9ff back=#282c36 --center --geometry=1200x800 --title \"XMonad keybindings\""
  hPutStr h (unlines $ showKm x)
  hClose h
  return ()

myKeys :: XConfig l0 -> [((KeyMask, KeySym), NamedAction)]
myKeys c = (subtitle "Custom Keys":) $ mkNamedKeymap c $
    [ ("M-S-q", addName "Restart XMonad"              $ spawn "xmonad --recompile; xmonad --restart")
    , ("M-S-q", addName "Quit XMonad"                 $ io exitSuccess)
    , ("M-<Return>", addName "Launch terminal"        $ spawn (myTerminal))
    , ("M-S-<Return>", addName "Launch browser"       $ spawn (myBrowser))
    , ("M-S-c", addName "Kill focused window"         $ kill1)
    , ("M-m", addName "Move focus to master window"   $ windows W.focusMaster)
    , ("M-j", addName "Move focus to next window"     $ windows W.focusDown)
    , ("M-k", addName "Move focus to prev window"     $ windows W.focusUp)
    , ("M-S-j", addName "Swap focus to next window"   $ windows W.swapDown)
    , ("M-S-k", addName "Swap focus to prev window"   $ windows W.swapUp) ]

main :: IO ()
main = do
    xmproc0 <- spawnPipe ("xmobar -x 0 $HOME/.config/xmobar/xmobarrc-top")
    xmproc1 <- spawnPipe ("xmobar -x 0 $HOME/.config/xmobar/xmobarrc-bottom")
    xmonad $ addDescrKeys ((mod4Mask, xK_F1), showKeybindings) myKeys def 
        {
          handleEventHook    = docksEventHook
                             -- <+> fullscreenEventHook
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = showWName' myShowWNameTheme $ myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor
        -- , logHook = dynamicLogWithPP $ xmobarPP 
        --     { 
        --       ppOutput = \x -> hPutStrLn xmproc0 x   -- xmobar on monitor 1
        --                 >> hPutStrLn xmproc1 x   -- xmobar on monitor 2
        --     , ppCurrent = xmobarColor logColor "" . wrap
        --                   ("<box type=Bottom width=2 mb=2 color=" ++ logColor ++ ">") "</box>"
        --       -- Visible but not current workspace
        --     , ppVisible = xmobarColor logColor "" . clickable
        --       -- Hidden workspace
        --     , ppHidden = xmobarColor logColor "" . wrap
        --                  ("<box type=Top width=2 mt=2 color=" ++ logColor ++ ">") "</box>" . clickable
        --       -- Hidden workspaces (no windows)
        --     , ppHiddenNoWindows = xmobarColor logColor ""  . clickable
        --       -- Title of active window
        --     , ppTitle = xmobarColor logColor "" . shorten 60
        --       -- Separator character
        --     , ppSep =  "<fc=" ++ logColor ++ "> <fn=1>|</fn> </fc>"
        --       -- Urgent workspace
        --     , ppUrgent = xmobarColor logColor "" . wrap "!" "!"
        --       -- Adding # of windows on current workspace to the bar
        --     , ppExtras  = [windowCount]
        --       -- order of things in xmobar
        --     , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
        --     }
        }


