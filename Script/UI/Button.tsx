import { Node, Sprite, Label, Vec2, TextAlign, App, thread, sleep, Color } from 'Dora';

// 按钮状态类型
export enum ButtonState {
	Normal = 'normal',
	Hover = 'hover',
	Pressed = 'pressed'
}

// 按钮类型
export enum ButtonType {
    Click = 'click',
    Toggle = 'toggle'
}

// 按钮组件属性
export interface ButtonProps {
	type?: ButtonType;
	x?: number;
	y?: number;
	width?: number;
	height?: number;
	onClick?: (this: void, switched: boolean, tag: string | null) => void;
	onDoubleClick?: (this: void, tag: string | null) => void;
	onStateChange?: (this: void, state: ButtonState) => void;
	normalImage?: string;
	pressImage?: string;
	text?: string;
	fontName?: string;
	color?: Color.Type;
	fontSize?: number;
	textWidth?: number;
	alignment?: TextAlign;
	tag?: string;
}

export const Button = (props: ButtonProps) => {
	// 设置默认值
	const {
		type = ButtonType.Click,
		x = 0,
		y = 0,
		width = 200,
		height = 100,
		onClick = () => { },
		onDoubleClick = () => { },
		onStateChange = () => { },
		normalImage = "Image/button/button.clip|button_up",
		pressImage = "Image/button/button.clip|button_down",
		text = "",
		fontName = "sarasa-mono-sc-regular",
		fontSize = 40,
		color = Color(0xffffff),
		textWidth = Label.AutomaticWidth,
		alignment = TextAlign.Center,
		tag = null,

	} = props;

	// 创建根节点
	const root = Node();
	root.x = x;
	root.y = y;

	// 创建正常状态精灵
	const buttonUp = Sprite(normalImage);
	if (buttonUp) {
		buttonUp.position = Vec2(0, 0);
		buttonUp.width = width;
		buttonUp.height = height;
		root.addChild(buttonUp);
	}

	// 创建按下状态精灵
	const buttonDown = Sprite(pressImage);
	if (buttonDown) {
		buttonDown.position = Vec2(0, 0);
		buttonDown.width = width;
		buttonDown.height = height;
		buttonDown.visible = false; // 默认隐藏
		root.addChild(buttonDown);
	}

	// 创建标签
	const buttonLabel = Label(fontName, fontSize);
	if (buttonLabel) {
		buttonLabel.text = text;
		buttonLabel.position = Vec2(0, 0);
		buttonLabel.textWidth = textWidth;
		buttonLabel.alignment = alignment;
		buttonLabel.color = color;
		root.addChild(buttonLabel);
	}
	//触发组件
	const clickNode = Node();
	clickNode.width = width;
	clickNode.height = height;
	root.addChild(clickNode);

	// 状态变量
	let state = ButtonState.Normal;
	let tempchange = false;
	let switched = false;
	let visible = true;
	let doubleClick = false;

	// 更新状态函数
	const setState = (newState: ButtonState) => {
		state = newState;
		if (buttonUp && buttonDown) {
			const pressed = state === ButtonState.Pressed;
			buttonUp.visible = !pressed;
			buttonDown.visible = pressed;
		}
		onStateChange(newState);
	};

	// 事件处理
	clickNode.onTapBegan(touch => {
		if (state === ButtonState.Normal) {
			tempchange = true;
			setState(ButtonState.Pressed);
			return true; // 阻止事件冒泡
		}
		return false;
	});

	clickNode.onTapEnded(() => {
		if (tempchange) {
			setState(ButtonState.Normal);
			tempchange = false;
		}
	});

	clickNode.onTapped(() => {
		if (type === ButtonType.Click) {
			setState(ButtonState.Normal);
			thread(() => {
				sleep(0.3);
				if (doubleClick) {
					doubleClick = false;
					onClick(switched, tag);
					// print("单击");
				}
			});
			if (doubleClick) {
				doubleClick = false;
				onDoubleClick(tag);
				// print("双击");
			} else {
				doubleClick = true;
			}
		} else {
			switched = !switched;
			setState(switched ? ButtonState.Pressed : ButtonState.Normal);
			onClick(switched, tag);
		}
		// print(App.runningTime);
		return true;
	});
	//毫无用处
	const setVisible = (tempvisible: boolean) => {
		visible = tempvisible;
		if (buttonDown && buttonUp && buttonLabel) {
			if (visible) {
				const pressed = state === ButtonState.Pressed;
				buttonUp.visible = !pressed;
				buttonDown.visible = pressed;
				buttonLabel.visible = true;
				root.addChild(clickNode);
			} else {
				buttonUp.visible = false;
				buttonDown.visible = false;
				buttonLabel.visible = false;
				clickNode.removeFromParent(false);
			}
		}
	}
	const setText = (temptext: string) => {
		if (buttonLabel) {
			print(temptext);
			buttonLabel.text = temptext;
		}
	}
	// return {root:root,setVisible:setVisible};
	return { root, setText };
};