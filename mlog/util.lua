local term = require("term")

local gpu = term.gpu()

function printC(text, color, isPalette)
  local oldColor, isPaletteIndex = gpu.getForeground()
  gpu.setForeground(color, isPalette)
  io.write(text)
  gpu.setForeground(oldColor, isPaletteIndex)
end

function stub()
  assert(false,"STUB")
end

solarized = {
  bg = 0x002b36,
  fg = 0x657b83,
  yellow = 0xb58900,
  orange = 0xcb4b16,
  red    = 0xdc322f,
  magenta = 0xd33682,
  violet = 0x6c71c4,
  blue = 0x268bd2,
  cyan = 0x2aa198,
  green = 0x859900
}