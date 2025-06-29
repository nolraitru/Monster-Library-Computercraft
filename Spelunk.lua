-- Vars
local torch = 1
local cobble = 2
local cobble2 = 3
local ladder = 4
local ladder2 = 5
local fuel = 6

-- Functions
--- Contains tfuel(amount, fuel) and turnAround()
local MonLib = require("MonLib")

function cobbleCount()
	if turtle.getItemCount(cobble) < 32 then
		turtle.select(cobble2)
		turtle.transferTo(cobble)
		turtle.select(cobble)
	end
end

function checkWalls()
    for e = 1, 4 do
        if turtle.detect() == false then
			cobbleCount()
        	turtle.select(cobble)
		turtle.place()
	end
	turtle.turnRight()
	end
end

function checkWallsT()
	for e = 1, 3 do
		if turtle.detect() == false then
			cobbleCount()
			turtle.select(cobble)
			turtle.place()
		end
	turtle.turnRight()
	end
 MonLib.turnAround()
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
        if e == 2 then
			turtle.turnLeft()
			MonLib.dig()
			turtle.forward()
			MonLib.digUp()
			MonLib.turnAround()
			MonLib.tfuel(1, fuel)
			turtle.forward()
			MonLib.dig()
			turtle.forward()
			MonLib.digUp()
			turtle.back()
			turtle.turnLeft()
        end
        turtle.back()
        turtle.turnRight()
    end
    MonLib.turnAround()
    turtle.forward()
    MonLib.turnAround()
end

function waitForInput()
	parallel.waitForAny(
		function()
			os.pullEvent("key")
			return
		end
		)
end

-- Main script

-- User input for script variables, ux increase (idealy)
term.clear()
term.setCursorPos(1,1)
print("Y level of the turtle...")
term.write("> ")
currY = read()
print("Goal Y level...")
term.write("> ")
goalY = read()
totalDist = currY - goalY
torchNeed = math.ceil(totalDist / 10)

if turtle.getItemCount(torch) < torchNeed then
	print("Need 1 torch per 10 depth. <Slot ",torch,">")
	print("<Press any key to continue...>")
	waitForInput()
end

if turtle.getItemCount(cobble) + turtle.getItemCount(cobble2) < 128 then
	print("Need 2 (TWO) stack of cobblestone. <Slot ",cobble," & ",cobble2,">")
	print("<Press any key to continue...>")
	waitForInput()
end

if totalDist > 64 then
	if turtle.getItemCount(ladder2) < totalDist - 64 then
		print("I need more ladders! <Slots ",ladder," & ",ladder2,">")
		print("<Press any key to continue...>")
		waitForInput()
	end
else
	if turtle.getItemCount(ladder) < totalDist then
		print("I need more ladders! <Slots ",ladder,">")
		print("<Press any key to continue...>")
		waitForInput()
	end
end

if turtle.getItemCount(fuel) < 10 then
	print("Need 10 fuel. <Slot ",fuel,">")
	print("<Press any key to continue...>")
	waitForInput()
end

for i = 1, totalDist do
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
	if (i % 10 == 0) then
		MonLib.turnAround()
		MonLib.dig()
		MonLib.tfuel(1, fuel)
		turtle.forward()
		turtle.turnLeft()
		checkWallsT()
		turtle.back()
		turtle.select(torch)
		turtle.place()
		MonLib.turnAround()
	end
	sleep(0.1)
end
makeroom()
