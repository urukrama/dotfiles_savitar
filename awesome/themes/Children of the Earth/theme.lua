-------------------------------
--  "Children of the Earth" awesome theme  --
--    by urukrama (February 2011)   --
-------------------------------

-- {{{ Main
theme = {}
theme.wallpaper_cmd = { "awsetbg '/usr/share/awesome/themes/Children of the Earth/Monk.jpg'" }
-- }}}

-- {{{ Styles
theme.font      = "nu 8"

-- {{{ Colors
theme.fg_normal = "#39331B"
theme.fg_focus  = "#b5aa74"
theme.fg_urgent = "#CC9393"
theme.bg_normal = "#FCFCFC"
theme.bg_focus  = "#39331B"
theme.bg_urgent = "#381a2f"
-- }}}

-- {{{ Borders
theme.border_width  = "2"
theme.border_normal = "#FCFCFC"
theme.border_focus  = "#39331B"
theme.border_marked = "#1a3823"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#39331B"
theme.titlebar_bg_normal = "#FCFCFC"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#FCFCFC"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = "15"
theme.menu_width  = "100"
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = "/usr/share/awesome/themes/Children of the Earth/taglist/squarefz.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/Children of the Earth/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = "/usr/share/awesome/themes/Children of the Earth/awesome-icon.png"
theme.menu_submenu_icon      = "/usr/share/awesome/themes/Children of the Earth/submenu.png"
theme.tasklist_floating_icon = "/usr/share/awesome/themes/Children of the Earth/tasklist/floating.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = "/usr/share/awesome/themes/Children of the Earth/layouts/tile.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/Children of the Earth/layouts/tileleft.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/Children of the Earth/layouts/tilebottom.png"
theme.layout_tiletop    = "/usr/share/awesome/themes/Children of the Earth/layouts/tiletop.png"
theme.layout_fairv      = "/usr/share/awesome/themes/Children of the Earth/layouts/fairv.png"
theme.layout_fairh      = "/usr/share/awesome/themes/Children of the Earth/layouts/fairh.png"
theme.layout_spiral     = "/usr/share/awesome/themes/Children of the Earth/layouts/spiral.png"
theme.layout_dwindle    = "/usr/share/awesome/themes/Children of the Earth/layouts/dwindle.png"
theme.layout_max        = "/usr/share/awesome/themes/Children of the Earth/layouts/max.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/Children of the Earth/layouts/fullscreen.png"
theme.layout_magnifier  = "/usr/share/awesome/themes/Children of the Earth/layouts/magnifier.png"
theme.layout_floating   = "/usr/share/awesome/themes/Children of the Earth/layouts/floating.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/Children of the Earth/titlebar/close_focus.png"
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/Children of the Earth/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/Children of the Earth/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/Children of the Earth/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/Children of the Earth/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/Children of the Earth/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/Children of the Earth/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/Children of the Earth/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/Children of the Earth/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/Children of the Earth/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/Children of the Earth/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/Children of the Earth/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/Children of the Earth/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/Children of the Earth/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/Children of the Earth/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/Children of the Earth/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/Children of the Earth/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/Children of the Earth/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme
