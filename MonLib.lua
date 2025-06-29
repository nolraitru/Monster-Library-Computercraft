-- Refuel function
local function tfuel(amount, fuel)
	if turtle.getFuelLevel() < 5 then
		turtle.select(fuel)
		turtle.refuel(amount)
	end
end

-- Obvious function
local function turnAround()
	turtle.turnRight()
	turtle.turnRight()
end

-- Reboot function for use with MonLib.Error()
local function reset()
	term.clear()
	term.setCursorPos(1, 1)
end

-- An error function that leaves the device
-- with a message stating the failure.
local function Error(text)
	reset()
	local x, y = term.getCursorPos()
	local width, height = term.getSize()
	term.setCursorPos(math.floor((width - #text) / 2) + 1, y)
	term.write(text)
	return
end

-- Updated dig and digUp accounting for gravity blocks
local function dig()
	while turtle.dig() do
		sleep(0.66)
	end
end

local function digUp()
	while turtle.digUp() do
		sleep(0.66)
	end
end

-- Table used to call functions
--- i.e. function = function

return {
	tfuel = tfuel,
	turnAround = turnAround,
	reset = reset,
	Error = Error,
	dig = dig,
	digUp = digUp
}
