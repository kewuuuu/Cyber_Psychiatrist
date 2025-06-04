-- [tsx]: init.tsx
local ____exports = {} -- 1
local ____DoraX = require("DoraX") -- 1
local React = ____DoraX.React -- 1
local toNode = ____DoraX.toNode -- 1
local useRef = ____DoraX.useRef -- 1
local ____Dora = require("Dora") -- 2
local Director = ____Dora.Director -- 2
local Vec2 = ____Dora.Vec2 -- 2
local View = ____Dora.View -- 2
local tolua = ____Dora.tolua -- 2
local Size = ____Dora.Size -- 2
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
	local buttonWidth = 200 -- 50
	local buttonHeight = 100 -- 51
	local buttonYOffset = 150 -- 52
	local buttonY1 = hh + buttonYOffset -- 54
	local buttonY2 = hh -- 55
	local buttonY3 = hh - buttonYOffset -- 56
	local buttonY4 = hh - 2 * buttonYOffset -- 57
	local button1 = useRef() -- 59
	return React.createElement( -- 61
		"align-node", -- 61
		{ -- 61
			style = {width = "60%", height = "60%"}, -- 61
			onLayout = function(width, height) -- 61
				local ____sprite_0 = sprite -- 67
				local current = ____sprite_0.current -- 67
				if current then -- 67
					current.position = Vec2(width / 2, height / 2) -- 69
					current.size = Size(width, height) -- 70
				end -- 70
			end -- 66
		}, -- 66
		React.createElement( -- 66
			Button, -- 73
			{ -- 73
				type = "click", -- 73
				x = 0, -- 73
				y = buttonY1, -- 73
				width = buttonWidth, -- 73
				height = buttonHeight, -- 73
				onClick = newGameClick, -- 73
				normalImage = "Image/button/button.clip|button_up", -- 73
				pressImage = "Image/button/button.clip|button_down" -- 73
			}, -- 73
			React.createElement("label", {text = "新游戏", fontName = "sarasa-mono-sc-regular", fontSize = 40, color3 = 16777215}) -- 73
		), -- 73
		React.createElement( -- 73
			Button, -- 90
			{ -- 90
				type = "click", -- 90
				x = 0, -- 90
				y = buttonY2, -- 90
				width = buttonWidth, -- 90
				height = buttonHeight, -- 90
				onClick = continueGameClick, -- 90
				normalImage = "Image/button/button.clip|button_up", -- 90
				pressImage = "Image/button/button.clip|button_down" -- 90
			}, -- 90
			React.createElement("label", {text = "继续游戏", fontName = "sarasa-mono-sc-regular", fontSize = 40, color3 = 16777215}) -- 90
		), -- 90
		React.createElement( -- 90
			Button, -- 107
			{ -- 107
				type = "click", -- 107
				x = 0, -- 107
				y = buttonY3, -- 107
				width = buttonWidth, -- 107
				height = buttonHeight, -- 107
				onClick = loadSaveClick, -- 107
				normalImage = "Image/button/button.clip|button_up", -- 107
				pressImage = "Image/button/button.clip|button_down" -- 107
			}, -- 107
			React.createElement("label", {text = "读取存档", fontName = "sarasa-mono-sc-regular", fontSize = 40, color3 = 16777215}) -- 107
		), -- 107
		React.createElement( -- 107
			Button, -- 124
			{ -- 124
				type = "click", -- 124
				x = 0, -- 124
				y = buttonY4, -- 124
				width = buttonWidth, -- 124
				height = buttonHeight, -- 124
				onClick = exitClick, -- 124
				normalImage = "Image/button/button.clip|button_up", -- 124
				pressImage = "Image/button/button.clip|button_down" -- 124
			}, -- 124
			React.createElement("label", {text = "退出游戏", fontName = "sarasa-mono-sc-regular", fontSize = 40, color3 = 16777215}) -- 124
		) -- 124
	) -- 124
end -- 35
local startupnode = toNode(React.createElement(StartUp, nil)) -- 146
if startupnode ~= nil then -- 146
	startupnode:addTo(Director.ui) -- 147
end -- 147
return ____exports -- 147