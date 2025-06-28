-- Libraries
local MonLib = require("MonLib")
local MonLibPC = require("MonLibPC")
 
-- Find weath_machine
-- Peripheral finding based on CecilKilmer's Clock.lua
weather_machine = nil
monitor = nil
 
screenWidth = 0
screenHeight = 0
 
-- Find them Periphs
sides = { "top", "bottom", "left", "right", "front", "back" }

for periph = 1, #sides do
	if peripheral.isPresent(sides[periph]) == "monitor" then
		monitor = peripheral.wrap(sides[periph])
		term.redirect(monitor)
	elseif peripheral.isPresent(sides[periph]) == "weather_machine" then
		weather_machine = peripheral.wrap(sides[periph])
	end
end
 
-- Checking if it can snow
Snow = weather_machine.canSnow()
weather = nil
 
-- Check precipitation, type, and thunder
local function isPrecip()
	if weather_machine.isPrecipitating() then
		if Snow and weather_machine.isSnowing() then
			weather = 1
		elseif weather_machine.isThundering() then
			weather = 2
		elseif weather_machine.isRaining() then
			weather = 3
		else
			weather = 0
		end
	end
end

 
-- Main script
while true do
	term.clear()
	term.setCursorPos(1, 1)
 
	local time = os.time()
	time = textutils.formatTime(time, false)
	MonLibPC.fText(time)
 
	if weather_machine.canSnow() and weather_machine.isSnowing() then
		MonLibPC.fText("Snowing")
	elseif weather_machine.isRaining() and not weather_machine.isThundering() then
		MonLibPC.fText("Raining")
	elseif weather_machine.isThundering() then
		MonLibPC.fText("Thunderstorm")
	else
		MonLibPC.fText("Clear Skies")
	end
 
	temp = MonLibPC.round(weather_machine.getTemperature() * 100)
	tempString = "Temp: "..temp.."%"
	MonLibPC.fText(tempString)
 
	MonLibPC.fText("line4")
	MonLibPC.fText("line5")
 
	sleep(0.1)
end