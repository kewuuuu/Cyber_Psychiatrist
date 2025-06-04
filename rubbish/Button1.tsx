// @preview-file on clear nolog
import { React, toNode, useRef } from 'DoraX';
import {emit, Director, Label, Node, Sprite, sleep} from 'Dora';


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
  x?: number;
  /** 按钮初始位置Y坐标 */
  y?: number;
  /** 按钮宽度 */
  width?: number;
  /** 按钮高度 */
  height?: number;
  /** 按钮被点击时的回调函数 */
  onClick?: (switched: boolean) => void;
  /** 按钮状态改变时的回调函数 */
  onStateChange?: (state: ButtonState) => void;
  normalImage?: string;
  // hoverImage?: string;
  pressImage?: string;
}

// 按钮标签组件(改成单独的标签类)
export const ButtonLabel = (props: {
  text: string;
  color?: number;
  fontSize?: number;
}) => {
  return (
    <label
      text={props.text} 
      fontName="sarasa-mono-sc-regular" 
      fontSize={props.fontSize || 24} 
      color3={props.color || 0xffffff}
    />
  );
};

export class Button extends React.Component<ButtonProps> {
	private defaultProps = {
	  type: "click", // 默认按钮类型为点击式
	  // label: <ButtonLabel text="" />, // 默认按钮文本为空
	  x: 0, // 默认 X 坐标为 0
	  y: 0, // 默认 Y 坐标为 0
	  width: 100, // 默认按钮宽度为 100
	  height: 50, // 默认按钮高度为 50
	  textColor: 0xFFFFFFFF, // 默认文本颜色为白色
	  fontSize: 20, // 默认字体大小为 20
	  onClick: () => {}, // 默认点击回调为空函数
	  onStateChange: (state: ButtonState) => {}, // 默认状态改变回调为空函数
	  normalImage: "Image/button/button_0.png",
	  // hoverImage: "Image/button/button_1.png",
	  pressImage: "Image/button/button_2.png",
	} as ButtonProps;
	state : ButtonState = "normal";
	switched: boolean = false;
	// imagesrc: string;

	// 构造函数，用于接受初始化属性
	constructor(props: ButtonProps) {
		super(props);
		this.props = { ...this.defaultProps, ...props };
		// this.imagesrc = this.props.normalImage || "Image/button/button_0.png";
	}

	// handleMouseEnter = () => {
	// 	if (this.state === 'normal') {
	// 		this.state = 'hover' ;
	// 	}
	// 	this.props.onStateChange?.(this.state);
	// };

	// handleMouseLeave = () => {
	// 	if (this.state === 'hover') {
	// 		this.state = 'normal' ;
	// 	}
	// 	this.props.onStateChange?.(this.state);
	// };
	onTapBegan = () => {
		print("onTapBegan");
		this.state = 'pressed' ;
		print(this.state);
	};
	onTapEnded = () => {
		print("onTapEnded");
		if (this.props.type === 'click') {
			this.state = 'normal';
		}else{
			if(this.switched === false){
				this.switched = true;
			}else{
				this.switched = false;
				this.state = 'normal';
			}
		}
		print(this.state);
	};
	// handleMouseDown = () => {
	// 	this.state = 'pressed' ;
	// 	// this.imagesrc = this.props.pressImage || "Image/button/button_2.png";
	// 	this.props.onStateChange?.(this.state);
	// };

	// handleMouseUp = () => {
	// 	if (this.props.type === 'click') {
	// 		// this.state = 'hover';
	// 		this.state = 'normal';
	// 		// this.imagesrc = this.props.normalImage || "Image/button/button_0.png";
	// 	}else{
	// 		if(this.switched === false){
	// 			this.switched = true;
	// 		}else{
	// 			this.switched = false;
	// 			// this.state = 'hover';
	// 			this.state = 'normal';
	// 			// this.imagesrc = this.props.normalImage || "Image/button/button_0.png";
	// 		}
	// 	}
		
	// 	this.props.onStateChange?.(this.state);
	// 	//调用onClick
	// 	this.props.onClick?.(this.switched);
	// };

	// updateimage = (node: Node.Type) => {
	// 	const frames = [
	// 		Sprite(this.props.normalImage || "Image/button/button_0.png") ?? Sprite(),
	// 		Sprite(this.props.pressImage || "Image/button/button_2.png") ?? Sprite()
	// 	];
	// 	node.loop(() => {
	// 		if(this.state==='normal'){
	// 			frames[0].visible = true;
	// 			frames[1].visible = true;
	// 		}else{
	// 			frames[1].visible = true;
	// 			frames[0].visible = true;
	// 		}
	// 		sleep(0.2);
	// 		return false;
	// 	});
	// };

	render() {
    return (
			<>
				<node x={this.props.x} y={this.props.y}>
					<sprite file={this.state === 'normal' ? this.props.normalImage : this.props.pressImage} 
					width={this.props.width}
          height={this.props.height}/>
					<node 
					width={this.props.width || 100}
	        height={this.props.height || 50}
					onTapBegan={this.onTapBegan}
					onTapEnded={this.onTapEnded}
					/>
				</node>
			</>
			// <>
			// 	<node x={this.props.x} y={this.props.y}
			// 	width={this.props.width || 100}
      //   height={this.props.height || 50}
			// 	onTapBegan={() => this.handleMouseDown}
			// 	onTapEnded={() => this.handleMouseUp}
			// 	onMount={node => {
			// 		this.updateimage(node);
			// 	}}>
			// 		<sprite file={this.state === 'normal' ? this.props.normalImage : this.props.pressImage} scaleX={this.props.width ? this.props.width / 100 : 1} scaleY={this.props.height ? this.props.height / 50 : 1}/>
			// 	</node>
			// </>
      // <Node x={this.props.x} y={this.props.y}>
      //   <Sprite file={this.state === 'normal' ? this.props.normalImage : this.state === 'hover' ? this.props.hoverImage : this.props.pressImage} scaleX={this.props.width ? this.props.width / 100 : 1} scaleY={this.props.height ? this.props.height / 100 : 1} />
      //   <Node
      //     width={this.props.width || 100}
      //     height={this.props.height || 50}
      //     onMouseEnter={this.handleMouseEnter}
      //     onMouseLeave={this.handleMouseLeave}
      //     onMouseDown={this.handleMouseDown}
      //     onMouseUp={this.handleMouseUp}
      //   />
      // </Node>
    );
  }
}