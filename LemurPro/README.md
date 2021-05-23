
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

4. Firefox
open about:config and set `browser.backspace_action` to `0`.

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

4.6. My xkeysnail config.py (stored as `$HOME/.config/xkeysnail/config.py`):
```
# -*- coding: utf-8 -*-

import re
from xkeysnail.transform import *

# define timeout for multipurpose_modmap
define_timeout(1)

# [Global modemap] Change modifier keys as in xmodmap
define_modmap({
    Key.CAPSLOCK: Key.LEFT_CTRL,
    Key.RIGHT_ALT: Key.MUHENKAN
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

define_keymap(re.compile(".*"), {
    K("T"): K("K"),
    K("K"): K("E"),
    K("E"): K("D"),
    K("D"): K("T"),
    K("Shift-T"): K("Shift-K"),
    K("Shift-K"): K("Shift-E"),
    K("Shift-E"): K("Shift-D"),
    K("Shift-D"): K("Shift-T"),
}, "Minimak-4")

```

5. Japanese IME settings

I do need to sometimes type in Japanese. So the dollowing 

https://kinakoankon.net/ubuntu-20-04-japanese-input-ibus-fcitx-mozc/







