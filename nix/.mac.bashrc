# Mac specific bashrc values

## Environment variables

export ANDROID_HOME='/Users/mike/Library/Android/sdk/'
export ONI_NEOVIM_PATH=/home/user/Downloads/nvim.appimage

## PATH additions

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=/usr/local/bin:$PATH
export PATH=~/Library/Android/sdk/tools:$PATH
export PATH=~/Library/Android/sdk/platform-tools:$PATH

# quickly show and hide hidden files in finder
# Taken from article: https://ianlunn.co.uk/articles/quickly-showhide-hidden-files-mac-os-x-mavericks/
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
