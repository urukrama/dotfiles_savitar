-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
--expose type behavior
require("revelation")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

-- Load Debian menu entries
require("debian.menu")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/Children of the Earth/theme.lua")
--beautiful.init("/home/urukrama/.config/awesome/themes/Children of the Earth/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = "gedit"
--os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.max,			-- 1
    awful.layout.suit.floating,		-- 2
    awful.layout.suit.tile,			-- 3 
    awful.layout.suit.tile.bottom,	-- 4
  --  awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,		-- 5
    awful.layout.suit.fair			-- 6
}
-- }}}

 -- {{{ Tags
 -- Define a tag table which will hold all screen tags.
 tags = {
   names  = { "text", "www", "image", "term", "tmp"},
   layout = { layouts[1], layouts[1], layouts[2], layouts[5], layouts[5]
 }}
 for s = 1, screen.count() do
     -- Each screen has its own tag table.
     tags[s] = awful.tag(tags.names, s, tags.layout)
 end
 -- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

myappmenu = {
	{ "Music", terminal .. "-e mocp" },
	{"Gimp", "gimp" }
}

mymainmenu = awful.menu({ items = {
		{ "Terminal", terminal },
		{ "Opera", "opera" },
		{"Thunar", "thunar" },
		{"Gedit", "gedit"},
		{ "Debian", debian.menu.Debian_menu.Debian },
		{"Applications", myappmenu },
		{ "awesome", myawesomemenu }
                                 }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                  menu = mymainmenu })
-- }}}

-- {{{ Wibox

-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" }, "  %H:%M  " )
mytextclock:buttons(awful.util.table.join(
	awful.button({ }, 1, function () awful.util.spawn("orage") end), -- left click to launch orage
	awful.button({ }, 3, function () awful.util.spawn("timer") end), -- right click to launch timer
	--awful.button({ }, 1, function () awful.util.spawn("/home/urukrama/.config/awesome/awesome-calendar.sh") end)   
mytextclock:add_signal("mouse::enter", function() naughty.notify ({ text = os.date ("%A, %d %B %Y"), timeout = 4 } ) end) -- mouse over date
 ))

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                           return awful.widget.tasklist.label.currenttags(c, s)
                                           end, mytasklist.buttons)

    -- Create the wibox
--    mywibox[s] = awful.wibox({ position = "top", screen = s })
    mywibox[s] = awful.wibox({ position = "top", height = "16", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey, "Control" }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey, "Control" }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

-- cycle through clients with Alt-Tab and Alt-Shift-Tab
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey, "Shift" }, "Tab",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

-- expose-type behavior
    awful.key({ modkey }, "e",  revelation.revelation),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx( 1)
    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),

-- Run or raise applications with dmenu
awful.key({ modkey }, "p",
function ()
    local f_reader = io.popen( "dmenu_path | dmenu -nb '".. beautiful.bg_normal .."' -nf '".. beautiful.fg_normal .."' -sb '" .. beautiful.bg_focus .."' -sf '" .. beautiful.fg_focus .. "' -fn '-*-nu-*-*-*-*-*-*-*-*-*-*-*-*'  ")
    local command = assert(f_reader:read('*a'))
    f_reader:close()
    if command == "" then return end

    -- Check the clients if the class match the command
    local lower_command=string.lower(command)
    for k, c in pairs(client.get()) do
        local class=string.lower(c.class)
        if string.match(class, lower_command) then
            for i, v in ipairs(c:tags()) do
                awful.tag.viewonly(v)
                c:raise()
                c.minimized = false
                return
            end
        end
    end
    awful.util.spawn(command)
end),
--launch menu
	awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),
	awful.key({modkey, "Control" }, "d", function() naughty.notify ({ text = os.date ("%A, %d %B %Y"), timeout = 4 }) end),

--application launchers
    awful.key({ modkey,           }, "F2", function () awful.util.spawn("gmrun") end),
    awful.key({ modkey,           }, "F3", function () awful.util.spawn("urxvt") end),
    awful.key({ modkey,  "Shift" }, "F3", function () awful.util.spawn("urxvt -e su") end),
    awful.key({ modkey,           }, "F4", function () awful.util.spawn("thunar") end),
    awful.key({ modkey,           }, "F8", function () awful.util.spawn("opera") end),
    awful.key({ modkey,           }, "F9", function () awful.util.spawn("stardict") end),
    awful.key({ modkey,           }, "F10", function () awful.util.spawn("gedit") end),
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),

-- Music player controls
    awful.key({ modkey, "Control" }, "space", function () awful.util.spawn("mocp -G") end),
    awful.key({ modkey, "Control" }, "Next", function () awful.util.spawn("mocp -f") end),
    awful.key({ modkey, "Control" }, "Prior", function () awful.util.spawn("mocp -r") end),
-- Volume control
    awful.key({ "Control" }, "Down", function () awful.util.spawn("amixer -q set PCM 1- unmute") end),
    awful.key({ "Control" }, "Up", function () awful.util.spawn("amixer -q set PCM 1+ unmute") end),
    awful.key({ modkey, "Control" }, "End", function () awful.util.spawn("amixer -q set PCM toggle") end),

-- resize etc.
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

-- Awesome control
	awful.key({ modkey, "Control" }, "r", awesome.restart),
	awful.key({ modkey, "Shift"   }, "q", awesome.quit),

-- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),
	--Dictionary
    awful.key({ modkey}, "d", function ()
	awful.prompt.run({ prompt = "Dictionary: " }, 
	mypromptbox[mouse.screen].widget,
        function(word)
                local f = io.popen("sdcv -u stardict-mw-Sanskrit-English-2.4.2 -n" .. word)
                local fr = ""
                for line in f:lines() do
                fr = fr .. line .. '\n  '
                end
                f:close()
                naughty.notify({ text = fr, width = 400 })
        end,
        nil, awful.util.getdir("cache") .. "/dict") 
end),

	--Lua code
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Shift" }, "f",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- load the 'run or raise' function
--require("aweror")
-- generate and add the 'run or raise' key bindings to the globalkeys table
--globalkeys = awful.util.table.join(globalkeys, aweror.genkeys(modkey))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
		border_color = beautiful.border_normal,
		focus = true,
		keys = clientkeys,
		maximized_vertical   = false,
		maximized_horizontal = false,
		buttons = clientbuttons } },
	{ rule = { class = "MPlayer" }, properties = { floating = true } },
	{ rule = { class = "Gmessage" }, properties = { floating = true } },
	{ rule = { class = "Gimp" }, properties = { floating = true }, callback = awful.titlebar.add, properties = { tag = tags[1][3] }  },
        { rule = { class = "Icedove" }, properties = { tag = tags[1][2] } },
        { rule = { class = "Opera" }, properties = { tag = tags[1][2] } },
    	{ rule = { class = "Gedit" }, properties = { tag = tags[1][1] }, master = true },
    	{ rule = { class = "Stardict" }, properties = { tag = tags[1][1] } },
	{ rule = { class = "LibreOffice" }, properties = { tag = tags[1][3] }, floating = false },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

-- add a titlebar
if awful.client.floating.get(c) then
	awful.titlebar.add(c, {modkey = modkey, height="16" })
end
  
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
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

---function run_once(prg)
  --awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg .. " || (" .. prg .. ")")
--end

--awful.util.spawn_with_shell("wicd-gtk")
--awful.util.spawn_with_shell("urxvtd -q -o -f")
--awful.util.spawn_with_shell("unclutter -idle 5")
