#! /usr/bin/env bash
################################################################################
# setup.sh
# -----------------
# This script installs and configures my machine
################################################################################
set -eo pipefail

setup_dotfiles(){
    # Check if user created ./shell/extra
    if [[ ! -f ./shell/.extra ]]; then
        echo "Don't forget to add ./shell/.extra file to export sensitive environment vars"
        echo 'export GIT_AUTHOR_EMAIL=""'
        echo 'export GIT_COMMITTER_EMAIL=""'
        exit 1
    fi
    # Symlink dotfiles
    for file in $(find "$PWD"/shell -name ".*"); do
        f="$(basename "$file")"
        ln -sfn "$file" "$HOME/$f"
    done
    # Symlink global gitignore
    ln -sfn "$PWD"/gitignore "$HOME"/.gitignore;
    echo "Added dotfiles to $HOME"
}

setup_macos() {
    if [[ "$(uname)" != "Darwin" ]]; then
        echo "Error: Tried to apply macos settings, but this is not a macos machine"
        exit 1
    fi
    pushd ./macos > /dev/null
    ./setup.sh
    popd > /dev/null
}

print_usage() {
    cat <<EOT

Setup a fresh machine - Joao Fernandes

Usage: $(basename "$0") [options]

Options:
    dotfiles    Install dotfiles for custom shell
    macos       Apply macOS preferences and install packages

EOT
}

# Read options, print usage if no valid option selected
case "$1" in
    macos)
        setup_macos
        ;;
    dotfiles)
        setup_dotfiles
        ;;
    *)
        print_usage
        ;;
esac

