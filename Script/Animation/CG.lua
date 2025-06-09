-- [tsx]: CG.tsx
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 3
local Sprite = ____Dora.Sprite -- 3
local Content = ____Dora.Content -- 3
local Size = ____Dora.Size -- 3
local Vec2 = ____Dora.Vec2 -- 3
local ____config = require("Script.config") -- 4
local designSize = ____config.designSize -- 4
local function autoSize(orisize, tagetsize) -- 6
	local scale = math.min(tagetsize.height / orisize.height, tagetsize.width / orisize.width) -- 7
	return Size(orisize:mul(Vec2(scale, scale))) -- 8
end -- 6
____exports.CG = function(node, foldername, intervals) -- 11
	node:removeAllChildren() -- 12
	local names = Content:getAllFiles(foldername) -- 17
	local frames = {} -- 19
	for ____, name in ipairs(names) do -- 20
		local frame = Sprite((foldername .. "/") .. name) or Sprite() -- 21
		frame.size = autoSize(frame.size, designSize) -- 23
		frame:addTo(node) -- 24
		frames[#frames + 1] = frame -- 26
	end -- 26
end -- 11
return ____exports -- 11