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
local ____Dora = require("Dora") -- 4
local Audio = ____Dora.Audio -- 4
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
local resources = {textures = {}, models = {}, sounds = {"Audio/《蝉鸣间的电子幽梦》欢快的桂花冰淇淋.mp3"}} -- 26
Audio:playStream(resources.sounds[1], true) -- 31
local function StartUp() -- 34
	local buttonWidth = 200 -- 35
	local buttonHeight = 100 -- 36
	local buttonx = 0 -- 37
	local buttony = {designSize.height / 5 * 4 - designSize.height / 2, designSize.height / 5 * 3 - designSize.height / 2, designSize.height / 5 * 2 - designSize.height / 2, designSize.height / 5 - designSize.height / 2} -- 38
	local function newGameClick(switched, tag) -- 45
		print("新游戏点击, switched: " .. (switched and "on" or "off")) -- 46
	end -- 45
	local function continueGameClick(switched, tag) -- 49
		print("继续游戏点击, switched: " .. (switched and "on" or "off")) -- 50
	end -- 49
	local function loadSaveClick(switched, tag) -- 53
		print("加载游戏点击, switched: " .. (switched and "on" or "off")) -- 54
	end -- 53
	local function exitClick(switched, tag) -- 57
		print("退出游戏点击, switched: " .. (switched and "on" or "off")) -- 58
		App:shutdown() -- 59
	end -- 57
	local root = Node() -- 61
	local background = Sprite("Image/background/background.png") -- 62
	if background then -- 62
		background.size = designSize -- 64
		root:addChild(background) -- 65
	end -- 65
	local ____Button_result_0 = Button({ -- 69
		type = "click", -- 70
		x = buttonx, -- 71
		y = buttony[1], -- 72
		width = buttonWidth, -- 73
		height = buttonHeight, -- 74
		onClick = continueGameClick, -- 75
		text = "继续游戏" -- 76
	}) -- 76
	local bt1 = ____Button_result_0.root -- 76
	local ____Button_result_1 = Button({ -- 80
		type = "click", -- 81
		x = buttonx, -- 82
		y = buttony[2], -- 83
		width = buttonWidth, -- 84
		height = buttonHeight, -- 85
		onClick = newGameClick, -- 86
		text = "新游戏" -- 87
	}) -- 87
	local bt2 = ____Button_result_1.root -- 87
	local ____Button_result_2 = Button({ -- 91
		type = "click", -- 92
		x = buttonx, -- 93
		y = buttony[3], -- 94
		width = buttonWidth, -- 95
		height = buttonHeight, -- 96
		onClick = loadSaveClick, -- 97
		text = "读取存档" -- 98
	}) -- 98
	local bt3 = ____Button_result_2.root -- 98
	local ____Button_result_3 = Button({ -- 102
		type = "click", -- 103
		x = buttonx, -- 104
		y = buttony[4], -- 105
		width = buttonWidth, -- 106
		height = buttonHeight, -- 107
		onClick = exitClick, -- 108
		text = "退出游戏" -- 109
	}) -- 109
	local bt4 = ____Button_result_3.root -- 109
	root:addChild(bt1) -- 111
	root:addChild(bt2) -- 112
	root:addChild(bt3) -- 113
	root:addChild(bt4) -- 114
	return root -- 116
end -- 34
local function SavePage() -- 119
	local saveSlots -- 119
	local file_num = 4 -- 120
	local file_label_size = {width = 250, height = 400} -- 121
	local delete_button_size = {width = 20, height = 20} -- 122
	local file_interval = 50 -- 123
	local totalWidth = file_num * file_label_size.width + (file_num - 1) * file_interval -- 124
	local label_x = {} -- 126
	do -- 126
		local i = 0 -- 127
		while i < file_num do -- 127
			label_x[#label_x + 1] = -totalWidth / 2 + file_label_size.width / 2 + i * (file_label_size.width + file_interval) -- 128
			i = i + 1 -- 127
		end -- 127
	end -- 127
	local saveManager = __TS__New(SaveManager) -- 131
	local saveSummaries = saveManager:getAllSavesSummary(file_num) -- 132
	local function saveSummaryToString(summary) -- 134
		if not summary.exists then -- 134
			return ("存档" .. tostring(summary.slot)) .. "\n（无存档）" -- 136
		end -- 136
		return ((((("存档" .. tostring(summary.slot)) .. "\n进度：") .. summary.progress) .. "\n游玩时长：") .. summary.playTime) .. "\n" -- 138
	end -- 134
	local function saveDetailToString(detail) -- 140
		if not detail.exists then -- 140
			return ("存档" .. tostring(detail.slot)) .. "\n（无存档）" -- 142
		end -- 142
		local itemsStr = #detail.items > 0 and ("道具：" .. table.concat(detail.items, ", ")) .. "\n" or "道具：（无道具）\n" -- 144
		return (((((("存档" .. tostring(detail.slot)) .. "\n进度：") .. detail.progress) .. "\n游玩时长：") .. detail.playTime) .. "\n") .. itemsStr -- 147
	end -- 140
	local function loadSaveFile(switched, tag) -- 152
		if not tag then -- 152
			return nil -- 153
		end -- 153
		local slot = __TS__ParseInt(__TS__StringTrim(tag)) -- 154
		if not saveSummaries[slot + 1].exists then -- 154
			print("新游戏") -- 156
			return nil -- 157
		end -- 157
		local saveDetail = saveManager:getSaveDetail(slot) -- 159
		if not saveDetail then -- 159
			print("存档损坏，请删除该存档") -- 161
			return nil -- 162
		else -- 162
			print(saveDetailToString(saveDetail)) -- 165
		end -- 165
		return nil -- 167
	end -- 152
	local function deleteSave(switched, tag) -- 169
		if not tag then -- 169
			return nil -- 170
		end -- 170
		local slot = __TS__ParseInt(__TS__StringTrim(tag)) -- 171
		local result = saveManager:deleteSave(slot) -- 172
		if result then -- 172
			saveSummaries = saveManager:getAllSavesSummary(file_num) -- 174
			saveSlots[slot + 1].st(saveSummaryToString(saveSummaries[slot + 1])) -- 175
		end -- 175
		return -- 177
	end -- 169
	local root = Node() -- 181
	saveSlots = {} -- 183
	do -- 183
		local i = 0 -- 187
		while i < file_num do -- 187
			local ____Button_result_4 = Button({ -- 188
				type = "click", -- 189
				x = label_x[i + 1], -- 190
				y = 0, -- 191
				width = file_label_size.width, -- 192
				height = file_label_size.height, -- 193
				onClick = loadSaveFile, -- 194
				text = saveSummaryToString(saveSummaries[i + 1]), -- 195
				tag = tostring(i), -- 196
				fontSize = 30, -- 197
				textWidth = file_label_size.width -- 198
			}) -- 198
			local bt = ____Button_result_4.root -- 198
			local st = ____Button_result_4.setText -- 198
			saveSlots[#saveSlots + 1] = {bt = bt, st = st} -- 200
			root:addChild(saveSlots[i + 1].bt or Node()) -- 201
			i = i + 1 -- 187
		end -- 187
	end -- 187
	local deleteButton = {} -- 204
	do -- 204
		local i = 0 -- 205
		while i < file_num do -- 205
			local ____Button_result_5 = Button({ -- 206
				type = "click", -- 207
				x = label_x[i + 1], -- 208
				y = -file_label_size.height / 2 - delete_button_size.height / 2 - 10, -- 209
				width = delete_button_size.width, -- 210
				height = delete_button_size.height, -- 211
				onClick = deleteSave, -- 212
				text = "删除存档", -- 213
				tag = tostring(i), -- 214
				fontSize = 20, -- 215
				textWidth = file_label_size.width -- 216
			}) -- 216
			local bt = ____Button_result_5.root -- 216
			deleteButton[#deleteButton + 1] = bt -- 218
			root:addChild(deleteButton[i + 1] or Node()) -- 219
			i = i + 1 -- 205
		end -- 205
	end -- 205
	local lb1 = Label(fontName, 20) -- 222
	if lb1 then -- 222
		lb1.text = "!注意：存档0为默认存档会被自动存档覆盖！" -- 224
		lb1.color = Color(4294923520) -- 225
		lb1.position = Vec2(label_x[1], file_label_size.height / 2 + 50) -- 226
		root:addChild(lb1) -- 227
	end -- 227
	return root -- 232
end -- 119
updateViewSize() -- 238
adjustWinSize() -- 239
Director.entry:onAppChange(function(settingName) -- 240
	if settingName == "Size" then -- 240
		updateViewSize() -- 242
	end -- 242
end) -- 240
SavePage() -- 248
return ____exports -- 248