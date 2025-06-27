-- Variables
local fuel = 16
local seeds2 = 15
local seeds = 14

-- Functions
--- Contains Error, tfuel(amount, fuel), and turnAround()
local MonLib = require("MonLib")

local function plant()
	if turtle.getItemCount(seeds2) < 32 and turtle.getItemCount(seeds) > 0 then
		turtle.select(seeds)
		turtle.transferTo(seeds2)
	end
	turtle.select(seeds2)
	turtle.placeDown()
end

-- Script
if turtle.getItemCount(fuel) < 10 then
	MonLib.Error("Please include 10 coal! <Slot 16>")
	return
end

if turtle.getItemCount(seeds) < 64 and turtle.getItemCount(seeds2) < 64 then
	MonLib.Error("Please include 2 stacks of seeds! <Slots 14 & 15>")
	return
end

MonLib.tfuel(1, fuel)
turtle.up()
turtle.forward()
for x = 1, 8 do
	for y = 1, 8 do
		turtle.digDown()
		plant()
		turtle.forward()
	end
	turtle.dig()
	plant()
	MonLib.tfuel(1, fuel)
	if (x % 2 == 1) then
		turtle.turnRight()
		turtle.forward()
		turtle.turnRight()
	else
		turtle.turnLeft()
		turtle.forward()
		turtle.turnLeft()
	end
end
MonLib.turnAround()
for i = 1, 9 do
	MonLib.tfuel(1, fuel)
	turtle.forward()
end
turtle.turnRight()
for i = 1, 8 do
	MonLib.tfuel(1, fuel)
	turtle.forward()
end
turtle.turnLeft()
turtle.down()
for s = 1, 13 do
	turtle.select(s)
	turtle.drop()
end
MonLib.turnAround()