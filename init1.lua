-- [tsx]: init1.tsx
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
	emit("ScaleUpdated", viewState) -- 33
end -- 21
updateViewSize() -- 35
Director.entry:onAppChange(function(settingName) -- 36
	if settingName == "Size" then -- 36
		updateViewSize() -- 38
	end -- 38
end) -- 36
local function StartUp() -- 43
	local function newGameClick(switched) -- 44
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 45
	end -- 44
	local function continueGameClick(switched) -- 47
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 48
	end -- 47
	local function loadSaveClick(switched) -- 50
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 51
	end -- 50
	local function exitClick(switched) -- 53
		print("Button clicked, switched: " .. (switched and "on" or "off")) -- 54
	end -- 53
	local buttonWidth = 30 -- 58
	local buttonHeight = 15 -- 59
	local Button_interval = 10 -- 60
	local buttonY1 = 5 + Button_interval * 3 + buttonHeight * 7 / 2 -- 62
	local buttonY2 = 5 + Button_interval * 2 + buttonHeight * 5 / 2 -- 63
	local buttonY3 = 5 + Button_interval + buttonHeight * 3 / 2 -- 64
	local buttonY4 = 5 + buttonHeight / 2 -- 65
	return React.createElement( -- 67
		"align-node", -- 67
		{windowRoot = true, style = {justifyContent = "center", alignItems = "center"}}, -- 67
		React.createElement( -- 67
			"align-node", -- 67
			{style = {width = "100%", height = "100%", justifyContent = "center", alignItems = "center"}}, -- 67
			React.createElement(Button, { -- 67
				type = "click", -- 67
				x = 50, -- 67
				y = buttonY1, -- 67
				width = buttonWidth, -- 67
				height = buttonHeight, -- 67
				onClick = newGameClick, -- 67
				normalImage = "Image/button/button.clip|button_up", -- 67
				pressImage = "Image/button/button.clip|button_down", -- 67
				text = "新游戏", -- 67
				viewState = viewState -- 67
			}) -- 67
		) -- 67
	) -- 67
end -- 43
local startupnode = toNode(React.createElement(StartUp, nil)) -- 97
if startupnode ~= nil then -- 97
	startupnode:addTo(Director.ui) -- 98
end -- 98
return ____exports -- 98