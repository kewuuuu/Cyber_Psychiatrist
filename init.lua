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
local Sprite = ____Dora.Sprite -- 2
local Size = ____Dora.Size -- 2
local App = ____Dora.App -- 2
local Vec2 = ____Dora.Vec2 -- 2
local View = ____Dora.View -- 2
local tolua = ____Dora.tolua -- 2
local Label = ____Dora.Label -- 2
local Color = ____Dora.Color -- 2
local sleep = ____Dora.sleep -- 2
local ____Button = require("Script.UI.Button") -- 3
local Button = ____Button.Button -- 3
local ____Dora = require("Dora") -- 4
local Audio = ____Dora.Audio -- 4
local ____SaveManager = require("Script.SaveManager") -- 5
local SaveManager = ____SaveManager.SaveManager -- 5
local designSize = Size(1280, 720) -- 17
local winsize = Size(1600, 900) -- 18
local fontName = "sarasa-mono-sc-regular" -- 19
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
local function playAnimation(node, names, interval, loop) -- 35
	node:removeAllChildren() -- 36
	local frames = {} -- 41
	for ____, name in ipairs(names) do -- 42
		local frame = Sprite(name) or Sprite() -- 43
		frame.visible = false -- 44
		frame:addTo(node) -- 45
		frames[#frames + 1] = frame -- 46
	end -- 46
	local i = 0 -- 48
	frames[i + 1].visible = true -- 49
	node:loop(function() -- 50
		sleep(interval) -- 51
		frames[(i + 1) % #names + 1].visible = true -- 52
		frames[i + 1].visible = false -- 53
		i = (i + 1) % #names -- 54
		return not loop -- 55
	end) -- 50
end -- 35
local file_num = 4 -- 59
local saveManager = __TS__New(SaveManager) -- 60
local saveSummaries = saveManager:getAllSavesSummary(file_num) -- 61
local function saveSummaryToString(summary) -- 63
	if not summary.exists then -- 63
		return ("存档" .. tostring(summary.slot)) .. "\n（无存档）" -- 65
	end -- 65
	return ((((("存档" .. tostring(summary.slot)) .. "\n进度：") .. summary.progress) .. "\n游玩时长：") .. summary.playTime) .. "\n" -- 67
end -- 63
local function saveDetailToString(detail) -- 69
	if not detail.exists then -- 69
		return ("存档" .. tostring(detail.slot)) .. "\n（无存档）" -- 71
	end -- 71
	local itemsStr = #detail.items > 0 and ("道具：" .. table.concat(detail.items, ", ")) .. "\n" or "道具：（无道具）\n" -- 73
	return (((((("存档" .. tostring(detail.slot)) .. "\n进度：") .. detail.progress) .. "\n游玩时长：") .. detail.playTime) .. "\n") .. itemsStr -- 76
end -- 69
local resources = {textures = {}, models = {}, sounds = {"Audio/《蝉鸣间的电子幽梦》欢快的桂花冰淇淋.mp3"}} -- 80
Audio:playStream(resources.sounds[1], true) -- 85
local function StartUp() -- 88
	local buttonWidth = 312 -- 89
	local buttonHeight = 124 -- 90
	local buttonx = -400 -- 91
	local buttony = {designSize.height / 5 * 4 - designSize.height / 2, designSize.height / 5 * 3 - designSize.height / 2, designSize.height / 5 * 2 - designSize.height / 2, designSize.height / 5 - designSize.height / 2} -- 92
	local function newGameClick(switched, tag) -- 99
		print("新游戏点击, switched: " .. (switched and "on" or "off")) -- 100
	end -- 99
	local function continueGameClick(switched, tag) -- 103
		print("继续游戏点击, switched: " .. (switched and "on" or "off")) -- 104
	end -- 103
	local function loadSaveClick(switched, tag) -- 107
		Director.entry:removeAllChildren() -- 109
		SavePage() -- 110
	end -- 107
	local function exitClick(switched, tag) -- 113
		print("退出游戏点击, switched: " .. (switched and "on" or "off")) -- 114
		App:shutdown() -- 115
	end -- 113
	local root = Node() -- 117
	local background = Node() -- 118
	local names = {} -- 119
	do -- 119
		local i = 1 -- 120
		while i <= 140 do -- 120
			local paddedNumber = tostring(i) -- 121
			while #paddedNumber < 4 do -- 121
				paddedNumber = "0" .. paddedNumber -- 123
			end -- 123
			names[#names + 1] = ("Image/home/背景动画/" .. paddedNumber) .. ".png" -- 125
			i = i + 1 -- 120
		end -- 120
	end -- 120
	playAnimation(background, names, 1 / 12, true) -- 127
	background.size = designSize -- 131
	background.position = Vec2(designSize.width / 2, designSize.height / 2) -- 132
	root:addChild(background) -- 133
	local ____Button_result_0 = Button({ -- 137
		x = buttonx, -- 138
		y = buttony[1], -- 139
		width = buttonWidth, -- 140
		height = buttonHeight, -- 141
		onClick = continueGameClick, -- 142
		normalImage = "Image/home/jixvtouxi.png", -- 143
		pressImage = "Image/home/jixvtouxi,anxia.png" -- 144
	}) -- 144
	local bt1 = ____Button_result_0.root -- 144
	local defaultSave = saveManager:getSaveDetail(0) -- 147
	if not (defaultSave and defaultSave.exists) then -- 147
		bt1.visible = false -- 149
	end -- 149
	local ____Button_result_1 = Button({ -- 153
		x = buttonx, -- 154
		y = buttony[2], -- 155
		width = buttonWidth, -- 156
		height = buttonHeight, -- 157
		onClick = newGameClick, -- 158
		normalImage = "Image/home/kaishiyouxi.png", -- 159
		pressImage = "Image/home/kaishiyouxi,anxia.png" -- 160
	}) -- 160
	local bt2 = ____Button_result_1.root -- 160
	local ____Button_result_2 = Button({ -- 165
		x = buttonx, -- 166
		y = buttony[3], -- 167
		width = buttonWidth, -- 168
		height = buttonHeight, -- 169
		onClick = loadSaveClick, -- 170
		normalImage = "Image/home/cundang.png", -- 171
		pressImage = "Image/home/cundang,anxia.png" -- 172
	}) -- 172
	local bt3 = ____Button_result_2.root -- 172
	local ____Button_result_3 = Button({ -- 177
		x = buttonx, -- 178
		y = buttony[4], -- 179
		width = buttonWidth, -- 180
		height = buttonHeight, -- 181
		onClick = exitClick, -- 182
		normalImage = "Image/home/tuichuyouxi.png", -- 183
		pressImage = "Image/home/tuichuyouxi,anxia.png" -- 184
	}) -- 184
	local bt4 = ____Button_result_3.root -- 184
	root:addChild(bt1) -- 187
	root:addChild(bt2) -- 188
	root:addChild(bt3) -- 189
	root:addChild(bt4) -- 190
	return root -- 192
end -- 88
SavePage = function() -- 195
	local saveSlots -- 195
	local file_label_size = {width = 250, height = 400} -- 196
	local delete_button_size = {width = 20, height = 20} -- 197
	local file_interval = 50 -- 198
	local totalWidth = file_num * file_label_size.width + (file_num - 1) * file_interval -- 199
	local label_x = {} -- 201
	do -- 201
		local i = 0 -- 202
		while i < file_num do -- 202
			label_x[#label_x + 1] = -totalWidth / 2 + file_label_size.width / 2 + i * (file_label_size.width + file_interval) -- 203
			i = i + 1 -- 202
		end -- 202
	end -- 202
	local function loadSaveFile(switched, tag) -- 207
		if not tag then -- 207
			return nil -- 208
		end -- 208
		local slot = __TS__ParseInt(__TS__StringTrim(tag)) -- 209
		if not saveSummaries[slot + 1].exists then -- 209
			print("新游戏") -- 211
			return nil -- 212
		end -- 212
		local saveDetail = saveManager:getSaveDetail(slot) -- 214
		if not saveDetail then -- 214
			print("存档损坏，请删除该存档") -- 216
			return nil -- 217
		else -- 217
			print(saveDetailToString(saveDetail)) -- 220
		end -- 220
		return nil -- 222
	end -- 207
	local function deleteSave(switched, tag) -- 224
		if not tag then -- 224
			return nil -- 225
		end -- 225
		local slot = __TS__ParseInt(__TS__StringTrim(tag)) -- 226
		local result = saveManager:deleteSave(slot) -- 227
		if result then -- 227
			saveSummaries = saveManager:getAllSavesSummary(file_num) -- 229
			saveSlots[slot + 1].st(saveSummaryToString(saveSummaries[slot + 1])) -- 230
		end -- 230
		return -- 232
	end -- 224
	local root = Node() -- 236
	saveSlots = {} -- 238
	do -- 238
		local i = 0 -- 242
		while i < file_num do -- 242
			local ____Button_result_4 = Button({ -- 244
				x = label_x[i + 1], -- 245
				y = 0, -- 246
				width = file_label_size.width, -- 247
				height = file_label_size.height, -- 248
				onClick = loadSaveFile, -- 249
				text = saveSummaryToString(saveSummaries[i + 1]), -- 250
				tag = tostring(i), -- 251
				fontSize = 30, -- 252
				textWidth = file_label_size.width -- 253
			}) -- 253
			local bt = ____Button_result_4.root -- 253
			local st = ____Button_result_4.setText -- 253
			saveSlots[#saveSlots + 1] = {bt = bt, st = st} -- 255
			root:addChild(saveSlots[i + 1].bt or Node()) -- 256
			i = i + 1 -- 242
		end -- 242
	end -- 242
	local deleteButton = {} -- 259
	do -- 259
		local i = 0 -- 260
		while i < file_num do -- 260
			local ____Button_result_5 = Button({ -- 261
				x = label_x[i + 1], -- 262
				y = -file_label_size.height / 2 - delete_button_size.height / 2 - 10, -- 263
				width = delete_button_size.width, -- 264
				height = delete_button_size.height, -- 265
				onClick = deleteSave, -- 266
				text = "删除存档", -- 267
				tag = tostring(i), -- 268
				fontSize = 20, -- 269
				textWidth = file_label_size.width -- 270
			}) -- 270
			local bt = ____Button_result_5.root -- 270
			deleteButton[#deleteButton + 1] = bt -- 272
			root:addChild(deleteButton[i + 1] or Node()) -- 273
			i = i + 1 -- 260
		end -- 260
	end -- 260
	local lb1 = Label(fontName, 20) -- 276
	if lb1 then -- 276
		lb1.text = "!注意：存档0为默认存档会被自动存档覆盖！" -- 278
		lb1.color = Color(4294923520) -- 279
		lb1.position = Vec2(label_x[1], file_label_size.height / 2 + 50) -- 280
		root:addChild(lb1) -- 281
	end -- 281
	return root -- 286
end -- 195
local function testPage() -- 290
	local root = Node() -- 298
	local names = {} -- 299
	do -- 299
		local i = 1 -- 300
		while i <= 140 do -- 300
			local paddedNumber = tostring(i) -- 301
			while #paddedNumber < 4 do -- 301
				paddedNumber = "0" .. paddedNumber -- 303
			end -- 303
			names[#names + 1] = ("Image/home/背景动画/" .. paddedNumber) .. ".png" -- 305
			i = i + 1 -- 300
		end -- 300
	end -- 300
	playAnimation(root, names, 1 / 12, true) -- 307
	return root -- 310
end -- 290
updateViewSize() -- 314
adjustWinSize() -- 315
Director.entry:onAppChange(function(settingName) -- 316
	if settingName == "Size" then -- 316
		updateViewSize() -- 318
	end -- 318
end) -- 316
SavePage() -- 324
return ____exports -- 324