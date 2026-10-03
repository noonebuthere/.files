hl.config({
    -- Keyboard
    input = {
        kb_layout = "de",
        kb_variant = "nodeadkeys",
        follow_mouse = 1,
        numlock_by_default = true,
        touchpad = {
    	    natural_scroll = false
        }
    },

    -- General Window Managing
    general = {
        gaps_in = 6,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = { colors = {"rgba(7c4a6bff)", "rgba(7c4a6bff)"}, angle = 45 },
            inactive_border = "rgba(3c3836ff)",
        },
        layout = "dwindle"
    },

    -- Decoration
    decoration = {
        rounding = 10,
        rounding_power = 2,   -- >2 = softer "squircle" corners instead of plain circular

        active_opacity = 1.0,
        inactive_opacity = 0.88,

        dim_inactive = true,
        dim_strength = 0.15,

        shadow = {
        	enabled = true,
            range = 6,
            render_power = 3,
            offset = {1, 2},
            color = "rgba(7c4a6b55)",
            color_inactive = "rgba(00000044)"
        },

        blur = {
        	enabled = true,
            size = 5,
            passes = 3,
            xray = false,
            special = true,
            popups = false,
            vibrancy = 0.15
        },
    },

    -- Animations
    animations = {
        enabled = true
    },
    
    -- Dwindle
    dwindle = {
        preserve_split = true
    },

    misc = {
        disable_hyprland_guiutils_check = true,
    },

    cursor = {
        no_hardware_cursors = true,
        enable_hyprcursor = false,
    },

    render = {
        direct_scanout = true,
    }
})

-- Curves
hl.curve("myBezier",     { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("easeOutExpo",  { type = "bezier", points = { {0.16, 1},   {0.3, 1} } })
hl.curve("easeInOutQuad", { type = "bezier", points = { {0.45, 0},   {0.55, 1} } })
hl.curve("linear",       { type = "bezier", points = { {0, 0},      {1, 1} } })

-- Animations
hl.animation({ leaf = "windows",          enabled = true, speed = 4,  bezier = "easeOutExpo",  style = "popin 90%" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 4,  bezier = "easeOutExpo",  style = "popin 90%" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 4,  bezier = "easeInOutQuad", style = "popin 80%" })
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 4,  bezier = "easeOutExpo" })

hl.animation({ leaf = "fade",             enabled = true, speed = 5,  bezier = "default" })
hl.animation({ leaf = "fadeIn",           enabled = true, speed = 3,  bezier = "default" })
hl.animation({ leaf = "fadeOut",          enabled = true, speed = 3,  bezier = "default" })

hl.animation({ leaf = "border",           enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "borderangle",      enabled = true, speed = 20, bezier = "linear" })

hl.animation({ leaf = "workspaces",       enabled = true, speed = 5,  bezier = "easeOutExpo",  style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5,  bezier = "easeOutExpo",  style = "slidevert" })

hl.animation({ leaf = "layers",           enabled = true, speed = 3,  bezier = "easeOutExpo",  style = "slide" })

-- Touchpad
hl.device({
    name = "synps/2-synaptics-touchpad",
    sensitivity = 0.7
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- ENV VARS --

-- Desktop Environment
hl.env("XCURSOR_THEME", "capitaine-cursors-gruvbox")
hl.env("XCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "kvantum")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-- Drivers
hl.env("NIXOS_OZONE_WL", "1")
hl.env("LIBVA_DRIVER_NAME", "iHD")

-- END ENV VARS --

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'capitaine-cursors-gruvbox'")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XCURSOR_THEME XCURSOR_SIZE")
    hl.exec_cmd("systemctl --user start hyprland-session.target")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaybg -i ~/backgrounds/lake-mountains.jpg -m fill")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("mako")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("/usr/bin/diodon")
    hl.exec_cmd("/usr/libexec/lxqt-policykit-agent")
    hl.exec_cmd("input-remapper-control --command set-config-dir --config-dir ~/.config/input-remapper-2")
    hl.exec_cmd("sudo tuned-adm profile throughput-performance")
    hl.exec_cmd("~/.config/sway/scripts/battery_alert.sh")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Gruvbox-B-LB-Dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Capitaine Cursors (Gruvbox)'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 24")
    hl.exec_cmd("qpwgraph -m")
end)

-- KEYBINDS --

local mainMod = "SUPER"

-- Core Applications
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("MOZ_ENABLE_WAYLAND=1 firefox --new-window"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("alacritty -e temp"))

-- Clipboard Manager
hl.bind("CTRL + ALT + SHIFT + V", hl.dsp.exec_cmd([[cliphist list | rofi -dmenu -p "Clipboard" | cliphist decode | wl-copy]]))

-- System Monitor (btop popup)
hl.bind("CTRL + ESCAPE", hl.dsp.exec_cmd("alacritty --class btop -e btop"))

-- Media & Hardware Keys
-- bindel = locked + repeating, bindl = locked
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer --allow-boost --set-limit 200 -i 5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer --allow-boost --set-limit 200 -d 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer --toggle-mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pamixer --default-source --toggle-mute"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5% -e"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%- -e"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })

-- Session Control
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + CTRL + K", hl.dsp.window.close())

-- Window Operations
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + V", hl.dsp.layout("togglesplit")) -- Alternate to sway vertical split

-- Focus movement (Arrow keys)
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move focused window (Shift + Arrow keys)
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- Workspaces 1-10 (key 0 maps to workspace 10)
for i = 1, 10 do
    local key = i % 10
    -- Switch to workspace
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
    -- Move window to workspace
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i) }))
end

-- Submap / Mode: Resize (Super + R to enter, Escape/Enter to leave)
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    -- binde = repeating
    hl.bind("right", hl.dsp.window.resize({ x = 10,  y = 0 }),   { repeating = true })
    hl.bind("left",  hl.dsp.window.resize({ x = -10, y = 0 }),   { repeating = true })
    hl.bind("up",    hl.dsp.window.resize({ x = 0,   y = -10 }), { repeating = true })
    hl.bind("down",  hl.dsp.window.resize({ x = 0,   y = 10 }),  { repeating = true })
    hl.bind("l",     hl.dsp.window.resize({ x = 10,  y = 0 }),   { repeating = true })
    hl.bind("j",     hl.dsp.window.resize({ x = -10, y = 0 }),   { repeating = true })
    hl.bind("k",     hl.dsp.window.resize({ x = 0,   y = -10 }), { repeating = true })
    hl.bind("o",     hl.dsp.window.resize({ x = 0,   y = 10 }),  { repeating = true })
 
    -- Leave the submap
    hl.bind("escape", hl.dsp.submap("default"))
    hl.bind("return", hl.dsp.submap("default"))
    hl.bind(mainMod .. " + R", hl.dsp.submap("default"))
end)
 
-- Mouse Window Control (Drag & Resize)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
 
-- Switch Lid Lock
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("swaylock -f"), { locked = true })

-- END OF KEYBINDS --

-- RULES --

-- Variables
local terminal = "alacritty"

-- Monitors
dofile(os.getenv("HOME") .. "/.config/hypr/monitors.lua")

-- btop terminal popup styling
hl.window_rule({
    name = "btop-popup",
    match = { class = "^(btop)$" },
    float = true,
    size = "1200 750",
    center = true,
})

-- Audio control
hl.window_rule({
    name = "pavucontrol-float",
    match = { class = "^(pavucontrol)$" },
    float = true,
})

-- Thunar Rename dialog
hl.window_rule({
    name = "thunar-rename",
    match = { class = "^(thunar)$", title = "^(Rename .+)$" },
    float = true,
})

-- Steam Toast Notifications
hl.window_rule({
    name = "steam-toasts",
    match = { class = "^(Steam)$", title = "^(notificationtoasts_)$" },
    float = true,
    no_focus = true,
})

-- Godot Editor
hl.window_rule({
    name = "godot-float",
    match = { class = "^(Godot)$" },
    float = true,
})

-- Float and center LXQt Polkit Agent
hl.window_rule({
    name = "lxqt-polkit",
    match = { initial_class = "^(lxqt-policykit-agent)$" },
    float = true,
    center = true,
})

-- Generic Dialogs & Popups
hl.window_rule({
    name = "dialog-open-file",
    match = { title = "^(Open File)$" },
    float = true,
    center = true,
})
hl.window_rule({
    name = "dialog-save-as",
    match = { title = "^(Save As)$" },
    float = true,
    center = true,
})
hl.window_rule({
    name = "dialog-select-file",
    match = { title = "^(Select a File)$" },
    float = true,
    center = true,
})

-- Cava widget (bottom-right corner of workspace 3)
hl.window_rule({
    name = "cava-widget",
    match = { class = "^(cava)$" },
    float = true,
    size = "400 200",
    move = "monitor_w-410 monitor_h-210",
    workspace = "3",
    no_focus = true,
})

-- Miniquad apps
hl.window_rule({
    name = "miniquad-float",
    match = { class = "^(miniquad-application)$" },
    float = true,
    center = true,
})

-- Tk windows
hl.window_rule({
    name = "tk-float-pin",
    match = { class = "^(Tk)$" },
    float = true,
    pin = true,
})

-- Deadlock
hl.window_rule({
    name = "deadlock-immediate",
    immediate = true,
    pin = true,
    match = { class = "^(steam_app_1422450)$" },
})

-- Layer rules
-- Blur rules for Waybar background
hl.layer_rule({
    name = "waybar-blur",
    match = { namespace = "waybar" },
    blur = true,
    ignore_alpha = 1,
})

hl.layer_rule({
    name = "notifications-blur",
    match = { namespace = "notifications" },
    blur = true,
})

hl.layer_rule({
    name = "selection-no-anim",
    match = { namespace = "selection" },
    animation = "none",
})
-- END OF RULES --
