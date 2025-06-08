import { React, toNode } from 'DoraX';
import { Director, Node, Sprite, Size, App, Vec2, View, tolua, TypeName, Camera2D, Label, TextAlign, Color } from 'Dora';
import { Button } from 'Script/UI/Button';
import { DB, thread, SQL, Audio } from "Dora";
import { SaveManager, SaveSummary, SaveDetail } from "Script/SaveManager";
import {ScrollBar, AlignMode} from "Script/UI/ScrollBar"

const designSize = Size(1280, 720);
const winsize = Size(1600, 900);
const fontName = "sarasa-mono-sc-regular"

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

//音频
const resources = {
	textures: [],
	models: [],
	sounds: ["Audio/《蝉鸣间的电子幽梦》欢快的桂花冰淇淋.mp3"]
};
Audio.playStream(resources.sounds[0], true);

// 启动场景
const StartUp = () => {
	const buttonWidth = 200;
	const buttonHeight = 100;
	const buttonx = 0;
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
		print(`加载游戏点击, switched: ${switched ? "on" : "off"}`);
	};

	const exitClick = (switched: boolean, tag: string | null) => {
		print(`退出游戏点击, switched: ${switched ? "on" : "off"}`);
		App.shutdown();
	};
	const root = Node();
	const background = Sprite("Image/background/background.png");
	if (background) {
		background.size = designSize;
		root.addChild(background);
	}

	// 按钮1
	const { root: bt1 } = Button({
		x: buttonx,
		y: buttony[0],
		width: buttonWidth,
		height: buttonHeight,
		onClick: continueGameClick,
		text: "继续游戏",
	});

	//按钮2
	const { root: bt2 } = Button({
		x: buttonx,
		y: buttony[1],
		width: buttonWidth,
		height: buttonHeight,
		onClick: newGameClick,
		text: "新游戏",
	});

	// 按钮3
	const { root: bt3 } = Button({
		x: buttonx,
		y: buttony[2],
		width: buttonWidth,
		height: buttonHeight,
		onClick: loadSaveClick,
		text: "读取存档",
	});

	// 按钮4
	const { root: bt4 } = Button({
		x: buttonx,
		y: buttony[3],
		width: buttonWidth,
		height: buttonHeight,
		onClick: exitClick,
		text: "退出游戏",
	});
	root.addChild(bt1);
	root.addChild(bt2);
	root.addChild(bt3);
	root.addChild(bt4);

	return root;
};

const SavePage = () => {
	const file_num = 4;
	const file_label_size = { width: 250, height: 400 };
	const delete_button_size = { width: 20, height: 20 };
	const file_interval = 50;
	const totalWidth = (file_num * file_label_size.width) + ((file_num - 1) * file_interval);

	const label_x: number[] = [];
	for (let i = 0; i < file_num; i++) {
		label_x.push(-totalWidth / 2 + file_label_size.width / 2 + i * (file_label_size.width + file_interval));
	}

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
			saveSlots[slot].st(saveSummaryToString(saveSummaries[slot]));
		}
		return;
	}

	//场景
	const root = Node();

	const saveSlots: {
		bt: Node.Type;
		st: (this: void, text: string) => void;
	}[] = [];
	for (let i = 0; i < file_num; i++) {
		const { root: bt, setText: st } = Button({
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
		saveSlots.push({ bt, st });
		root.addChild(saveSlots[i].bt || Node());
	}

	const deleteButton = [];
	for (let i = 0; i < file_num; i++) {
		const { root: bt } = Button({
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
		root.addChild(deleteButton[i] || Node());
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
	const root = ScrollBar({
		width: 500,
		height: 500,
		alignmode: AlignMode.Vertical,
		totalwidth: 5000,
	});
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