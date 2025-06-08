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
local ____ScrollBar = require("Script.UI.ScrollBar") -- 6
local ScrollBar = ____ScrollBar.ScrollBar -- 6
local AlignMode = ____ScrollBar.AlignMode -- 6
local designSize = Size(1280, 720) -- 8
local winsize = Size(1600, 900) -- 9
local fontName = "sarasa-mono-sc-regular" -- 10
local function updateViewSize() -- 13
	local camera = tolua.cast(Director.currentCamera, "Camera2D") -- 14
	if camera then -- 14
		camera.zoom = math.min(View.size.height / designSize.height, View.size.width / designSize.width) -- 16
	end -- 16
end -- 13
local function adjustWinSize() -- 21
	App.winSize = winsize -- 22
	print("Visual size: " .. tostring(App.visualSize)) -- 23
end -- 21
local resources = {textures = {}, models = {}, sounds = {"Audio/《蝉鸣间的电子幽梦》欢快的桂花冰淇淋.mp3"}} -- 27
Audio:playStream(resources.sounds[1], true) -- 32
local function StartUp() -- 35
	local buttonWidth = 200 -- 36
	local buttonHeight = 100 -- 37
	local buttonx = 0 -- 38
	local buttony = {designSize.height / 5 * 4 - designSize.height / 2, designSize.height / 5 * 3 - designSize.height / 2, designSize.height / 5 * 2 - designSize.height / 2, designSize.height / 5 - designSize.height / 2} -- 39
	local function newGameClick(switched, tag) -- 46
		print("新游戏点击, switched: " .. (switched and "on" or "off")) -- 47
	end -- 46
	local function continueGameClick(switched, tag) -- 50
		print("继续游戏点击, switched: " .. (switched and "on" or "off")) -- 51
	end -- 50
	local function loadSaveClick(switched, tag) -- 54
		print("加载游戏点击, switched: " .. (switched and "on" or "off")) -- 55
	end -- 54
	local function exitClick(switched, tag) -- 58
		print("退出游戏点击, switched: " .. (switched and "on" or "off")) -- 59
		App:shutdown() -- 60
	end -- 58
	local root = Node() -- 62
	local background = Sprite("Image/background/background.png") -- 63
	if background then -- 63
		background.size = designSize -- 65
		root:addChild(background) -- 66
	end -- 66
	local ____Button_result_0 = Button({ -- 70
		x = buttonx, -- 71
		y = buttony[1], -- 72
		width = buttonWidth, -- 73
		height = buttonHeight, -- 74
		onClick = continueGameClick, -- 75
		text = "继续游戏" -- 76
	}) -- 76
	local bt1 = ____Button_result_0.root -- 76
	local ____Button_result_1 = Button({ -- 80
		x = buttonx, -- 81
		y = buttony[2], -- 82
		width = buttonWidth, -- 83
		height = buttonHeight, -- 84
		onClick = newGameClick, -- 85
		text = "新游戏" -- 86
	}) -- 86
	local bt2 = ____Button_result_1.root -- 86
	local ____Button_result_2 = Button({ -- 90
		x = buttonx, -- 91
		y = buttony[3], -- 92
		width = buttonWidth, -- 93
		height = buttonHeight, -- 94
		onClick = loadSaveClick, -- 95
		text = "读取存档" -- 96
	}) -- 96
	local bt3 = ____Button_result_2.root -- 96
	local ____Button_result_3 = Button({ -- 100
		x = buttonx, -- 101
		y = buttony[4], -- 102
		width = buttonWidth, -- 103
		height = buttonHeight, -- 104
		onClick = exitClick, -- 105
		text = "退出游戏" -- 106
	}) -- 106
	local bt4 = ____Button_result_3.root -- 106
	root:addChild(bt1) -- 108
	root:addChild(bt2) -- 109
	root:addChild(bt3) -- 110
	root:addChild(bt4) -- 111
	return root -- 113
end -- 35
local function SavePage() -- 116
	local saveSlots -- 116
	local file_num = 4 -- 117
	local file_label_size = {width = 250, height = 400} -- 118
	local delete_button_size = {width = 20, height = 20} -- 119
	local file_interval = 50 -- 120
	local totalWidth = file_num * file_label_size.width + (file_num - 1) * file_interval -- 121
	local label_x = {} -- 123
	do -- 123
		local i = 0 -- 124
		while i < file_num do -- 124
			label_x[#label_x + 1] = -totalWidth / 2 + file_label_size.width / 2 + i * (file_label_size.width + file_interval) -- 125
			i = i + 1 -- 124
		end -- 124
	end -- 124
	local saveManager = __TS__New(SaveManager) -- 128
	local saveSummaries = saveManager:getAllSavesSummary(file_num) -- 129
	local function saveSummaryToString(summary) -- 131
		if not summary.exists then -- 131
			return ("存档" .. tostring(summary.slot)) .. "\n（无存档）" -- 133
		end -- 133
		return ((((("存档" .. tostring(summary.slot)) .. "\n进度：") .. summary.progress) .. "\n游玩时长：") .. summary.playTime) .. "\n" -- 135
	end -- 131
	local function saveDetailToString(detail) -- 137
		if not detail.exists then -- 137
			return ("存档" .. tostring(detail.slot)) .. "\n（无存档）" -- 139
		end -- 139
		local itemsStr = #detail.items > 0 and ("道具：" .. table.concat(detail.items, ", ")) .. "\n" or "道具：（无道具）\n" -- 141
		return (((((("存档" .. tostring(detail.slot)) .. "\n进度：") .. detail.progress) .. "\n游玩时长：") .. detail.playTime) .. "\n") .. itemsStr -- 144
	end -- 137
	local function loadSaveFile(switched, tag) -- 149
		if not tag then -- 149
			return nil -- 150
		end -- 150
		local slot = __TS__ParseInt(__TS__StringTrim(tag)) -- 151
		if not saveSummaries[slot + 1].exists then -- 151
			print("新游戏") -- 153
			return nil -- 154
		end -- 154
		local saveDetail = saveManager:getSaveDetail(slot) -- 156
		if not saveDetail then -- 156
			print("存档损坏，请删除该存档") -- 158
			return nil -- 159
		else -- 159
			print(saveDetailToString(saveDetail)) -- 162
		end -- 162
		return nil -- 164
	end -- 149
	local function deleteSave(switched, tag) -- 166
		if not tag then -- 166
			return nil -- 167
		end -- 167
		local slot = __TS__ParseInt(__TS__StringTrim(tag)) -- 168
		local result = saveManager:deleteSave(slot) -- 169
		if result then -- 169
			saveSummaries = saveManager:getAllSavesSummary(file_num) -- 171
			saveSlots[slot + 1].st(saveSummaryToString(saveSummaries[slot + 1])) -- 172
		end -- 172
		return -- 174
	end -- 166
	local root = Node() -- 178
	saveSlots = {} -- 180
	do -- 180
		local i = 0 -- 184
		while i < file_num do -- 184
			local ____Button_result_4 = Button({ -- 185
				x = label_x[i + 1], -- 186
				y = 0, -- 187
				width = file_label_size.width, -- 188
				height = file_label_size.height, -- 189
				onClick = loadSaveFile, -- 190
				text = saveSummaryToString(saveSummaries[i + 1]), -- 191
				tag = tostring(i), -- 192
				fontSize = 30, -- 193
				textWidth = file_label_size.width -- 194
			}) -- 194
			local bt = ____Button_result_4.root -- 194
			local st = ____Button_result_4.setText -- 194
			saveSlots[#saveSlots + 1] = {bt = bt, st = st} -- 196
			root:addChild(saveSlots[i + 1].bt or Node()) -- 197
			i = i + 1 -- 184
		end -- 184
	end -- 184
	local deleteButton = {} -- 200
	do -- 200
		local i = 0 -- 201
		while i < file_num do -- 201
			local ____Button_result_5 = Button({ -- 202
				x = label_x[i + 1], -- 203
				y = -file_label_size.height / 2 - delete_button_size.height / 2 - 10, -- 204
				width = delete_button_size.width, -- 205
				height = delete_button_size.height, -- 206
				onClick = deleteSave, -- 207
				text = "删除存档", -- 208
				tag = tostring(i), -- 209
				fontSize = 20, -- 210
				textWidth = file_label_size.width -- 211
			}) -- 211
			local bt = ____Button_result_5.root -- 211
			deleteButton[#deleteButton + 1] = bt -- 213
			root:addChild(deleteButton[i + 1] or Node()) -- 214
			i = i + 1 -- 201
		end -- 201
	end -- 201
	local lb1 = Label(fontName, 20) -- 217
	if lb1 then -- 217
		lb1.text = "!注意：存档0为默认存档会被自动存档覆盖！" -- 219
		lb1.color = Color(4294923520) -- 220
		lb1.position = Vec2(label_x[1], file_label_size.height / 2 + 50) -- 221
		root:addChild(lb1) -- 222
	end -- 222
	return root -- 227
end -- 116
local function testPage() -- 230
	local root = ScrollBar({width = 500, height = 500, alignmode = AlignMode.Vertical, totalwidth = 5000}) -- 231
	return root -- 237
end -- 230
updateViewSize() -- 241
adjustWinSize() -- 242
Director.entry:onAppChange(function(settingName) -- 243
	if settingName == "Size" then -- 243
		updateViewSize() -- 245
	end -- 245
end) -- 243
testPage() -- 252
return ____exports -- 252