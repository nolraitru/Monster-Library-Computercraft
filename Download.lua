-- Function
local function fancyWrite(text, nl, c)
	local x, y = term.getCursorPos()
	local width, height = term.getSize()
	if c == 1 then
		local y = y + nl
		term.setTextColor(colors.orange)
		term.setCursorPos(math.floor((width - #text) / 2) + 1, y)
		term.write(text)
	else
		local y = y + nl
		term.setTextColor(colors.white)
		term.setCursorPos(math.floor((width - #text) / 2) + 1, y)
		term.write(text)
	end
end

local version = tostring(tArgs[1])

if not version == "Ducky" or "Advanced" then
	fancyWrite("Please append <Ducky> or <Advanced> after command")
	return false
end

if turtle then
	-- Monster Library
	shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/MonLib.lua", "MonLib.lua")
	-- Spelunk
	shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/Spelunk.lua", "Spelunk.lua")
	-- Mine
	shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/Mine.lua", "Mine.lua")
	-- Strip Mine
	shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/StripMine.lua", "StripMine.lua")
elseif pocket then
	-- MonLib
	shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/MonLib.lua", "MonLib.lua")
	-- MonLibPC
	shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/MonLibPC.lua", "MonLibPC.lua")
	-- Dashboard
	if version == "Ducky" then
		shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/DuckyDashboard.lua", "DuckyDashboard.lua")
	elseif version == "Advanced"
		shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/AdvancedDashboard.lua", "AdvancedDashboard.lua")
	end
else
	-- MonLib
	shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/MonLib.lua", "MonLib.lua")
	-- MonLibPC
	shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/MonLibPC.lua", "MonLibPC.lua")
	-- Dashboard
	if version == "Ducky" then
		shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/DuckyDashboard.lua", "DuckyDashboard.lua")
	elseif version == "Advanced"
		shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/AdvancedDashboard.lua", "AdvancedDashboard.lua")
	end
end

term.clear()
term.setCursorPos(1, 1)
fancyWrite("Thank you for downloading...", 0, 0)
fancyWrite(".-* MONSTER LIBRARY *-.", 1, 1)
fancyWrite("Please check <dir> for program list.", 1, 1)
fancyWrite("The Download script will now remove itself.", 1, 0)
term.setCursorPos(1, 5)
shell.run("remove", "Download.lua")
