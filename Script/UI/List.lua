-- [tsx]: List.tsx
local ____lualib = require("lualib_bundle") -- 1
local __TS__ArrayIsArray = ____lualib.__TS__ArrayIsArray -- 1
local __TS__ArrayMap = ____lualib.__TS__ArrayMap -- 1
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 3
local Node = ____Dora.Node -- 3
local Label = ____Dora.Label -- 3
local Vec2 = ____Dora.Vec2 -- 3
local Color = ____Dora.Color -- 3
local ____Button = require("Script.UI.Button") -- 4
local Button = ____Button.Button -- 4
local ____ScrollBar = require("Script.UI.ScrollBar") -- 5
local ScrollBar = ____ScrollBar.ScrollBar -- 5
____exports.AlignMode = AlignMode or ({}) -- 11
____exports.AlignMode.Horizontal = "horizontal" -- 12
____exports.AlignMode.Vertical = "vertical" -- 13
____exports.List = function(props) -- 50
	local ____props_0 = props -- 79
	local x = ____props_0.x -- 79
	if x == nil then -- 79
		x = 0 -- 52
	end -- 52
	local y = ____props_0.y -- 52
	if y == nil then -- 52
		y = 0 -- 53
	end -- 53
	local width = ____props_0.width -- 53
	if width == nil then -- 53
		width = 200 -- 54
	end -- 54
	local height = ____props_0.height -- 54
	if height == nil then -- 54
		height = 100 -- 55
	end -- 55
	local itemInterval = ____props_0.itemInterval -- 55
	if itemInterval == nil then -- 55
		itemInterval = 10 -- 56
	end -- 56
	local alignmode = ____props_0.alignmode -- 56
	if alignmode == nil then -- 56
		alignmode = ____exports.AlignMode.Vertical -- 57
	end -- 57
	local autoLayout = ____props_0.autoLayout -- 57
	if autoLayout == nil then -- 57
		autoLayout = false -- 58
	end -- 58
	local lineInterval = ____props_0.lineInterval -- 58
	if lineInterval == nil then -- 58
		lineInterval = 0 -- 59
	end -- 59
	local itemwidth = ____props_0.itemwidth -- 59
	if itemwidth == nil then -- 59
		itemwidth = 200 -- 60
	end -- 60
	local itemheight = ____props_0.itemheight -- 60
	if itemheight == nil then -- 60
		itemheight = 100 -- 61
	end -- 61
	local itemnum = ____props_0.itemnum -- 61
	if itemnum == nil then -- 61
		itemnum = 0 -- 62
	end -- 62
	local onClick = ____props_0.onClick -- 62
	if onClick == nil then -- 62
		onClick = function() -- 63
		end -- 63
	end -- 63
	local onDoubleClick = ____props_0.onDoubleClick -- 63
	if onDoubleClick == nil then -- 63
		onDoubleClick = function() -- 64
		end -- 64
	end -- 64
	local onStateChange = ____props_0.onStateChange -- 64
	if onStateChange == nil then -- 64
		onStateChange = function() -- 65
		end -- 65
	end -- 65
	local normalImages = ____props_0.normalImages -- 65
	if normalImages == nil then -- 65
		normalImages = "Image/button/button.clip|button_up" -- 66
	end -- 66
	local pressImages = ____props_0.pressImages -- 66
	if pressImages == nil then -- 66
		pressImages = "Image/button/button.clip|button_down" -- 67
	end -- 67
	local texts = ____props_0.texts -- 67
	if texts == nil then -- 67
		texts = "" -- 68
	end -- 68
	local fontName = ____props_0.fontName -- 68
	if fontName == nil then -- 68
		fontName = "sarasa-mono-sc-regular" -- 69
	end -- 69
	local fontSize = ____props_0.fontSize -- 69
	if fontSize == nil then -- 69
		fontSize = 20 -- 70
	end -- 70
	local colors = ____props_0.colors -- 70
	if colors == nil then -- 70
		colors = Color(4294967295) -- 71
	end -- 71
	local textWidth = ____props_0.textWidth -- 71
	if textWidth == nil then -- 71
		textWidth = Label.AutomaticWidth -- 72
	end -- 72
	local alignment = ____props_0.alignment -- 72
	if alignment == nil then -- 72
		alignment = "Center" -- 73
	end -- 73
	local textisdeleted = ____props_0.textisdeleted -- 73
	if textisdeleted == nil then -- 73
		textisdeleted = false -- 74
	end -- 74
	local tags = ____props_0.tags -- 74
	if tags == nil then -- 74
		tags = "0" -- 75
	end -- 75
	local backgroundImage = ____props_0.backgroundImage -- 75
	if backgroundImage == nil then -- 75
		backgroundImage = "Image/background/background.png" -- 76
	end -- 76
	local scrollblockImage = ____props_0.scrollblockImage -- 76
	if scrollblockImage == nil then -- 76
		scrollblockImage = "Image/button/button.png" -- 77
	end -- 77
	local scrollbarwidth = ____props_0.scrollbarwidth -- 77
	if scrollbarwidth == nil then -- 77
		scrollbarwidth = 10 -- 78
	end -- 78
	local root = Node() -- 81
	root.x = x -- 82
	root.y = y -- 83
	local items_position = {} -- 84
	local totalwidth = 0 -- 85
	local items = {} -- 87
	if alignmode == ____exports.AlignMode.Horizontal and autoLayout or alignmode == ____exports.AlignMode.Vertical and not autoLayout then -- 87
		if autoLayout then -- 87
			local tempi = 0 -- 92
			local lines = 1 -- 92
			do -- 92
				local i = 0 -- 93
				while i < itemnum do -- 93
					local temppos = Vec2(itemInterval + itemwidth / 2 + (itemInterval + itemwidth) * (i - tempi), (lineInterval + itemheight / 2) * lines + itemheight / 2) -- 94
					if temppos.x + itemwidth / 2 > width then -- 94
						tempi = i -- 96
						lines = lines + 1 -- 96
						temppos = Vec2(itemInterval + itemwidth / 2 + (itemInterval + itemwidth) * (i - tempi), (lineInterval + itemheight / 2) * lines + itemheight / 2) -- 97
					end -- 97
					items_position[#items_position + 1] = temppos -- 99
					totalwidth = temppos.y + itemheight / 2 + lineInterval -- 100
					local bt = Button({ -- 101
						x = temppos.x, -- 102
						y = temppos.y, -- 103
						width = itemwidth, -- 104
						height = itemheight, -- 105
						onClick = onClick, -- 106
						onDoubleClick = onDoubleClick, -- 107
						onStateChange = onStateChange, -- 108
						text = __TS__ArrayIsArray(texts) and texts[i + 1] or texts, -- 109
						tag = __TS__ArrayIsArray(tags) and tags[i + 1] or tags, -- 110
						fontName = fontName, -- 111
						fontSize = fontSize, -- 112
						color = __TS__ArrayIsArray(colors) and colors[i + 1] or colors, -- 113
						textWidth = textWidth, -- 114
						alignment = alignment, -- 115
						normalImage = __TS__ArrayIsArray(normalImages) and normalImages[i + 1] or normalImages, -- 116
						pressImage = __TS__ArrayIsArray(pressImages) and pressImages[i + 1] or pressImages -- 117
					}) -- 117
					items[#items + 1] = bt -- 119
					i = i + 1 -- 93
				end -- 93
			end -- 93
		else -- 93
			do -- 93
				local i = 0 -- 122
				while i < itemnum do -- 122
					local temppos = Vec2(width / 2, itemInterval + itemheight / 2 + (itemInterval + itemheight) * i) -- 123
					items_position[#items_position + 1] = temppos -- 124
					totalwidth = temppos.y + itemheight / 2 + itemInterval -- 125
					local bt = Button({ -- 126
						x = temppos.x, -- 127
						y = temppos.y, -- 128
						width = itemwidth, -- 129
						height = itemheight, -- 130
						onClick = onClick, -- 131
						onDoubleClick = onDoubleClick, -- 132
						onStateChange = onStateChange, -- 133
						text = __TS__ArrayIsArray(texts) and texts[i + 1] or texts, -- 134
						tag = __TS__ArrayIsArray(tags) and tags[i + 1] or tags, -- 135
						fontName = fontName, -- 136
						fontSize = fontSize, -- 137
						color = __TS__ArrayIsArray(colors) and colors[i + 1] or colors, -- 138
						textWidth = textWidth, -- 139
						alignment = alignment, -- 140
						normalImage = __TS__ArrayIsArray(normalImages) and normalImages[i + 1] or normalImages, -- 141
						pressImage = __TS__ArrayIsArray(pressImages) and pressImages[i + 1] or pressImages -- 142
					}) -- 142
					items[#items + 1] = bt -- 144
					i = i + 1 -- 122
				end -- 122
			end -- 122
		end -- 122
		local background = ScrollBar({ -- 149
			x = 0, -- 150
			y = 0, -- 151
			width = width, -- 152
			height = height, -- 153
			alignmode = ____exports.AlignMode.Vertical, -- 154
			backgroundImage = backgroundImage, -- 155
			scrollblockImage = scrollblockImage, -- 156
			scrollbarwidth = scrollbarwidth, -- 157
			totalwidth = totalwidth, -- 158
			nowposition = 0, -- 159
			children = __TS__ArrayMap( -- 160
				items, -- 160
				function(____, item) return item.node end -- 160
			) -- 160
		}) -- 160
		root:addChild(background.node) -- 162
	else -- 162
		if autoLayout then -- 162
			local tempi = 0 -- 166
			local lines = 1 -- 166
			do -- 166
				local i = 0 -- 167
				while i < itemnum do -- 167
					local temppos = Vec2((lineInterval + itemwidth / 2) * lines + itemwidth / 2, itemInterval + itemheight / 2 + (itemInterval + itemheight) * (i - tempi)) -- 168
					if temppos.y + itemheight / 2 > height then -- 168
						tempi = i -- 170
						lines = lines + 1 -- 170
						temppos = Vec2((lineInterval + itemwidth / 2) * lines + itemwidth / 2, itemInterval + itemheight / 2 + (itemInterval + itemheight) * (i - tempi)) -- 171
					end -- 171
					items_position[#items_position + 1] = temppos -- 173
					totalwidth = temppos.x + itemwidth / 2 + lineInterval -- 174
					local bt = Button({ -- 175
						x = temppos.x, -- 176
						y = temppos.y, -- 177
						width = itemwidth, -- 178
						height = itemheight, -- 179
						onClick = onClick, -- 180
						onDoubleClick = onDoubleClick, -- 181
						onStateChange = onStateChange, -- 182
						text = __TS__ArrayIsArray(texts) and texts[i + 1] or texts, -- 183
						tag = __TS__ArrayIsArray(tags) and tags[i + 1] or tags, -- 184
						fontName = fontName, -- 185
						fontSize = fontSize, -- 186
						color = __TS__ArrayIsArray(colors) and colors[i + 1] or colors, -- 187
						textWidth = textWidth, -- 188
						alignment = alignment, -- 189
						normalImage = __TS__ArrayIsArray(normalImages) and normalImages[i + 1] or normalImages, -- 190
						pressImage = __TS__ArrayIsArray(pressImages) and pressImages[i + 1] or pressImages -- 191
					}) -- 191
					items[#items + 1] = bt -- 193
					i = i + 1 -- 167
				end -- 167
			end -- 167
		else -- 167
			do -- 167
				local i = 0 -- 196
				while i < itemnum do -- 196
					local temppos = Vec2(itemInterval + itemwidth / 2 + (itemInterval + itemwidth) * i, height / 2) -- 197
					items_position[#items_position + 1] = temppos -- 198
					totalwidth = temppos.x + itemwidth / 2 + itemInterval -- 199
					local bt = Button({ -- 200
						x = temppos.x, -- 201
						y = temppos.y, -- 202
						width = itemwidth, -- 203
						height = itemheight, -- 204
						onClick = onClick, -- 205
						onDoubleClick = onDoubleClick, -- 206
						onStateChange = onStateChange, -- 207
						text = __TS__ArrayIsArray(texts) and texts[i + 1] or texts, -- 208
						tag = __TS__ArrayIsArray(tags) and tags[i + 1] or tags, -- 209
						fontName = fontName, -- 210
						fontSize = fontSize, -- 211
						color = __TS__ArrayIsArray(colors) and colors[i + 1] or colors, -- 212
						textWidth = textWidth, -- 213
						alignment = alignment, -- 214
						normalImage = __TS__ArrayIsArray(normalImages) and normalImages[i + 1] or normalImages, -- 215
						pressImage = __TS__ArrayIsArray(pressImages) and pressImages[i + 1] or pressImages -- 216
					}) -- 216
					items[#items + 1] = bt -- 218
					i = i + 1 -- 196
				end -- 196
			end -- 196
		end -- 196
		local background = ScrollBar({ -- 223
			x = 0, -- 224
			y = 0, -- 225
			width = width, -- 226
			height = height, -- 227
			alignmode = ____exports.AlignMode.Horizontal, -- 228
			backgroundImage = backgroundImage, -- 229
			scrollblockImage = scrollblockImage, -- 230
			scrollbarwidth = scrollbarwidth, -- 231
			totalwidth = totalwidth, -- 232
			nowposition = 0, -- 233
			children = __TS__ArrayMap( -- 234
				items, -- 234
				function(____, item) return item.node end -- 234
			) -- 234
		}) -- 234
		root:addChild(background.node) -- 236
	end -- 236
	local listNode = {node = root} -- 239
	return listNode -- 241
end -- 50
return ____exports -- 50