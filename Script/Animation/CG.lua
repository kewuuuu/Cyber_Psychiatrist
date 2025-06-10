-- [tsx]: CG.tsx
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 3
local Sprite = ____Dora.Sprite -- 3
local Content = ____Dora.Content -- 3
local Size = ____Dora.Size -- 3
local Vec2 = ____Dora.Vec2 -- 3
local thread = ____Dora.thread -- 3
local sleep = ____Dora.sleep -- 3
local ____config = require("Script.config") -- 4
local designSize = ____config.designSize -- 4
local ____Animation = require("Script.Animation.Animation") -- 5
local NodeMove = ____Animation.NodeMove -- 5
local function autoSize(orisize, tagetsize) -- 7
	local scale = math.min(tagetsize.height / orisize.height, tagetsize.width / orisize.width) -- 8
	return Size(orisize:mul(Vec2(scale, scale))) -- 9
end -- 7
____exports.CG = function(node, foldername, speed, intervals, pos) -- 12
	node:removeAllChildren() -- 13
	local names = Content:getAllFiles(foldername) -- 18
	local i = 0 -- 20
	local frames = {} -- 21
	for ____, name in ipairs(names) do -- 22
		local frame = Sprite((foldername .. "/") .. name) or Sprite() -- 23
		frame.position = pos[i + 1] -- 25
		frame.size = autoSize(frame.size, designSize) -- 26
		frame:addTo(node) -- 27
		frames[#frames + 1] = frame -- 29
		i = i + 1 -- 30
	end -- 30
	return thread(function() -- 32
		i = 0 -- 33
		do -- 33
			i = 0 -- 34
			while i < #pos do -- 34
				local moveCoroutine = NodeMove( -- 35
					frames[i + 1], -- 35
					speed, -- 35
					{ -- 35
						pos[i + 1], -- 35
						Vec2(0, 0) -- 35
					}, -- 35
					false -- 35
				) -- 35
				sleep(intervals[i + 1]) -- 36
				i = i + 1 -- 34
			end -- 34
		end -- 34
	end) -- 32
end -- 12
return ____exports -- 12