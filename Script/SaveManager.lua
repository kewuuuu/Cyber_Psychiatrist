-- [tsx]: SaveManager.tsx
local ____lualib = require("lualib_bundle") -- 1
local __TS__Class = ____lualib.__TS__Class -- 1
local __TS__StringTrim = ____lualib.__TS__StringTrim -- 1
local __TS__StringSplit = ____lualib.__TS__StringSplit -- 1
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter -- 1
local __TS__ParseInt = ____lualib.__TS__ParseInt -- 1
local __TS__ArrayMap = ____lualib.__TS__ArrayMap -- 1
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 3
local Content = ____Dora.Content -- 3
____exports.SaveManager = __TS__Class() -- 18
local SaveManager = ____exports.SaveManager -- 18
SaveManager.name = "SaveManager" -- 18
function SaveManager.prototype.____constructor(self) -- 21
	self.saveDir = "Save" -- 19
	self:ensureSaveDir() -- 22
end -- 21
function SaveManager.prototype.ensureSaveDir(self) -- 26
	if not Content:isdir(self.saveDir) then -- 26
		Content:mkdir(self.saveDir) -- 28
	end -- 28
end -- 26
function SaveManager.prototype.getSavePath(self, slot) -- 33
	return (self.saveDir .. "/save") .. tostring(slot) -- 34
end -- 33
function SaveManager.prototype.getAllSavesSummary(self, maxSlots) -- 38
	local saves = {} -- 39
	do -- 39
		local slot = 0 -- 41
		while slot < maxSlots do -- 41
			local savePath = self:getSavePath(slot) -- 42
			if Content:exist(savePath) then -- 42
				local content = Content:load(savePath) -- 45
				local lines = __TS__ArrayFilter( -- 46
					__TS__StringSplit(content, "\n"), -- 46
					function(____, line) return __TS__StringTrim(line) ~= "" end -- 46
				) -- 46
				if #lines >= 2 then -- 46
					saves[#saves + 1] = {slot = slot, progress = lines[1], playTime = lines[2], exists = true} -- 48
				end -- 48
			else -- 48
				saves[#saves + 1] = {slot = slot, progress = "新存档", playTime = "00:00:00", exists = false} -- 56
			end -- 56
			slot = slot + 1 -- 41
		end -- 41
	end -- 41
	return saves -- 65
end -- 38
function SaveManager.prototype.getSaveDetail(self, slot) -- 69
	local savePath = self:getSavePath(slot) -- 70
	if not Content:exist(savePath) then -- 70
		return { -- 73
			slot = slot, -- 74
			progress = "新存档", -- 75
			playTime = "00:00:00", -- 76
			items = {}, -- 77
			exists = false -- 78
		} -- 78
	end -- 78
	local content = Content:load(savePath) -- 82
	if not content then -- 82
		return nil -- 83
	end -- 83
	local lines = __TS__ArrayFilter( -- 85
		__TS__StringSplit(content, "\n"), -- 85
		function(____, line) return __TS__StringTrim(line) ~= "" end -- 85
	) -- 85
	if #lines < 3 then -- 85
		return nil -- 86
	end -- 86
	local items = lines[3] ~= "" and __TS__ArrayMap( -- 89
		__TS__StringSplit(lines[3], ","), -- 90
		function(____, id) return __TS__ParseInt(__TS__StringTrim(id)) end -- 90
	) or ({}) -- 90
	return { -- 93
		slot = slot, -- 94
		progress = lines[1], -- 95
		playTime = lines[2], -- 96
		items = items, -- 97
		exists = true -- 98
	} -- 98
end -- 69
function SaveManager.prototype.saveGame(self, slot, progress, playTime, items) -- 103
	local itemStr = table.concat(items, ",") -- 107
	local content = (((progress .. "\n") .. playTime) .. "\n") .. itemStr -- 110
	local savePath = self:getSavePath(slot) -- 113
	return Content:save(savePath, content) -- 114
end -- 103
function SaveManager.prototype.deleteSave(self, slot) -- 117
	return Content:remove(self:getSavePath(slot)) -- 118
end -- 117
return ____exports -- 117