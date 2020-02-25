#! /usr/bin/env bash
################################################################################
# setup_system.sh
# -----------------
# This script applies my favorite macos system settings
################################################################################
set -eox pipefail

# What's missing, needs to be configured manually
# Keyboard / Input sources / Add US international
# Security / Ask password immediately
# Set up night shift hours and color temperature
# Set up app-specific shortcuts
# Make finder open in new tab instead of window
# Configure finder left pane favorites

USER=jff
HOSTNAME=jff-mac

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Global
###############################################################################

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

###############################################################################
# System preferences
# 1. General
###############################################################################

# Set accent color to graphite
defaults write NSGlobalDomain AppleAccentColor -int -1

# Set highlight color to graphite
defaults write NSGlobalDomain AppleHighlightColor -string "0.847059 0.847059 0.862745 Graphite"

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Show scroll bars automatically based on mouse
# Possible values: `WhenScrolling`, `Automatic` and `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string "Automatic"

## Click in the scrollbar to jump to spot where it was clicked
defaults write NSGlobalDomain AppleScrollerPagingBehavior -int 1

###############################################################################
# System preferences
# 2. Desktop & screen saver
###############################################################################

# Never show screensaver
defaults -currentHost write com.apple.screensaver idleTime 0

###############################################################################
# System preferences
# 3. Dock
###############################################################################

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

# Double click a window's title bar to zoom
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Maximize"

# Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true

# Animate opening applications
defaults write com.apple.dock launchanim -bool true

# Automatically hide and show dock
defaults write com.apple.dock autohide -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don't show recent apps in dock
defaults write com.apple.dock show-recents -bool false

###############################################################################
# System preferences
# 4. Mission Control
###############################################################################

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# When switching apps, switch to space with that app
# todo, find what controls this

# Don’t group windows by application
defaults write com.apple.dock expose-group-by-app -bool false

# Disable Dashboard
defaults write com.apple.dashboard db-enabled-state -int 1

###############################################################################
# System preferences
# 5. Language & Region
###############################################################################

# English language
defaults write NSGlobalDomain AppleLanguages -array "en-US"

# Region - US
defaults write NSGlobalDomain AppleLocale -string "en_US"

# Set first day of week to Monday
defaults write NSGlobalDomain AppleFirstWeekday -dict "gregorian" "2"

# Use 24-hour time format
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

# Temperature in Celsius
defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"

# Use metric units
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set measurement units to metric
# Supported values "Centimeters", "Inches"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"

# Set Date format strings

# Short
#defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "1" "dd/MM/yy"
# Medium
#defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "2" "MMM dd yyyy"
# Long
#defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "3" "MMM dd yyyy"
# Full
#defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "4" "EEEE, MMMM dd, yyyy"

# Set Time format strings

# Short
#defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "1" "HH:mm"
# Medium
#defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "2" "HH:mm:ss"
# Long
#defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "3" "HH:mm:ss z"
# Full
#defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "4" "HH:mm:ss zzzz"

###############################################################################
# System preferences
# 6. Security and privacy
###############################################################################

# Require password immediately after sleep or screen saver begins
# This doesn't work after 10.13
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0

###############################################################################
# System preferences
# 7. Spotlight
###############################################################################


# Customize what spotlight shows
defaults write com.apple.spotlight orderedItems -array \
    '{"enabled" = 1;"name" = "APPLICATIONS";}' \
    '{"enabled" = 0;"name" = "BOOKMARKS";}' \
    '{"enabled" = 1;"name" = "CONTACT";}' \
    '{"enabled" = 1;"name" = "DIRECTORIES";}' \
    '{"enabled" = 1;"name" = "DOCUMENTS";}' \
    '{"enabled" = 1;"name" = "MESSAGES";}' \
    '{"enabled" = 0;"name" = "EVENT_TODO";}' \
    '{"enabled" = 0;"name" = "FONTS";}' \
    '{"enabled" = 0;"name" = "IMAGES";}' \
    '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
    '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
    '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
    '{"enabled" = 0;"name" = "MENU_OTHER";}' \
    '{"enabled" = 1;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}' \
    '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
    '{"enabled" = 0;"name" = "MOVIES";}' \
    '{"enabled" = 0;"name" = "MUSIC";}' \
    '{"enabled" = 0;"name" = "PDF";}' \
    '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
    '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
    '{"enabled" = 1;"name" = "SYSTEM_PREFS";}'

# Load new settings before rebuilding the index
killall mds &> /dev/null || true
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null

###############################################################################
# System preferences
# 8. Notifications
###############################################################################

# TODO

###############################################################################
# System preferences
# 9. Displays
###############################################################################

# TODO

###############################################################################
# System preferences
# 10. Energy saver
###############################################################################

# When using charger, put display to sleep after 10 mins
sudo pmset -c displaysleep 10

# When using battery, put display to sleep after 10 mins
sudo pmset -b displaysleep 2

# When using battery, put disk to sleep after 10 mins
sudo pmset -b disksleep 2

# While sleeping on battery don't update iCloud services
sudo pmset -b powernap 0

# When using battery don't dim display
sudo pmset -b halfdim 0

###############################################################################
# System preferences
# 11. Keyboard
###############################################################################

# Set fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Correct spelling
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Don't add period with double space
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Don't use smart quotes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

###############################################################################
# System preferences
# 12. Mouse
###############################################################################

# Todo

###############################################################################
# System preferences
# 13. Trackpad
###############################################################################

# Tap to click, both for this user and login screen
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# TODO disable app expose gesture

# Disable the Launchpad gesture (pinch with thumb and three fingers)
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# Enable 3 finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1

###############################################################################
# System preferences
# 23. Sharing
###############################################################################

sudo scutil --set ComputerName "$HOSTNAME"
sudo scutil --set HostName "$HOSTNAME"
sudo scutil --set LocalHostName "$HOSTNAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$HOSTNAME"

###############################################################################
# System preferences
# 29. Accessibility
###############################################################################

# Disable transparency in menu bar
# TODO jff: this is failing
#defaults write com.apple.universalaccess reduceTransparency -bool false

###############################################################################
# Finder settings
###############################################################################

# Show only external disks on Desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false

# Show full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# TODO, check open folders in tabs instead of new windows

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Don't show  warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show hidden files by default
#defaults write com.apple.finder AppleShowAllFiles -bool true

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

###############################################################################
# Desktop settings
###############################################################################

# Snap to grid
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Set icon size to 36x36
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 36" ~/Library/Preferences/com.apple.finder.plist

# Set grid spacing to 54
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 54" ~/Library/Preferences/com.apple.finder.plist

# Set text size to 12
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:textSize 12" ~/Library/Preferences/com.apple.finder.plist

###############################################################################
# Time Machine settings
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

###############################################################################
# Activity Monitor settings
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Kill affected applications so settings take effect
###############################################################################

for app in "Activity Monitor" \
    "Dock" \
    "Finder" \
    "Spectacle"; do
    killall "${app}" &> /dev/null || true
done