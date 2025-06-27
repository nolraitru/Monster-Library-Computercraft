-- Variables
local fuel = 16

-- Functions
--- Contains Error, tfuel(amount, fuel), and turnAround()
local MonLib = require("MonLib")

-- Script
if turtle.getItemCount(fuel) < 10 then
	MonLib.Error("Please include 10 coal! <Slot 16>")
	return
end

MonLib.tfuel(1, fuel)
turtle.up()
turtle.forward()
for x = 1, 8 do
	for y = 1, 8 do
		turtle.digDown()
		turtle.forward()
	end
	turtle.dig()
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
turtle.turnRight()
turtle.down()