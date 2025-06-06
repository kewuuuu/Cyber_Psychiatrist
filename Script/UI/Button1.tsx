// @preview-file on clear nolog
import { React, toNode, useRef } from 'DoraX';
import {emit, Director, Label, Node, Sprite, sleep, Vec2, Size, AlignNode} from 'Dora';


// 按钮状态类型
export type ButtonState = 'normal' | 'hover' | 'pressed';

// 按钮类型
type ButtonType = 'click' | 'toggle';

// 按钮组件属性
interface ButtonProps {
  /** 按钮类型：点击式（click）或切换式（toggle） */
  type?: ButtonType;
  /** 按钮显示的文本标签 */
  // label?: React.Element;
  /** 按钮初始位置X坐标 */
  x?: string | number;
  /** 按钮初始位置Y坐标 */
  y?: string | number;
  /** 按钮宽度 */
  width?: string | number;
  /** 按钮高度 */
  height?: string | number;
  /** 按钮被点击时的回调函数 */
  onClick?: (switched: boolean) => void;
  /** 按钮状态改变时的回调函数 */
  onStateChange?: (state: ButtonState) => void;
  normalImage?: string;
  // hoverImage?: string;
  pressImage?: string;
	children?: any | any[];
	text?: string;
	fontName?: string;
  color?: number;
  fontSize?: number;
	viewState?: {
	  scale: number;
	  NowViewWidth: number;
	  NowViewHeight: number;
	};
}

export class Button extends React.Component<ButtonProps> {
	private defaultProps = {
	  type: "click", // 默认按钮类型为点击式
	  // label: <ButtonLabel text="" />, // 默认按钮文本为空
	  x: 0, // 默认 X 坐标为 0
	  y: 0, // 默认 Y 坐标为 0
	  width: "60%", // 默认按钮宽度为 100
	  height: "60%", // 默认按钮高度为 50
	  onClick: () => {}, // 默认点击回调为空函数
	  onStateChange: (state: ButtonState) => {}, // 默认状态改变回调为空函数
	  normalImage: "Image/button/button.clip|button_up",
	  pressImage: "Image/button/button.clip|button_down",
		text:"",
    fontName:"sarasa-mono-sc-regular",
    fontSize:40,
    color : 0xffffff
	} as ButtonProps;
	state : ButtonState = "normal";
	tempchange : boolean = false;
	switched: boolean = false;
	spriteRef1: JSX.Ref<Sprite.Type>;
	spriteRef2: JSX.Ref<Sprite.Type>;
	labelRef: JSX.Ref<Label.Type>;
	nodeRef: JSX.Ref<AlignNode.Type>;
	
	// 构造函数，用于接受初始化属性
	constructor(props: ButtonProps) {
		super(props);
		this.props = { ...this.defaultProps, ...props };
		this.spriteRef1 = useRef<Sprite.Type>();
		this.spriteRef2 = useRef<Sprite.Type>();
		this.labelRef = useRef<Label.Type>();
		this.nodeRef = useRef<AlignNode.Type>();

		this.onTapBegan = this.onTapBegan.bind(this);
		this.onTapEnded = this.onTapEnded.bind(this);
    this.onTapped = this.onTapped.bind(this);
    this.setState = this.setState.bind(this);
	}

	setState = (state: ButtonState) =>{
		this.state = state;
		this.updateVisualState();
	}
	updateVisualState() {
    if (this.spriteRef1.current && this.spriteRef2.current) {
      const pressed = this.state === 'pressed';
      this.spriteRef1.current.visible = !pressed;
      this.spriteRef2.current.visible = pressed;
    }
  }

	onTapBegan = () => {
		// print("onTapBegan");
		if(this.state === 'normal'){
			this.tempchange = true;
			this.setState('pressed');
			this.props.onStateChange?.("pressed");
		}
		return true;
	};

	onTapEnded = () => {
		// print("onTapEnded");
		if(this.tempchange === true){
			this.setState('normal');
			this.props.onStateChange?.("normal");
			this.tempchange = false;
		}
		return true;
	};

	onTapped = () => {
		// print("onTapped");
		if (this.props.type === 'click') {
			this.setState('normal');
			this.props.onStateChange?.("normal");
		}else{
			if(this.switched === false){
				this.switched = true;
				this.setState('pressed');
			}else{
				this.switched = false;
				this.setState('normal');
				this.props.onStateChange?.("normal");
			}
		}
		this.props.onClick?.(this.switched);
		return true;
	};
	render() {
		// print(`Current state: ${this.state}, Image: ${this.state === 'normal' ? this.props.normalImage : this.props.pressImage}`);
		print(this.props.x);
    return (
				<node 
				x={this.props.x} y={this.props.y}
				style={{width: this.props.width,height: this.props.height}}
				>
					<sprite ref={this.spriteRef1}
	            file={this.props.normalImage} 
	            visible={!this.switched}
							width={this.props.width} height={this.props.height}
	        />
	        <sprite ref={this.spriteRef2}
	            file={this.props.pressImage} 
	            visible={this.switched}
							width={this.props.width} height={this.props.height}
	        />
					<label ref={this.labelRef}
              text={this.props.text}
              fontName={this.props.fontName || "sarasa-mono-sc-regular"}
              fontSize={this.props.fontSize || 40}
              color3={this.props.color}
          />
					<align-node style={{width: '100%',height: '100%'}}
					onTapBegan={this.onTapBegan}
					onTapped={this.onTapped}
					onTapEnded={this.onTapEnded}
					/>
				</node>
    );
  }
}

//tsx调用方式
// <Button
//   type="toggle"
//   x={0}
//   y={0}
//   width={200}
//   height={100}
//   onClick={handleClick}
//   onStateChange={handleStateChange}
//   normalImage="Image/button/button.clip|button_up"
//   pressImage="Image/button/button.clip|button_down"
// >
// 	<label
// 	text="123"
// 	fontName="sarasa-mono-sc-regular" 
// 	fontSize={24} 
// 	color3={0xffffff}
// 	/>
// </Button>