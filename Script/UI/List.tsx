// @preview-file on clear nolog
import { React, toNode, useRef } from 'DoraX';
import { Node, Sprite, Label, Vec2, TextAlign, App, thread, sleep, Color, Size, ClipNode } from 'Dora';
import { Button, ButtonNode, ButtonState } from 'Script/UI/Button';
import {ScrollBar} from 'Script/UI/ScrollBar';

export interface ListNode {
	node:Node.Type,
}

export enum AlignMode {
	Horizontal = "horizontal",
	Vertical = "vertical"
};

export interface ListProps {
	x?: number;
	y?: number;
	width?: number;
	height?: number;
	itemInterval?: number;
	alignmode?: AlignMode;//列表方向
	autoLayout?: boolean;//列表项自动换行
	lineInterval?: number;
	itemwidth?: number;
	itemheight?: number;
	itemnum: number;
	onClick?: (this: void, switched: boolean, tag: string | null) => void;
	onDoubleClick?: (this: void, tag: string | null) => void;
	onStateChange?: (this: void, state: ButtonState) => void;
	normalImages?: string[] | string;
	pressImages?: string[] | string;

	texts?: string[] | string;
	fontName?: string;
	fontSize?: number;
	colors?: Color.Type[] | Color.Type;
	textWidth?: number;
	alignment?: TextAlign;
	textisdeleted?: boolean[] | boolean;

	scrollblockImage?: string;
	scrollbarwidth?:number;

	tags?: string[] | string;
	backgroundImage?: string;
}


export const List = (props: ListProps) => {
	const {
		x = 0,
		y = 0,
		width = 200,
		height = 100,
		itemInterval = 10,
		alignmode = AlignMode.Vertical,
		autoLayout = false,
		lineInterval = 0,
		itemwidth = 200,
		itemheight = 100,
		itemnum = 0,
		onClick = () => { },
		onDoubleClick = () => { },
		onStateChange = () => { },
		normalImages = "Image/button/button.clip|button_up",
		pressImages = "Image/button/button.clip|button_down",
		texts = "",
		fontName = "sarasa-mono-sc-regular",
		fontSize = 20,
		colors = Color(0xffffffff),
		textWidth = Label.AutomaticWidth,
		alignment = TextAlign.Center,
		textisdeleted = false,
		tags = "0",
		backgroundImage = "Image/background/background.png",
		scrollblockImage = "Image/button/button.png",
		scrollbarwidth = 10,
	} = props;

	const root = Node();
	root.x = x;
	root.y = y;
	const items_position: Vec2.Type[] = [];
	let totalwidth = 0;
	
	const items: ButtonNode[] = [];

	if(alignmode === AlignMode.Horizontal&&autoLayout || alignmode===AlignMode.Vertical&&!autoLayout){
		//竖向
		if(autoLayout){
			let tempi=0;let lines=1;
			for(let i=0;i<itemnum;i++){
				let temppos = Vec2(itemInterval+itemwidth/2+(itemInterval+itemwidth)*(i-tempi),(lineInterval+itemheight/2)*lines+itemheight/2);
				if(temppos.x+itemwidth/2>width){
					tempi=i;lines++;
					temppos = Vec2(itemInterval+itemwidth/2+(itemInterval+itemwidth)*(i-tempi),(lineInterval+itemheight/2)*lines+itemheight/2);
				}
				items_position.push(temppos);
				totalwidth = temppos.y+itemheight/2+lineInterval;
				const bt = Button({
					x: temppos.x,
					y: temppos.y,
					width: itemwidth,
					height: itemheight,
					onClick: onClick,
					onDoubleClick:onDoubleClick,
					onStateChange:onStateChange,
					text: Array.isArray(texts) ? texts[i] : texts,
					tag: Array.isArray(tags) ? tags[i] : tags,
					fontName:fontName,
					fontSize: fontSize,
					color : Array.isArray(colors) ? colors[i] : colors,
					textWidth : textWidth,
					alignment : alignment,
					normalImage:Array.isArray(normalImages) ? normalImages[i] : normalImages,
					pressImage:Array.isArray(pressImages) ? pressImages[i] : pressImages,
				});
				items.push(bt);
			}
		}else{
			for(let i=0;i<itemnum;i++){
				const temppos = Vec2(width/2,itemInterval+itemheight/2+(itemInterval+itemheight)*i);
				items_position.push(temppos);
				totalwidth = temppos.y+itemheight/2+itemInterval;
				const bt = Button({
					x: temppos.x,
					y: temppos.y,
					width: itemwidth,
					height: itemheight,
					onClick: onClick,
					onDoubleClick:onDoubleClick,
					onStateChange:onStateChange,
					text: Array.isArray(texts) ? texts[i] : texts,
					tag: Array.isArray(tags) ? tags[i] : tags,
					fontName:fontName,
					fontSize: fontSize,
					color : Array.isArray(colors) ? colors[i] : colors,
					textWidth : textWidth,
					alignment : alignment,
					normalImage:Array.isArray(normalImages) ? normalImages[i] : normalImages,
					pressImage:Array.isArray(pressImages) ? pressImages[i] : pressImages,
				});
				items.push(bt);
				// root.addChild(items[i].bt || Node());
			}
		}
		
		const background = ScrollBar({
			x:0,
			y:0,
			width:width,
			height:height,
			alignmode:AlignMode.Vertical,
			backgroundImage:backgroundImage,
			scrollblockImage:scrollblockImage,
			scrollbarwidth:scrollbarwidth,
			totalwidth:totalwidth,
			nowposition:0,
			children:items.map(item => item.node),
		});
		root.addChild(background.node);
	}else{
		//横向
		if(autoLayout){
			let tempi=0;let lines=1;
			for(let i=0;i<itemnum;i++){
				let temppos = Vec2((lineInterval+itemwidth/2)*lines+itemwidth/2,itemInterval+itemheight/2+(itemInterval+itemheight)*(i-tempi));
				if(temppos.y+itemheight/2>height){
					tempi=i;lines++;
					temppos = Vec2((lineInterval+itemwidth/2)*lines+itemwidth/2,itemInterval+itemheight/2+(itemInterval+itemheight)*(i-tempi));
				}
				items_position.push(temppos);
				totalwidth = temppos.x+itemwidth/2+lineInterval;
				const bt = Button({
					x: temppos.x,
					y: temppos.y,
					width: itemwidth,
					height: itemheight,
					onClick: onClick,
					onDoubleClick:onDoubleClick,
					onStateChange:onStateChange,
					text: Array.isArray(texts) ? texts[i] : texts,
					tag: Array.isArray(tags) ? tags[i] : tags,
					fontName:fontName,
					fontSize: fontSize,
					color : Array.isArray(colors) ? colors[i] : colors,
					textWidth : textWidth,
					alignment : alignment,
					normalImage:Array.isArray(normalImages) ? normalImages[i] : normalImages,
					pressImage:Array.isArray(pressImages) ? pressImages[i] : pressImages,
				});
				items.push(bt);
			}
		}else{
			for(let i=0;i<itemnum;i++){
				const temppos = Vec2(itemInterval+itemwidth/2+(itemInterval+itemwidth)*i,height/2);
				items_position.push(temppos);
				totalwidth = temppos.x+itemwidth/2+itemInterval;
				const bt = Button({
					x: temppos.x,
					y: temppos.y,
					width: itemwidth,
					height: itemheight,
					onClick: onClick,
					onDoubleClick:onDoubleClick,
					onStateChange:onStateChange,
					text: Array.isArray(texts) ? texts[i] : texts,
					tag: Array.isArray(tags) ? tags[i] : tags,
					fontName:fontName,
					fontSize: fontSize,
					color : Array.isArray(colors) ? colors[i] : colors,
					textWidth : textWidth,
					alignment : alignment,
					normalImage:Array.isArray(normalImages) ? normalImages[i] : normalImages,
					pressImage:Array.isArray(pressImages) ? pressImages[i] : pressImages,
				});
				items.push(bt);
				// root.addChild(items[i].bt || Node());
			}
		}
		
		const background = ScrollBar({
			x:0,
			y:0,
			width:width,
			height:height,
			alignmode:AlignMode.Horizontal,
			backgroundImage:backgroundImage,
			scrollblockImage:scrollblockImage,
			scrollbarwidth:scrollbarwidth,
			totalwidth:totalwidth,
			nowposition:0,
			children:items.map(item => item.node),
		});
		root.addChild(background.node);
	}

	const listNode:ListNode = {node:root};

	return listNode;
}
