// @preview-file on clear nolog
import { React, toNode, useRef } from 'DoraX';
import { Node, Sprite, Label, Vec2, TextAlign, App, thread, sleep, Color, Size, ClipNode, DrawNode } from 'Dora';

export enum AlignMode {
	Horizontal = "horizontal",
	Vertical = "vertical"
};

export interface ScrollBarProps {
	x?: number;
	y?: number;
	width?: number;
	height?: number;
	backgroundImage?: string;
	alignmode?: AlignMode;
	scrollbarwidth?:number;
	scrollblockImage?: string;
	totalwidth: number;
	nowposition?: number;//0-100
}

export const ScrollBar = (props: ScrollBarProps) =>{
	const {
		x = 0,
		y = 0,
		width = 100,
		height = 100,
		backgroundImage = "Image/background/background.png",
		scrollbarwidth = 20,
		alignmode = AlignMode.Vertical,
		scrollblockImage = "Image/button/button.png",
		totalwidth = 100,
		nowposition = 0,
	} = props;
	let scale;
	let blockrange={min:0,max:0,de:0};
	const root = Node();
	root.x = x;
	root.y = y;
	// const background = Sprite(backgroundImage);
	const background = DrawNode();
	// background.drawPolygon([Vec2(-width/2,-height/2),Vec2(width/2,-height/2),Vec2(width/2,height/2),Vec2(-width/2,height/2)],Color(0xaaffffff));
	background.drawPolygon([Vec2(0,0),Vec2(width,0),Vec2(width,height),Vec2(0,height)],Color(0xaaffffff));
	// if(background){
		// background.size = Size(width,height);
	// }
	const clipnode = ClipNode(background||Node());
	clipnode.size = Size(width,height);
	// clipnode.position = Vec2(width/2,height/2);
	root.addChild(clipnode);
	// if(background)
		clipnode.addChild(background);
	const track = DrawNode();
	const block = Sprite(scrollblockImage);
	// if(track){
		clipnode.addChild(track);
		if(block){
			track.addChild(block);
			if(alignmode===AlignMode.Horizontal){
				scale = totalwidth/width;
				track.x = width /2;
				track.y=scrollbarwidth/2;
				// track.drawPolygon([Vec2(-width/2,-scrollbarwidth/2),Vec2(width/2,-scrollbarwidth/2),Vec2(width/2,scrollbarwidth/2),Vec2(-width/2,scrollbarwidth/2)],Color(0x55555555));
				track.drawPolygon([Vec2(-width/2,-scrollbarwidth/2),Vec2(width/2,-scrollbarwidth/2),Vec2(width/2,scrollbarwidth/2),Vec2(-width/2,scrollbarwidth/2)],Color(0x55555555));
				block.width = width/scale;
				block.height = scrollbarwidth;
				blockrange.min = block.width/2-width/2;
				blockrange.max = width/2-block.width/2;
				blockrange.de = blockrange.max-blockrange.min;
				block.x = blockrange.min+blockrange.de*nowposition/100;
				block.onTapMoved(touch => {
					const temp = block.x + touch.delta.x;
					if(temp>blockrange.max){
						block.x=blockrange.max;
					}else if(temp<blockrange.min){
						block.x=blockrange.min;
					}else{
						block.x=temp;
					}
					props.nowposition=(block.x-blockrange.min)*100/blockrange.de;
					// print(props.nowposition);
				});
				clipnode.onMouseWheel(delta => {
					const temp = block.x + delta.y*block.width/2;
					if(temp>blockrange.max){
						block.x=blockrange.max;
					}else if(temp<blockrange.min){
						block.x=blockrange.min;
					}else{
						block.x=temp;
					}
					props.nowposition=(block.x-blockrange.min)*100/blockrange.de;
				});
			}else{
				scale = totalwidth/width;
				track.x=width-scrollbarwidth/2;
				track.y = height/2;
				// track.drawPolygon([Vec2(-width/2,-scrollbarwidth/2),Vec2(width/2,-scrollbarwidth/2),Vec2(width/2,scrollbarwidth/2),Vec2(-width/2,scrollbarwidth/2)],Color(0x55555555));
				track.drawPolygon([Vec2(-scrollbarwidth/2,height/2),Vec2(-scrollbarwidth/2,-height/2),Vec2(scrollbarwidth/2,-height/2),Vec2(scrollbarwidth/2,height/2)],Color(0x55555555));
				block.width = scrollbarwidth;
				block.height = height/scale;
				blockrange.min = block.height/2-height/2;
				blockrange.max = height/2-block.height/2;
				blockrange.de = blockrange.max-blockrange.min;
				block.y = blockrange.max-blockrange.de*nowposition/100;
				block.onTapMoved(touch => {
					const temp = block.y + touch.delta.y;
					if(temp>blockrange.max){
						block.y=blockrange.max;
					}else if(temp<blockrange.min){
						block.y=blockrange.min;
					}else{
						block.y=temp;
					}
					props.nowposition=(blockrange.max-block.y)*100/blockrange.de;
					// print(props.nowposition);
				});
				clipnode.onMouseWheel(delta => {
					const temp = block.y + delta.y*block.height/2;
					if(temp>blockrange.max){
						block.y=blockrange.max;
					}else if(temp<blockrange.min){
						block.y=blockrange.min;
					}else{
						block.y=temp;
					}
					props.nowposition=(blockrange.max-block.y)*100/blockrange.de;
				});
			}
		}
	// }
	

	return root;
}
