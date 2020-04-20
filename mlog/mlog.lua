local filesystem = require("filesystem")
require("util")

local mlog = {}
local logDir = "/var/log"
local config = {}

-- TODO should have individual configurable logging instances

----------------------
-- log levels
-- 0 = OFF
-- 1 = ERROR
-- 2 = WARNING
-- 3 = NOTICE
-- 4 = DEBUG

config.level = 3 -- default to NOTICE, supress DEBUG
config.logFile = "messages" -- default log file
mlog.config = config

function mlog.log(msg, level)
  if level > config.level then
    return
  end

  local color = solarized.fg
  if level == 4 then
    color = solarized.blue
  elseif level == 2 then
    color = solarized.yellow
  elseif level == 1 then
    color = solarized.red
  end

  -- TODO cache file streams
  local logPath = logDir .. "/" .. config.logFile
  local file = filesystem.open(logPath, "a")
  if not file then
    error("Failed to open to log file: " .. logPath)
    
  end
  local timestamp = os.date()
  local success = file:write(timestamp .. " : " .. msg .. "\n")
  file:close()
  if not success then
    error("Failed to write to log file: " .. logPath)
  end
  printC(os.date(), solarized.green)
  printC(" : " .. msg, color)
  print()
 
end

function mlog.info(msg)
  mlog.log(msg, 3)
end

function mlog.error(msg)
  mlog.log(msg, 1)
end

function mlog.warning(msg)
  mlog.log(msg, 2)
end

function mlog.debug(msg)
  mlog.log(msg, 4)
end

-- internal function for initializing the logger
function init()
  if not filesystem.isDirectory(logDir) then
    filesystem.makeDirectory(logDir)
  end
end


init()

return mlog