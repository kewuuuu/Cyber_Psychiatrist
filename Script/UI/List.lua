-- [tsx]: List.tsx
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 3
local Node = ____Dora.Node -- 3
local Label = ____Dora.Label -- 3
local ____Button = require("Button") -- 4
local Button = ____Button.Button -- 4
local ____ScrollBar = require("ScrollBar") -- 5
local ScrollBar = ____ScrollBar.ScrollBar -- 5
____exports.AlignMode = AlignMode or ({}) -- 7
____exports.AlignMode.Horizontal = "horizontal" -- 8
____exports.AlignMode.Vertical = "vertical" -- 9
____exports.List = function(props) -- 45
	local ____props_0 = props -- 73
	local x = ____props_0.x -- 73
	if x == nil then -- 73
		x = 0 -- 47
	end -- 47
	local y = ____props_0.y -- 47
	if y == nil then -- 47
		y = 0 -- 48
	end -- 48
	local width = ____props_0.width -- 48
	if width == nil then -- 48
		width = 200 -- 49
	end -- 49
	local height = ____props_0.height -- 49
	if height == nil then -- 49
		height = 100 -- 50
	end -- 50
	local itemInterval = ____props_0.itemInterval -- 50
	if itemInterval == nil then -- 50
		itemInterval = 10 -- 51
	end -- 51
	local alignmode = ____props_0.alignmode -- 51
	if alignmode == nil then -- 51
		alignmode = ____exports.AlignMode.Vertical -- 52
	end -- 52
	local autoLayout = ____props_0.autoLayout -- 52
	if autoLayout == nil then -- 52
		autoLayout = false -- 53
	end -- 53
	local itemwidth = ____props_0.itemwidth -- 53
	if itemwidth == nil then -- 53
		itemwidth = 200 -- 54
	end -- 54
	local itemheight = ____props_0.itemheight -- 54
	if itemheight == nil then -- 54
		itemheight = 100 -- 55
	end -- 55
	local itemnum = ____props_0.itemnum -- 55
	if itemnum == nil then -- 55
		itemnum = 0 -- 56
	end -- 56
	local onClick = ____props_0.onClick -- 56
	if onClick == nil then -- 56
		onClick = function() -- 57
		end -- 57
	end -- 57
	local onDoubleClick = ____props_0.onDoubleClick -- 57
	if onDoubleClick == nil then -- 57
		onDoubleClick = function() -- 58
		end -- 58
	end -- 58
	local onStateChange = ____props_0.onStateChange -- 58
	if onStateChange == nil then -- 58
		onStateChange = function() -- 59
		end -- 59
	end -- 59
	local normalImages = ____props_0.normalImages -- 59
	if normalImages == nil then -- 59
		normalImages = "Image/button/button.clip|button_up" -- 60
	end -- 60
	local pressImages = ____props_0.pressImages -- 60
	if pressImages == nil then -- 60
		pressImages = "Image/button/button.clip|button_down" -- 61
	end -- 61
	local texts = ____props_0.texts -- 61
	if texts == nil then -- 61
		texts = "" -- 62
	end -- 62
	local fontName = ____props_0.fontName -- 62
	if fontName == nil then -- 62
		fontName = "sarasa-mono-sc-regular" -- 63
	end -- 63
	local fontSize = ____props_0.fontSize -- 63
	if fontSize == nil then -- 63
		fontSize = 20 -- 64
	end -- 64
	local colors = ____props_0.colors -- 64
	if colors == nil then -- 64
		colors = 16777215 -- 65
	end -- 65
	local textWidth = ____props_0.textWidth -- 65
	if textWidth == nil then -- 65
		textWidth = Label.AutomaticWidth -- 66
	end -- 66
	local alignment = ____props_0.alignment -- 66
	if alignment == nil then -- 66
		alignment = "Center" -- 67
	end -- 67
	local textisdeleted = ____props_0.textisdeleted -- 67
	if textisdeleted == nil then -- 67
		textisdeleted = false -- 68
	end -- 68
	local tags = ____props_0.tags -- 68
	if tags == nil then -- 68
		tags = nil -- 69
	end -- 69
	local backgroundImage = ____props_0.backgroundImage -- 69
	if backgroundImage == nil then -- 69
		backgroundImage = "Image/background/background.png" -- 70
	end -- 70
	local scrollblockImage = ____props_0.scrollblockImage -- 70
	if scrollblockImage == nil then -- 70
		scrollblockImage = "Image/button/button.png" -- 71
	end -- 71
	local scrollbarwidth = ____props_0.scrollbarwidth -- 71
	if scrollbarwidth == nil then -- 71
		scrollbarwidth = 10 -- 72
	end -- 72
	local root = Node() -- 75
	root.x = x -- 76
	root.y = y -- 77
	local buttonpositions = {} -- 78
	if ____ then -- 78
		local items = {} -- 80
	end -- 80
	do -- 80
		local i = 0 -- 84
		while i < itemnum do -- 84
			local ____Button_result_1 = Button({ -- 85
				x = label_x[i], -- 86
				y = 0, -- 87
				width = file_label_size.width, -- 88
				height = file_label_size.height, -- 89
				onClick = loadSaveFile, -- 90
				text = saveSummaryToString(saveSummaries[i]), -- 91
				tag = tostring(i), -- 92
				fontSize = 30, -- 93
				textWidth = file_label_size.width -- 94
			}) -- 94
			local bt = ____Button_result_1.root -- 94
			local st = ____Button_result_1.setText -- 94
			saveSlots.push({bt = bt, st = st}) -- 96
			root:addChild(saveSlots[i].bt or Node()) -- 97
			i = i + 1 -- 84
		end -- 84
	end -- 84
	if alignmode == ____exports.AlignMode.Horizontal and autoLayout or alignmode == ____exports.AlignMode.Vertical and not autoLayout then -- 84
		local background = ScrollBar({ -- 102
			x = x, -- 103
			y = y, -- 104
			width = width, -- 105
			height = height, -- 106
			alignmode = alignmode, -- 107
			backgroundImage = backgroundImage, -- 108
			scrollblockImage = scrollblockImage, -- 109
			scrollbarwidth = scrollbarwidth, -- 110
			totalwidth = totalwidth, -- 111
			nowposition = nowposition, -- 112
			children = children -- 113
		}) -- 113
	else -- 113
	end -- 113
	return root -- 126
end -- 45
return ____exports -- 45