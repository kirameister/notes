# -*- coding: utf-8 -*-

# this file is assumed to be moved / renamed to $HOME/.config/xkeysnail/config.py

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


define_keymap(lambda wm_class: wm_class in ("URxvt", "Terminator", "Terminal", "Gnome-terminal"), {
    K("C-g"): K("C-w"),
    K("C-w"): K("C-g"),
}, "terminal key-swaps")

define_keymap(lambda wm_class: wm_class in ("Firefox", "firefox"), {
    K("C-s"): K("C-f"),
}, "browser s for search-find")


define_keymap(lambda wm_class: wm_class not in ("Emacs", "URxvt", "Terminator", "Terminal", "Gnome-terminal"), {
    # multiple strokes to enter umlauts and es-zett in/for German
    K("C-M-u"): {
        K('a'): [K('C-Shift-u'), Key.KEY_0, Key.KEY_0, Key.E, Key.KEY_4, Key.ENTER],
        K('Shift-a'): [K('C-Shift-u'), Key.KEY_0, Key.KEY_0, Key.C, Key.KEY_4, Key.ENTER],
        K('o'): [K('C-Shift-u'), Key.KEY_0, Key.KEY_0, Key.F, Key.KEY_6, Key.ENTER],
        K('Shift-o'): [K('C-Shift-u'), Key.KEY_0, Key.KEY_0, Key.D, Key.KEY_6, Key.ENTER],
        K('u'): [K('C-Shift-u'), Key.KEY_0, Key.KEY_0, Key.F, Key.C, Key.ENTER],
        K('Shift-u'): [K('C-Shift-u'), Key.KEY_0, Key.KEY_0, Key.D, Key.C, Key.ENTER],
        K('s'): [K('C-Shift-u'), Key.KEY_0, Key.KEY_0, Key.D, Key.F, Key.ENTER],
    }
}, 'Umlauts')

