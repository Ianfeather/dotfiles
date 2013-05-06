#!/bin/bash

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Use AirDrop over every interface. srsly this should be a default."
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

echo "Enable javascript console"
sudo ln /System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc /bin/jsc

echo "Disable the crash reporter"
#defaults write com.apple.CrashReporter DialogType -string "none"

echo "Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "Save screenshots to the desktop"
defaults write com.apple.screencapture location -string "$HOME/Desktop"

echo "Finder: allow quitting via ⌘ + Q;"
defaults write com.apple.finder QuitMenuItem -bool true

echo "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Copy email addresses as foo@example.com instead of Foo Bar <foo@example.com> in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo "Speed up repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 0

echo "Remap the hash key to §"
if [ ! -d $HOME/Library/KeyBindings/ ]; then
  mkdir $HOME/Library/KeyBindings
fi
if [ ! -f $HOME/Library/KeyBindings/DefaultKeyBinding.dict ]; then
  touch $HOME/Library/KeyBindings/DefaultKeyBinding.dict;
fi
cat script/remap.SOURCE >> ~/Library/KeyBindings/DefaultKeyBinding.dict


for app in "Address Book" "Calendar" "Contacts" "Dashboard" "Dock" "Finder" \
  "Mail" "Safari" "SystemUIServer" "Terminal" "iCal"; do
  killall "$app" > /dev/null 2>&1
done

echo "Done. Note that some of these changes require a logout/restart to take effect."