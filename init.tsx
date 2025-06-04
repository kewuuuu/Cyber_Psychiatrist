import { React, toNode, useRef } from 'DoraX';
import { AlignNode, Audio, BodyMoveType, ButtonName, Camera2D, Director, KeyName, Label, Node, PhysicsWorld, Sprite, TypeName, Vec2, View, emit, sleep, thread, tolua, Size, SpriteEffect, Color } from 'Dora';
import { CreateManager, Trigger, GamePad } from 'InputManager';
import { ButtonLabel, Button, ButtonState } from 'Script/UI/Button';

// 设计分辨率
const DesignWidth = 480;
const DesignHeight = 700;
const hw = DesignWidth / 2;
const hh = DesignHeight / 2;

// 背景图片
const Background = () => <sprite file="Image/art.png" scaleX={1} scaleY={1}/>;

// 更新视图大小
const updateViewSize = () => {
    const camera = tolua.cast(Director.currentCamera, TypeName.Camera2D);
    if (camera) {
        // 计算缩放比例
        const scaleX = View.size.width / DesignWidth;
        const scaleY = View.size.height / DesignHeight;
        const scale = Math.min(scaleX, scaleY); // 保持比例
        camera.zoom = scale;
        camera.position = Vec2(hw * scale, hh * scale); // 保持相机中心在设计分辨率的中心
    }
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
    const buttonWidth = 200;
    const buttonHeight = 100;
    const buttonYOffset = 150;

    const buttonY1 = hh + buttonYOffset;
    const buttonY2 = hh;
    const buttonY3 = hh - buttonYOffset;
    const buttonY4 = hh - 2 * buttonYOffset;

		const button1 = useRef<Button.Type>();

    return (
        <align-node style={{
					width: '60%',
					height: '60%'
				}}
				onLayout={(width, height) => {
					let {current} = sprite;
					if (current) {
						current.position = Vec2(width / 2, height / 2);
						current.size = Size(width, height);
					}
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
            >
              <label
                  text="新游戏"
                  fontName="sarasa-mono-sc-regular"
                  fontSize={40}
                  color3={0xffffff}
              />
            </Button>
            <Button
                type="click"
                x={0}
                y={buttonY2}
                width={buttonWidth}
                height={buttonHeight}
                onClick={continueGameClick}
                normalImage="Image/button/button.clip|button_up"
                pressImage="Image/button/button.clip|button_down"
            >
                <label
                    text="继续游戏"
                    fontName="sarasa-mono-sc-regular"
                    fontSize={40}
                    color3={0xffffff}
                />
            </Button>
            <Button
                type="click"
                x={0}
                y={buttonY3}
                width={buttonWidth}
                height={buttonHeight}
                onClick={loadSaveClick}
                normalImage="Image/button/button.clip|button_up"
                pressImage="Image/button/button.clip|button_down"
            >
                <label
                    text="读取存档"
                    fontName="sarasa-mono-sc-regular"
                    fontSize={40}
                    color3={0xffffff}
                />
            </Button>
            <Button
                type="click"
                x={0}
                y={buttonY4}
                width={buttonWidth}
                height={buttonHeight}
                onClick={exitClick}
                normalImage="Image/button/button.clip|button_up"
                pressImage="Image/button/button.clip|button_down"
            >
                <label
                    text="退出游戏"
                    fontName="sarasa-mono-sc-regular"
                    fontSize={40}
                    color3={0xffffff}
                />
            </Button>
        </align-node>
    );
};

// 添加启动界面到用户界面
const startupnode = toNode(<StartUp />);
startupnode?.addTo(Director.ui);