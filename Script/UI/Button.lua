-- [tsx]: Button.tsx
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 1
local Node = ____Dora.Node -- 1
local Sprite = ____Dora.Sprite -- 1
local Label = ____Dora.Label -- 1
local Vec2 = ____Dora.Vec2 -- 1
____exports.Button = function(props) -- 26
	local ____props_0 = props -- 42
	local ____type = ____props_0.type -- 42
	if ____type == nil then -- 42
		____type = "click" -- 29
	end -- 29
	local x = ____props_0.x -- 29
	if x == nil then -- 29
		x = 0 -- 30
	end -- 30
	local y = ____props_0.y -- 30
	if y == nil then -- 30
		y = 0 -- 31
	end -- 31
	local width = ____props_0.width -- 31
	if width == nil then -- 31
		width = 200 -- 32
	end -- 32
	local height = ____props_0.height -- 32
	if height == nil then -- 32
		height = 100 -- 33
	end -- 33
	local onClick = ____props_0.onClick -- 33
	if onClick == nil then -- 33
		onClick = function() -- 34
		end -- 34
	end -- 34
	local onStateChange = ____props_0.onStateChange -- 34
	if onStateChange == nil then -- 34
		onStateChange = function() -- 35
		end -- 35
	end -- 35
	local normalImage = ____props_0.normalImage -- 35
	if normalImage == nil then -- 35
		normalImage = "Image/button/button.clip|button_up" -- 36
	end -- 36
	local pressImage = ____props_0.pressImage -- 36
	if pressImage == nil then -- 36
		pressImage = "Image/button/button.clip|button_down" -- 37
	end -- 37
	local text = ____props_0.text -- 37
	if text == nil then -- 37
		text = "" -- 38
	end -- 38
	local fontName = ____props_0.fontName -- 38
	if fontName == nil then -- 38
		fontName = "sarasa-mono-sc-regular" -- 39
	end -- 39
	local fontSize = ____props_0.fontSize -- 39
	if fontSize == nil then -- 39
		fontSize = 40 -- 40
	end -- 40
	local color = ____props_0.color -- 40
	if color == nil then -- 40
		color = 16777215 -- 41
	end -- 41
	local root = Node() -- 45
	root.x = x -- 46
	root.y = y -- 47
	root.width = width -- 48
	root.height = height -- 49
	local ____ = root.alignItems -- 49
	local buttonUp = Sprite(normalImage) -- 53
	if buttonUp then -- 53
		buttonUp.position = Vec2(width / 2, height / 2) -- 55
		buttonUp.width = width -- 56
		buttonUp.height = height -- 57
		root:addChild(buttonUp) -- 58
	end -- 58
	local buttonDown = Sprite(pressImage) -- 62
	if buttonDown then -- 62
		buttonDown.position = Vec2(width / 2, height / 2) -- 64
		buttonDown.width = width -- 65
		buttonDown.height = height -- 66
		buttonDown.visible = false -- 67
		root:addChild(buttonDown) -- 68
	end -- 68
	local buttonLabel = Label(fontName, fontSize) -- 72
	if buttonLabel then -- 72
		buttonLabel.text = text -- 74
		buttonLabel.position = Vec2(width / 2, height / 2) -- 75
		root:addChild(buttonLabel) -- 76
	end -- 76
	local state = "normal" -- 80
	local tempchange = false -- 81
	local switched = false -- 82
	local function setState(newState) -- 85
		state = newState -- 86
		if buttonUp and buttonDown then -- 86
			local pressed = state == "pressed" -- 88
			buttonUp.visible = not pressed -- 89
			buttonDown.visible = pressed -- 90
		end -- 90
		onStateChange(nil, newState) -- 92
	end -- 85
	root:onTapBegan(function(touch) -- 96
		if state == "normal" then -- 96
			tempchange = true -- 98
			setState("pressed") -- 99
			return true -- 100
		end -- 100
		return false -- 102
	end) -- 96
	root:onTapEnded(function() -- 105
		if tempchange then -- 105
			setState("normal") -- 107
			tempchange = false -- 108
		end -- 108
	end) -- 105
	root:onTapped(function() -- 112
		if ____type == "click" then -- 112
			setState("normal") -- 114
		else -- 114
			switched = not switched -- 116
			setState(switched and "pressed" or "normal") -- 117
		end -- 117
		onClick(nil, switched) -- 119
		return true -- 120
	end) -- 112
	return root -- 123
end -- 26
return ____exports -- 26