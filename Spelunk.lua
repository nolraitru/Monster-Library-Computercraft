-- Vars
local tArgs = { ... }
local curry = tonumber(tArgs[1]) or 0
local dest = 13
local dist = curry - dest
local torch = 1
local cobble = 2
local fuel = 3
local ladder = 4
local ladder2 = 5

-- Functions
--- Contains tfuel(amount, fuel) and turnAround()
local MonLib = require("MonLib")

function checkWalls()
    for e = 1, 4 do
        if turtle.detect() == false then
        	turtle.select(cobble)
		turtle.place()
	end
	turtle.turnRight()
	end
end

function checkWallsT()
	for e = 1, 3 do
		if turtle.detect() == false then
			turtle.select(cobble)
			turtle.place()
		end
	turtle.turnRight()
end

function moveF(dist)
	MonLib.tfuel(1, fuel)
	turtle.forward(dist)
end

function moveB(dist)
	MonLib.tfuel(1, fuel)
	MonLib.turnAround()
	turtle.forward(dist)
	MonLib.turnAround()
end

function moveL(dist)
	MonLib.tfuel(1, fuel)
	turtle.turnLeft()
	turtle.forward(dist)
	turtle.turnRight()
end

function moveR(dist)
	MonLib.tfuel(1, fuel)
	turtle.turnRight()
	turtle.forward(dist)
	turtle.turnLeft()
end

function makeroom()
	MonLib.dig()
	turtle.forward()
	MonLib.turnAround()
	turtle.select(ladder)
	turtle.place()
	MonLib.turnAround()
	MonLib.digUp()
	turtle.turnLeft()
	for e = 1, 3 do
		MonLib.dig()
		turtle.forward()
		MonLib.digUp()
		turtle.back()
		turtle.turnRight()
	end
	MonLib.turnAround()
	turtle.forward()
	turtle.turnLeft()
	MonLib.dig()
	turtle.forward()
	MonLib.digUp()
	MonLib.turnAround()
	turtle.forward()
	MonLib.dig()
	turtle.forward()
	MonLib.digUp()
	MonLib.turnAround()
	turtle.forward()
	turtle.turnLeft()
end

-- Main script
torchNeed = math.ceil(dist / 5)

if #tArgs == 0 then
	MonLib.Error("Invalid syntax. Use [Spelunk <Current Y>].")
	return
end

if turtle.getItemCount(torch) < torchNeed then
	MonLib.Error("Need 1 torch per 5 depth. <Slot 1>")
	return
end

if turtle.getItemCount(fuel) < 1 then
	MonLib.Error("Need fuel. <Slot 3>")
	return
end

if turtle.getItemCount(cobble) < 64 then
	MonLib.Error("Need a stack of cobblestone. <Slot 2>")
	return
end

if dist > 64 then
	if turtle.getItemCount(ladder2) < dist - 64 then
		MonLib.Error("I need more ladders! <Slots 4 & 5>")
		return
	end
else
	if turtle.getItemCount(ladder) < dist then
		MonLib.Error("I need more ladders! <Slot 4>")
		return
	end
end

for i = 1, dist do
	MonLib.tfuel(1, fuel)
	turtle.digDown()
	turtle.down()
	checkWalls()
	turtle.select(ladder)
	if turtle.compareTo(ladder2) then
		if turtle.getItemSpace(ladder) > 60 then
			turtle.select(ladder2)
			turtle.transferTo(ladder)
			turtle.select(ladder)
		end
	end
	turtle.placeUp()
	if (i % 5 == 0) then
		MonLib.turnAround()
		while turtle.dig() do
			sleep(0.66)
		end
		MonLib.tfuel(1, fuel)
		turtle.forward()
		turtle.turnLeft()
		checkWallsT()
		turtle.turnLeft()
		turtle.back()
		turtle.select(torch)
		turtle.place()
		MonLib.turnAround()
	end
end
makeroom()
