-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
local vicious = require("vicious")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
--Third party plugins
-- local lain = require("lain")
local minitray = require("minitray")

-- Start apps
awful.util.spawn_with_shell("start-pulseaudio-x11")
awful.util.spawn_with_shell("setxkbmap es")
awful.util.spawn_with_shell("xrandr --output LVDS --mode 1366x768 --primary")
awful.util.spawn_with_shell("/usr/lib/kde4/libexec/polkit-kde-authentication-agent-1")
awful.util.spawn_with_shell("compton -m 0.9 -f -D 5 -c")
awful.util.spawn_with_shell("indicator-kdeconnect")
awful.util.spawn_with_shell("octopi-notifier")
-- awful.util.spawn_with_shell("nm-applet")
awful.util.spawn_with_shell("dropboxd")
awful.util.spawn_with_shell("megasync")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/ander/.config/awesome/themes/ander-zenburn/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
-- editor = os.getenv("EDITOR") or "nano"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    -- tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
    tags[s] = awful.tag({ "1  ", "2  ","3  ", "4  ", "5  ", "6  ", "7  ", "8  ", "9 " }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

configmenu = {
    { "bash", editor_cmd .. " " .. "/home/ander/.bashrc" },
    { "zsh", editor_cmd .. " " .. "/home/ander/.zshrc" },
    { "fish", editor_cmd .. " " .. "/home/ander/.config/fish/config.fish" },
    { "vim", editor_cmd .. " " .. "/home/ander/.vimrc" },
    -- { "compton", editor_cmd .. " " .. "/home/ander/.config/compton/compton.conf" },
    { "mirrors", editor_cmd .. " " .. "/etc/pacman.d/mirrorlist" },
    { "pacman", editor_cmd .. " " .. "/etc/pacman.conf" }
}

screenmenu= {
    { "LVDS: 1366x768", "xrandr --output LVDS --mode 1366x768"},
    { "DPMS on", "xset +dpms"},
    { "DPMS off", "xset -dpms"},
    { "VGA-0: monitor left", "xrandr --output VGA-0 --mode 1440x900 --left-of LVDS" },
    { "VGA-0: unplug", "xrandr --output VGA-0 --off" }
}

keyboardmenu= {
    { "es (qwerty)", "setxkbmap es"},
    { "es (dvorak)", "setxkbmap es -variant dvorak" }
}

settingsmenu = {
    { "monitors", screenmenu },
    { "keyboard", keyboardmenu }
}

sysmenu= {
    { "reboot", "systemctl reboot"},
    { "poweroff", "systemctl poweroff" }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon_default },
                                    -- { "sistema", sysmenu },
                                    { "configs", configmenu },
                                    { "settings", settingsmenu },
                                    { "system", sysmenu },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock(" %a %d %b, %H:%M:%S ", 1)

-- Create a wibox for each screen and add it
mywibox = {}
mywibox2 = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 5, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 4, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Custom widgets {{{
    vicious.cache(vicious.widgets.cpu, vicious.widgets.mem, vicious.widgets.net, 
                    vicious.widgets.fs, vicious.widgets.volume, vicious.widgets.bat, vicious.widgets.os, vicious.widgets.pkg)

    -- NET
    mynet = wibox.widget.textbox()
    vicious.register(mynet, vicious.widgets.net, "<span font-family='FontAwesome' color='#FF99cc'>   ${wlp5s0 up_kb}  ${wlp5s0 down_kb}  </span>")

    -- CPU
    mycpu = wibox.widget.textbox()
    mycpu:set_markup("<span font-family='FontAwesome' color='#99ff99'>    </span>")
    -- PRUEBAS
    cpuwidget = awful.widget.progressbar()
    cpuwidget:set_width(55)
    cpuwidget:set_background_color(beautiful.bar_bg)
    cpuwidget:set_color(beautiful.cpu_fg)
    vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 13)
    cpumargin = wibox.layout.margin(cpuwidget, 2, 7)
    cpumargin:set_top(5)
    cpumargin:set_bottom(5)
    cpuwidget = wibox.widget.background(cpumargin)
    cpuwidget:set_bg(beautiful.titlebar_bg_normal) 

    -- RAM
    mymem = wibox.widget.textbox()
    mymem:set_markup("<span font-family='FontAwesome' color='#ffff99'>   </span>")
    -- PRUEBAS
    memwidget = awful.widget.progressbar()
    memwidget:set_width(55)
    memwidget:set_background_color(beautiful.bar_bg)
    memwidget:set_color(beautiful.mem_fg)
    vicious.register(memwidget, vicious.widgets.mem, "$1", 13)
    memmargin = wibox.layout.margin(memwidget, 2, 7)
    memmargin:set_top(5)
    memmargin:set_bottom(5)
    memwidget = wibox.widget.background(memmargin)
    memwidget:set_bg(beautiful.titlebar_bg_normal) 
    -- PKG updates
    mypkg = wibox.widget.textbox()
    vicious.register(mypkg, vicious.widgets.pkg, "<span font-family='FontAwesome' color='#ffff99'>  $1  </span>", 60 ,"Arch")

    -- File System
    myfs = wibox.widget.textbox()
    vicious.register(myfs, vicious.widgets.fs, "<span font-family='FontAwesome' color='#99ccff'>  ${/ used_gb}/${/ size_gb} GB  </span>")

    -- Brightness
    mybrightness = wibox.widget.textbox()
    mybrightness:set_markup("<span font-family='FontAwesome'>    </span>" )
    mybrightness:buttons(awful.util.table.join(
        -- Bright control
        awful.button({  }, 5, function ()
            awful.util.spawn("light -U 5", false) end),
        awful.button({  }, 4, function ()
            awful.util.spawn("light -A 5", false) end)
    ))

    -- Volume
    myvolume = wibox.widget.textbox()
    vicious.register(myvolume, vicious.widgets.volume, "<span font-family='FontAwesome' color='#FF9966'>  $1 $2  </span>", 3, "Master")
    myvolume:buttons(awful.util.table.join(
        -- Sound control
        awful.button({ }, 4, function ()
            awful.util.spawn("amixer set Master 7%+", false) end),
        awful.button({ }, 5, function ()
            awful.util.spawn("amixer set Master 7%-", false) end),
        awful.button({ }, 1, function ()
           awful.util.spawn("amixer set Master toggle", false) end)
    ))

    -- Sys menu
    mysysmenu = wibox.widget.textbox()
    mysysmenu:set_markup("<span font-family='FontAwesome' color='#99ccff'><b>  </b></span>")
    mysysmenu:buttons(awful.util.table.join(
        -- showmenu
        awful.button({ }, 1, function ()
                mymainmenu:show() end)
    ))
    
    -- Sys info
    mysys = wibox.widget.textbox()
    vicious.register(mysys, vicious.widgets.os, "<span font-family='FontAwesome' color='#66ccff'>  $1 $2   </span>")

    mybat = wibox.widget.textbox()
    vicious.register(mybat, vicious.widgets.bat, "<span font-family='FontAwesome' color='#99FFCC'> $1 $2% ($3)  </span>", 60, "BAT1")

    -- }}} custom widgets

    -- Create the wibox 1 {{{
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(mynet)
    right_layout:add(mycpu)
    right_layout:add(cpuwidget)
    right_layout:add(mymem)
    right_layout:add(memwidget)
    right_layout:add(myfs)
    right_layout:add(mybrightness)
    right_layout:add(myvolume)
    right_layout:add(mybat)
    right_layout:add(mytextclock)
    right_layout:add(mysysmenu)

    -- Widgets that are aligned to the right
    local middle_layout = wibox.layout.fixed.horizontal()
    middle_layout:add(mysys)
    middle_layout:add(mypkg)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(middle_layout)
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
    --- }}}

    -- Create the wibox 2 {{{
    mywibox2[s] = awful.wibox({ position = "bottom", screen = s })

    -- Widgets that are aligned to the left
    local left_layout2 = wibox.layout.fixed.horizontal()
    -- if s == 1 then left_layout2:add(wibox.widget.systray()) end

    -- Widgets that are aligned to the right
    local right_layout2 = wibox.layout.fixed.horizontal()
    right_layout2:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout2 = wibox.layout.align.horizontal()
    layout2:set_left(left_layout2)
    layout2:set_middle(mytasklist[s])
    layout2:set_right(right_layout2)

    mywibox2[s]:set_widget(layout2)
    --- }}}
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 5, awful.tag.viewnext),
    awful.button({ }, 4, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(

    -- Change laouts
    awful.key({ modkey }, "q", function () awful.layout.set(awful.layout.suit.tile) end),

    -- Xlock
    awful.key({ modkey }, "F12", function () awful.util.spawn("xlock -mode pacman") end),

    -- Toggle minitray | Dependencies: minitray.lua
    awful.key({ modkey }, "z", function() minitray.toggle() end ),
    -- Audio
    awful.key({ }, "XF86AudioRaiseVolume", function ()
       awful.util.spawn("amixer set Master 7%+", false) end),
    awful.key({ }, "XF86AudioLowerVolume", function ()
       awful.util.spawn("amixer set Master 7%-", false) end),
    awful.key({ }, "XF86AudioMute", function ()
       awful.util.spawn("amixer set Master toggle", false) end),

    -- Capturar pantalla
    awful.key({ }, "Print", function ()
       awful.util.spawn("shutter -f", false) end),
    awful.key({"Shift" }, "Print", function ()
       awful.util.spawn("shutter -s", false) end),

    -- Brightness | dependencies: light-git
    awful.key({ }, "XF86MonBrightnessDown", function ()
    awful.util.spawn("light -U 5", false) end),
    awful.key({ }, "XF86MonBrightnessUp", function ()
    awful.util.spawn("light -A 5", false) end),

    -- Hide bar
    awful.key({ modkey }, "b", function ()
         mywibox2[mouse.screen].visible = not mywibox2[mouse.screen].visible
     end),

    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey, "Control" }, "j",   awful.tag.viewprev       ),
    awful.key({ modkey, "Control" }, "ntilde",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    -- Show clients menu
    awful.key({ modkey,           }, "a",
        function ()
            instance = awful.menu.clients({ theme = { width = 250 } })
        end),

    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "l",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "l", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "l", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey, "Shift", "Control"   }, "k", function () awful.client.incwfact( 0.05) end),
    awful.key({ modkey, "Shift", "Control"   }, "l", function () awful.client.incwfact(-0.05) end),
    awful.key({ modkey,           }, "ntilde",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "j",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "j",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "ntilde",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "j",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "ntilde",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey, }, "+", function(c)
        c.opacity = c.opacity + 0.1
    end),
    awful.key({ modkey, }, "-", function(c)
        c.opacity = c.opacity - 0.1
    end),
    awful.key({ modkey, "Shift" }, "t", awful.titlebar.toggle),
    awful.key({ modkey, "Control", "Shift" }, "Down",  function () awful.client.moveresize( 0,  0, 0, 40) end),
    awful.key({ modkey, "Control", "Shift" }, "Up",  function () awful.client.moveresize( 0,  0, 0, -40) end),
    awful.key({ modkey, "Control", "Shift" }, "Left", function () awful.client.moveresize(0, 0,  -40,  0) end),
    awful.key({ modkey, "Control", "Shift" }, "Right", function () awful.client.moveresize(0, 0,  40,  0) end),
    awful.key({ modkey, "Control" }, "Down",  function () awful.client.moveresize(  0,  20,   0,   0) end),
    awful.key({ modkey, "Control" }, "Up",    function () awful.client.moveresize(  0, -20,   0,   0) end),
    awful.key({ modkey, "Control" }, "Left",  function () awful.client.moveresize(-20,   0,   0,   0) end),
    awful.key({ modkey, "Control" }, "Right", function () awful.client.moveresize( 20,   0,   0,   0) end),
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end),
    awful.key({ modkey, "Shift"   }, "Left",
       function (c)
          local curidx = awful.tag.getidx()
          if curidx == 1 then
              awful.client.movetotag(tags[client.focus.screen][#tags[client.focus.screen]])
          else
              awful.client.movetotag(tags[client.focus.screen][curidx - 1])
          end
          awful.tag.viewidx(-1)
      end),
    awful.key({ modkey, "Shift"   }, "Right",
      function (c)
          local curidx = awful.tag.getidx()
          if curidx == #tags[client.focus.screen] then
              awful.client.movetotag(tags[client.focus.screen][1])
          else
              awful.client.movetotag(tags[client.focus.screen][curidx + 1])
          end
          awful.tag.viewidx(1)
      end),
     awful.key({ modkey, "Shift"   }, ",",
       function (c)
           local curidx = awful.tag.getidx()
           if curidx == 1 then
               awful.client.movetotag(tags[client.focus.screen][9])
           else
               awful.client.movetotag(tags[client.focus.screen][curidx - 1])
           end
       end),
     awful.key({ modkey, "Shift"   }, ".",
       function (c)
           local curidx = awful.tag.getidx()
           if curidx == 9 then
               awful.client.movetotag(tags[client.focus.screen][1])
           else
               awful.client.movetotag(tags[client.focus.screen][curidx + 1])
           end
       end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
-- client.connect_signal("focus", function(c) 
--     c.border_color = beautiful.border_focus 
--     c.opacity = 1
-- end)
-- client.connect_signal("unfocus", function(c)
--     c.border_color = beautiful.border_normal 
--     c.opacity = 0.7
-- end)
    awful.button({ modkey, }, 4, function(c)
        c.opacity = c.opacity + 0.1
    end),
    awful.button({ modkey, }, 5, function(c)
        c.opacity = c.opacity - 0.1
        if (c.opacity == 0.0) then
            c.opacity = 0.1
        end
    end),
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize),
    awful.button({ modkey }, 2, function (c) c:kill() end)
    )

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     maximized_vertical   = false,
                     maximized_horizontal = false,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) 
    c.border_color = beautiful.border_focus 
    -- c.opacity = 1
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal 
    -- c.opacity = 0.7
end)
-- }}}
