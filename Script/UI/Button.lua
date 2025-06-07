-- [tsx]: Button.tsx
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 1
local Node = ____Dora.Node -- 1
local Sprite = ____Dora.Sprite -- 1
local Label = ____Dora.Label -- 1
local Vec2 = ____Dora.Vec2 -- 1
____exports.Button = function(props) -- 29
	local ____props_0 = props -- 49
	local ____type = ____props_0.type -- 49
	if ____type == nil then -- 49
		____type = "click" -- 32
	end -- 32
	local x = ____props_0.x -- 32
	if x == nil then -- 32
		x = 0 -- 33
	end -- 33
	local y = ____props_0.y -- 33
	if y == nil then -- 33
		y = 0 -- 34
	end -- 34
	local width = ____props_0.width -- 34
	if width == nil then -- 34
		width = 200 -- 35
	end -- 35
	local height = ____props_0.height -- 35
	if height == nil then -- 35
		height = 100 -- 36
	end -- 36
	local onClick = ____props_0.onClick -- 36
	if onClick == nil then -- 36
		onClick = function() -- 37
		end -- 37
	end -- 37
	local onStateChange = ____props_0.onStateChange -- 37
	if onStateChange == nil then -- 37
		onStateChange = function() -- 38
		end -- 38
	end -- 38
	local normalImage = ____props_0.normalImage -- 38
	if normalImage == nil then -- 38
		normalImage = "Image/button/button.clip|button_up" -- 39
	end -- 39
	local pressImage = ____props_0.pressImage -- 39
	if pressImage == nil then -- 39
		pressImage = "Image/button/button.clip|button_down" -- 40
	end -- 40
	local text = ____props_0.text -- 40
	if text == nil then -- 40
		text = "" -- 41
	end -- 41
	local fontName = ____props_0.fontName -- 41
	if fontName == nil then -- 41
		fontName = "sarasa-mono-sc-regular" -- 42
	end -- 42
	local fontSize = ____props_0.fontSize -- 42
	if fontSize == nil then -- 42
		fontSize = 40 -- 43
	end -- 43
	local color = ____props_0.color -- 43
	if color == nil then -- 43
		color = 16777215 -- 44
	end -- 44
	local textWidth = ____props_0.textWidth -- 44
	if textWidth == nil then -- 44
		textWidth = Label.AutomaticWidth -- 45
	end -- 45
	local alignment = ____props_0.alignment -- 45
	if alignment == nil then -- 45
		alignment = "Center" -- 46
	end -- 46
	local tag = ____props_0.tag -- 46
	if tag == nil then -- 46
		tag = nil -- 47
	end -- 47
	local root = Node() -- 52
	root.x = x -- 53
	root.y = y -- 54
	local buttonUp = Sprite(normalImage) -- 57
	if buttonUp then -- 57
		buttonUp.position = Vec2(0, 0) -- 59
		buttonUp.width = width -- 60
		buttonUp.height = height -- 61
		root:addChild(buttonUp) -- 62
	end -- 62
	local buttonDown = Sprite(pressImage) -- 66
	if buttonDown then -- 66
		buttonDown.position = Vec2(0, 0) -- 68
		buttonDown.width = width -- 69
		buttonDown.height = height -- 70
		buttonDown.visible = false -- 71
		root:addChild(buttonDown) -- 72
	end -- 72
	local buttonLabel = Label(fontName, fontSize) -- 76
	if buttonLabel then -- 76
		buttonLabel.text = text -- 78
		buttonLabel.position = Vec2(0, 0) -- 79
		buttonLabel.textWidth = textWidth -- 80
		buttonLabel.alignment = alignment -- 81
		root:addChild(buttonLabel) -- 82
	end -- 82
	local clickNode = Node() -- 85
	clickNode.width = width -- 86
	clickNode.height = height -- 87
	root:addChild(clickNode) -- 88
	local state = "normal" -- 91
	local tempchange = false -- 92
	local switched = false -- 93
	local visible = true -- 94
	local function setState(newState) -- 97
		state = newState -- 98
		if buttonUp and buttonDown then -- 98
			local pressed = state == "pressed" -- 100
			buttonUp.visible = not pressed -- 101
			buttonDown.visible = pressed -- 102
		end -- 102
		onStateChange(newState) -- 104
	end -- 97
	clickNode:onTapBegan(function(touch) -- 108
		if state == "normal" then -- 108
			tempchange = true -- 110
			setState("pressed") -- 111
			return true -- 112
		end -- 112
		return false -- 114
	end) -- 108
	clickNode:onTapEnded(function() -- 117
		if tempchange then -- 117
			setState("normal") -- 119
			tempchange = false -- 120
		end -- 120
	end) -- 117
	clickNode:onTapped(function() -- 124
		if ____type == "click" then -- 124
			setState("normal") -- 126
		else -- 126
			switched = not switched -- 128
			setState(switched and "pressed" or "normal") -- 129
		end -- 129
		onClick(switched, tag) -- 131
		return true -- 132
	end) -- 124
	local function setVisible(tempvisible) -- 135
		visible = tempvisible -- 136
		if buttonDown and buttonUp and buttonLabel then -- 136
			if visible then -- 136
				local pressed = state == "pressed" -- 139
				buttonUp.visible = not pressed -- 140
				buttonDown.visible = pressed -- 141
				buttonLabel.visible = true -- 142
				root:addChild(clickNode) -- 143
			else -- 143
				buttonUp.visible = false -- 145
				buttonDown.visible = false -- 146
				buttonLabel.visible = false -- 147
				clickNode:removeFromParent(false) -- 148
			end -- 148
		end -- 148
	end -- 135
	local function setText(temptext) -- 152
		if buttonLabel then -- 152
			print(temptext) -- 154
			buttonLabel.text = temptext -- 155
		end -- 155
	end -- 152
	return {root = root, setText = setText} -- 159
end -- 29
return ____exports -- 29