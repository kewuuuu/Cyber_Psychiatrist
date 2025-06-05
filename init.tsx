import { React, toNode, useRef } from 'DoraX';
import { AlignNode, Audio, BodyMoveType, ButtonName, Camera2D, Director, KeyName, Label, Node, PhysicsWorld, Sprite, TypeName, Vec2, View, emit, sleep, thread, tolua, Size, SpriteEffect, Color } from 'Dora';
import { CreateManager, Trigger, GamePad } from 'InputManager';
import { Button, ButtonState } from 'Script/UI/Button';

// 设计分辨率
const DesignWidth = 200;
const DesignHeight = 100;
const hw = DesignWidth / 2;
const hh = DesignHeight / 2;
let scale = Math.min(View.size.width / DesignWidth, View.size.height / DesignHeight);
// let NowViewWidth = 1000;
// let NowViewHeight = 500;

// 背景图片
// const Background = () => <sprite file="Image/art.png" scaleX={1} scaleY={1} />;

// 更新视图大小
const updateViewSize = () => {
	const camera = tolua.cast(Director.currentCamera, TypeName.Camera2D);
	if (camera) {
		// 计算缩放比例
		const scaleX = View.size.width / DesignWidth;
		const scaleY = View.size.height / DesignHeight;
		scale = Math.min(scaleX, scaleY); // 保持比例
		// NowViewWidth = DesignWidth * scale;
		// NowViewHeight = DesignHeight * scale;
		camera.zoom = scale;
		camera.position = Vec2(hw * scale, hh * scale); // 保持相机中心在设计分辨率的中心
	}
	// print("View.size.width\height\scale");
	// print(View.size.width);
	// print(View.size.height);
	// print(scale);
	emit('ScaleUpdated', scale);
};
updateViewSize();
Director.entry.onAppChange(settingName => {
	if (settingName === 'Size') {
		updateViewSize();
	}
});

// 启动界面组件
const StartUp = () => {
	const newGameClick = (switched: boolean) => {
		print(`Button clicked, switched: ${switched ? "on" : "off"}`);
	};
	const continueGameClick = (switched: boolean) => {
		print(`Button clicked, switched: ${switched ? "on" : "off"}`);
	};
	const loadSaveClick = (switched: boolean) => {
		print(`Button clicked, switched: ${switched ? "on" : "off"}`);
	};
	const exitClick = (switched: boolean) => {
		print(`Button clicked, switched: ${switched ? "on" : "off"}`);
	};

	// 计算按钮的大小和位置
	const buttonWidth = 30;
	const buttonHeight = 15;
	const Button_interval = 10;
	const buttonY1 = (Button_interval*3/2+buttonHeight*3/2);
	const buttonY2 = Button_interval/2+buttonHeight/2;
	const buttonY3 = -(Button_interval/2+buttonHeight/2);
	const buttonY4 = -(Button_interval*3/2+buttonHeight*3/2);


	return (
		<align-node windowRoot style={{
			justifyContent: 'center',
			alignItems: 'center'
		}}>
			<align-node style={{
				width: '100%',
				height: '100%',
				justifyContent: 'center',
				alignItems: 'center'
			}}>
				<Button
					type="click"
					x={0}
					y={buttonY1}
					width={buttonWidth}
					height={buttonHeight}
					onClick={newGameClick}
					normalImage="Image/button/button.clip|button_up"
					pressImage="Image/button/button.clip|button_down"
					text="新游戏"
					scale={scale}
				/>
			</align-node>
		</align-node>
	);
};

// 添加启动界面到用户界面
const startupnode = toNode(<StartUp />);
startupnode?.addTo(Director.ui);