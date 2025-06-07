-- [tsx]: init.tsx
local ____lualib = require("lualib_bundle") -- 1
local __TS__New = ____lualib.__TS__New -- 1
local __TS__StringTrim = ____lualib.__TS__StringTrim -- 1
local __TS__ParseInt = ____lualib.__TS__ParseInt -- 1
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 2
local Director = ____Dora.Director -- 2
local Node = ____Dora.Node -- 2
local Sprite = ____Dora.Sprite -- 2
local Size = ____Dora.Size -- 2
local App = ____Dora.App -- 2
local Vec2 = ____Dora.Vec2 -- 2
local View = ____Dora.View -- 2
local tolua = ____Dora.tolua -- 2
local Label = ____Dora.Label -- 2
local Color = ____Dora.Color -- 2
local ____Button = require("Script.UI.Button") -- 3
local Button = ____Button.Button -- 3
local ____SaveManager = require("Script.SaveManager") -- 5
local SaveManager = ____SaveManager.SaveManager -- 5
local designSize = Size(1280, 720) -- 7
local winsize = Size(1600, 900) -- 8
local fontName = "sarasa-mono-sc-regular" -- 9
local function updateViewSize() -- 12
	local camera = tolua.cast(Director.currentCamera, "Camera2D") -- 13
	if camera then -- 13
		camera.zoom = math.min(View.size.height / designSize.height, View.size.width / designSize.width) -- 15
	end -- 15
end -- 12
local function adjustWinSize() -- 20
	App.winSize = winsize -- 21
	print("Visual size: " .. tostring(App.visualSize)) -- 22
end -- 20
local function StartUp() -- 26
	local buttonWidth = 200 -- 27
	local buttonHeight = 100 -- 28
	local buttonx = 0 -- 29
	local buttony = {designSize.height / 5 * 4 - designSize.height / 2, designSize.height / 5 * 3 - designSize.height / 2, designSize.height / 5 * 2 - designSize.height / 2, designSize.height / 5 - designSize.height / 2} -- 30
	local function newGameClick(switched, tag) -- 37
		print("新游戏点击, switched: " .. (switched and "on" or "off")) -- 38
	end -- 37
	local function continueGameClick(switched, tag) -- 41
		print("继续游戏点击, switched: " .. (switched and "on" or "off")) -- 42
	end -- 41
	local function loadSaveClick(switched, tag) -- 45
		print("加载游戏点击, switched: " .. (switched and "on" or "off")) -- 46
	end -- 45
	local function exitClick(switched, tag) -- 49
		print("退出游戏点击, switched: " .. (switched and "on" or "off")) -- 50
		App:shutdown() -- 51
	end -- 49
	local root = Node() -- 53
	local background = Sprite("Image/background/background.png") -- 54
	if background then -- 54
		background.size = designSize -- 56
		root:addChild(background) -- 57
	end -- 57
	local ____Button_result_0 = Button({ -- 61
		type = "click", -- 62
		x = buttonx, -- 63
		y = buttony[1], -- 64
		width = buttonWidth, -- 65
		height = buttonHeight, -- 66
		onClick = continueGameClick, -- 67
		text = "继续游戏" -- 68
	}) -- 68
	local bt1 = ____Button_result_0.root -- 68
	local ____Button_result_1 = Button({ -- 72
		type = "click", -- 73
		x = buttonx, -- 74
		y = buttony[2], -- 75
		width = buttonWidth, -- 76
		height = buttonHeight, -- 77
		onClick = newGameClick, -- 78
		text = "新游戏" -- 79
	}) -- 79
	local bt2 = ____Button_result_1.root -- 79
	local ____Button_result_2 = Button({ -- 83
		type = "click", -- 84
		x = buttonx, -- 85
		y = buttony[3], -- 86
		width = buttonWidth, -- 87
		height = buttonHeight, -- 88
		onClick = loadSaveClick, -- 89
		text = "读取存档" -- 90
	}) -- 90
	local bt3 = ____Button_result_2.root -- 90
	local ____Button_result_3 = Button({ -- 94
		type = "click", -- 95
		x = buttonx, -- 96
		y = buttony[4], -- 97
		width = buttonWidth, -- 98
		height = buttonHeight, -- 99
		onClick = exitClick, -- 100
		text = "退出游戏" -- 101
	}) -- 101
	local bt4 = ____Button_result_3.root -- 101
	root:addChild(bt1) -- 103
	root:addChild(bt2) -- 104
	root:addChild(bt3) -- 105
	root:addChild(bt4) -- 106
	return root -- 108
end -- 26
local function SavePage() -- 111
	local saveSlots -- 111
	local file_num = 4 -- 112
	local file_label_size = {width = 250, height = 400} -- 113
	local delete_button_size = {width = 20, height = 20} -- 114
	local file_interval = 50 -- 115
	local totalWidth = file_num * file_label_size.width + (file_num - 1) * file_interval -- 116
	local label_x = {} -- 118
	do -- 118
		local i = 0 -- 119
		while i < file_num do -- 119
			label_x[#label_x + 1] = -totalWidth / 2 + file_label_size.width / 2 + i * (file_label_size.width + file_interval) -- 120
			i = i + 1 -- 119
		end -- 119
	end -- 119
	local saveManager = __TS__New(SaveManager) -- 123
	local saveSummaries = saveManager:getAllSavesSummary(file_num) -- 124
	local function saveSummaryToString(summary) -- 126
		if not summary.exists then -- 126
			return ("存档" .. tostring(summary.slot)) .. "\n（无存档）" -- 128
		end -- 128
		return ((((("存档" .. tostring(summary.slot)) .. "\n进度：") .. summary.progress) .. "\n游玩时长：") .. summary.playTime) .. "\n" -- 130
	end -- 126
	local function saveDetailToString(detail) -- 132
		if not detail.exists then -- 132
			return ("存档" .. tostring(detail.slot)) .. "\n（无存档）" -- 134
		end -- 134
		local itemsStr = #detail.items > 0 and ("道具：" .. table.concat(detail.items, ", ")) .. "\n" or "道具：（无道具）\n" -- 136
		return (((((("存档" .. tostring(detail.slot)) .. "\n进度：") .. detail.progress) .. "\n游玩时长：") .. detail.playTime) .. "\n") .. itemsStr -- 139
	end -- 132
	local function loadSaveFile(switched, tag) -- 144
		if not tag then -- 144
			return nil -- 145
		end -- 145
		local slot = __TS__ParseInt(__TS__StringTrim(tag)) -- 146
		if not saveSummaries[slot + 1].exists then -- 146
			print("新游戏") -- 148
			return nil -- 149
		end -- 149
		local saveDetail = saveManager:getSaveDetail(slot) -- 151
		if not saveDetail then -- 151
			print("存档损坏，请删除该存档") -- 153
			return nil -- 154
		else -- 154
			print(saveDetailToString(saveDetail)) -- 157
		end -- 157
		return nil -- 159
	end -- 144
	local function deleteSave(switched, tag) -- 161
		if not tag then -- 161
			return nil -- 162
		end -- 162
		local slot = __TS__ParseInt(__TS__StringTrim(tag)) -- 163
		local result = saveManager:deleteSave(slot) -- 164
		if result then -- 164
			saveSummaries = saveManager:getAllSavesSummary(file_num) -- 166
			saveSlots[slot + 1].st(saveSummaryToString(saveSummaries[slot + 1])) -- 167
		end -- 167
		return -- 169
	end -- 161
	local root = Node() -- 173
	saveSlots = {} -- 175
	do -- 175
		local i = 0 -- 179
		while i < file_num do -- 179
			local ____Button_result_4 = Button({ -- 180
				type = "click", -- 181
				x = label_x[i + 1], -- 182
				y = 0, -- 183
				width = file_label_size.width, -- 184
				height = file_label_size.height, -- 185
				onClick = loadSaveFile, -- 186
				text = saveSummaryToString(saveSummaries[i + 1]), -- 187
				tag = tostring(i), -- 188
				fontSize = 30, -- 189
				textWidth = file_label_size.width -- 190
			}) -- 190
			local bt = ____Button_result_4.root -- 190
			local st = ____Button_result_4.setText -- 190
			saveSlots[#saveSlots + 1] = {bt = bt, st = st} -- 192
			root:addChild(saveSlots[i + 1].bt or Node()) -- 193
			i = i + 1 -- 179
		end -- 179
	end -- 179
	local deleteButton = {} -- 196
	do -- 196
		local i = 0 -- 197
		while i < file_num do -- 197
			local ____Button_result_5 = Button({ -- 198
				type = "click", -- 199
				x = label_x[i + 1], -- 200
				y = -file_label_size.height / 2 - delete_button_size.height / 2 - 10, -- 201
				width = delete_button_size.width, -- 202
				height = delete_button_size.height, -- 203
				onClick = deleteSave, -- 204
				text = "删除存档", -- 205
				tag = tostring(i), -- 206
				fontSize = 20, -- 207
				textWidth = file_label_size.width -- 208
			}) -- 208
			local bt = ____Button_result_5.root -- 208
			deleteButton[#deleteButton + 1] = bt -- 210
			root:addChild(deleteButton[i + 1] or Node()) -- 211
			i = i + 1 -- 197
		end -- 197
	end -- 197
	local lb1 = Label(fontName, 20) -- 214
	if lb1 then -- 214
		lb1.text = "!注意：存档0为默认存档会被自动存档覆盖！" -- 216
		lb1.color = Color(4294923520) -- 217
		lb1.position = Vec2(label_x[1], file_label_size.height / 2 + 50) -- 218
		root:addChild(lb1) -- 219
	end -- 219
	return root -- 224
end -- 111
updateViewSize() -- 230
adjustWinSize() -- 231
Director.entry:onAppChange(function(settingName) -- 232
	if settingName == "Size" then -- 232
		updateViewSize() -- 234
	end -- 234
end) -- 232
SavePage() -- 240
return ____exports -- 240