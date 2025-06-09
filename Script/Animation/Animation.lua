-- [tsx]: Animation.tsx
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 3
local Sprite = ____Dora.Sprite -- 3
local sleep = ____Dora.sleep -- 3
____exports.playAnimation = function(node, names, interval, loop) -- 7
	node:removeAllChildren() -- 8
	local frames = {} -- 13
	for ____, name in ipairs(names) do -- 14
		local frame = Sprite(name) or Sprite() -- 15
		frame.visible = false -- 16
		frame:addTo(node) -- 17
		frames[#frames + 1] = frame -- 18
	end -- 18
	local i = 0 -- 20
	frames[i + 1].visible = true -- 21
	node:loop(function() -- 22
		sleep(interval) -- 23
		frames[(i + 1) % #names + 1].visible = true -- 24
		frames[i + 1].visible = false -- 25
		i = (i + 1) % #names -- 26
		return not loop -- 27
	end) -- 22
end -- 7
return ____exports -- 7