# Setting up a fedora machine
 
 **Any settings changed may require the user to log out or a restart to take effect**

First install vim for editing any further configuration files

```shell
sudo dnf install vim
```

Clone this repository to get the scripts for futher setup

```shell
mkdir dev && cd dev
git clone https://github.com/0mpurdy/dotfiles
```

Install i3

```
sudo dnf install i3 i3status dmenu i3lock xbacklight feh conky
```

The configuration for i3 is located at `~/.config/i3/config`, it may be worth adding mouse key bindings from [this Reddit post](i3-mouse)

Edit `~/.bash_profile` to set the default terminal emulator for i3

```
export TERMINAL=gnome-terminal
```

Install [nvm](https://github.com/creationix/nvm)

[i3-mouse]: https://www.reddit.com/r/i3wm/comments/3btki2/use_the_mouse_cursor_from_the_keyboard/
