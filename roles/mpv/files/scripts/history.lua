-- Not my code: originally from https://redd.it/3t6s7k (author deleted; failed to ask for permission).
-- Only tested on Windows. Date is set to dd/mmm/yy and time to machine-wide format.
-- Save as "mpvhistory.lua" in your mpv scripts dir. Log will be saved to mpv default config directory.
-- Make sure to leave a comment if you make any improvements/changes to the script!

local HISTFILE = (os.getenv('APPDATA') or os.getenv('HOME')..'/.config')..'/mpv/mpvhistory.log';

mp.register_event('file-loaded', function()
  local title, logfile;

  filename = mp.get_property('filename')
  title = mp.get_property('media-title');
  title = (title == filename and '' or ('%s'):format(title));

  if not string_exists(HISTFILE, filename) then
    logfile = io.open(HISTFILE, 'a+');
    logfile:write(('[%s] "%s" "%s"\n'):format(os.date('%d/%b/%y %X'), mp.get_property('path'), title));
    logfile:close();
  end
end)

function file_exists(path)
  local file = io.open(path, "rb")
  if file then file:close() end
  return file ~= nil
end

function string_exists(filename, pattern)
  local fn = io.open(filename, 'r')
  local content = fn:read("*all")
  pos = string.find(content, pattern)
  fn:close()
  return pos ~= nil
end
