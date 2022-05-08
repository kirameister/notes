
It's been a while since I purchased (and started using) LemurPro from System76. While I enjoyed using the machine, there are some settings I thought worth taking note (in order to avoid wandering around next time I'd be going on the same path). 

1. Upgrade Firmware

2. Install software from Pop_Shop
Following software have been installed (not exclusive): 
- KiCad
- Signal
- Chromium
- Firefox
- Dropbox
- GParted
- PrusaSlicer
- Skype
- VLC

3. Install software via apt
- python3
- python3-pip
- virtualenv
- awesome
- awesome-extra
- zsh
- vim
- ripgrep
- git
- protobuf-compiler

4. xkeysnail
```
sudo pip3 install xkeysnail
```

Following procedures are taken from https://qiita.com/yosmoc/items/2e1d779e806a7e8543d6

4.1. create a user group called `uinput`:
```
sudo groupadd uinput
sudo usermod -a -G input,uinput `whoami`
```

4.2. create following files:

/etc/udev/rules.d/input.rules:
```
KERNEL=="event*", NAME="input/%k", MODE="660", GROUP="input"
```

/etc/udev/rules.d/uinput.rules:
```
KERNEL=="uinput", GROUP="uinput"
```

4.3. create systemd service

```
# 1. Copy this to ~/.config/systemd/user/xkeysnail.service
# 2. systemctl --user enable xkeysnail
#
# Note that you need to set proper $DISPLAY on your environment.

[Unit]
Description=xkeysnail

[Service]
KillMode=process
ExecStart=/usr/local/bin/xkeysnail /home/your_username/.xkeysnail/config.py
ExecStartPre=/usr/bin/xhost +SI:localuser:root
Type=simple
Restart=always

# Update DISPLAY to be the same as `echo $DISPLAY` on your graphical terminal.
Environment=DISPLAY=:0

[Install]
WantedBy=default.target
```

4.4. enable and start the service

```
systemctl --user enable xkeysnail
systemctl --user start xkeysnail
```

4.5. check the service status

```
systemctl --user status xkeysnail
```

4.6. Example xkeysnail config.py (to be stored as `$HOME/.config/xkeysnail/config.py`) shown below. Please have a look at xkeymacs_config.py for the latest version.

```
# -*- coding: utf-8 -*-

import re
from xkeysnail.transform import *

# define timeout for multipurpose_modmap
define_timeout(1)

# [Global modemap] Change modifier keys as in xmodmap
define_modmap({
    Key.CAPSLOCK: Key.LEFT_CTRL,
})

define_multipurpose_modmap({
    Key.RIGHT_ALT: [Key.MUHENKAN, Key.RIGHT_ALT],
})

# Emacs-like keybindings in non-Emacs applications
define_keymap(lambda wm_class: wm_class not in ("Emacs", "URxvt", "Gnome-terminal"), {
    # Cursor
    K("C-b"): with_mark(K("left")),
    K("C-f"): with_mark(K("right")),
    K("C-p"): with_mark(K("up")),
    K("C-n"): with_mark(K("down")),
    K("C-h"): with_mark(K("backspace")),
    # Beginning/End of line
    K("C-a"): with_mark(K("home")),
    K("C-e"): with_mark(K("end")),
    # Newline
    K("C-m"): K("enter"),
    K("C-j"): K("enter"),
    K("C-o"): [K("enter"), K("left")],
    # Delete
    K("C-d"): [K("delete"), set_mark(False)],
    K("C-g"): K("C-BACKSPACE"),
    # Kill line
    K("C-k"): [K("Shift-end"), K("C-x"), set_mark(False)],
}, "Emacs-like keys")
```

5. Japanese IME settings

I do need to sometimes type in Japanese. So the dollowing 

https://kinakoankon.net/ubuntu-20-04-japanese-input-ibus-fcitx-mozc/

I personally use 新下駄配列 by mozc, which is a Japanese IME. In order to use the 新下駄配列, one needs to (currently) build the latest (version equal or later than 2.26.4450) mozc locally. On top of that, one would need to update the `config1.db`, stored in binary format, in order to configure the 新下駄配列 correctly: 

```
cat $HOME/.mozc/config1.db | protoc --proto_path=mozc/src/protocol --decode "mozc.config.Config" mozc/src/protocol/config.proto > $HOME/.mozc/config1.txt
## modify $HOME/.mozc/config1.txt
cat $HOME/.mozc/config1.txt | protoc --proto_path=mozc/src/protocol --encode "mozc.config.Config" mozc/src/protocol/config.proto > $HOME/.mozc/config1.db
```

Please note that `protoc` command is provided as part of `protobuf-compiler` package in the Debian-based operating systems (including `Ubuntu` and `Pop!_OS`). 

Modyfing the `$HOME/.mozc/config1.txt` could be done as following: 

```
cat $HOME/.mozc/config1.txt | perl -pe 's/^(custom_roman_table: ".*)"$/$1{!}\t\t\tNoTransliteration\n"/' > $HOME/.mozc/config1.txt
echo 'composing_timeout_threshold_msec: 80' >> $HOME/.mozc/config1.txt
```

The number `80` in the second command corresponds to the threshold in milliseconds to identify the simultaneous key-strokes. 

As indicated in the Xkeysnail config above, I've set binding from R_ALT to MUHENKAN key. This is to toggle direct input mode and Hiragana input mode by MUHENKAN, which doesn't exist in ANSI US physical keyboard layout. Such settings could be configured by `mozc icon -> Tools -> Properties` and clicking `Keymap Style Customize..`, and is stored within `config1.db`. 


6. Firefox
open about:config and set `browser.backspace_action` to `0`.





