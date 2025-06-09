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
____exports.ScrollBar = function(props) -- 28
	local ____props_0 = props -- 40
	local x = ____props_0.x -- 40
	if x == nil then -- 40
		x = 0 -- 30
	end -- 30
	local y = ____props_0.y -- 30
	if y == nil then -- 30
		y = 0 -- 31
	end -- 31
	local width = ____props_0.width -- 31
	if width == nil then -- 31
		width = 100 -- 32
	end -- 32
	local height = ____props_0.height -- 32
	if height == nil then -- 32
		height = 100 -- 33
	end -- 33
	local backgroundImage = ____props_0.backgroundImage -- 33
	if backgroundImage == nil then -- 33
		backgroundImage = "Image/background/background.png" -- 34
	end -- 34
	local scrollbarwidth = ____props_0.scrollbarwidth -- 34
	if scrollbarwidth == nil then -- 34
		scrollbarwidth = 20 -- 35
	end -- 35
	local alignmode = ____props_0.alignmode -- 35
	if alignmode == nil then -- 35
		alignmode = ____exports.AlignMode.Vertical -- 36
	end -- 36
	local scrollblockImage = ____props_0.scrollblockImage -- 36
	if scrollblockImage == nil then -- 36
		scrollblockImage = "Image/button/button.png" -- 37
	end -- 37
	local totalwidth = ____props_0.totalwidth -- 37
	if totalwidth == nil then -- 37
		totalwidth = 100 -- 38
	end -- 38
	local nowposition = ____props_0.nowposition -- 38
	if nowposition == nil then -- 38
		nowposition = 0 -- 39
	end -- 39
	local scale -- 41
	local blockrange = {min = 0, max = 0, de = 0} -- 42
	local root = Node() -- 43
	root.x = x -- 44
	root.y = y -- 45
	local background = DrawNode() -- 47
	background:drawPolygon( -- 49
		{ -- 49
			Vec2(0, 0), -- 49
			Vec2(width, 0), -- 49
			Vec2(width, height), -- 49
			Vec2(0, height) -- 49
		}, -- 49
		Color(2868903935) -- 49
	) -- 49
	local clipnode = ClipNode(background or Node()) -- 53
	clipnode.size = Size(width, height) -- 54
	root:addChild(clipnode) -- 56
	clipnode:addChild(background) -- 58
	local track = DrawNode() -- 59
	local block = Sprite(scrollblockImage) -- 60
	clipnode:addChild(track) -- 62
	local child = props.children -- 63
	clipnode:addChild(child) -- 64
	local function setTotalwidth(totalwidth1) -- 66
		totalwidth = totalwidth1 -- 67
		if block then -- 67
			if alignmode == ____exports.AlignMode.Horizontal then -- 67
				scale = totalwidth / width -- 70
				block.width = width / scale -- 71
				blockrange.min = block.width / 2 - width / 2 -- 72
				blockrange.max = width / 2 - block.width / 2 -- 73
				blockrange.de = blockrange.max - blockrange.min -- 74
				block.x = blockrange.min + blockrange.de * nowposition / 100 -- 75
			else -- 75
				scale = totalwidth / height -- 77
				block.height = height / scale -- 78
				blockrange.min = block.height / 2 - height / 2 -- 79
				blockrange.max = height / 2 - block.height / 2 -- 80
				blockrange.de = blockrange.max - blockrange.min -- 81
				block.y = blockrange.max - blockrange.de * nowposition / 100 -- 82
			end -- 82
		end -- 82
	end -- 66
	if block then -- 66
		track:addChild(block) -- 88
		if alignmode == ____exports.AlignMode.Horizontal then -- 88
			track.x = width / 2 -- 91
			track.y = scrollbarwidth / 2 -- 92
			track:drawPolygon( -- 94
				{ -- 94
					Vec2(-width / 2, -scrollbarwidth / 2), -- 94
					Vec2(width / 2, -scrollbarwidth / 2), -- 94
					Vec2(width / 2, scrollbarwidth / 2), -- 94
					Vec2(-width / 2, scrollbarwidth / 2) -- 94
				}, -- 94
				Color(1431655765) -- 94
			) -- 94
			block.height = scrollbarwidth -- 95
			setTotalwidth(totalwidth) -- 96
			block:onTapMoved(function(touch) -- 97
				local temp = block.x + touch.delta.x -- 98
				if temp > blockrange.max then -- 98
					block.x = blockrange.max -- 100
				elseif temp < blockrange.min then -- 100
					block.x = blockrange.min -- 102
				else -- 102
					block.x = temp -- 104
				end -- 104
				props.nowposition = (block.x - blockrange.min) * 100 / blockrange.de -- 106
			end) -- 97
			clipnode:onMouseWheel(function(delta) -- 109
				local temp = block.x + delta.y * block.width / 2 -- 110
				if temp > blockrange.max then -- 110
					block.x = blockrange.max -- 112
				elseif temp < blockrange.min then -- 112
					block.x = blockrange.min -- 114
				else -- 114
					block.x = temp -- 116
				end -- 116
				props.nowposition = (block.x - blockrange.min) * 100 / blockrange.de -- 118
			end) -- 109
		else -- 109
			track.x = width - scrollbarwidth / 2 -- 121
			track.y = height / 2 -- 122
			track:drawPolygon( -- 124
				{ -- 124
					Vec2(-scrollbarwidth / 2, height / 2), -- 124
					Vec2(-scrollbarwidth / 2, -height / 2), -- 124
					Vec2(scrollbarwidth / 2, -height / 2), -- 124
					Vec2(scrollbarwidth / 2, height / 2) -- 124
				}, -- 124
				Color(1431655765) -- 124
			) -- 124
			block.width = scrollbarwidth -- 125
			setTotalwidth(totalwidth) -- 126
			block:onTapMoved(function(touch) -- 127
				local temp = block.y + touch.delta.y -- 128
				if temp > blockrange.max then -- 128
					block.y = blockrange.max -- 130
				elseif temp < blockrange.min then -- 130
					block.y = blockrange.min -- 132
				else -- 132
					block.y = temp -- 134
				end -- 134
				props.nowposition = (blockrange.max - block.y) * 100 / blockrange.de -- 136
			end) -- 127
			clipnode:onMouseWheel(function(delta) -- 139
				local temp = block.y + delta.y * block.height / 2 -- 140
				if temp > blockrange.max then -- 140
					block.y = blockrange.max -- 142
				elseif temp < blockrange.min then -- 142
					block.y = blockrange.min -- 144
				else -- 144
					block.y = temp -- 146
				end -- 146
				props.nowposition = (blockrange.max - block.y) * 100 / blockrange.de -- 148
			end) -- 139
		end -- 139
	end -- 139
	local scrollBarNode = {node = root, setTotalwidth = setTotalwidth} -- 156
	return scrollBarNode -- 157
end -- 28
return ____exports -- 28