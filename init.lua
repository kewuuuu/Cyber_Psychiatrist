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
local ____ScrollBar = require("Script.UI.ScrollBar") -- 6
local AlignMode = ____ScrollBar.AlignMode -- 6
local ____List = require("Script.UI.List") -- 7
local List = ____List.List -- 7
local designSize = Size(1280, 720) -- 18
local winsize = Size(1600, 900) -- 19
local fontName = "sarasa-mono-sc-regular" -- 20
local function updateViewSize() -- 23
	local camera = tolua.cast(Director.currentCamera, "Camera2D") -- 24
	if camera then -- 24
		camera.zoom = math.min(View.size.height / designSize.height, View.size.width / designSize.width) -- 26
	end -- 26
end -- 23
local function adjustWinSize() -- 31
	App.winSize = winsize -- 32
	print("Visual size: " .. tostring(App.visualSize)) -- 33
end -- 31
local function playAnimation(node, names, interval, loop) -- 36
	node:removeAllChildren() -- 37
	local frames = {} -- 42
	for ____, name in ipairs(names) do -- 43
		local frame = Sprite(name) or Sprite() -- 44
		frame.visible = false -- 45
		frame:addTo(node) -- 46
		frames[#frames + 1] = frame -- 47
	end -- 47
	local i = 0 -- 49
	frames[i + 1].visible = true -- 50
	node:loop(function() -- 51
		sleep(interval) -- 52
		frames[(i + 1) % #names + 1].visible = true -- 53
		frames[i + 1].visible = false -- 54
		i = (i + 1) % #names -- 55
		return not loop -- 56
	end) -- 51
end -- 36
local file_num = 4 -- 60
local saveManager = __TS__New(SaveManager) -- 61
local saveSummaries = saveManager:getAllSavesSummary(file_num) -- 62
local function saveSummaryToString(summary) -- 64
	if not summary.exists then -- 64
		return ("存档" .. tostring(summary.slot)) .. "\n（无存档）" -- 66
	end -- 66
	return ((((("存档" .. tostring(summary.slot)) .. "\n进度：") .. summary.progress) .. "\n游玩时长：") .. summary.playTime) .. "\n" -- 68
end -- 64
local function saveDetailToString(detail) -- 70
	if not detail.exists then -- 70
		return ("存档" .. tostring(detail.slot)) .. "\n（无存档）" -- 72
	end -- 72
	local itemsStr = #detail.items > 0 and ("道具：" .. table.concat(detail.items, ", ")) .. "\n" or "道具：（无道具）\n" -- 74
	return (((((("存档" .. tostring(detail.slot)) .. "\n进度：") .. detail.progress) .. "\n游玩时长：") .. detail.playTime) .. "\n") .. itemsStr -- 77
end -- 70
local resources = {textures = {}, models = {}, sounds = {"Audio/《蝉鸣间的电子幽梦》欢快的桂花冰淇淋.mp3"}} -- 81
Audio:playStream(resources.sounds[1], true) -- 86
local function StartUp() -- 89
	local buttonWidth = 312 -- 90
	local buttonHeight = 124 -- 91
	local buttonx = -400 -- 92
	local buttony = {designSize.height / 5 * 4 - designSize.height / 2, designSize.height / 5 * 3 - designSize.height / 2, designSize.height / 5 * 2 - designSize.height / 2, designSize.height / 5 - designSize.height / 2} -- 93
	local function newGameClick(switched, tag) -- 100
		print("新游戏点击, switched: " .. (switched and "on" or "off")) -- 101
	end -- 100
	local function continueGameClick(switched, tag) -- 104
		print("继续游戏点击, switched: " .. (switched and "on" or "off")) -- 105
	end -- 104
	local function loadSaveClick(switched, tag) -- 108
		Director.entry:removeAllChildren() -- 110
		SavePage() -- 111
	end -- 108
	local function exitClick(switched, tag) -- 114
		print("退出游戏点击, switched: " .. (switched and "on" or "off")) -- 115
		App:shutdown() -- 116
	end -- 114
	local root = Node() -- 118
	local background = Node() -- 119
	local names = {} -- 120
	do -- 120
		local i = 1 -- 121
		while i <= 140 do -- 121
			local paddedNumber = tostring(i) -- 122
			while #paddedNumber < 4 do -- 122
				paddedNumber = "0" .. paddedNumber -- 124
			end -- 124
			names[#names + 1] = ("Image/home/背景动画/" .. paddedNumber) .. ".png" -- 126
			i = i + 1 -- 121
		end -- 121
	end -- 121
	playAnimation(background, names, 1 / 12, true) -- 128
	background.size = designSize -- 132
	background.position = Vec2(designSize.width / 2, designSize.height / 2) -- 133
	root:addChild(background) -- 134
	local bt1 = Button({ -- 138
		x = buttonx, -- 139
		y = buttony[1], -- 140
		width = buttonWidth, -- 141
		height = buttonHeight, -- 142
		onClick = continueGameClick, -- 143
		normalImage = "Image/home/jixvtouxi.png", -- 144
		pressImage = "Image/home/jixvtouxi,anxia.png" -- 145
	}) -- 145
	local defaultSave = saveManager:getSaveDetail(0) -- 148
	if not (defaultSave and defaultSave.exists) then -- 148
		bt1.node.visible = false -- 150
	end -- 150
	local bt2 = Button({ -- 154
		x = buttonx, -- 155
		y = buttony[2], -- 156
		width = buttonWidth, -- 157
		height = buttonHeight, -- 158
		onClick = newGameClick, -- 159
		normalImage = "Image/home/kaishiyouxi.png", -- 160
		pressImage = "Image/home/kaishiyouxi,anxia.png" -- 161
	}) -- 161
	local bt3 = Button({ -- 166
		x = buttonx, -- 167
		y = buttony[3], -- 168
		width = buttonWidth, -- 169
		height = buttonHeight, -- 170
		onClick = loadSaveClick, -- 171
		normalImage = "Image/home/cundang.png", -- 172
		pressImage = "Image/home/cundang,anxia.png" -- 173
	}) -- 173
	local bt4 = Button({ -- 178
		x = buttonx, -- 179
		y = buttony[4], -- 180
		width = buttonWidth, -- 181
		height = buttonHeight, -- 182
		onClick = exitClick, -- 183
		normalImage = "Image/home/tuichuyouxi.png", -- 184
		pressImage = "Image/home/tuichuyouxi,anxia.png" -- 185
	}) -- 185
	root:addChild(bt1.node) -- 188
	root:addChild(bt2.node) -- 189
	root:addChild(bt3.node) -- 190
	root:addChild(bt4.node) -- 191
	return root -- 193
end -- 89
SavePage = function() -- 196
	local saveSlots -- 196
	local file_label_size = {width = 250, height = 400} -- 197
	local delete_button_size = {width = 20, height = 20} -- 198
	local file_interval = 50 -- 199
	local totalWidth = file_num * file_label_size.width + (file_num - 1) * file_interval -- 200
	local label_x = {} -- 202
	do -- 202
		local i = 0 -- 203
		while i < file_num do -- 203
			label_x[#label_x + 1] = -totalWidth / 2 + file_label_size.width / 2 + i * (file_label_size.width + file_interval) -- 204
			i = i + 1 -- 203
		end -- 203
	end -- 203
	local function loadSaveFile(switched, tag) -- 208
		if not tag then -- 208
			return nil -- 209
		end -- 209
		local slot = __TS__ParseInt(__TS__StringTrim(tag)) -- 210
		if not saveSummaries[slot + 1].exists then -- 210
			print("新游戏") -- 212
			return nil -- 213
		end -- 213
		local saveDetail = saveManager:getSaveDetail(slot) -- 215
		if not saveDetail then -- 215
			print("存档损坏，请删除该存档") -- 217
			return nil -- 218
		else -- 218
			print(saveDetailToString(saveDetail)) -- 221
		end -- 221
		return nil -- 223
	end -- 208
	local function deleteSave(switched, tag) -- 225
		if not tag then -- 225
			return nil -- 226
		end -- 226
		local slot = __TS__ParseInt(__TS__StringTrim(tag)) -- 227
		local result = saveManager:deleteSave(slot) -- 228
		if result then -- 228
			saveSummaries = saveManager:getAllSavesSummary(file_num) -- 230
			saveSlots[slot + 1].setText(saveSummaryToString(saveSummaries[slot + 1])) -- 231
		end -- 231
		return -- 233
	end -- 225
	local root = Node() -- 237
	saveSlots = {} -- 239
	do -- 239
		local i = 0 -- 240
		while i < file_num do -- 240
			local bt = Button({ -- 242
				x = label_x[i + 1], -- 243
				y = 0, -- 244
				width = file_label_size.width, -- 245
				height = file_label_size.height, -- 246
				onClick = loadSaveFile, -- 247
				text = saveSummaryToString(saveSummaries[i + 1]), -- 248
				tag = tostring(i), -- 249
				fontSize = 30, -- 250
				textWidth = file_label_size.width -- 251
			}) -- 251
			saveSlots[#saveSlots + 1] = bt -- 253
			root:addChild(saveSlots[i + 1].node) -- 254
			i = i + 1 -- 240
		end -- 240
	end -- 240
	local deleteButton = {} -- 257
	do -- 257
		local i = 0 -- 258
		while i < file_num do -- 258
			local bt = Button({ -- 259
				x = label_x[i + 1], -- 260
				y = -file_label_size.height / 2 - delete_button_size.height / 2 - 10, -- 261
				width = delete_button_size.width, -- 262
				height = delete_button_size.height, -- 263
				onClick = deleteSave, -- 264
				text = "删除存档", -- 265
				tag = tostring(i), -- 266
				fontSize = 20, -- 267
				textWidth = file_label_size.width -- 268
			}) -- 268
			deleteButton[#deleteButton + 1] = bt -- 270
			root:addChild(deleteButton[i + 1].node) -- 271
			i = i + 1 -- 258
		end -- 258
	end -- 258
	local lb1 = Label(fontName, 20) -- 274
	if lb1 then -- 274
		lb1.text = "!注意：存档0为默认存档会被自动存档覆盖！" -- 276
		lb1.color = Color(4294923520) -- 277
		lb1.position = Vec2(label_x[1], file_label_size.height / 2 + 50) -- 278
		root:addChild(lb1) -- 279
	end -- 279
	return root -- 282
end -- 196
local function testPage() -- 286
	local root = Node() -- 287
	local list = List({ -- 322
		x = 0, -- 323
		y = 0, -- 324
		width = 500, -- 325
		height = 500, -- 326
		itemInterval = 10, -- 327
		alignmode = AlignMode.Vertical, -- 328
		autoLayout = false, -- 329
		lineInterval = 0, -- 330
		itemwidth = 200, -- 331
		itemheight = 100, -- 332
		itemnum = 10, -- 333
		normalImages = "Image/button/button.clip|button_up", -- 334
		pressImages = "Image/button/button.clip|button_down", -- 335
		texts = "sdfa", -- 336
		fontName = "sarasa-mono-sc-regular", -- 337
		fontSize = 20, -- 338
		colors = Color(4294967295), -- 339
		textWidth = Label.AutomaticWidth, -- 340
		alignment = "Center", -- 341
		textisdeleted = false, -- 342
		tags = "0", -- 343
		backgroundImage = "Image/background/background.png", -- 344
		scrollblockImage = "Image/button/button.png", -- 345
		scrollbarwidth = 10 -- 346
	}) -- 346
	return root -- 349
end -- 286
updateViewSize() -- 353
adjustWinSize() -- 354
Director.entry:onAppChange(function(settingName) -- 355
	if settingName == "Size" then -- 355
		updateViewSize() -- 357
	end -- 357
end) -- 355
StartUp() -- 362
return ____exports -- 362