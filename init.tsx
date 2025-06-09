import { React, toNode } from 'DoraX';
import { Director, Node, Sprite, Size, App, Vec2, View, tolua, TypeName, Camera2D, Label, TextAlign, Color, sleep, Path, Content } from 'Dora';
import { Button, ButtonNode } from 'Script/UI/Button';
import { DB, thread, SQL, Audio } from "Dora";
import { SaveManager, SaveSummary, SaveDetail } from "Script/SaveManager";
import { ScrollBarNode, ScrollBar, AlignMode } from "Script/UI/ScrollBar"
import { List, ListNode } from "Script/UI/List"
import { Model } from "Dora";
import { playAnimation } from "Script/Animation/Animation";
import { CG } from "Script/Animation/CG";
import { designSize, winsize, fontName } from "Script/config";
// const currentScriptPath = Path.getScriptPath("Dora")
// Content.searchPaths = {
// 	Path(currentScriptPath, "Script"),
// 	Path(currentScriptPath),
// 	Path(Content.assetPath, "Script", "Lib"),
// 	Path(Content.assetPath, "Script", "Lib", "Dora", "zh-Hans")
// }


// 更新视图大小
const updateViewSize = () => {
	const camera = tolua.cast(Director.currentCamera, TypeName.Camera2D);
	if (camera) {
		camera.zoom = Math.min(View.size.height / designSize.height, View.size.width / designSize.width);
	}
};

// 自动调整窗口
const adjustWinSize = () => {
	App.winSize = winsize;
	print(`Visual size: ${App.visualSize}`);
};
//存档操作
const file_num = 4;
const saveManager = new SaveManager();
let saveSummaries = saveManager.getAllSavesSummary(file_num);
//存档概要、详情tostring
const saveSummaryToString = (summary: SaveSummary) => {
	if (!summary.exists) {
		return `存档${summary.slot}\n（无存档）`;
	}
	return `存档${summary.slot}\n进度：${summary.progress}\n游玩时长：${summary.playTime}\n`;
}
const saveDetailToString = (detail: SaveDetail): string => {
	if (!detail.exists) {
		return `存档${detail.slot}\n（无存档）`;
	}
	const itemsStr = detail.items.length > 0
		? `道具：${detail.items.join(', ')}\n`
		: `道具：（无道具）\n`;
	return `存档${detail.slot}\n进度：${detail.progress}\n游玩时长：${detail.playTime}\n${itemsStr}`;
};

//音频
const resources = {
	textures: [],
	models: [],
	sounds: ["Audio/《蝉鸣间的电子幽梦》欢快的桂花冰淇淋.mp3"]
};
Audio.playStream(resources.sounds[0], true);

// 启动场景
const StartUp = () => {
	const buttonWidth = 312;
	const buttonHeight = 124;
	const buttonx = -400;
	const buttony: number[] = [
		designSize.height / 5 * 4 - designSize.height / 2,
		designSize.height / 5 * 3 - designSize.height / 2,
		designSize.height / 5 * 2 - designSize.height / 2,
		designSize.height / 5 - designSize.height / 2
	];

	const newGameClick = (switched: boolean, tag: string | null) => {
		print(`新游戏点击, switched: ${switched ? "on" : "off"}`);
	};

	const continueGameClick = (switched: boolean, tag: string | null) => {
		print(`继续游戏点击, switched: ${switched ? "on" : "off"}`);
	};

	const loadSaveClick = (switched: boolean, tag: string | null) => {
		// print(`加载游戏点击, switched: ${switched ? "on" : "off"}`);
		Director.entry.removeAllChildren();
		SavePage();
	};

	const exitClick = (switched: boolean, tag: string | null) => {
		print(`退出游戏点击, switched: ${switched ? "on" : "off"}`);
		App.shutdown();
	};
	const root = Node();
	const background = Node();
	const names: string[] = [];
	for (let i = 1; i <= 140; i++) {
		let paddedNumber = i.toString();
		while (paddedNumber.length < 4) {
			paddedNumber = "0" + paddedNumber;
		}
		names.push(`Image/home/背景动画/${paddedNumber}.png`);
	}
	playAnimation(background, names, 1 / 12, true);

	// const background = Sprite("Image/background/background.png");
	// if (background) {
	background.size = designSize;
	background.position = Vec2(designSize.width / 2, designSize.height / 2)
	root.addChild(background);
	// }

	// 按钮1
	const bt1 = Button({
		x: buttonx,
		y: buttony[0],
		width: buttonWidth,
		height: buttonHeight,
		onClick: continueGameClick,
		normalImage: "Image/home/jixvtouxi.png",
		pressImage: "Image/home/jixvtouxi,anxia.png",
		// text: "继续游戏",
	});
	const defaultSave = saveManager.getSaveDetail(0);
	if(!(defaultSave && defaultSave.exists)){
		bt1.node.visible=false;
	}

	//按钮2
	const bt2 = Button({
		x: buttonx,
		y: buttony[1],
		width: buttonWidth,
		height: buttonHeight,
		onClick: newGameClick,
		normalImage: "Image/home/kaishiyouxi.png",
		pressImage: "Image/home/kaishiyouxi,anxia.png",
		// text: "新游戏",
	});

	// 按钮3
	const bt3 = Button({
		x: buttonx,
		y: buttony[2],
		width: buttonWidth,
		height: buttonHeight,
		onClick: loadSaveClick,
		normalImage: "Image/home/cundang.png",
		pressImage: "Image/home/cundang,anxia.png",
		// text: "读取存档",
	});

	// 按钮4
	const bt4 = Button({
		x: buttonx,
		y: buttony[3],
		width: buttonWidth,
		height: buttonHeight,
		onClick: exitClick,
		normalImage: "Image/home/tuichuyouxi.png",
		pressImage: "Image/home/tuichuyouxi,anxia.png",
		// text: "退出游戏",
	});
	root.addChild(bt1.node);
	root.addChild(bt2.node);
	root.addChild(bt3.node);
	root.addChild(bt4.node);

	return root;
};

const SavePage = () => {
	const file_label_size = { width: 250, height: 400 };
	const delete_button_size = { width: 20, height: 20 };
	const file_interval = 50;
	const totalWidth = (file_num * file_label_size.width) + ((file_num - 1) * file_interval);

	const label_x: number[] = [];
	for (let i = 0; i < file_num; i++) {
		label_x.push(-totalWidth / 2 + file_label_size.width / 2 + i * (file_label_size.width + file_interval));
	}

	//各类事件
	const loadSaveFile = (switched: boolean, tag: string | null) => {
		if (!tag) return null;
		const slot = parseInt(tag.trim());
		if (!saveSummaries[slot].exists) {
			print("新游戏");
			return null;
		}
		const saveDetail = saveManager.getSaveDetail(slot);
		if (!saveDetail) {
			print("存档损坏，请删除该存档");
			return null;
		}
		else {
			print(saveDetailToString(saveDetail));
		}
		return null;
	};
	const deleteSave = (switched: boolean, tag: string | null) => {
		if (!tag) return null;
		const slot = parseInt(tag.trim());
		const result = saveManager.deleteSave(slot);
		if (result) {
			saveSummaries = saveManager.getAllSavesSummary(file_num);
			saveSlots[slot].setText(saveSummaryToString(saveSummaries[slot]));
		}
		return;
	}

	//场景
	const root = Node();

	const saveSlots: ButtonNode[] = [];
	for (let i = 0; i < file_num; i++) {
		// print(saveSummaryToString(saveSummaries[i]));
		const bt = Button({
			x: label_x[i],
			y: 0,
			width: file_label_size.width,
			height: file_label_size.height,
			onClick: loadSaveFile,
			text: saveSummaryToString(saveSummaries[i]),
			tag: i.toString(),
			fontSize: 30,
			textWidth: file_label_size.width,
		});
		saveSlots.push(bt);
		root.addChild(saveSlots[i].node);
	}

	const deleteButton = [];
	for (let i = 0; i < file_num; i++) {
		const bt = Button({
			x: label_x[i],
			y: -file_label_size.height / 2 - delete_button_size.height / 2 - 10,
			width: delete_button_size.width,
			height: delete_button_size.height,
			onClick: deleteSave,
			text: "删除存档",
			tag: i.toString(),
			fontSize: 20,
			textWidth: file_label_size.width,
		});
		deleteButton.push(bt);
		root.addChild(deleteButton[i].node);
	}

	const lb1 = Label(fontName, 20);
	if (lb1) {
		lb1.text = "!注意：存档0为默认存档会被自动存档覆盖！";
		lb1.color = Color(0xffff5500);
		lb1.position = Vec2(label_x[0], file_label_size.height / 2 + 50);
		root.addChild(lb1);
	}

	return root;
}


const testPage = () => {
	const root= Node();
	// const { root: bt1 } = Button({
	// 	x: 52,
	// 	y: 52,
	// 	width: 100,
	// 	height: 100,
	// 	// text: "读取存档",
	// });
	// const { root: bt2 } = Button({
	// 	x: 252,
	// 	y: 252,
	// 	width: 100,
	// 	height: 100,
	// 	// text: "读取存档",
	// });
	// const root = ScrollBar({
	// 	width: 500,
	// 	height: 500,
	// 	alignmode: AlignMode.Horizontal,
	// 	totalwidth: 5000,
	// 	children:[bt1,bt2],
	// });
	// const root = Node();
	// const names: string[] = [];
	// for (let i = 1; i <= 140; i++) {
	// 	let paddedNumber = i.toString();
	// 	while (paddedNumber.length < 4) {
	// 		paddedNumber = "0" + paddedNumber;
	// 	}
	// 	names.push(`Image/home/背景动画/${paddedNumber}.png`);
	// }
	// playAnimation(root, names, 1 / 12, true);

	// character.play(true);

	// const list=List({
	// 	x : 0,
	// 	y : 0,
	// 	width : 500,
	// 	height : 500,
	// 	itemInterval : 10,
	// 	alignmode : AlignMode.Vertical,
	// 	autoLayout : false,
	// 	lineInterval : 0,
	// 	itemwidth : 200,
	// 	itemheight : 100,
	// 	itemnum : 10,
	// 	normalImages : "Image/button/button.clip|button_up",
	// 	pressImages : "Image/button/button.clip|button_down",
	// 	texts : "sdfa",
	// 	fontName : "sarasa-mono-sc-regular",
	// 	fontSize : 20,
	// 	colors : Color(0xffffffff),
	// 	textWidth : Label.AutomaticWidth,
	// 	alignment : TextAlign.Center,
	// 	textisdeleted : false,
	// 	tags : "0",
	// 	backgroundImage : "Image/background/background.png",
	// 	scrollblockImage : "Image/button/button.png",
	// 	scrollbarwidth : 10,
	// });

	CG(root,"Image/CG/1",3);
	return root;
}

// 初始化
updateViewSize();
adjustWinSize();
Director.entry.onAppChange(settingName => {
	if (settingName === 'Size') {
		updateViewSize();
	}
});

// 启动场景
// StartUp();
// SavePage();
testPage();
// const background = Sprite("Image/background/background.png");
// if(background){
// 	background.size = Size(1149,720);
// }


//删除文本的样式
// const lb = Label("sarasa-mono-sc-regular",20);
// lb.color=Color(0xff888888);
// lb.text="寻找机器人的脑袋";
// const lb1 = Label("sarasa-mono-sc-regular",40);
// lb1.color=Color(0xff888888);
// lb1.text="—".repeat(lb.characterCount);
//删除文本用\u0336插入实现