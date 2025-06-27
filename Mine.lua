-- Variables
local tArgs = { ... }
local fuel = 16
local torch = 15
local storage = 14
local cobble = 13
local dist = 0
local travel = tonumber(tArgs[1])
local tc = true
local cc = true
i = 1

-- Functions
--- Contains tfuel(amount, fuel) and turnAround()
local MonLib = require("MonLib")

local function placeTorch()
	if tc then
		MonLib.tfuel(1, fuel)
		turtle.turnRight()
		turtle.up()
		turtle.dig()
		turtle.forward()
		if not turtle.detect() then
			turtle.select(cobble)
			turtle.place()
		end
		if not turtle.detectUp() then
			turtle.select(cobble)
			turtle.placeUp()
		end
		turtle.back()
		turtle.select(torch)
		turtle.place()
		turtle.turnLeft()
		turtle.down()
		tc = false
	else
		MonLib.tfuel(1, fuel)
		turtle.turnLeft()
		turtle.up()
		turtle.dig()
		turtle.forward()
		if not turtle.detect() then
			turtle.select(cobble)
			turtle.place()
		end
		if not turtle.detectUp() then
			turtle.select(cobble)
			turtle.placeUp()
		end
		turtle.back()
		turtle.select(torch)
		turtle.place()
		turtle.turnRight()
		turtle.down()
		tc = true
	end
end

local function invCheck()
	if turtle.getItemSpace(12) < 16 then
		if cc then
			turtle.turnLeft()
			turtle.dig()
			MonLib.tfuel(1, fuel)
			turtle.forward()
			turtle.digUp()
			turtle.back()
			turtle.select(storage)
			turtle.place()
			for s = 1, 12 do
				turtle.select(s)
				turtle.drop()
			end
			turtle.turnRight()
			cc = false
		else
			turtle.turnRight()
			turtle.dig()
			MonLib.tfuel(1, fuel)
			turtle.forward()
			turtle.digUp()
			turtle.back()
			turtle.select(storage)
			turtle.place()
			for s = 1, 12 do
				turtle.select(s)
				turtle.drop()
			end
			turtle.turnLeft()
			cc = true
		end
	end
end

local function wcf()
	if not turtle.detect() then
		turtle.place()
	end
end

local function wcd()
	if not turtle.detectDown() then
		turtle.placeDown()
	end
end

local function wcu()
	if not turtle.detectUp() then
		turtle.placeUp()
	end
end

local function wcdFull()
	wcd()
	turtle.turnRight()
	wcf()
	MonLib.turnAround()
	wcf()
	turtle.turnRight()
end

local function wcuFull()
	MonLib.tfuel(1, fuel)
	turtle.up()
	wcu()
	turtle.turnRight()
	wcf()
	MonLib.turnAround()
	wcf()
	turtle.turnRight()
	turtle.down()
end

local function forwardMarch()
	MonLib.dig()
	MonLib.tfuel(1, fuel)
	turtle.forward()
	wcdFull()
	MonLib.digUp()
	wcuFull()
end

-- Script
if #tArgs == 0 then
	MonLib.Error("Invalid syntax. Use [Mine <length>].")
	return
end
 
if turtle.getItemCount(torch) < 1 then
	MonLib.Error("Please add torches in slot 15.")
	return
elseif turtle.getItemCount(torch) < math.ceil(travel / 10) then
	MonLib.Error("Need 1 torch per 10.")
	return
end
 
if turtle.getItemCount(storage) < 6 then
	MonLib.Error("Atleast 6 chests needed in slot 14.")
	return
end
 
if turtle.getItemCount(fuel) < 32 then
	MonLib.Error("32 fuel needed in slot 16.")
	return
end
 
if turtle.getItemCount(cobble) < 64 then
	MonLib.Error("A stack of cobble needed in slot 13.")
	return
end
 
for i = 1, travel do
    MonLib.tfuel(1, fuel)
    invCheck()
    if (i % 10 == 0) then
        forwardMarch()
        placeTorch()
        dist = dist + 1
    else
        forwardMarch()
        dist = dist + 1
    end
end
 
MonLib.turnAround()
for r = 1, dist do
    MonLib.tfuel(1, fuel)
    turtle.forward()
end
 
turtle.turnRight()
MonLib.dig()
MonLib.tfuel(1, fuel)
turtle.forward()
MonLib.digUp()
turtle.back()
turtle.select(storage)
turtle.place()
for s = 1, 12 do
	turtle.select(s)
	turtle.drop()
end
turtle.turnLeft()