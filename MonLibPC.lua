-- This Monster Library (MonLibPC) is for Computercraft COMPUTERS.
-- Turtle functionality is in MonLib.lua

-- Color list
--- White = 1       | Orange = 2
--- magenta = 4     | lightBlue = 8
--- yellow = 16     | lime = 32
--- pink = 64       | gray = 128
--- lightGray = 256 | cyan = 512
--- purple = 1024   | blue = 2048
--- brown = 4096    | green = 8192
--- red = 16384     | black = 32768
 

function fText(text, colorPick, newLine, clear)
	x, y = term.getCursorPos()
	width, height = term.getSize()
	colorPickValue = tonumber(colorPick or 1)
	newLineCount = tonumber(newLine or 0)
	clearBool = clear or false
	if newLineCount ~= 0 then
		y = y + newLineCount
	end
	term.setCursorPos(math.floor((width - #text) / 2) + 1, y)
	if clearBool then
		term.clearLine()
	end
	term.setTextColor(colorPickValue) 
	term.write(text)
	if colorPickValue > 1 then
		term.setTextColor(1)
	end
	term.setCursorPos(x, y + 1)
end

function round(number)
	return number - (number % 1)
end

local function reset()
	term.clear()
	term.setCursorPos(1, 1)
end

local function Error(text)
	reset()
	local x, y = term.getCursorPos()
	local width, height = term.getSize()
	term.setCursorPos(math.floor((width - #text) / 2) + 1, y)
	term.write(text)
	return
end

return {
	fText = fText,
	round = round,
	reset = reset,
	Error = Error
}
