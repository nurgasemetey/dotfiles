--[[
Ring Meters by londonali1010 (2009)

This script draws percentage meters as rings. It is fully customisable; all options are described in the script.

IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring straight away. The if statement on line 145 uses a delay to make sure that this doesn't happen. It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s is long enough, so if you update Conky every 1s, use update_num > 5 in that if statement (the default). If you only update Conky every 2s, you should change it to update_num > 3; conversely if you update Conky every 0.5s, you should use update_num > 10. ALSO, if you change your Conky, is it best to use "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.

To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
    lua_load ~/scripts/rings-v1.2.1.lua
    lua_draw_hook_pre ring_stats

Changelog:
+ v1.2.1 -- Fixed minor bug that caused script to crash if conky_parse() returns a nil value (20.10.2009)
+ v1.2 -- Added option for the ending angle of the rings (07.10.2009)
+ v1.1 -- Added options for the starting angle of the rings, and added the "max" variable, to allow for variables that output a numerical value rather than a percentage (29.09.2009)
+ v1.0 -- Original release (28.09.2009)
]] -- ===================================================================================================================================================================================
settings_table = {
    {
        name = 'wireless_link_qual_perc',
        arg = 'wlx0015af414869',
        max = 200,
        bg_colour = 0xffffff,
        bg_alpha = 1,
        fg_colour = 0x558888,
        fg_alpha = 1,
        x = 120,
        y = 900,
        radius = 75,
        thickness = 10,
        start_angle = 0,
        end_angle = 360
    },
}

ring_color_table = {}
ring_color_table[0] = 0x7CFC00 
ring_color_table[1] = 0xFFB6C1 
ring_color_table[2] = 0xA52A2A
ring_color_table[3] = 0x00FFFF
ring_color_table[4] = 0x1E90FF
ring_color_table[5] = 0xFFFF00
-- ===============================================================================================================
----------------
require 'cairo'
----------------
function rgb_to_r_g_b(colour, alpha)
    return ((colour / 0x10000) % 0x100) / 255.,
           ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr, t, pt)
    -- print("dynamic")
    local w, h = conky_window.width, conky_window.height
    local xc, yc, ring_r, ring_w, sa, ea = pt['x'], pt['y'], pt['radius'],
                                           pt['thickness'], pt['start_angle'],
                                           pt['end_angle']
    local bgc, bga, fgc, fga = pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'],
                               pt['fg_alpha']
    local angle_0 = sa * (2 * math.pi / 360) - math.pi / 2
    local angle_f = ea * (2 * math.pi / 360) - math.pi / 2
    local t_arc = t * (angle_f - angle_0)
    -- print(ring_w)
    -- *1 is used to convert str to number
    secs = (os.date("%S")*1)
    remainder = (os.date("%S")*1)%10
    -- print(secs)
    -- print( math.floor(secs/10))
    bgc=ring_color_table[math.floor(secs/10)]
    -- print(secs)
    -- secs_num = secs*2
    -- print(secs%10)
    if (remainder >= 0 and remainder<=4) then
        ring_w = 60 - remainder*10
    else
        ring_w = 20 + (remainder-5)*10
    end
    -- print(ring_w)
    -- Draw background ring

    cairo_arc(cr, xc, yc, ring_r, angle_0, angle_f)
    cairo_set_source_rgba(cr, rgb_to_r_g_b(bgc, bga))
    cairo_set_line_width(cr, ring_w)
    cairo_stroke(cr)

    -- Draw indicator ring

    cairo_arc(cr, xc, yc, ring_r, angle_0, angle_0 + t_arc)
    cairo_set_source_rgba(cr, rgb_to_r_g_b(fgc, fga))
    cairo_stroke(cr)
end


function conky_main_rings()
    local function setup_rings(cr, pt)
        local str = ''
        local value = 0
        str = string.format('${%s %s}', pt['name'], pt['arg'])
        str = conky_parse(str)
        value = tonumber(str)
        
        if value == nil then value = 0 end
        pct = value / pt['max']
        draw_ring(cr, pct, pt)
    end

    -- Check that Conky has been running for at least (default) 5s
    if conky_window == nil then return end
    local cs = cairo_xlib_surface_create(conky_window.display,
                                         conky_window.drawable,
                                         conky_window.visual,
                                         conky_window.width, conky_window.height)
    local cr = cairo_create(cs)
    local updates = conky_parse('${updates}')
    update_num = tonumber(updates)
    if update_num > 1 then

        for i in pairs(settings_table) do
            setup_rings(cr, settings_table[i])
        end
    end
    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
    collectgarbage()
end
-- =============================================================================================================================================

--[[ TEXT WIDGET v1.42 by Wlourf 07 Feb. 2011

This widget can drawn texts set in the "text_settings" table with some parameters
http://u-scripts.blogspot.com/2010/06/text-widget.html

To call the script in a conky, use, before TEXT
	lua_load /path/to/the/script/graph.lua
	lua_draw_hook_pre main_graph
and add one line (blank or not) after TEXT
		
]]
--------------------------
require 'cairo'
--------------------------
function conky_draw_text()
    local text_settings = {
        -------[ BEGIN OF PARAMETERS ]-------
 
        {
            text = "Exhale",
            x = 80,
            y = 900,
            colour = {
                {1, 0xDDDDDD, 1}, {1, 0xEEEEEE, 1}, {1, 0xDDDDDD, 1}
            },
            font_name = "Decker",
            font_size = 20,
            orientation = "nn"
        }, 

    }
    --------------[ END OF PARAMETERS ]----------------

    if conky_window == nil then return end
    if tonumber(conky_parse("$updates")) < 1 then return end

    local cs = cairo_xlib_surface_create(conky_window.display,
                                         conky_window.drawable,
                                         conky_window.visual,
                                         conky_window.width, conky_window.height)

    for i, v in pairs(text_settings) do
        cr = cairo_create(cs)
        display_text(v)
        cairo_destroy(cr)
        cr = nil
    end

    cairo_surface_destroy(cs)

end

function rgb_to_r_g_b2(tcolour)
    local colour, alpha = tcolour[2], tcolour[3]
    return ((colour / 0x10000) % 0x100) / 255.,
           ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function display_text(t)
    if t.draw_me == true then t.draw_me = nil end
    if t.draw_me ~= nil and conky_parse(tostring(t.draw_me)) ~= "1" then
        return
    end
    local function set_pattern(te)
        -- this function set the pattern
        if #t.colour == 1 then
            cairo_set_source_rgba(cr, rgb_to_r_g_b2(t.colour[1]))
        else
            local pat

            if t.radial == nil then
                local pts = linear_orientation(t, te)
                pat =
                    cairo_pattern_create_linear(pts[1], pts[2], pts[3], pts[4])
            else
                pat = cairo_pattern_create_radial(t.radial[1], t.radial[2],
                                                  t.radial[3], t.radial[4],
                                                  t.radial[5], t.radial[6])
            end

            for i = 1, #t.colour do
                cairo_pattern_add_color_stop_rgba(pat, t.colour[i][1],
                                                  rgb_to_r_g_b2(t.colour[i]))
            end
            cairo_set_source(cr, pat)
            cairo_pattern_destroy(pat)
        end
    end

    -- set default values if needed
    if t.text == nil then t.text = "Conky is good for you !" end
    if t.x == nil then t.x = conky_window.width / 2 end
    if t.y == nil then t.y = conky_window.height / 2 end
    if t.colour == nil then t.colour = {{1, 0xFFFFFF, 1}} end
    if t.font_name == nil then t.font_name = "Free Sans" end
    if t.font_size == nil then t.font_size = 14 end
    if t.angle == nil then t.angle = 0 end
    if t.italic == nil then t.italic = false end
    if t.oblique == nil then t.oblique = false end
    if t.bold == nil then t.bold = false end
    if t.radial ~= nil then
        if #t.radial ~= 6 then
            print("error in radial table")
            t.radial = nil
        end
    end
    if t.orientation == nil then t.orientation = "ww" end
    if t.h_align == nil then t.h_align = "l" end
    if t.v_align == nil then t.v_align = "b" end
    if t.reflection_alpha == nil then t.reflection_alpha = 0 end
    if t.reflection_length == nil then t.reflection_length = 1 end
    if t.reflection_scale == nil then t.reflection_scale = 1 end
    if t.skew_x == nil then t.skew_x = 0 end
    if t.skew_y == nil then t.skew_y = 0 end
    cairo_translate(cr, t.x, t.y)
    cairo_rotate(cr, t.angle * math.pi / 180)
    cairo_save(cr)

    local slant = CAIRO_FONT_SLANT_NORMAL
    local weight = CAIRO_FONT_WEIGHT_NORMAL
    if t.italic then slant = CAIRO_FONT_SLANT_ITALIC end
    if t.oblique then slant = CAIRO_FONT_SLANT_OBLIQUE end
    if t.bold then weight = CAIRO_FONT_WEIGHT_BOLD end

    -- print(ring_w)
    -- *1 is used to convert str to number
    secs = (os.date("%S")*1)%10
    -- print(secs)
    -- secs_num = secs*2
    -- print(secs%10)
    if (secs >= 0 and secs<=4) then
        t.text = 'INHALE'
    else
        t.text = 'EXHALE'
    end
    -- print(ring_w)

    cairo_select_font_face(cr, t.font_name, slant, weight)

    for i = 1, #t.colour do
        if #t.colour[i] ~= 3 then
            print("error in color table")
            t.colour[i] = {1, 0xFFFFFF, 1}
        end
    end

    local matrix0 = cairo_matrix_t:create()
    tolua.takeownership(matrix0)
    local skew_x, skew_y = t.skew_x / t.font_size, t.skew_y / t.font_size
    cairo_matrix_init(matrix0, 1, skew_y, skew_x, 1, 0, 0)
    cairo_transform(cr, matrix0)
    cairo_set_font_size(cr, t.font_size)
    local te = cairo_text_extents_t:create()
    tolua.takeownership(te)
    t.text = conky_parse(t.text)
    cairo_text_extents(cr, t.text, te)
    set_pattern(te)

    local mx, my = 0, 0

    if t.h_align == "c" then
        mx = -te.width / 2 - te.x_bearing
    elseif t.h_align == "r" then
        mx = -te.width
    end
    if t.v_align == "m" then
        my = -te.height / 2 - te.y_bearing
    elseif t.v_align == "t" then
        my = -te.y_bearing
    end
    cairo_move_to(cr, mx, my)

    cairo_show_text(cr, t.text)

    if t.reflection_alpha ~= 0 then
        local matrix1 = cairo_matrix_t:create()
        tolua.takeownership(matrix1)
        cairo_set_font_size(cr, t.font_size)

        cairo_matrix_init(matrix1, 1, 0, 0, -1 * t.reflection_scale, 0,
                          (te.height + te.y_bearing + my) *
                              (1 + t.reflection_scale))
        cairo_set_font_size(cr, t.font_size)
        te = nil
        local te = cairo_text_extents_t:create()
        tolua.takeownership(te)
        cairo_text_extents(cr, t.text, te)

        cairo_transform(cr, matrix1)
        set_pattern(te)
        cairo_move_to(cr, mx, my)
        cairo_show_text(cr, t.text)

        local pat2 = cairo_pattern_create_linear(0, (te.y_bearing + te.height +
                                                     my), 0, te.y_bearing + my)
        cairo_pattern_add_color_stop_rgba(pat2, 0, 1, 0, 0,
                                          1 - t.reflection_alpha)
        cairo_pattern_add_color_stop_rgba(pat2, t.reflection_length, 0, 0, 0, 1)

        -- line is not drawn but with a size of zero, the mask won't be nice
        cairo_set_line_width(cr, 1)
        local dy = te.x_bearing
        if dy < 0 then dy = dy * (-1) end
        cairo_rectangle(cr, mx + te.x_bearing, te.y_bearing + te.height + my,
                        te.width + dy, -te.height * 1.05)
        cairo_clip_preserve(cr)
        cairo_set_operator(cr, CAIRO_OPERATOR_CLEAR)
        -- cairo_stroke(cr)
        cairo_mask(cr, pat2)
        cairo_pattern_destroy(pat2)
        cairo_set_operator(cr, CAIRO_OPERATOR_OVER)
        te = nil
    end

end

function linear_orientation(t, te)
    local w, h = te.width, te.height
    local xb, yb = te.x_bearing, te.y_bearing

    if t.h_align == "c" then
        xb = xb - w / 2
    elseif t.h_align == "r" then
        xb = xb - w
    end
    if t.v_align == "m" then
        yb = -h / 2
    elseif t.v_align == "t" then
        yb = 0
    end
    local p = 0
    if t.orientation == "nn" then
        p = {xb + w / 2, yb, xb + w / 2, yb + h}
    elseif t.orientation == "ne" then
        p = {xb + w, yb, xb, yb + h}
    elseif t.orientation == "ww" then
        p = {xb, h / 2, xb + w, h / 2}
    elseif vorientation == "se" then
        p = {xb + w, yb + h, xb, yb}
    elseif t.orientation == "ss" then
        p = {xb + w / 2, yb + h, xb + w / 2, yb}
    elseif t.orientation == "ee" then
        p = {xb + w, h / 2, xb, h / 2}
    elseif t.orientation == "sw" then
        p = {xb, yb + h, xb + w, yb}
    elseif t.orientation == "nw" then
        p = {xb, yb, xb + w, yb + h}
    end
    return p
end
