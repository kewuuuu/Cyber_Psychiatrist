-- [tsx]: init.tsx
local ____lualib = require("lualib_bundle") -- 1
local __TS__New = ____lualib.__TS__New -- 1
local __TS__StringTrim = ____lualib.__TS__StringTrim -- 1
local __TS__ParseInt = ____lualib.__TS__ParseInt -- 1
local ____exports = {} -- 1
local SavePage -- 1
local ____Dora = require("Dora") -- 2
local Director = ____Dora.Director -- 2
local Node = ____Dora.Node -- 2
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
local ____Animation = require("Script.Animation.Animation") -- 9
local playAnimation = ____Animation.playAnimation -- 9
local ____CG = require("Script.Animation.CG") -- 10
local CG = ____CG.CG -- 10
local ____config = require("Script.config") -- 11
local designSize = ____config.designSize -- 11
local winsize = ____config.winsize -- 11
local fontName = ____config.fontName -- 11
local function updateViewSize() -- 22
	local camera = tolua.cast(Director.currentCamera, "Camera2D") -- 23
	if camera then -- 23
		camera.zoom = math.min(View.size.height / designSize.height, View.size.width / designSize.width) -- 25
	end -- 25
end -- 22
local function adjustWinSize() -- 30
	App.winSize = winsize -- 31
	print("Visual size: " .. tostring(App.visualSize)) -- 32
end -- 30
local file_num = 4 -- 35
local saveManager = __TS__New(SaveManager) -- 36
local saveSummaries = saveManager:getAllSavesSummary(file_num) -- 37
local function saveSummaryToString(summary) -- 39
	if not summary.exists then -- 39
		return ("存档" .. tostring(summary.slot)) .. "\n（无存档）" -- 41
	end -- 41
	return ((((("存档" .. tostring(summary.slot)) .. "\n进度：") .. summary.progress) .. "\n游玩时长：") .. summary.playTime) .. "\n" -- 43
end -- 39
local function saveDetailToString(detail) -- 45
	if not detail.exists then -- 45
		return ("存档" .. tostring(detail.slot)) .. "\n（无存档）" -- 47
	end -- 47
	local itemsStr = #detail.items > 0 and ("道具：" .. table.concat(detail.items, ", ")) .. "\n" or "道具：（无道具）\n" -- 49
	return (((((("存档" .. tostring(detail.slot)) .. "\n进度：") .. detail.progress) .. "\n游玩时长：") .. detail.playTime) .. "\n") .. itemsStr -- 52
end -- 45
local resources = {textures = {}, models = {}, sounds = {"Audio/《蝉鸣间的电子幽梦》欢快的桂花冰淇淋.mp3"}} -- 56
Audio:playStream(resources.sounds[1], true) -- 61
local function StartUp() -- 64
	local buttonWidth = 312 -- 65
	local buttonHeight = 124 -- 66
	local buttonx = -400 -- 67
	local buttony = {designSize.height / 5 * 4 - designSize.height / 2, designSize.height / 5 * 3 - designSize.height / 2, designSize.height / 5 * 2 - designSize.height / 2, designSize.height / 5 - designSize.height / 2} -- 68
	local function newGameClick(switched, tag) -- 75
		print("新游戏点击, switched: " .. (switched and "on" or "off")) -- 76
	end -- 75
	local function continueGameClick(switched, tag) -- 79
		print("继续游戏点击, switched: " .. (switched and "on" or "off")) -- 80
	end -- 79
	local function loadSaveClick(switched, tag) -- 83
		Director.entry:removeAllChildren() -- 85
		SavePage() -- 86
	end -- 83
	local function exitClick(switched, tag) -- 89
		print("退出游戏点击, switched: " .. (switched and "on" or "off")) -- 90
		App:shutdown() -- 91
	end -- 89
	local root = Node() -- 93
	local background = Node() -- 94
	local names = {} -- 95
	do -- 95
		local i = 1 -- 96
		while i <= 140 do -- 96
			local paddedNumber = tostring(i) -- 97
			while #paddedNumber < 4 do -- 97
				paddedNumber = "0" .. paddedNumber -- 99
			end -- 99
			names[#names + 1] = ("Image/home/背景动画/" .. paddedNumber) .. ".png" -- 101
			i = i + 1 -- 96
		end -- 96
	end -- 96
	playAnimation(background, names, 1 / 12, true) -- 103
	background.size = designSize -- 107
	background.position = Vec2(designSize.width / 2, designSize.height / 2) -- 108
	root:addChild(background) -- 109
	local bt1 = Button({ -- 113
		x = buttonx, -- 114
		y = buttony[1], -- 115
		width = buttonWidth, -- 116
		height = buttonHeight, -- 117
		onClick = continueGameClick, -- 118
		normalImage = "Image/home/jixvtouxi.png", -- 119
		pressImage = "Image/home/jixvtouxi,anxia.png" -- 120
	}) -- 120
	local defaultSave = saveManager:getSaveDetail(0) -- 123
	if not (defaultSave and defaultSave.exists) then -- 123
		bt1.node.visible = false -- 125
	end -- 125
	local bt2 = Button({ -- 129
		x = buttonx, -- 130
		y = buttony[2], -- 131
		width = buttonWidth, -- 132
		height = buttonHeight, -- 133
		onClick = newGameClick, -- 134
		normalImage = "Image/home/kaishiyouxi.png", -- 135
		pressImage = "Image/home/kaishiyouxi,anxia.png" -- 136
	}) -- 136
	local bt3 = Button({ -- 141
		x = buttonx, -- 142
		y = buttony[3], -- 143
		width = buttonWidth, -- 144
		height = buttonHeight, -- 145
		onClick = loadSaveClick, -- 146
		normalImage = "Image/home/cundang.png", -- 147
		pressImage = "Image/home/cundang,anxia.png" -- 148
	}) -- 148
	local bt4 = Button({ -- 153
		x = buttonx, -- 154
		y = buttony[4], -- 155
		width = buttonWidth, -- 156
		height = buttonHeight, -- 157
		onClick = exitClick, -- 158
		normalImage = "Image/home/tuichuyouxi.png", -- 159
		pressImage = "Image/home/tuichuyouxi,anxia.png" -- 160
	}) -- 160
	root:addChild(bt1.node) -- 163
	root:addChild(bt2.node) -- 164
	root:addChild(bt3.node) -- 165
	root:addChild(bt4.node) -- 166
	return root -- 168
end -- 64
SavePage = function() -- 171
	local saveSlots -- 171
	local file_label_size = {width = 250, height = 400} -- 172
	local delete_button_size = {width = 20, height = 20} -- 173
	local file_interval = 50 -- 174
	local totalWidth = file_num * file_label_size.width + (file_num - 1) * file_interval -- 175
	local label_x = {} -- 177
	do -- 177
		local i = 0 -- 178
		while i < file_num do -- 178
			label_x[#label_x + 1] = -totalWidth / 2 + file_label_size.width / 2 + i * (file_label_size.width + file_interval) -- 179
			i = i + 1 -- 178
		end -- 178
	end -- 178
	local function loadSaveFile(switched, tag) -- 183
		if not tag then -- 183
			return nil -- 184
		end -- 184
		local slot = __TS__ParseInt(__TS__StringTrim(tag)) -- 185
		if not saveSummaries[slot + 1].exists then -- 185
			print("新游戏") -- 187
			return nil -- 188
		end -- 188
		local saveDetail = saveManager:getSaveDetail(slot) -- 190
		if not saveDetail then -- 190
			print("存档损坏，请删除该存档") -- 192
			return nil -- 193
		else -- 193
			print(saveDetailToString(saveDetail)) -- 196
		end -- 196
		return nil -- 198
	end -- 183
	local function deleteSave(switched, tag) -- 200
		if not tag then -- 200
			return nil -- 201
		end -- 201
		local slot = __TS__ParseInt(__TS__StringTrim(tag)) -- 202
		local result = saveManager:deleteSave(slot) -- 203
		if result then -- 203
			saveSummaries = saveManager:getAllSavesSummary(file_num) -- 205
			saveSlots[slot + 1].setText(saveSummaryToString(saveSummaries[slot + 1])) -- 206
		end -- 206
		return -- 208
	end -- 200
	local root = Node() -- 212
	saveSlots = {} -- 214
	do -- 214
		local i = 0 -- 215
		while i < file_num do -- 215
			local bt = Button({ -- 217
				x = label_x[i + 1], -- 218
				y = 0, -- 219
				width = file_label_size.width, -- 220
				height = file_label_size.height, -- 221
				onClick = loadSaveFile, -- 222
				text = saveSummaryToString(saveSummaries[i + 1]), -- 223
				tag = tostring(i), -- 224
				fontSize = 30, -- 225
				textWidth = file_label_size.width -- 226
			}) -- 226
			saveSlots[#saveSlots + 1] = bt -- 228
			root:addChild(saveSlots[i + 1].node) -- 229
			i = i + 1 -- 215
		end -- 215
	end -- 215
	local deleteButton = {} -- 232
	do -- 232
		local i = 0 -- 233
		while i < file_num do -- 233
			local bt = Button({ -- 234
				x = label_x[i + 1], -- 235
				y = -file_label_size.height / 2 - delete_button_size.height / 2 - 10, -- 236
				width = delete_button_size.width, -- 237
				height = delete_button_size.height, -- 238
				onClick = deleteSave, -- 239
				text = "删除存档", -- 240
				tag = tostring(i), -- 241
				fontSize = 20, -- 242
				textWidth = file_label_size.width -- 243
			}) -- 243
			deleteButton[#deleteButton + 1] = bt -- 245
			root:addChild(deleteButton[i + 1].node) -- 246
			i = i + 1 -- 233
		end -- 233
	end -- 233
	local lb1 = Label(fontName, 20) -- 249
	if lb1 then -- 249
		lb1.text = "!注意：存档0为默认存档会被自动存档覆盖！" -- 251
		lb1.color = Color(4294923520) -- 252
		lb1.position = Vec2(label_x[1], file_label_size.height / 2 + 50) -- 253
		root:addChild(lb1) -- 254
	end -- 254
	return root -- 257
end -- 171
local function testPage() -- 261
	local root = Node() -- 262
	CG(root, "Image/CG/1", 3) -- 324
	return root -- 325
end -- 261
updateViewSize() -- 329
adjustWinSize() -- 330
Director.entry:onAppChange(function(settingName) -- 331
	if settingName == "Size" then -- 331
		updateViewSize() -- 333
	end -- 333
end) -- 331
testPage() -- 340
return ____exports -- 340