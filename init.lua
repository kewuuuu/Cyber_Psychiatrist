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
local viewState = { -- 11
	scale = math.min(View.size.width / DesignWidth, View.size.height / DesignHeight), -- 12
	NowViewWidth = 1000, -- 13
	NowViewHeight = 500 -- 14
} -- 14
local function updateViewSize() -- 21
	local camera = tolua.cast(Director.currentCamera, "Camera2D") -- 22
	if camera then -- 22
		local scaleX = View.size.width / DesignWidth -- 25
		local scaleY = View.size.height / DesignHeight -- 26
		viewState.scale = math.min(scaleX, scaleY) -- 27
		viewState.NowViewWidth = DesignWidth * viewState.scale -- 28
		viewState.NowViewHeight = DesignHeight * viewState.scale -- 29
		camera.zoom = viewState.scale -- 30
		camera.position = Vec2(hw * viewState.scale, hh * viewState.scale) -- 31
	end -- 31
	emit("ScaleUpdated", viewState) -- 37
end -- 21
updateViewSize() -- 39
Director.entry:onAppChange(function(settingName) -- 40
	if settingName == "Size" then -- 40
		updateViewSize() -- 42
	end -- 42
end) -- 40
local function StartUp() -- 47
	local function newGameClick(switched) -- 48
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 49
	end -- 48
	local function continueGameClick(switched) -- 51
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 52
	end -- 51
	local function loadSaveClick(switched) -- 54
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 55
	end -- 54
	local function exitClick(switched) -- 57
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 58
	end -- 57
	local buttonWidth = 30 -- 62
	local buttonHeight = 15 -- 63
	local Button_interval = 10 -- 64
	local buttonY1 = 5 + Button_interval * 3 + buttonHeight * 7 / 2 -- 70
	local buttonY2 = 5 + Button_interval * 2 + buttonHeight * 5 / 2 -- 71
	local buttonY3 = 5 + Button_interval + buttonHeight * 3 / 2 -- 72
	local buttonY4 = 5 + buttonHeight / 2 -- 73
	return React.createElement( -- 75
		"align-node", -- 75
		{windowRoot = true, style = {justifyContent = "center", alignItems = "center"}}, -- 75
		React.createElement( -- 75
			"align-node", -- 75
			{style = {width = "100%", height = "100%", justifyContent = "center", alignItems = "center"}}, -- 75
			React.createElement(Button, { -- 75
				type = "click", -- 75
				x = 50, -- 75
				y = buttonY1, -- 75
				width = buttonWidth, -- 75
				height = buttonHeight, -- 75
				onClick = newGameClick, -- 75
				normalImage = "Image/button/button.clip|button_up", -- 75
				pressImage = "Image/button/button.clip|button_down", -- 75
				text = "新游戏", -- 75
				viewState = viewState -- 75
			}) -- 75
		) -- 75
	) -- 75
end -- 47
local startupnode = toNode(React.createElement(StartUp, nil)) -- 105
if startupnode ~= nil then -- 105
	startupnode:addTo(Director.ui) -- 106
end -- 106
return ____exports -- 106