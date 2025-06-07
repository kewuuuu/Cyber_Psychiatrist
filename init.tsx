import { React, toNode } from 'DoraX';
import { Director, Node, Sprite, Size, App, Vec2, View, tolua, TypeName, Camera2D, Label, TextAlign } from 'Dora';
import { Button } from 'Script/UI/Button'; // 确保路径正确
import { DB, thread, SQL } from "Dora";


const designSize = Size(1280, 720);
const winsize = Size(1600, 900);

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
	const bt1 = toNode(<Button
		type="click"
		x={buttonx}
		y={buttony[0]}
		width={buttonWidth}
		height={buttonHeight}
		onClick={newGameClick}
		text="新游戏"
	/>);
	const bt2 = toNode(<Button
		type="click"
		x={buttonx}
		y={buttony[1]}
		width={buttonWidth}
		height={buttonHeight}
		onClick={continueGameClick}
		text="继续游戏"
	/>);
	const bt3 = toNode(<Button
		type="click"
		x={buttonx}
		y={buttony[2]}
		width={buttonWidth}
		height={buttonHeight}
		onClick={loadSaveClick}
		text="读取存档"
	/>);
	const bt4 = toNode(<Button
		type="click"
		x={buttonx}
		y={buttony[3]}
		width={buttonWidth}
		height={buttonHeight}
		onClick={exitClick}
		text="退出游戏"
	/>);
	if (bt1 && bt2 && bt3 && bt4) {
		root.addChild(bt1);
		root.addChild(bt2);
		root.addChild(bt3);
		root.addChild(bt4);
	}
	return root;
};

const SavePage = () => {
	const file_num = 4;
	const file_label_size = { width: 250, height: 600 };
	const file_interval = 50;
	const totalWidth = (file_num * file_label_size.width) + ((file_num - 1) * file_interval);

	const label_x: number[] = [];
	for (let i = 0; i < file_num; i++) {
		label_x.push(-totalWidth / 2 +file_label_size.width/2+ i * (file_label_size.width + file_interval));
	}

	const fileClick = (switched: boolean, tag: string|null) => {
		print("switched:",switched);
		print("tag:",tag);
	};
	const root = Node();
	const savefiles = [];

	for (let i = 0; i < file_num; i++) {
		savefiles.push(
			<Button
				type="click"
				x={label_x[i]}
				y={0}
				width={file_label_size.width}
				height={file_label_size.height}
				onClick={fileClick}
				text={`存档${i + 1}`}
				tag={i.toString()}
				fontSize={50}
				textWidth={file_label_size.width}
			/>
		);
		root.addChild(savefiles[i]);
	}
	

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
SavePage();