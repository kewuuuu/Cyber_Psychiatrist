-- [tsx]: Button.tsx
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 1
local Node = ____Dora.Node -- 1
local Sprite = ____Dora.Sprite -- 1
local Label = ____Dora.Label -- 1
local Vec2 = ____Dora.Vec2 -- 1
____exports.Button = function(props) -- 29
	local ____props_0 = props -- 48
	local ____type = ____props_0.type -- 48
	if ____type == nil then -- 48
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
	local root = Node() -- 51
	root.x = x -- 52
	root.y = y -- 53
	root.width = width -- 54
	root.height = height -- 55
	local ____ = root.alignItems -- 55
	local buttonUp = Sprite(normalImage) -- 59
	if buttonUp then -- 59
		buttonUp.position = Vec2(width / 2, height / 2) -- 61
		buttonUp.width = width -- 62
		buttonUp.height = height -- 63
		root:addChild(buttonUp) -- 64
	end -- 64
	local buttonDown = Sprite(pressImage) -- 68
	if buttonDown then -- 68
		buttonDown.position = Vec2(width / 2, height / 2) -- 70
		buttonDown.width = width -- 71
		buttonDown.height = height -- 72
		buttonDown.visible = false -- 73
		root:addChild(buttonDown) -- 74
	end -- 74
	local buttonLabel = Label(fontName, fontSize) -- 78
	if buttonLabel then -- 78
		buttonLabel.text = text -- 80
		buttonLabel.position = Vec2(width / 2, height / 2) -- 81
		buttonLabel.textWidth = textWidth -- 82
		buttonLabel.alignment = alignment -- 83
		root:addChild(buttonLabel) -- 84
	end -- 84
	local state = "normal" -- 88
	local tempchange = false -- 89
	local switched = false -- 90
	local function setState(newState) -- 93
		state = newState -- 94
		if buttonUp and buttonDown then -- 94
			local pressed = state == "pressed" -- 96
			buttonUp.visible = not pressed -- 97
			buttonDown.visible = pressed -- 98
		end -- 98
		onStateChange(newState) -- 100
	end -- 93
	root:onTapBegan(function(touch) -- 104
		if state == "normal" then -- 104
			tempchange = true -- 106
			setState("pressed") -- 107
			return true -- 108
		end -- 108
		return false -- 110
	end) -- 104
	root:onTapEnded(function() -- 113
		if tempchange then -- 113
			setState("normal") -- 115
			tempchange = false -- 116
		end -- 116
	end) -- 113
	root:onTapped(function() -- 120
		if ____type == "click" then -- 120
			setState("normal") -- 122
		else -- 122
			switched = not switched -- 124
			setState(switched and "pressed" or "normal") -- 125
		end -- 125
		print("switched:", switched) -- 127
		print("tag:", tag) -- 128
		onClick(switched, tag) -- 129
		return true -- 130
	end) -- 120
	return root -- 133
end -- 29
return ____exports -- 29