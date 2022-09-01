--[[

     Powerarrow Dark Awesome WM theme
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local bling = require("bling")
local current_theme = require("beautiful.xresources").get_current_theme()
local dpi = require("beautiful.xresources").apply_dpi
local net_widgets = require("net_widgets")


local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local currentWalWallpaper = ""

awful.spawn.easy_async_with_shell("cat $HOME/.cache/wal/wal", function(stdout)
	currentWalWallpaper = stdout
end)

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/standard"
theme.wallpaper																	= currentWalWallpaper
theme.font                                      = "FiraCode Nerd Font 10"
theme.fg_normal                                 = current_theme.color6
theme.fg_focus                                  = current_theme.foreground
theme.fg_urgent                                 = "#CC9393"
theme.bg_normal                                 = current_theme.background
theme.bg_focus                                  = current_theme.color0
theme.bg_urgent                                 = "#1A1A1A"
theme.border_width                              = dpi(1)
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#7F7F7F"
theme.border_marked                             = "#CC9393"
theme.tasklist_bg_focus                         = current_theme.color1
theme.tasklist_fg_normal												= current_theme.color6
theme.tasklist_fg_focus													= "#000000"
theme.tasklist_bg_normal                        = "#00000055"
theme.titlebar_bg_focus                         = current_theme.color1
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = current_theme.color1
theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(140)
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 1

theme.mstab_bar_ontop = false          -- whether you want to allow the bar to be ontop of clients
theme.mstab_dont_resize_slaves = false -- whether the tabbed stack windows should be smaller than the
                                       -- currently focused stack window (set it to true if you use
                                       -- transparent terminals. False if you use shadows on solid ones
theme.mstab_bar_padding = "default"    -- how much padding there should be between clients and your tabbar
                                       -- by default it will adjust based on your useless gaps.
                                       -- If you want a custom value. Set it to the number of pixels (int)
theme.mstab_border_radius = 0          -- border radius of the tabbar
theme.mstab_bar_height = 40            -- height of the tabbar
theme.mstab_tabbar_position = "top"    -- position of the tabbar (mstab currently does not support left,right)
theme.mstab_tabbar_style = "default"   -- style of the tabbar ("default", "boxes" or "modern")
                                       -- defaults to the tabbar_style so only change if you want a
                                       -- different style for mstab and tabbed
local markup = lain.util.markup
local separators = lain.util.separators

local keyboardlayout = awful.widget.keyboardlayout:new()

-- Textclock
local clock = awful.widget.watch(
    "date +'%a %d %b %I:%M'", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { clock },
    notification_preset = {
        font = "FiraCode Nerd Font 9",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- MEM
local memicon = wibox.widget.textbox(markup.font(theme.font, " "))
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpuicon = wibox.widget.textbox("")
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
    end
})


-- Battery
local baticon = wibox.widget.textbox("")
local bat = lain.widget.bat({
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                baticon:set_markup_silently("  ")
						elseif tonumber(bat_now.perc) <= 15 then
								baticon:set_markup_silently("")
            elseif tonumber(bat_now.perc) <= 30 then
                baticon:set_markup_silently("  ")
            elseif tonumber(bat_now.perc) <= 60 then
                baticon:set_markup_silently("")
            else
                baticon:set_markup_silently("  ")
            end
            widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
        else
            widget:set_markup(markup.font(theme.font, " AC "))
            baticon:set_markup_silently(" ")
        end
    end
})

-- ALSA volume
local volicon = wibox.widget.textbox(" ")
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volicon:set_markup_silently("婢")
        elseif tonumber(volume_now.level) == 0 then
            volicon:set_markup_silently("奄 ")
        elseif tonumber(volume_now.level) <= 50 then
            volicon:set_markup_silently("奔 ")
        else
            volicon:set_markup_silently(" ")
        end

        widget:set_markup(markup.font(theme.font, " " .. volume_now.level .. "% "))
    end
})
theme.volume.widget:buttons(awful.util.table.join(
                               awful.button({}, 4, function ()
                                     awful.util.spawn("amixer set Master 1%+")
                                     theme.volume.update()
                               end),
                               awful.button({}, 5, function ()
                                     awful.util.spawn("amixer set Master 1%-")
                                     theme.volume.update()
                               end)
))

-- Net
local net_widget = net_widgets.wireless({ interfaces = {
	"enp2s0",
	"wlo1"
}, popup_signal=true })

-- Separators
local spr = wibox.widget {
	widget = wibox.widget.separator,
	orientation = "horizontal",
	forced_width = 10,
	color= "#00000000"
}

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

		awful.tag.add("  ", {
			layout = awful.layout.suit.max,
			screen = s
		})

		awful.tag.add(" ﭮ ", {
			layout = awful.layout.suit.max,
			screen = s
		})

		awful.tag.add("  ", {
			layout = awful.layout.suit.floating,
			screen = s
		})

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
		s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(25), bg = theme.bg_normal .. "55", fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            s.mytaglist,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
						spr,
            volicon,
            theme.volume.widget,
            spr,
						spr,
						memicon,
						mem.widget,
						spr,
						spr,
						cpuicon,
						cpu.widget,
						spr,
						spr,
						baticon,
						bat.widget,
						spr,
						spr,
						net_widgets.indicator({
							interfaces = { "enp2s0", "wlo1" }
						}),
						spr,
						spr,
						clock,
						spr,
						spr,
						s.mylayoutbox
        },
    }
end

return theme
