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
____exports.ButtonState = ButtonState or ({}) -- 9
____exports.ButtonState.Normal = "normal" -- 10
____exports.ButtonState.Hover = "hover" -- 11
____exports.ButtonState.Pressed = "pressed" -- 12
____exports.ButtonType = ButtonType or ({}) -- 16
____exports.ButtonType.Click = "click" -- 17
____exports.ButtonType.Toggle = "toggle" -- 18
____exports.Button = function(props) -- 42
	local ____props_0 = props -- 63
	local ____type = ____props_0.type -- 63
	if ____type == nil then -- 63
		____type = ____exports.ButtonType.Click -- 45
	end -- 45
	local x = ____props_0.x -- 45
	if x == nil then -- 45
		x = 0 -- 46
	end -- 46
	local y = ____props_0.y -- 46
	if y == nil then -- 46
		y = 0 -- 47
	end -- 47
	local width = ____props_0.width -- 47
	if width == nil then -- 47
		width = 200 -- 48
	end -- 48
	local height = ____props_0.height -- 48
	if height == nil then -- 48
		height = 100 -- 49
	end -- 49
	local onClick = ____props_0.onClick -- 49
	if onClick == nil then -- 49
		onClick = function() -- 50
		end -- 50
	end -- 50
	local onDoubleClick = ____props_0.onDoubleClick -- 50
	if onDoubleClick == nil then -- 50
		onDoubleClick = function() -- 51
		end -- 51
	end -- 51
	local onStateChange = ____props_0.onStateChange -- 51
	if onStateChange == nil then -- 51
		onStateChange = function() -- 52
		end -- 52
	end -- 52
	local normalImage = ____props_0.normalImage -- 52
	if normalImage == nil then -- 52
		normalImage = "Image/button/button.clip|button_up" -- 53
	end -- 53
	local pressImage = ____props_0.pressImage -- 53
	if pressImage == nil then -- 53
		pressImage = "Image/button/button.clip|button_down" -- 54
	end -- 54
	local text = ____props_0.text -- 54
	if text == nil then -- 54
		text = "" -- 55
	end -- 55
	local fontName = ____props_0.fontName -- 55
	if fontName == nil then -- 55
		fontName = "sarasa-mono-sc-regular" -- 56
	end -- 56
	local fontSize = ____props_0.fontSize -- 56
	if fontSize == nil then -- 56
		fontSize = 40 -- 57
	end -- 57
	local color = ____props_0.color -- 57
	if color == nil then -- 57
		color = Color(4294967295) -- 58
	end -- 58
	local textWidth = ____props_0.textWidth -- 58
	if textWidth == nil then -- 58
		textWidth = Label.AutomaticWidth -- 59
	end -- 59
	local alignment = ____props_0.alignment -- 59
	if alignment == nil then -- 59
		alignment = "Center" -- 60
	end -- 60
	local tag = ____props_0.tag -- 60
	if tag == nil then -- 60
		tag = nil -- 61
	end -- 61
	local root = Node() -- 66
	root.x = x -- 67
	root.y = y -- 68
	local buttonUp = Sprite(normalImage) -- 71
	if buttonUp then -- 71
		buttonUp.position = Vec2(0, 0) -- 73
		buttonUp.width = width -- 74
		buttonUp.height = height -- 75
		root:addChild(buttonUp) -- 76
	end -- 76
	local buttonDown = Sprite(pressImage) -- 80
	if buttonDown then -- 80
		buttonDown.position = Vec2(0, 0) -- 82
		buttonDown.width = width -- 83
		buttonDown.height = height -- 84
		buttonDown.visible = false -- 85
		root:addChild(buttonDown) -- 86
	end -- 86
	local buttonLabel = Label(fontName, fontSize) -- 90
	if buttonLabel then -- 90
		buttonLabel.text = text -- 92
		buttonLabel.position = Vec2(0, 0) -- 93
		buttonLabel.textWidth = textWidth -- 94
		buttonLabel.alignment = alignment -- 95
		buttonLabel.color = color -- 96
		root:addChild(buttonLabel) -- 97
	end -- 97
	local clickNode = Node() -- 100
	clickNode.width = width -- 101
	clickNode.height = height -- 102
	root:addChild(clickNode) -- 103
	local state = ____exports.ButtonState.Normal -- 106
	local tempchange = false -- 107
	local switched = false -- 108
	local visible = true -- 109
	local doubleClick = false -- 110
	local function setState(newState) -- 113
		state = newState -- 114
		if buttonUp and buttonDown then -- 114
			local pressed = state == ____exports.ButtonState.Pressed -- 116
			buttonUp.visible = not pressed -- 117
			buttonDown.visible = pressed -- 118
		end -- 118
		onStateChange(newState) -- 120
	end -- 113
	clickNode:onTapBegan(function(touch) -- 124
		if state == ____exports.ButtonState.Normal then -- 124
			tempchange = true -- 126
			setState(____exports.ButtonState.Pressed) -- 127
			return true -- 128
		end -- 128
		return false -- 130
	end) -- 124
	clickNode:onTapEnded(function() -- 133
		if tempchange then -- 133
			setState(____exports.ButtonState.Normal) -- 135
			tempchange = false -- 136
		end -- 136
	end) -- 133
	clickNode:onTapped(function() -- 140
		if ____type == ____exports.ButtonType.Click then -- 140
			setState(____exports.ButtonState.Normal) -- 142
			thread(function() -- 143
				sleep(0.3) -- 144
				if doubleClick then -- 144
					doubleClick = false -- 146
					onClick(switched, tag) -- 147
				end -- 147
			end) -- 143
			if doubleClick then -- 143
				doubleClick = false -- 152
				onDoubleClick(tag) -- 153
			else -- 153
				doubleClick = true -- 156
			end -- 156
		else -- 156
			switched = not switched -- 159
			setState(switched and ____exports.ButtonState.Pressed or ____exports.ButtonState.Normal) -- 160
			onClick(switched, tag) -- 161
		end -- 161
		return true -- 164
	end) -- 140
	local function setVisible(tempvisible) -- 167
		visible = tempvisible -- 168
		if buttonDown and buttonUp and buttonLabel then -- 168
			if visible then -- 168
				local pressed = state == ____exports.ButtonState.Pressed -- 171
				buttonUp.visible = not pressed -- 172
				buttonDown.visible = pressed -- 173
				buttonLabel.visible = true -- 174
				root:addChild(clickNode) -- 175
			else -- 175
				buttonUp.visible = false -- 177
				buttonDown.visible = false -- 178
				buttonLabel.visible = false -- 179
				clickNode:removeFromParent(false) -- 180
			end -- 180
		end -- 180
	end -- 167
	local function setText(temptext) -- 184
		if buttonLabel then -- 184
			print(temptext) -- 186
			buttonLabel.text = temptext -- 187
		end -- 187
	end -- 184
	local buttonNode = {node = root, setText = setText} -- 191
	return buttonNode -- 192
end -- 42
return ____exports -- 42