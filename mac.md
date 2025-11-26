# Setting up a mac

 - Check for updates

## Settings

- For external keyboard, choose "British PC" as input language so that keys
  like #\\\` all work.
- Change settings
  + Display resolution
  + Gestures
  + Set up internet accounts
  + Remap caps lock key
- Clone dotfiles repo
- Set up [ssh keys][github-ssh]

## Apps

See  [[apps]] for generic apps

- Screen management
  + ~~Magnet~~
  + Rectangle
- Apple software suite
  + Numbers
  + Pages
  + Keynote
  + iMovie
  + XCode
- [Homebrew][homebrew]
- [iTerm][iterm]
- [Boop](https://github.com/IvanMathy/Boop) - install from mac app store
- [Git stats] (`brew install git-quick-stats`)

  zshrc config

  ```
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  ```

[homebrew]: https://brew.sh
[iterm]: https://www.iterm2.com
[Git stats]: https://github.com/git-quick-stats/git-quick-stats
