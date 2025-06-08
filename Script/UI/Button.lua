-- [tsx]: Button.tsx
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 1
local Node = ____Dora.Node -- 1
local Sprite = ____Dora.Sprite -- 1
local Label = ____Dora.Label -- 1
local Vec2 = ____Dora.Vec2 -- 1
local thread = ____Dora.thread -- 1
local sleep = ____Dora.sleep -- 1
local Color = ____Dora.Color -- 1
____exports.ButtonState = ButtonState or ({}) -- 4
____exports.ButtonState.Normal = "normal" -- 5
____exports.ButtonState.Hover = "hover" -- 6
____exports.ButtonState.Pressed = "pressed" -- 7
____exports.ButtonType = ButtonType or ({}) -- 11
____exports.ButtonType.Click = "click" -- 12
____exports.ButtonType.Toggle = "toggle" -- 13
____exports.Button = function(props) -- 37
	local ____props_0 = props -- 58
	local ____type = ____props_0.type -- 58
	if ____type == nil then -- 58
		____type = ____exports.ButtonType.Click -- 40
	end -- 40
	local x = ____props_0.x -- 40
	if x == nil then -- 40
		x = 0 -- 41
	end -- 41
	local y = ____props_0.y -- 41
	if y == nil then -- 41
		y = 0 -- 42
	end -- 42
	local width = ____props_0.width -- 42
	if width == nil then -- 42
		width = 200 -- 43
	end -- 43
	local height = ____props_0.height -- 43
	if height == nil then -- 43
		height = 100 -- 44
	end -- 44
	local onClick = ____props_0.onClick -- 44
	if onClick == nil then -- 44
		onClick = function() -- 45
		end -- 45
	end -- 45
	local onDoubleClick = ____props_0.onDoubleClick -- 45
	if onDoubleClick == nil then -- 45
		onDoubleClick = function() -- 46
		end -- 46
	end -- 46
	local onStateChange = ____props_0.onStateChange -- 46
	if onStateChange == nil then -- 46
		onStateChange = function() -- 47
		end -- 47
	end -- 47
	local normalImage = ____props_0.normalImage -- 47
	if normalImage == nil then -- 47
		normalImage = "Image/button/button.clip|button_up" -- 48
	end -- 48
	local pressImage = ____props_0.pressImage -- 48
	if pressImage == nil then -- 48
		pressImage = "Image/button/button.clip|button_down" -- 49
	end -- 49
	local text = ____props_0.text -- 49
	if text == nil then -- 49
		text = "" -- 50
	end -- 50
	local fontName = ____props_0.fontName -- 50
	if fontName == nil then -- 50
		fontName = "sarasa-mono-sc-regular" -- 51
	end -- 51
	local fontSize = ____props_0.fontSize -- 51
	if fontSize == nil then -- 51
		fontSize = 40 -- 52
	end -- 52
	local color = ____props_0.color -- 52
	if color == nil then -- 52
		color = Color(16777215) -- 53
	end -- 53
	local textWidth = ____props_0.textWidth -- 53
	if textWidth == nil then -- 53
		textWidth = Label.AutomaticWidth -- 54
	end -- 54
	local alignment = ____props_0.alignment -- 54
	if alignment == nil then -- 54
		alignment = "Center" -- 55
	end -- 55
	local tag = ____props_0.tag -- 55
	if tag == nil then -- 55
		tag = nil -- 56
	end -- 56
	local root = Node() -- 61
	root.x = x -- 62
	root.y = y -- 63
	local buttonUp = Sprite(normalImage) -- 66
	if buttonUp then -- 66
		buttonUp.position = Vec2(0, 0) -- 68
		buttonUp.width = width -- 69
		buttonUp.height = height -- 70
		root:addChild(buttonUp) -- 71
	end -- 71
	local buttonDown = Sprite(pressImage) -- 75
	if buttonDown then -- 75
		buttonDown.position = Vec2(0, 0) -- 77
		buttonDown.width = width -- 78
		buttonDown.height = height -- 79
		buttonDown.visible = false -- 80
		root:addChild(buttonDown) -- 81
	end -- 81
	local buttonLabel = Label(fontName, fontSize) -- 85
	if buttonLabel then -- 85
		buttonLabel.text = text -- 87
		buttonLabel.position = Vec2(0, 0) -- 88
		buttonLabel.textWidth = textWidth -- 89
		buttonLabel.alignment = alignment -- 90
		buttonLabel.color = color -- 91
		root:addChild(buttonLabel) -- 92
	end -- 92
	local clickNode = Node() -- 95
	clickNode.width = width -- 96
	clickNode.height = height -- 97
	root:addChild(clickNode) -- 98
	local state = ____exports.ButtonState.Normal -- 101
	local tempchange = false -- 102
	local switched = false -- 103
	local visible = true -- 104
	local doubleClick = false -- 105
	local function setState(newState) -- 108
		state = newState -- 109
		if buttonUp and buttonDown then -- 109
			local pressed = state == ____exports.ButtonState.Pressed -- 111
			buttonUp.visible = not pressed -- 112
			buttonDown.visible = pressed -- 113
		end -- 113
		onStateChange(newState) -- 115
	end -- 108
	clickNode:onTapBegan(function(touch) -- 119
		if state == ____exports.ButtonState.Normal then -- 119
			tempchange = true -- 121
			setState(____exports.ButtonState.Pressed) -- 122
			return true -- 123
		end -- 123
		return false -- 125
	end) -- 119
	clickNode:onTapEnded(function() -- 128
		if tempchange then -- 128
			setState(____exports.ButtonState.Normal) -- 130
			tempchange = false -- 131
		end -- 131
	end) -- 128
	clickNode:onTapped(function() -- 135
		if ____type == ____exports.ButtonType.Click then -- 135
			setState(____exports.ButtonState.Normal) -- 137
			thread(function() -- 138
				sleep(0.3) -- 139
				if doubleClick then -- 139
					doubleClick = false -- 141
					onClick(switched, tag) -- 142
				end -- 142
			end) -- 138
			if doubleClick then -- 138
				doubleClick = false -- 147
				onDoubleClick(tag) -- 148
			else -- 148
				doubleClick = true -- 151
			end -- 151
		else -- 151
			switched = not switched -- 154
			setState(switched and ____exports.ButtonState.Pressed or ____exports.ButtonState.Normal) -- 155
			onClick(switched, tag) -- 156
		end -- 156
		return true -- 159
	end) -- 135
	local function setVisible(tempvisible) -- 162
		visible = tempvisible -- 163
		if buttonDown and buttonUp and buttonLabel then -- 163
			if visible then -- 163
				local pressed = state == ____exports.ButtonState.Pressed -- 166
				buttonUp.visible = not pressed -- 167
				buttonDown.visible = pressed -- 168
				buttonLabel.visible = true -- 169
				root:addChild(clickNode) -- 170
			else -- 170
				buttonUp.visible = false -- 172
				buttonDown.visible = false -- 173
				buttonLabel.visible = false -- 174
				clickNode:removeFromParent(false) -- 175
			end -- 175
		end -- 175
	end -- 162
	local function setText(temptext) -- 179
		if buttonLabel then -- 179
			print(temptext) -- 181
			buttonLabel.text = temptext -- 182
		end -- 182
	end -- 179
	return {root = root, setText = setText} -- 186
end -- 37
return ____exports -- 37