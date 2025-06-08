-- [tsx]: List.tsx
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 3
local Node = ____Dora.Node -- 3
local Sprite = ____Dora.Sprite -- 3
local Label = ____Dora.Label -- 3
local Size = ____Dora.Size -- 3
local ClipNode = ____Dora.ClipNode -- 3
local ____Button = require("Button") -- 4
local Button = ____Button.Button -- 4
____exports.AlignMode = AlignMode or ({}) -- 6
____exports.AlignMode.Horizontal = "horizontal" -- 7
____exports.AlignMode.Vertical = "vertical" -- 8
____exports.List = function(props) -- 43
	local ____props_0 = props -- 70
	local x = ____props_0.x -- 70
	if x == nil then -- 70
		x = 0 -- 45
	end -- 45
	local y = ____props_0.y -- 45
	if y == nil then -- 45
		y = 0 -- 46
	end -- 46
	local width = ____props_0.width -- 46
	if width == nil then -- 46
		width = 200 -- 47
	end -- 47
	local height = ____props_0.height -- 47
	if height == nil then -- 47
		height = 100 -- 48
	end -- 48
	local itemInterval = ____props_0.itemInterval -- 48
	if itemInterval == nil then -- 48
		itemInterval = 10 -- 49
	end -- 49
	local alignmode = ____props_0.alignmode -- 49
	if alignmode == nil then -- 49
		alignmode = ____exports.AlignMode.Vertical -- 50
	end -- 50
	local autoLayout = ____props_0.autoLayout -- 50
	if autoLayout == nil then -- 50
		autoLayout = false -- 51
	end -- 51
	local itemwidth = ____props_0.itemwidth -- 51
	if itemwidth == nil then -- 51
		itemwidth = 200 -- 52
	end -- 52
	local itemheight = ____props_0.itemheight -- 52
	if itemheight == nil then -- 52
		itemheight = 100 -- 53
	end -- 53
	local itemnum = ____props_0.itemnum -- 53
	if itemnum == nil then -- 53
		itemnum = 0 -- 54
	end -- 54
	local onClick = ____props_0.onClick -- 54
	if onClick == nil then -- 54
		onClick = function() -- 55
		end -- 55
	end -- 55
	local onDoubleClick = ____props_0.onDoubleClick -- 55
	if onDoubleClick == nil then -- 55
		onDoubleClick = function() -- 56
		end -- 56
	end -- 56
	local onStateChange = ____props_0.onStateChange -- 56
	if onStateChange == nil then -- 56
		onStateChange = function() -- 57
		end -- 57
	end -- 57
	local normalImages = ____props_0.normalImages -- 57
	if normalImages == nil then -- 57
		normalImages = "Image/button/button.clip|button_up" -- 58
	end -- 58
	local pressImages = ____props_0.pressImages -- 58
	if pressImages == nil then -- 58
		pressImages = "Image/button/button.clip|button_down" -- 59
	end -- 59
	local texts = ____props_0.texts -- 59
	if texts == nil then -- 59
		texts = "" -- 60
	end -- 60
	local fontName = ____props_0.fontName -- 60
	if fontName == nil then -- 60
		fontName = "sarasa-mono-sc-regular" -- 61
	end -- 61
	local fontSize = ____props_0.fontSize -- 61
	if fontSize == nil then -- 61
		fontSize = 20 -- 62
	end -- 62
	local colors = ____props_0.colors -- 62
	if colors == nil then -- 62
		colors = 16777215 -- 63
	end -- 63
	local textWidth = ____props_0.textWidth -- 63
	if textWidth == nil then -- 63
		textWidth = Label.AutomaticWidth -- 64
	end -- 64
	local alignment = ____props_0.alignment -- 64
	if alignment == nil then -- 64
		alignment = "Center" -- 65
	end -- 65
	local textisdeleted = ____props_0.textisdeleted -- 65
	if textisdeleted == nil then -- 65
		textisdeleted = false -- 66
	end -- 66
	local tags = ____props_0.tags -- 66
	if tags == nil then -- 66
		tags = nil -- 67
	end -- 67
	local backgroundImage = ____props_0.backgroundImage -- 67
	if backgroundImage == nil then -- 67
		backgroundImage = "Image/background/background.png" -- 68
	end -- 68
	local scrollbarwidth = ____props_0.scrollbarwidth -- 68
	if scrollbarwidth == nil then -- 68
		scrollbarwidth = 10 -- 69
	end -- 69
	local root = Node() -- 72
	root.x = x -- 73
	root.y = y -- 74
	local background = Sprite(backgroundImage) -- 75
	if background then -- 75
		background.size = Size(width, height) -- 77
	end -- 77
	local clipnode = ClipNode(background or Node()) -- 79
	root:addChild(clipnode) -- 80
	if background then -- 80
		clipnode:addChild(background) -- 82
	end -- 82
	local buttonpositions = {} -- 84
	if ____ then -- 84
		local items = {} -- 87
	end -- 87
	do -- 87
		local i = 0 -- 91
		while i < itemnum do -- 91
			local ____Button_result_1 = Button({ -- 92
				x = label_x[i], -- 93
				y = 0, -- 94
				width = file_label_size.width, -- 95
				height = file_label_size.height, -- 96
				onClick = loadSaveFile, -- 97
				text = saveSummaryToString(saveSummaries[i]), -- 98
				tag = tostring(i), -- 99
				fontSize = 30, -- 100
				textWidth = file_label_size.width -- 101
			}) -- 101
			local bt = ____Button_result_1.root -- 101
			local st = ____Button_result_1.setText -- 101
			saveSlots.push({bt = bt, st = st}) -- 103
			root:addChild(saveSlots[i].bt or Node()) -- 104
			i = i + 1 -- 91
		end -- 91
	end -- 91
	return root -- 109
end -- 43
return ____exports -- 43