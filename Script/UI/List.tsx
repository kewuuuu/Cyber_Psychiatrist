// @preview-file on clear nolog
import { React, toNode, useRef } from 'DoraX';
import { Node, Sprite, Label, Vec2, TextAlign, App, thread, sleep, Color, Size, ClipNode } from 'Dora';
import { Button, ButtonState } from 'Button';
import {ScrollBar} from 'ScrollBar';

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
		colors = 0xffffff,
		textWidth = Label.AutomaticWidth,
		alignment = TextAlign.Center,
		textisdeleted = false,
		tags = null,
		backgroundImage = "Image/background/background.png",
		scrollblockImage = "Image/button/button.png",
		scrollbarwidth = 10,
	} = props;

	const root = Node();
	root.x = x;
	root.y = y;
	const buttonpositions :{x:number,y:number}[] = [];
	const items_position: Vec2.Type[] = [];
	for(let i=0;i<itemnum;i++){
		items_position
	}
	const items: {
		bt: Node.Type;
		st: (this: void, text: string) => void;
	}[] = [];
	for (let i = 0; i < itemnum; i++) {
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

	if(alignmode === AlignMode.Horizontal&&autoLayout || alignmode===AlignMode.Vertical&&!autoLayout){
		//竖向
		const background = ScrollBar({
			x=0,
			y=0,
			width=width,
			height=height,
			alignmode=AlignMode.Vertical,
			backgroundImage=backgroundImage,
			scrollblockImage=scrollblockImage,
			scrollbarwidth=scrollbarwidth,
			totalwidth=0,
			nowposition=0,
			children=,
		});
	}else{

	}

	
	

	

	const 

	return root;
}
