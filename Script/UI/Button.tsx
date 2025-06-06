import { Node, Sprite, Label, Vec2 } from 'Dora';

// 按钮状态类型
export type ButtonState = 'normal' | 'hover' | 'pressed';

// 按钮类型
type ButtonType = 'click' | 'toggle';

// 按钮组件属性
interface ButtonProps {
	type?: ButtonType;
	x?: number;
	y?: number;
	width?: number;
	height?: number;
	onClick?: (switched: boolean) => void;
	onStateChange?: (state: ButtonState) => void;
	normalImage?: string;
	pressImage?: string;
	text?: string;
	fontName?: string;
	color?: number;
	fontSize?: number;
}

export const Button = (props: ButtonProps) => {
	// 设置默认值
	const {
		type = "click",
		x = 0,
		y = 0,
		width = 200,
		height = 100,
		onClick = () => { },
		onStateChange = () => { },
		normalImage = "Image/button/button.clip|button_up",
		pressImage = "Image/button/button.clip|button_down",
		text = "",
		fontName = "sarasa-mono-sc-regular",
		fontSize = 40,
		color = 0xffffff
	} = props;

	// 创建根节点
	const root = Node();
	root.x = x;
	root.y = y;
	root.width = width;
	root.height = height;
	root.alignItems

	// 创建正常状态精灵
	const buttonUp = Sprite(normalImage);
	if (buttonUp) {
		buttonUp.position = Vec2(width / 2, height / 2);
		buttonUp.width = width;
		buttonUp.height = height;
		root.addChild(buttonUp);
	}

	// 创建按下状态精灵
	const buttonDown = Sprite(pressImage);
	if (buttonDown) {
		buttonDown.position = Vec2(width / 2, height / 2);
		buttonDown.width = width;
		buttonDown.height = height;
		buttonDown.visible = false; // 默认隐藏
		root.addChild(buttonDown);
	}

	// 创建标签
	const buttonLabel = Label(fontName, fontSize);
	if (buttonLabel) {
		buttonLabel.text = text;
		buttonLabel.position = Vec2(width / 2, height / 2);
		root.addChild(buttonLabel);
	}

	// 状态变量
	let state: ButtonState = "normal";
	let tempchange = false;
	let switched = false;

	// 更新状态函数
	const setState = (newState: ButtonState) => {
		state = newState;
		if (buttonUp && buttonDown) {
			const pressed = state === 'pressed';
			buttonUp.visible = !pressed;
			buttonDown.visible = pressed;
		}
		onStateChange(newState);
	};

	// 事件处理
	root.onTapBegan(touch => {
		if (state === 'normal') {
			tempchange = true;
			setState('pressed');
			return true; // 阻止事件冒泡
		}
		return false;
	});

	root.onTapEnded(() => {
		if (tempchange) {
			setState('normal');
			tempchange = false;
		}
	});

	root.onTapped(() => {
		if (type === 'click') {
			setState('normal');
		} else {
			switched = !switched;
			setState(switched ? 'pressed' : 'normal');
		}
		onClick(switched);
		return true;
	});

	return root;
};