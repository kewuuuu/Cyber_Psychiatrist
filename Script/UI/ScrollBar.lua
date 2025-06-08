-- [tsx]: ScrollBar.tsx
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 3
local Node = ____Dora.Node -- 3
local Sprite = ____Dora.Sprite -- 3
local Vec2 = ____Dora.Vec2 -- 3
local Color = ____Dora.Color -- 3
local Size = ____Dora.Size -- 3
local ClipNode = ____Dora.ClipNode -- 3
local DrawNode = ____Dora.DrawNode -- 3
____exports.AlignMode = AlignMode or ({}) -- 5
____exports.AlignMode.Horizontal = "horizontal" -- 6
____exports.AlignMode.Vertical = "vertical" -- 7
____exports.ScrollBar = function(props) -- 23
	local ____props_0 = props -- 35
	local x = ____props_0.x -- 35
	if x == nil then -- 35
		x = 0 -- 25
	end -- 25
	local y = ____props_0.y -- 25
	if y == nil then -- 25
		y = 0 -- 26
	end -- 26
	local width = ____props_0.width -- 26
	if width == nil then -- 26
		width = 100 -- 27
	end -- 27
	local height = ____props_0.height -- 27
	if height == nil then -- 27
		height = 100 -- 28
	end -- 28
	local backgroundImage = ____props_0.backgroundImage -- 28
	if backgroundImage == nil then -- 28
		backgroundImage = "Image/background/background.png" -- 29
	end -- 29
	local scrollbarwidth = ____props_0.scrollbarwidth -- 29
	if scrollbarwidth == nil then -- 29
		scrollbarwidth = 20 -- 30
	end -- 30
	local alignmode = ____props_0.alignmode -- 30
	if alignmode == nil then -- 30
		alignmode = ____exports.AlignMode.Vertical -- 31
	end -- 31
	local scrollblockImage = ____props_0.scrollblockImage -- 31
	if scrollblockImage == nil then -- 31
		scrollblockImage = "Image/button/button.png" -- 32
	end -- 32
	local totalwidth = ____props_0.totalwidth -- 32
	if totalwidth == nil then -- 32
		totalwidth = 100 -- 33
	end -- 33
	local nowposition = ____props_0.nowposition -- 33
	if nowposition == nil then -- 33
		nowposition = 0 -- 34
	end -- 34
	local scale -- 36
	local blockrange = {min = 0, max = 0, de = 0} -- 37
	local root = Node() -- 38
	root.x = x -- 39
	root.y = y -- 40
	local background = DrawNode() -- 42
	background:drawPolygon( -- 44
		{ -- 44
			Vec2(0, 0), -- 44
			Vec2(width, 0), -- 44
			Vec2(width, height), -- 44
			Vec2(0, height) -- 44
		}, -- 44
		Color(2868903935) -- 44
	) -- 44
	local clipnode = ClipNode(background or Node()) -- 48
	clipnode.size = Size(width, height) -- 49
	root:addChild(clipnode) -- 51
	clipnode:addChild(background) -- 53
	local track = DrawNode() -- 54
	local block = Sprite(scrollblockImage) -- 55
	clipnode:addChild(track) -- 57
	if block then -- 57
		track:addChild(block) -- 59
		if alignmode == ____exports.AlignMode.Horizontal then -- 59
			scale = totalwidth / width -- 61
			track.x = width / 2 -- 62
			track.y = scrollbarwidth / 2 -- 63
			track:drawPolygon( -- 65
				{ -- 65
					Vec2(-width / 2, -scrollbarwidth / 2), -- 65
					Vec2(width / 2, -scrollbarwidth / 2), -- 65
					Vec2(width / 2, scrollbarwidth / 2), -- 65
					Vec2(-width / 2, scrollbarwidth / 2) -- 65
				}, -- 65
				Color(1431655765) -- 65
			) -- 65
			block.width = width / scale -- 66
			block.height = scrollbarwidth -- 67
			blockrange.min = block.width / 2 - width / 2 -- 68
			blockrange.max = width / 2 - block.width / 2 -- 69
			blockrange.de = blockrange.max - blockrange.min -- 70
			block.x = blockrange.min + blockrange.de * nowposition / 100 -- 71
			block:onTapMoved(function(touch) -- 72
				local temp = block.x + touch.delta.x -- 73
				if temp > blockrange.max then -- 73
					block.x = blockrange.max -- 75
				elseif temp < blockrange.min then -- 75
					block.x = blockrange.min -- 77
				else -- 77
					block.x = temp -- 79
				end -- 79
				props.nowposition = (block.x - blockrange.min) * 100 / blockrange.de -- 81
			end) -- 72
			clipnode:onMouseWheel(function(delta) -- 84
				local temp = block.x + delta.y * block.width / 2 -- 85
				if temp > blockrange.max then -- 85
					block.x = blockrange.max -- 87
				elseif temp < blockrange.min then -- 87
					block.x = blockrange.min -- 89
				else -- 89
					block.x = temp -- 91
				end -- 91
				props.nowposition = (block.x - blockrange.min) * 100 / blockrange.de -- 93
			end) -- 84
		else -- 84
			scale = totalwidth / width -- 96
			track.x = width - scrollbarwidth / 2 -- 97
			track.y = height / 2 -- 98
			track:drawPolygon( -- 100
				{ -- 100
					Vec2(-scrollbarwidth / 2, height / 2), -- 100
					Vec2(-scrollbarwidth / 2, -height / 2), -- 100
					Vec2(scrollbarwidth / 2, -height / 2), -- 100
					Vec2(scrollbarwidth / 2, height / 2) -- 100
				}, -- 100
				Color(1431655765) -- 100
			) -- 100
			block.width = scrollbarwidth -- 101
			block.height = height / scale -- 102
			blockrange.min = block.height / 2 - height / 2 -- 103
			blockrange.max = height / 2 - block.height / 2 -- 104
			blockrange.de = blockrange.max - blockrange.min -- 105
			block.y = blockrange.max - blockrange.de * nowposition / 100 -- 106
			block:onTapMoved(function(touch) -- 107
				local temp = block.y + touch.delta.y -- 108
				if temp > blockrange.max then -- 108
					block.y = blockrange.max -- 110
				elseif temp < blockrange.min then -- 110
					block.y = blockrange.min -- 112
				else -- 112
					block.y = temp -- 114
				end -- 114
				props.nowposition = (blockrange.max - block.y) * 100 / blockrange.de -- 116
			end) -- 107
			clipnode:onMouseWheel(function(delta) -- 119
				local temp = block.y + delta.y * block.height / 2 -- 120
				if temp > blockrange.max then -- 120
					block.y = blockrange.max -- 122
				elseif temp < blockrange.min then -- 122
					block.y = blockrange.min -- 124
				else -- 124
					block.y = temp -- 126
				end -- 126
				props.nowposition = (blockrange.max - block.y) * 100 / blockrange.de -- 128
			end) -- 119
		end -- 119
	end -- 119
	return root -- 135
end -- 23
return ____exports -- 23