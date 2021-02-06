
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









