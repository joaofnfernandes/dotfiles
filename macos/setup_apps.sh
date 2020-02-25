#! /usr/bin/env bash
################################################################################
# setup_apps.sh
# -----------------
# This script installs and configures my macOS apps
################################################################################
set -eo pipefail

install_brew(){
    if [[ -z "$(command -v brew)" ]]; then
        echo "Installing Homebrew"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

install_packages(){
    if [[ -z $(command -v brew) ]]; then
        echo "Error: Homebrew not installed"
        exit 1
    fi
    echo "Installing Homebrew packages"
    brew update
    brew bundle install --file confs/Brewfile
    brew cleanup
}

# Use Bash installed with brew as default shell
config_bash(){
    BREW_PREFIX=$(brew --prefix)
    if ! grep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
        echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells
        chsh -s "${BREW_PREFIX}/bin/bash"
    fi
}

config_iterm(){
    if [[ -z $(brew cask info iterm2) ]]; then
        echo "Error: iTerm2 not installed"
        exit 1
    fi
    
    # Don’t prompt on ⌘+Q
    defaults write com.googlecode.iterm2 PromptOnQuit -bool false
}

config_spectacle(){
    if [[ -z $(brew cask info spectacle) ]]; then
        echo "Error: Spectacle not installed"
        exit 1
    fi
    ln -sfn "$PWD"/confs/spectacle.json ~/Library/Application\ Support/Spectacle/Shortcuts.json
}

main(){
    install_brew
    install_packages
    config_bash
    config_iterm
    config_spectacle
}

main