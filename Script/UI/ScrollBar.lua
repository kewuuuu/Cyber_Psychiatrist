-- [tsx]: ScrollBar.tsx
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 4
local Node = ____Dora.Node -- 4
local Sprite = ____Dora.Sprite -- 4
local Vec2 = ____Dora.Vec2 -- 4
local Color = ____Dora.Color -- 4
local Size = ____Dora.Size -- 4
local ClipNode = ____Dora.ClipNode -- 4
local DrawNode = ____Dora.DrawNode -- 4
____exports.AlignMode = AlignMode or ({}) -- 6
____exports.AlignMode.Horizontal = "horizontal" -- 7
____exports.AlignMode.Vertical = "vertical" -- 8
____exports.ScrollBar = function(props) -- 29
	local ____props_0 = props -- 41
	local x = ____props_0.x -- 41
	if x == nil then -- 41
		x = 0 -- 31
	end -- 31
	local y = ____props_0.y -- 31
	if y == nil then -- 31
		y = 0 -- 32
	end -- 32
	local width = ____props_0.width -- 32
	if width == nil then -- 32
		width = 100 -- 33
	end -- 33
	local height = ____props_0.height -- 33
	if height == nil then -- 33
		height = 100 -- 34
	end -- 34
	local backgroundImage = ____props_0.backgroundImage -- 34
	if backgroundImage == nil then -- 34
		backgroundImage = "Image/background/background.png" -- 35
	end -- 35
	local scrollbarwidth = ____props_0.scrollbarwidth -- 35
	if scrollbarwidth == nil then -- 35
		scrollbarwidth = 20 -- 36
	end -- 36
	local alignmode = ____props_0.alignmode -- 36
	if alignmode == nil then -- 36
		alignmode = ____exports.AlignMode.Vertical -- 37
	end -- 37
	local scrollblockImage = ____props_0.scrollblockImage -- 37
	if scrollblockImage == nil then -- 37
		scrollblockImage = "Image/button/button.png" -- 38
	end -- 38
	local totalwidth = ____props_0.totalwidth -- 38
	if totalwidth == nil then -- 38
		totalwidth = 100 -- 39
	end -- 39
	local nowposition = ____props_0.nowposition -- 39
	if nowposition == nil then -- 39
		nowposition = 0 -- 40
	end -- 40
	local scale -- 42
	local blockrange = {min = 0, max = 0, de = 0} -- 43
	local root = Node() -- 44
	root.x = x -- 45
	root.y = y -- 46
	local background = DrawNode() -- 48
	background:drawPolygon( -- 50
		{ -- 50
			Vec2(0, 0), -- 50
			Vec2(width, 0), -- 50
			Vec2(width, height), -- 50
			Vec2(0, height) -- 50
		}, -- 50
		Color(2868903935) -- 50
	) -- 50
	local clipnode = ClipNode(background or Node()) -- 54
	clipnode.size = Size(width, height) -- 55
	root:addChild(clipnode) -- 57
	clipnode:addChild(background) -- 59
	local track = DrawNode() -- 60
	local block = Sprite(scrollblockImage) -- 61
	clipnode:addChild(track) -- 63
	local function changeorigintoupright(pos) -- 65
		if alignmode == ____exports.AlignMode.Horizontal then -- 65
			print(height - pos.y) -- 67
			return Vec2(pos.x, height - pos.y) -- 68
		else -- 68
			print(height + totalwidth * nowposition / 100 - pos.y) -- 70
			return Vec2(pos.x, height + totalwidth * nowposition / 100 - pos.y) -- 71
		end -- 71
	end -- 65
	if props.children then -- 65
		for ____, child in ipairs(props.children) do -- 76
			child.position = changeorigintoupright(child.position) -- 77
			clipnode:addChild(child) -- 78
		end -- 78
	end -- 78
	local function setTotalwidth(totalwidth1) -- 81
		totalwidth = totalwidth1 -- 82
		if block then -- 82
			if alignmode == ____exports.AlignMode.Horizontal then -- 82
				scale = (totalwidth - width) / width -- 85
				block.width = width / scale -- 86
				blockrange.min = block.width / 2 - width / 2 -- 87
				blockrange.max = width / 2 - block.width / 2 -- 88
				blockrange.de = blockrange.max - blockrange.min -- 89
				block.x = blockrange.min + blockrange.de * nowposition / 100 -- 90
			else -- 90
				scale = (totalwidth - height) / height -- 92
				block.height = height / scale -- 93
				blockrange.min = block.height / 2 - height / 2 -- 94
				blockrange.max = height / 2 - block.height / 2 -- 95
				blockrange.de = blockrange.max - blockrange.min -- 96
				block.y = blockrange.max - blockrange.de * nowposition / 100 -- 97
			end -- 97
		end -- 97
	end -- 81
	local function changeNowPosition(np) -- 101
		local delta = np - (props.nowposition or 0) -- 102
		props.nowposition = np -- 103
		if props.children then -- 103
			if alignmode == ____exports.AlignMode.Horizontal then -- 103
				for ____, child in ipairs(props.children) do -- 106
					child.x = child.x - (totalwidth - width) * delta / 100 -- 108
				end -- 108
			else -- 108
				for ____, child in ipairs(props.children) do -- 111
					child.y = child.y + (totalwidth - height) * delta / 100 -- 113
				end -- 113
			end -- 113
		end -- 113
	end -- 101
	if block then -- 101
		track:addChild(block) -- 119
		if alignmode == ____exports.AlignMode.Horizontal then -- 119
			track.x = width / 2 -- 122
			track.y = scrollbarwidth / 2 -- 123
			track:drawPolygon( -- 125
				{ -- 125
					Vec2(-width / 2, -scrollbarwidth / 2), -- 125
					Vec2(width / 2, -scrollbarwidth / 2), -- 125
					Vec2(width / 2, scrollbarwidth / 2), -- 125
					Vec2(-width / 2, scrollbarwidth / 2) -- 125
				}, -- 125
				Color(1431655765) -- 125
			) -- 125
			block.height = scrollbarwidth -- 126
			setTotalwidth(totalwidth) -- 127
			block:onTapMoved(function(touch) -- 128
				local temp = block.x + touch.delta.x -- 129
				if temp > blockrange.max then -- 129
					block.x = blockrange.max -- 131
				elseif temp < blockrange.min then -- 131
					block.x = blockrange.min -- 133
				else -- 133
					block.x = temp -- 135
				end -- 135
				changeNowPosition((block.x - blockrange.min) * 100 / blockrange.de) -- 137
			end) -- 128
			clipnode:onMouseWheel(function(delta) -- 140
				local temp = block.x + delta.y * block.width / 2 -- 141
				if temp > blockrange.max then -- 141
					block.x = blockrange.max -- 143
				elseif temp < blockrange.min then -- 143
					block.x = blockrange.min -- 145
				else -- 145
					block.x = temp -- 147
				end -- 147
				changeNowPosition((block.x - blockrange.min) * 100 / blockrange.de) -- 149
			end) -- 140
		else -- 140
			track.x = width - scrollbarwidth / 2 -- 152
			track.y = height / 2 -- 153
			track:drawPolygon( -- 155
				{ -- 155
					Vec2(-scrollbarwidth / 2, height / 2), -- 155
					Vec2(-scrollbarwidth / 2, -height / 2), -- 155
					Vec2(scrollbarwidth / 2, -height / 2), -- 155
					Vec2(scrollbarwidth / 2, height / 2) -- 155
				}, -- 155
				Color(1431655765) -- 155
			) -- 155
			block.width = scrollbarwidth -- 156
			setTotalwidth(totalwidth) -- 157
			block:onTapMoved(function(touch) -- 158
				local temp = block.y + touch.delta.y -- 159
				if temp > blockrange.max then -- 159
					block.y = blockrange.max -- 161
				elseif temp < blockrange.min then -- 161
					block.y = blockrange.min -- 163
				else -- 163
					block.y = temp -- 165
				end -- 165
				changeNowPosition((blockrange.max - block.y) * 100 / blockrange.de) -- 167
			end) -- 158
			clipnode:onMouseWheel(function(delta) -- 170
				local temp = block.y + delta.y * block.height / 2 -- 171
				if temp > blockrange.max then -- 171
					block.y = blockrange.max -- 173
				elseif temp < blockrange.min then -- 173
					block.y = blockrange.min -- 175
				else -- 175
					block.y = temp -- 177
				end -- 177
				changeNowPosition((blockrange.max - block.y) * 100 / blockrange.de) -- 179
			end) -- 170
		end -- 170
	end -- 170
	local scrollBarNode = {node = root, setTotalwidth = setTotalwidth} -- 187
	return scrollBarNode -- 188
end -- 29
return ____exports -- 29