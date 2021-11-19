debug_print("Application: " .. get_application_name())
debug_print("Window: " .. get_window_name())

if (string.find(get_application_name(), "Spotify")) then
   set_window_workspace(7)
   -- maximize()
   -- focus()
end


if (string.find(get_application_name(), "Firefox")) then
   set_window_workspace(7)
   -- maximize()
   -- focus()
end


if (string.find(get_application_name(), "Discord")) then
   set_window_workspace(7)
   -- maximize()
   -- focus()
end
