-- [tsx]: init.tsx
local ____exports = {} -- 1
local ____DoraX = require("DoraX") -- 1
local React = ____DoraX.React -- 1
local toNode = ____DoraX.toNode -- 1
local ____Dora = require("Dora") -- 2
local Director = ____Dora.Director -- 2
local Vec2 = ____Dora.Vec2 -- 2
local View = ____Dora.View -- 2
local tolua = ____Dora.tolua -- 2
local ____Button = require("Script.UI.Button") -- 4
local Button = ____Button.Button -- 4
local DesignWidth = 480 -- 7
local DesignHeight = 700 -- 8
local hw = DesignWidth / 2 -- 9
local hh = DesignHeight / 2 -- 10
local function Background() -- 13
	return React.createElement("sprite", {file = "Image/art.png", scaleX = 1, scaleY = 1}) -- 13
end -- 13
local function updateViewSize() -- 16
	local camera = tolua.cast(Director.currentCamera, "Camera2D") -- 17
	if camera then -- 17
		local scaleX = View.size.width / DesignWidth -- 20
		local scaleY = View.size.height / DesignHeight -- 21
		local scale = math.min(scaleX, scaleY) -- 22
		camera.zoom = scale -- 23
		camera.position = Vec2(hw * scale, hh * scale) -- 24
	end -- 24
end -- 16
updateViewSize() -- 27
Director.entry:onAppChange(function(settingName) -- 28
	if settingName == "Size" then -- 28
		updateViewSize() -- 30
	end -- 30
end) -- 28
local function StartUp() -- 35
	local function newGameClick(switched) -- 36
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 37
	end -- 36
	local function continueGameClick(switched) -- 39
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 40
	end -- 39
	local function loadSaveClick(switched) -- 42
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 43
	end -- 42
	local function exitClick(switched) -- 45
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 46
	end -- 45
	local buttonWidth = "50%" -- 50
	local buttonHeight = "40%" -- 51
	local buttonYOffset = 150 -- 52
	local buttonY1 = hh + buttonYOffset -- 54
	local buttonY2 = hh -- 55
	local buttonY3 = hh - buttonYOffset -- 56
	local buttonY4 = hh - 2 * buttonYOffset -- 57
	return React.createElement( -- 60
		"align-node", -- 60
		{windowRoot = true, style = {justifyContent = "center", alignItems = "center"}}, -- 60
		React.createElement( -- 60
			"align-node", -- 60
			{style = {width = "100%", height = "100%", justifyContent = "center", alignItems = "center"}}, -- 60
			React.createElement(Button, { -- 60
				type = "click", -- 60
				x = 0, -- 60
				y = 0, -- 60
				width = buttonWidth, -- 60
				height = buttonHeight, -- 60
				onClick = newGameClick, -- 60
				normalImage = "Image/button/button.clip|button_up", -- 60
				pressImage = "Image/button/button.clip|button_down", -- 60
				text = "新游戏" -- 60
			}) -- 60
		) -- 60
	) -- 60
end -- 35
local startupnode = toNode(React.createElement(StartUp, nil)) -- 89
if startupnode ~= nil then -- 89
	startupnode:addTo(Director.ui) -- 90
end -- 90
return ____exports -- 90