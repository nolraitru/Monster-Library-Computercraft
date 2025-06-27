-- Function
local function fancyWrite(text, nl, c)
	local x, y = term.getCursorPos()
	local width, height = term.getSize()
	if c == 1 then
		local y = y + nl
		term.setTextColor(colors.orange)
	elseif c == 2 then
		local y = y + nl
		term.setTextColor(colors.lime)
	else
		local y = y + nl
		term.setTextColor(colors.white)
	end
	term.setCursorPos(math.floor((width - #text) / 2) + 1, y)
	term.write(text)
end

-- Monster Library
shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/MonLib.lua", "MonLib.lua")
-- Spelunk
shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/Spelunk.lua", "Spelunk.lua")
-- Mine
shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/Mine.lua", "Mine.lua")
-- Strip Mine
shell.run("wget", "https://raw.githubusercontent.com/nolraitru/Monster-Library-Computercraft/refs/heads/main/StripMine.lua", "StripMine.lua")

term.clear()
term.setCursorPos(1, 1)
fancyWrite("Thank you for downloading...", 0, 0)
fancyWrite(".-* MONSTER LIBRARY *-.", 1, 1)
fancyWrite("Please check <dir> for program list.", 1, 0)
fancyWrite("Have a great day!", 1, 2)
term.setCursorPos(1, 5)
