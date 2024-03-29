# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
import subprocess
import os

from libqtile import bar, layout, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile import extension

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration, BorderDecoration

mod = "mod4"
terminal = 'alacritty'

keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "control"], "p", lazy.layout.grow()),
    Key([mod, "control"], "n", lazy.layout.shrink()),

    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),

    Key([mod], "t", lazy.spawn(terminal), desc="Launch terminal"),

    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    Key([mod], "r", lazy.run_extension(extension.DmenuRun(
            dmenu_prompt="> ",
            background="#262626",
            foreground="#d8dee9",
            fontsize=12,
        )
        ), desc="Launch dmenu"),
    Key([mod], "s", lazy.spawn('flameshot gui'), desc="Take a screenshot"),

    Key([mod], 'f', lazy.window.toggle_floating(), desc='Toggle floating'),

    Key([mod], "w", lazy.to_screen(1)),
    Key([mod], "e", lazy.to_screen(0)),

    # Volume (hold shift for lighter adjustments)

    # Comment/Uncomment depending on what works on your keyboard

    # Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 5")),
    # Key(['shift'], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 1")),
    # Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 5")),
    # Key(['shift'], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 1")),
    # Key([], "XF86AudioMute", lazy.spawn("pamixer -t")),

    Key([], "F11", lazy.spawn("pamixer -d 5")),
    Key(['shift'], "F11", lazy.spawn("pamixer -d 1")),
    Key([], "F12", lazy.spawn("pamixer -i 5")),
    Key(['shift'], "F12", lazy.spawn("pamixer -i 1")),
    Key([], "F10", lazy.spawn("pamixer -t")),

    Key([], "XF86MonBrightnessDown", lazy.spawn("light -U 5")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("light -A 5")),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Columns(border_focus_stack=["#4c7dc7", "#347deb"], border_width=3, margin=4,
                   border_focus='#22b0e3', border_normal='#061e42'),

    layout.MonadTall(border_focus_stack=["#4c7dc7", "#347deb"], border_width=3, margin=4,
                     border_focus='#22b0e3', border_normal='#061e42'),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

extension_defaults = dict(
    font="roboto bold",
    fontsize=14,
    padding=5,
    background='#262626',
    foreground='#d8dee9',
)

font = 'roboto bold'

colors = [["#282c34", "#282c34"],
          ["#1c1f24", "#1c1f24"],
          ["#dfdfdf", "#dfdfdf"],
          ["#f5e0dc", "#f5e0dc"],
          ["#81c19b", "#81c19b"],
          ["#df5b61", "#df5b61"],
          ["#6791c9", "#6791c9"],
          ["#f5c2e7", "#f5c2e7"],
          ["#89dceb", "#89dceb"],
          ["#a9a1e1", "#a9a1e1"]]

widget_defaults = dict(
    font="roboto bold",
    fontsize=14,
    padding=10,
    background=colors[0],
    foreground=colors[2],
)

tri_left = '◀' 
tri_right = '▶'
tri_left = ''


def border(color):
    return {
        'decorations': [
            BorderDecoration(
                border_width=[0, 0, 2, 0],
                colour=color)
        ]
    }


keyboard_layout = widget.KeyboardLayout(
                                        configured_keyboards=['us', 'cz'],
                                        # background=colors[7],
                                        foreground=colors[7],
                                        font='Inconsolata Bold',
                                        fontsize=17,
                                        **border(colors[7]))

keys.append(Key([mod], "m", lazy.widget['keyboardlayout'].next_keyboard()))

screens = [
    Screen(
        # wallpaper='~/Downloads/alena-aenami-wings-hd.jpg',
        wallpaper='~/Downloads/rose_pine_shape.png',
        wallpaper_mode='fill',
        bottom=bar.Bar(
            [
                widget.CurrentLayoutIcon(
                    background=colors[0],
                    foreground=colors[2]),

                widget.GroupBox(background=colors[0], padding=7),

                widget.WindowName(font='roboto',
                                  foreground=colors[2],
                                  fontsize=15,
                                  background=colors[0],
                                  for_current_screen=True,
                                  format='{state} {name}',
                                  ),

                widget.Systray(**border(colors[4])),

                # widget.Battery(
                #     format='{percent:2.0%}',
                #     background=colors[3],
                #     foreground=colors[1],
                #     **powerline),

                # widget.UPowerWidget(
                #     background=colors[3],
                #     foreground=colors[1],
                #     border_colour=colors[0],
                #     border_charge_colour=colors[0],
                #     border_critical_colour=colors[0],
                #     fill_charge=colors[4],
                #     fill_low=colors[0],
                #     fill_critical=colors[0],
                #     fill_normal=colors[0],
                #     text_display_time=3,
                #     text_charging='{ttf} until fully charged',
                #     text_discharging='{tte} until empty',
                #     **powerline,
                #     ),

                widget.PulseVolume(
                    update_interval=0.1,
                    foreground=colors[6],
                    **border(colors[6])
                    ),

                keyboard_layout,

                widget.Clock(format="%a %d.%m.%Y",
                             font=font,
                             foreground=colors[8],
                             **border(colors[8])),

                widget.Clock(format="%H:%M",
                             font=font,
                             foreground=colors[9],
                             **border(colors[9])),
            ],
            24,
        ),

    ),

    Screen(
        # wallpaper='~/Downloads/alena-aenami-wings-hd.jpg',
        # wallpaper='~/Downloads/rose_pine_maze.png',
        # wallpaper='~/Downloads/rose_pine_noiseline.png',
        wallpaper='~/Downloads/rose_pine_shape.png',
        wallpaper_mode='fill',
    )
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
    border_width=0
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True


# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

wmname = "LG3D"


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])
