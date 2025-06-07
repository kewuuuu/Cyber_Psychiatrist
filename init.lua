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
local designSize = Size(1280, 720) -- 7
local winsize = Size(1600, 900) -- 8
local function updateViewSize() -- 11
	local camera = tolua.cast(Director.currentCamera, "Camera2D") -- 12
	if camera then -- 12
		camera.zoom = math.min(View.size.height / designSize.height, View.size.width / designSize.width) -- 14
	end -- 14
end -- 11
local function adjustWinSize() -- 19
	App.winSize = winsize -- 20
	print("Visual size: " .. tostring(App.visualSize)) -- 21
end -- 19
local function StartUp() -- 25
	local buttonWidth = 200 -- 26
	local buttonHeight = 100 -- 27
	local buttonx = 0 -- 28
	local buttony = {designSize.height / 5 * 4 - designSize.height / 2, designSize.height / 5 * 3 - designSize.height / 2, designSize.height / 5 * 2 - designSize.height / 2, designSize.height / 5 - designSize.height / 2} -- 29
	local function newGameClick(switched, tag) -- 36
		print("新游戏点击, switched: " .. (switched and "on" or "off")) -- 37
	end -- 36
	local function continueGameClick(switched, tag) -- 40
		print("继续游戏点击, switched: " .. (switched and "on" or "off")) -- 41
	end -- 40
	local function loadSaveClick(switched, tag) -- 44
		print("加载游戏点击, switched: " .. (switched and "on" or "off")) -- 45
	end -- 44
	local function exitClick(switched, tag) -- 48
		print("退出游戏点击, switched: " .. (switched and "on" or "off")) -- 49
		App:shutdown() -- 50
	end -- 48
	local root = Node() -- 52
	local bt1 = toNode(React.createElement(Button, { -- 53
		type = "click", -- 53
		x = buttonx, -- 53
		y = buttony[1], -- 53
		width = buttonWidth, -- 53
		height = buttonHeight, -- 53
		onClick = newGameClick, -- 53
		text = "新游戏" -- 53
	})) -- 53
	local bt2 = toNode(React.createElement(Button, { -- 62
		type = "click", -- 62
		x = buttonx, -- 62
		y = buttony[2], -- 62
		width = buttonWidth, -- 62
		height = buttonHeight, -- 62
		onClick = continueGameClick, -- 62
		text = "继续游戏" -- 62
	})) -- 62
	local bt3 = toNode(React.createElement(Button, { -- 71
		type = "click", -- 71
		x = buttonx, -- 71
		y = buttony[3], -- 71
		width = buttonWidth, -- 71
		height = buttonHeight, -- 71
		onClick = loadSaveClick, -- 71
		text = "读取存档" -- 71
	})) -- 71
	local bt4 = toNode(React.createElement(Button, { -- 80
		type = "click", -- 80
		x = buttonx, -- 80
		y = buttony[4], -- 80
		width = buttonWidth, -- 80
		height = buttonHeight, -- 80
		onClick = exitClick, -- 80
		text = "退出游戏" -- 80
	})) -- 80
	if bt1 and bt2 and bt3 and bt4 then -- 80
		root:addChild(bt1) -- 90
		root:addChild(bt2) -- 91
		root:addChild(bt3) -- 92
		root:addChild(bt4) -- 93
	end -- 93
	return root -- 95
end -- 25
local function SavePage() -- 98
	local file_num = 4 -- 99
	local file_label_size = {width = 250, height = 600} -- 100
	local file_interval = 50 -- 101
	local totalWidth = file_num * file_label_size.width + (file_num - 1) * file_interval -- 102
	local label_x = {} -- 104
	do -- 104
		local i = 0 -- 105
		while i < file_num do -- 105
			label_x[#label_x + 1] = -totalWidth / 2 + file_label_size.width / 2 + i * (file_label_size.width + file_interval) -- 106
			i = i + 1 -- 105
		end -- 105
	end -- 105
	local function fileClick(switched, tag) -- 109
		print("switched:", switched) -- 110
		print("tag:", tag) -- 111
	end -- 109
	local root = Node() -- 113
	local savefiles = {} -- 114
	do -- 114
		local i = 0 -- 116
		while i < file_num do -- 116
			savefiles[#savefiles + 1] = React.createElement( -- 117
				Button, -- 118
				{ -- 118
					type = "click", -- 118
					x = label_x[i + 1], -- 118
					y = 0, -- 118
					width = file_label_size.width, -- 118
					height = file_label_size.height, -- 118
					onClick = fileClick, -- 118
					text = "存档" .. tostring(i + 1), -- 118
					tag = tostring(i), -- 118
					fontSize = 50, -- 118
					textWidth = file_label_size.width -- 118
				} -- 118
			) -- 118
			root:addChild(savefiles[i + 1]) -- 131
			i = i + 1 -- 116
		end -- 116
	end -- 116
	return root -- 135
end -- 98
updateViewSize() -- 141
adjustWinSize() -- 142
Director.entry:onAppChange(function(settingName) -- 143
	if settingName == "Size" then -- 143
		updateViewSize() -- 145
	end -- 145
end) -- 143
SavePage() -- 151
return ____exports -- 151