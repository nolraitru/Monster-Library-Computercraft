-- Libraries
local MonLib = require("MonLib")
local MonLibPC = require("MonLibPC")
 
-- Find weath_machine
-- Peripheral finding originally based on CecilKilmer's Clock.lua
environmentDetector = nil
monitor = nil
 
screenWidth = 0
screenHeight = 0
 
-- Find them Periphs
sides = { "top", "bottom", "left", "right", "front", "back" }

for periph = 1, #sides do
	if peripheral.isPresent(sides[periph]) == "monitor" then
		monitor = peripheral.wrap(sides[periph])
		term.redirect(monitor)
	elseif peripheral.isPresent(sides[periph]) == "environmentDetector" then
		environmentDetector = peripheral.wrap(sides[periph])
	end
end

weather = nil
 
-- Check precipitation, type, and thunder
local function isPrecip()
	if environmentDetector.isPrecipitating() then
		if environmentDetector.isThundering() then
			weather = "Thunder"
		elseif environmentDetector.isRaining() and not environmentDetector.isThundering()
			weather = "Rain"
		elseif environmentDetector.isSunny()
			weather = "Sunshine"
		else
			weather = "Snow"
		end
	end
end
 
-- Main script
while true do
	term.clear()
	term.setCursorPos(1, 1)

	-- A 2x2 Monitor Setup allows for 5 displayed lines
	-- Line 1
	local time = os.time()
	time = textutils.formatTime(time, false)
	MonLibPC.fText(time, 64)

	-- Line 2
	isPrecip()
	if weather == "Rain" then
		MonLibPC.fText("Raining", 8)
	elseif weather == "Thunder"
		MonLibPC.fText("Thunderstorm", 16)
	elseif weather == "Sunshine"
		MonLibPC.fText("Clear Skies")
	elseif weather == "Snow"
		MonLibPC.fText("Snowing")
	end

	-- Line 3
	if environmentDetector.isSlimeChunk() then
		MonLibPC.fText("Slime Chunk", 32)
	else
		MonLibPC.fText("Not Slime Chunk", 256)
	end

	-- Line 4
	moonPhase = environmentDetector.getMoonName()
	MonLibPC.fText(moonPhase)
	
	-- Line 5
	currDimension = environmentDetector.getDimension()
	MonLibPC.fText(currDimension)
 
	sleep(0.1)
end