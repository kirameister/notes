# This is a note over the environment for my Framework Laptop 13inch AMD

## Initial installation settings

Update `/etc/pacman.conf` by un-commenting following lines

```
[multilib]
Include = /etc/pacman.d/mirrorlist
```

## Pacman packages

* less
* acpi
* brightnessctl
* xev
* rofi
* ibus
* neovim
* virtualbox
* wine
* winetricks
* ollama
* signal-desktop
* handbrake-cli
* unrar
* calibre
* audacity
* conky
* nitrogen
* flameshot
* python-virtualenv
* xinput
* libinput
* acipilight
* python-dbus-fast
* alsa-utils
* python-iwlib
* upower
* xorg-server-xephyr
* thunar
* sshfs (necessary for thunar to communicate via ssh)
* gvfs (necessary for thunar to communicate via ssh)
* zenity (for confirmation dialog within thunar)
* vlc
* vlc-plugins-all
* breeze-icons
* keepassxc
* simple-scan
* catfish
* feh
* arandr
* npm (required by NeoVim package)
* python-pytest (for my own project)
* python-pytest-mock (for my own project)

### following packages are only necessary for playing audio in Wine environment

* alsa-firmware
* alsa-lib
* alsa-plugins
* alsa-utils
* lib32-alsa-lib
* lib32-alsa-plugins
* pulseaudio-alsa
* lib32-libpulse
* libcanberra-pulse
* libpulse
* pulseaudio
* pulseaudio-alsa
* lib32-openal
* openal

## AUR

* [qtile-extras](https://aur.archlinux.org/packages/qtile-extras)
* [teams](https://aur.archlinux.org/packages/teams)
* [brave-bin](https://aur.archlinux.org/packages/brave-bin)
* [i3lock-color](https://aur.archlinux.org/packages/i3lock-color)
* [i3lock-fancy-git](https://aur.archlinux.org/packages/i3lock-fancy-git)
* [mcomix](https://aur.archlinux.org/packages/mcomix)
* [mozc](https://aur.archlinux.org/packages/mozc)
* [ibus-mozc](https://aur.archlinux.org/packages/ibus-mozc)
* [mozc-ut](https://aur.archlinux.org/packages/mozc-ut)
* [ttf-juisee](https://aur.archlinux.org/packages/ttf-juisee) -- This is the font I'd be using
* [xremap-x11-bin](https://aur.archlinux.org/packages/xremap-x11-bin)
* [auto-cpufreq](https://aur.archlinux.org/packages/auto-cpufreq)
* [Brother-printer-driver](https://aur.archlinux.org/packages/brother-hll2350dw)

## Configs

```
export HC="$HOME/.config"
```

### XRemap
```
mv xremap.yml $HC/
sudo gpasswd -a $USER input
echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/input.rules
echo "uinput" | sudo tee /etc/modules-load.d/uinput.conf
echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules

mkdir -p $HC/systemd/user
mv xremap.service $HC/systemd/user/
systemctl --user enable xremap.service
systemctl --user start xremap.service
```

### DPI settings (for my display)

```
echo 'Xft.dpi: 164' > $HOME/.Xresources
```

### Qtile

```
cp -r qtile $HC/
```

### vim

Please note that the location of `.vimrc` is directly under the `$HOME`.
```
mkdir $HOME/.vim
cp dot.vimrc $HOME/.vimrc
```

### NeoVim

```
cp -r nvim $HC/
```

### Mozc
```
mkdir $HC/mozc
cp config1.db $HC/mozc

mkdir -p $HC/systemd/user
mv ibus_daemon.service $HC/systemd/user/
systemctl --user enable ibus_daemon.service
systemctl --user start ibus_daemon.service
```

Run `ibus-setup` and select "mozc(あ)" as only input source.

### Terminal config
```
# alacritty
mkdir $HC/alacritty
cp alacritty.toml $HC/alacritty/
```

### For alttab , add following lines in `/etc/fonts/fonts.conf`
```
<!--
  Font family that can also render Japanese chars
-->
	<match target="pattern">
		<test qual="any" name="family">
			<string>juisee</string>
		</test>
		<edit name="family" mode="assign" binding="same">
			<string>JuiseeSZIS-Regular</string>
		</edit>
	</match>
```

### video group (necessary for brightness control)
```
sudo usermod -a -G video $USER
sudo chgrp video /sys/class/backlight/amdgpu_bl1/brightness
sudo chmod g+w /sys/class/backlight/amdgpu_bl1/brightness
sudo chown root:video /sys/class/leds/chromeos:white:power/brightness
```

### Libinput (trackpad)

Create a file called `/etc/X11/xorg.conf.d/30-touchpad.conf` and add following lines
```
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "ClickMethod" "clickfinger"
EndSection
```

### Network

Open `/etc/resolv.conf` and use the following value instead of `.` (of course, replace `HOME_DOMAIN.NAME` with something appropriate)
```
search HOME_DOMAIN.NAME
```

### MComix
```
cp -r mcomix $HC/
```

### Thunar

 Go over the following steps. This is to let the confirmation dialog window to appear when deleting the file (in the original Thunar behavior, files are removed permanently without confirmation).

1. Select "Edit" > "Preference"
2. In the opened dialog, select "Shortcuts" tab, and empty (remove) "Delete" from both "Move to Trash" and "Delete" under "Launcher" segment. Click "Close" once done. 
3. Select "Edit" > "Configure custom actions...".
4. In the opened dialog, click "+" icon, and fill in following values (in "Basic" tab): 
	* Name: "delete-confirm"
	* Command: `zenity --question --text="Are you sure you want to delete %N?" && rm -rf %F`
	* Keyboard Shortcut: "Delete"
5. In "Appearance Conditions" tab, select all the checkboxes under "Appears if selection contains:". Click "OK" (and then "Close") once this is done. 

### Brave browser

* Open "Settings" => "Contents" and enable "Cycle through the most recently use tabs with Ctrl-Tab".
* Install [Keyboard Shortcuts](https://chromewebstore.google.com/detail/keyboard-shortcuts/lplcmnhgijkkmflbmhabnccgelffpnog?hl=en-US) extension and set "Ctrl+PageUp" for "Select previous tab" and "Ctrl+PageDown" for "Select next tab".
* Open "Settings" => "System" => "Shortcuts" and make "Previous tab" empty while keeping only "Ctrl+Tab" for "Next tab"

### Wine
```
winetricks jkfonts
winetricks sound=alsa
```

Following are necessary for properly installing [VMJapan](https://ja.wikipedia.org/wiki/VM_JAPAN) (ancient strategy game from Falcom Japan)
```
cd $HOME/.wine/drive_c/users/$USER/
ln -s AppData "Application Data"
```

