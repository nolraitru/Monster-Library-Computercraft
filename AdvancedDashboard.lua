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
	if peripheral.getType(sides[periph]) == "monitor" then
		monitor = peripheral.wrap(sides[periph])
		term.redirect(monitor)
	elseif peripheral.getType(sides[periph]) == "environmentDetector" then
		environmentDetector = peripheral.wrap(sides[periph])
	end
end

weather = nil
 
-- Check precipitation, type, and thunder
local function isPrecip()
	if environmentDetector.isThunder() then
		weather = "Thunder"
	elseif environmentDetector.isRaining() and not environmentDetector.isThunder() then
		weather = "Rain"
	elseif environmentDetector.isSunny() then
		weather = "Sunshine"
	else
		weather = "Snow"
	end
end

-- Find biome and shorten
currDimension = environmentDetector.getDimension()
colonPos = string.find(currDimension,":") + 1
dimString = string.sub(currDimension,colonPos)
dimString = string.upper(dimString)
 
-- Main script
term.clear()
while true do
	term.setCursorPos(1, 1)

	-- A 2x2 Monitor Setup allows for 5 displayed lines
	-- without text scaling
	-- Line 1
	local time = os.time()
	time = textutils.formatTime(time, false)
	MonLibPC.fText(time, 64)

	-- Line 2
	isPrecip()
	if weather == "Rain" then
		MonLibPC.fText("Raining", 8)
	elseif weather == "Thunder" then
		MonLibPC.fText("Thunderstorm", 16)
	elseif weather == "Sunshine" then
		MonLibPC.fText("Clear Skies")
	elseif weather == "Snow" then
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
	MonLibPC.fText(dimString)
 
	sleep(0.1)
end
