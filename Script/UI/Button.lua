-- [tsx]: Button.tsx
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 1
local Node = ____Dora.Node -- 1
local Sprite = ____Dora.Sprite -- 1
local Label = ____Dora.Label -- 1
local Vec2 = ____Dora.Vec2 -- 1
local thread = ____Dora.thread -- 1
local sleep = ____Dora.sleep -- 1
____exports.Button = function(props) -- 30
	local ____props_0 = props -- 51
	local ____type = ____props_0.type -- 51
	if ____type == nil then -- 51
		____type = "click" -- 33
	end -- 33
	local x = ____props_0.x -- 33
	if x == nil then -- 33
		x = 0 -- 34
	end -- 34
	local y = ____props_0.y -- 34
	if y == nil then -- 34
		y = 0 -- 35
	end -- 35
	local width = ____props_0.width -- 35
	if width == nil then -- 35
		width = 200 -- 36
	end -- 36
	local height = ____props_0.height -- 36
	if height == nil then -- 36
		height = 100 -- 37
	end -- 37
	local onClick = ____props_0.onClick -- 37
	if onClick == nil then -- 37
		onClick = function() -- 38
		end -- 38
	end -- 38
	local onDoubleClick = ____props_0.onDoubleClick -- 38
	if onDoubleClick == nil then -- 38
		onDoubleClick = function() -- 39
		end -- 39
	end -- 39
	local onStateChange = ____props_0.onStateChange -- 39
	if onStateChange == nil then -- 39
		onStateChange = function() -- 40
		end -- 40
	end -- 40
	local normalImage = ____props_0.normalImage -- 40
	if normalImage == nil then -- 40
		normalImage = "Image/button/button.clip|button_up" -- 41
	end -- 41
	local pressImage = ____props_0.pressImage -- 41
	if pressImage == nil then -- 41
		pressImage = "Image/button/button.clip|button_down" -- 42
	end -- 42
	local text = ____props_0.text -- 42
	if text == nil then -- 42
		text = "" -- 43
	end -- 43
	local fontName = ____props_0.fontName -- 43
	if fontName == nil then -- 43
		fontName = "sarasa-mono-sc-regular" -- 44
	end -- 44
	local fontSize = ____props_0.fontSize -- 44
	if fontSize == nil then -- 44
		fontSize = 40 -- 45
	end -- 45
	local color = ____props_0.color -- 45
	if color == nil then -- 45
		color = 16777215 -- 46
	end -- 46
	local textWidth = ____props_0.textWidth -- 46
	if textWidth == nil then -- 46
		textWidth = Label.AutomaticWidth -- 47
	end -- 47
	local alignment = ____props_0.alignment -- 47
	if alignment == nil then -- 47
		alignment = "Center" -- 48
	end -- 48
	local tag = ____props_0.tag -- 48
	if tag == nil then -- 48
		tag = nil -- 49
	end -- 49
	local root = Node() -- 54
	root.x = x -- 55
	root.y = y -- 56
	local buttonUp = Sprite(normalImage) -- 59
	if buttonUp then -- 59
		buttonUp.position = Vec2(0, 0) -- 61
		buttonUp.width = width -- 62
		buttonUp.height = height -- 63
		root:addChild(buttonUp) -- 64
	end -- 64
	local buttonDown = Sprite(pressImage) -- 68
	if buttonDown then -- 68
		buttonDown.position = Vec2(0, 0) -- 70
		buttonDown.width = width -- 71
		buttonDown.height = height -- 72
		buttonDown.visible = false -- 73
		root:addChild(buttonDown) -- 74
	end -- 74
	local buttonLabel = Label(fontName, fontSize) -- 78
	if buttonLabel then -- 78
		buttonLabel.text = text -- 80
		buttonLabel.position = Vec2(0, 0) -- 81
		buttonLabel.textWidth = textWidth -- 82
		buttonLabel.alignment = alignment -- 83
		root:addChild(buttonLabel) -- 84
	end -- 84
	local clickNode = Node() -- 87
	clickNode.width = width -- 88
	clickNode.height = height -- 89
	root:addChild(clickNode) -- 90
	local state = "normal" -- 93
	local tempchange = false -- 94
	local switched = false -- 95
	local visible = true -- 96
	local doubleClick = false -- 97
	local function setState(newState) -- 100
		state = newState -- 101
		if buttonUp and buttonDown then -- 101
			local pressed = state == "pressed" -- 103
			buttonUp.visible = not pressed -- 104
			buttonDown.visible = pressed -- 105
		end -- 105
		onStateChange(newState) -- 107
	end -- 100
	clickNode:onTapBegan(function(touch) -- 111
		if state == "normal" then -- 111
			tempchange = true -- 113
			setState("pressed") -- 114
			return true -- 115
		end -- 115
		return false -- 117
	end) -- 111
	clickNode:onTapEnded(function() -- 120
		if tempchange then -- 120
			setState("normal") -- 122
			tempchange = false -- 123
		end -- 123
	end) -- 120
	clickNode:onTapped(function() -- 127
		if ____type == "click" then -- 127
			setState("normal") -- 129
			thread(function() -- 130
				sleep(0.3) -- 131
				if doubleClick then -- 131
					doubleClick = false -- 133
					onClick(switched, tag) -- 134
				end -- 134
			end) -- 130
			if doubleClick then -- 130
				doubleClick = false -- 139
				onDoubleClick(tag) -- 140
			else -- 140
				doubleClick = true -- 143
			end -- 143
		else -- 143
			switched = not switched -- 146
			setState(switched and "pressed" or "normal") -- 147
			onClick(switched, tag) -- 148
		end -- 148
		return true -- 151
	end) -- 127
	local function setVisible(tempvisible) -- 154
		visible = tempvisible -- 155
		if buttonDown and buttonUp and buttonLabel then -- 155
			if visible then -- 155
				local pressed = state == "pressed" -- 158
				buttonUp.visible = not pressed -- 159
				buttonDown.visible = pressed -- 160
				buttonLabel.visible = true -- 161
				root:addChild(clickNode) -- 162
			else -- 162
				buttonUp.visible = false -- 164
				buttonDown.visible = false -- 165
				buttonLabel.visible = false -- 166
				clickNode:removeFromParent(false) -- 167
			end -- 167
		end -- 167
	end -- 154
	local function setText(temptext) -- 171
		if buttonLabel then -- 171
			print(temptext) -- 173
			buttonLabel.text = temptext -- 174
		end -- 174
	end -- 171
	return {root = root, setText = setText} -- 178
end -- 30
return ____exports -- 30