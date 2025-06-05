-- [tsx]: init.tsx
local ____exports = {} -- 1
local ____DoraX = require("DoraX") -- 1
local React = ____DoraX.React -- 1
local toNode = ____DoraX.toNode -- 1
local ____Dora = require("Dora") -- 2
local Director = ____Dora.Director -- 2
local Vec2 = ____Dora.Vec2 -- 2
local View = ____Dora.View -- 2
local emit = ____Dora.emit -- 2
local tolua = ____Dora.tolua -- 2
local ____Button = require("Script.UI.Button") -- 4
local Button = ____Button.Button -- 4
local DesignWidth = 200 -- 7
local DesignHeight = 100 -- 8
local hw = DesignWidth / 2 -- 9
local hh = DesignHeight / 2 -- 10
local scale = math.min(View.size.width / DesignWidth, View.size.height / DesignHeight) -- 11
local function updateViewSize() -- 19
	local camera = tolua.cast(Director.currentCamera, "Camera2D") -- 20
	if camera then -- 20
		local scaleX = View.size.width / DesignWidth -- 23
		local scaleY = View.size.height / DesignHeight -- 24
		scale = math.min(scaleX, scaleY) -- 25
		camera.zoom = scale -- 28
		camera.position = Vec2(hw * scale, hh * scale) -- 29
	end -- 29
	emit("ScaleUpdated", scale) -- 35
end -- 19
updateViewSize() -- 37
Director.entry:onAppChange(function(settingName) -- 38
	if settingName == "Size" then -- 38
		updateViewSize() -- 40
	end -- 40
end) -- 38
local function StartUp() -- 45
	local function newGameClick(switched) -- 46
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 47
	end -- 46
	local function continueGameClick(switched) -- 49
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 50
	end -- 49
	local function loadSaveClick(switched) -- 52
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 53
	end -- 52
	local function exitClick(switched) -- 55
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 56
	end -- 55
	local buttonWidth = 30 -- 60
	local buttonHeight = 15 -- 61
	local Button_interval = 10 -- 62
	local buttonY1 = Button_interval * 3 / 2 + buttonHeight * 3 / 2 -- 63
	local buttonY2 = Button_interval / 2 + buttonHeight / 2 -- 64
	local buttonY3 = -(Button_interval / 2 + buttonHeight / 2) -- 65
	local buttonY4 = -(Button_interval * 3 / 2 + buttonHeight * 3 / 2) -- 66
	return React.createElement( -- 69
		"align-node", -- 69
		{windowRoot = true, style = {justifyContent = "center", alignItems = "center"}}, -- 69
		React.createElement( -- 69
			"align-node", -- 69
			{style = {width = "100%", height = "100%", justifyContent = "center", alignItems = "center"}}, -- 69
			React.createElement(Button, { -- 69
				type = "click", -- 69
				x = 0, -- 69
				y = buttonY1, -- 69
				width = buttonWidth, -- 69
				height = buttonHeight, -- 69
				onClick = newGameClick, -- 69
				normalImage = "Image/button/button.clip|button_up", -- 69
				pressImage = "Image/button/button.clip|button_down", -- 69
				text = "新游戏", -- 69
				scale = scale -- 69
			}) -- 69
		) -- 69
	) -- 69
end -- 45
local startupnode = toNode(React.createElement(StartUp, nil)) -- 98
if startupnode ~= nil then -- 98
	startupnode:addTo(Director.ui) -- 99
end -- 99
return ____exports -- 99