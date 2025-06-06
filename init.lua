-- [tsx]: init.tsx
local ____exports = {} -- 1
local ____DoraX = require("DoraX") -- 1
local React = ____DoraX.React -- 1
local toNode = ____DoraX.toNode -- 1
local ____Dora = require("Dora") -- 2
local Director = ____Dora.Director -- 2
local Node = ____Dora.Node -- 2
local Size = ____Dora.Size -- 2
local App = ____Dora.App -- 2
local View = ____Dora.View -- 2
local tolua = ____Dora.tolua -- 2
local ____Button = require("Script.UI.Button") -- 3
local Button = ____Button.Button -- 3
local designSize = Size(1280, 720) -- 5
local winsize = Size(1600, 900) -- 6
local function updateViewSize() -- 9
	local camera = tolua.cast(Director.currentCamera, "Camera2D") -- 10
	if camera then -- 10
		camera.zoom = View.size.height / designSize.height -- 12
	end -- 12
end -- 9
local function adjustWinSize() -- 17
	App.winSize = winsize -- 18
	print("Visual size: " .. tostring(App.visualSize)) -- 19
end -- 17
local function StartUp() -- 23
	local buttonWidth = 200 -- 24
	local buttonHeight = 100 -- 25
	local buttonx = 0 -- 26
	local buttony = {designSize.height / 5 * 4 - designSize.height / 2, designSize.height / 5 * 3 - designSize.height / 2, designSize.height / 5 * 2 - designSize.height / 2, designSize.height / 5 - designSize.height / 2} -- 27
	local function newGameClick(switched) -- 34
		print("新游戏点击, switched: " .. (switched and "on" or "off")) -- 35
	end -- 34
	local function continueGameClick(switched) -- 38
		print("继续游戏点击, switched: " .. (switched and "on" or "off")) -- 39
	end -- 38
	local function loadSaveClick(switched) -- 42
		print("加载游戏点击, switched: " .. (switched and "on" or "off")) -- 43
	end -- 42
	local function exitClick(switched) -- 46
		print("退出游戏点击, switched: " .. (switched and "on" or "off")) -- 47
	end -- 46
	local root = Node() -- 50
	local bt1 = toNode(React.createElement(Button, { -- 51
		type = "click", -- 51
		x = buttonx, -- 51
		y = buttony[1], -- 51
		width = buttonWidth, -- 51
		height = buttonHeight, -- 51
		onClick = newGameClick, -- 51
		text = "新游戏" -- 51
	})) -- 51
	local bt2 = toNode(React.createElement(Button, { -- 60
		type = "click", -- 60
		x = buttonx, -- 60
		y = buttony[2], -- 60
		width = buttonWidth, -- 60
		height = buttonHeight, -- 60
		onClick = continueGameClick, -- 60
		text = "继续游戏" -- 60
	})) -- 60
	local bt3 = toNode(React.createElement(Button, { -- 69
		type = "click", -- 69
		x = buttonx, -- 69
		y = buttony[3], -- 69
		width = buttonWidth, -- 69
		height = buttonHeight, -- 69
		onClick = loadSaveClick, -- 69
		text = "读取存档" -- 69
	})) -- 69
	local bt4 = toNode(React.createElement(Button, { -- 78
		type = "click", -- 78
		x = buttonx, -- 78
		y = buttony[4], -- 78
		width = buttonWidth, -- 78
		height = buttonHeight, -- 78
		onClick = exitClick, -- 78
		text = "退出游戏" -- 78
	})) -- 78
	return root -- 87
end -- 23
updateViewSize() -- 94
adjustWinSize() -- 95
Director.entry:onAppChange(function(settingName) -- 96
	if settingName == "Size" then -- 96
		updateViewSize() -- 98
	end -- 98
end) -- 96
StartUp() -- 103
return ____exports -- 103