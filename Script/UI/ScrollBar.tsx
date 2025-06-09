// @preview-file on clear nolog
//代码重复率有点高有空可以改进一下
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
	scrollbarwidth?: number;
	scrollblockImage?: string;
	totalwidth: number;
	nowposition?: number;//0-100
	children?: any[];
}
export interface ScrollBarNode {
	node: Node.Type;
	setTotalwidth?: (this: void, totalwidth: number) => void;
}

export const ScrollBar = (props: ScrollBarProps) => {
	let {
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
	let blockrange = { min: 0, max: 0, de: 0 };
	const root = Node();
	root.x = x;
	root.y = y;
	// const background = Sprite(backgroundImage);
	const background = DrawNode();
	// background.drawPolygon([Vec2(-width/2,-height/2),Vec2(width/2,-height/2),Vec2(width/2,height/2),Vec2(-width/2,height/2)],Color(0xaaffffff));
	background.drawPolygon([Vec2(0, 0), Vec2(width, 0), Vec2(width, height), Vec2(0, height)], Color(0xaaffffff));
	// if(background){
	// background.size = Size(width,height);
	// }
	const clipnode = ClipNode(background || Node());
	clipnode.size = Size(width, height);
	// clipnode.position = Vec2(width/2,height/2);
	root.addChild(clipnode);
	// if(background)
	clipnode.addChild(background);
	const track = DrawNode();
	const block = Sprite(scrollblockImage);
	// if(track){
	clipnode.addChild(track);

	const changeorigintoupright=(pos: Vec2.Type) => {
		if (alignmode === AlignMode.Horizontal) {
			print(height-pos.y);
			return Vec2(pos.x,height-pos.y);
		}else{
			print(height+totalwidth*nowposition/100-pos.y);
			return Vec2(pos.x,height+totalwidth*nowposition/100-pos.y);
		}
	}

	if(props.children)
	for(let child of props.children){
		child.position = changeorigintoupright(child.position);
		clipnode.addChild(child);
	}

	const setTotalwidth = (totalwidth1: number) => {
		totalwidth = totalwidth1;
		if (block) {
			if (alignmode === AlignMode.Horizontal) {
				scale = (totalwidth-width) / width;
				block.width = width / scale;
				blockrange.min = block.width / 2 - width / 2;
				blockrange.max = width / 2 - block.width / 2;
				blockrange.de = blockrange.max - blockrange.min;
				block.x = blockrange.min + blockrange.de * nowposition / 100;
			} else {
				scale = (totalwidth-height) / height;
				block.height = height / scale;
				blockrange.min = block.height / 2 - height / 2;
				blockrange.max = height / 2 - block.height / 2;
				blockrange.de = blockrange.max - blockrange.min;
				block.y = blockrange.max - blockrange.de * nowposition / 100;
			}
		}
	}
	const changeNowPosition=(np: number) =>{
		const delta = np-(props.nowposition||0);
		props.nowposition = np;
		if(props.children)
		if(alignmode === AlignMode.Horizontal){
			for(let child of props.children){
				// child.position = changeorigintoupright(child.position);
				child.x-=(totalwidth-width)*delta/100;
			}
		}else{
			for(let child of props.children){
				// child.position = changeorigintoupright(child.position);
				child.y+=(totalwidth-height)*delta/100;
			}
		}
		
	}
	if (block) {
		track.addChild(block);
		if (alignmode === AlignMode.Horizontal) {
			// scale = totalwidth / width;
			track.x = width / 2;
			track.y = scrollbarwidth / 2;
			// track.drawPolygon([Vec2(-width/2,-scrollbarwidth/2),Vec2(width/2,-scrollbarwidth/2),Vec2(width/2,scrollbarwidth/2),Vec2(-width/2,scrollbarwidth/2)],Color(0x55555555));
			track.drawPolygon([Vec2(-width / 2, -scrollbarwidth / 2), Vec2(width / 2, -scrollbarwidth / 2), Vec2(width / 2, scrollbarwidth / 2), Vec2(-width / 2, scrollbarwidth / 2)], Color(0x55555555));
			block.height = scrollbarwidth;
			setTotalwidth(totalwidth);
			block.onTapMoved(touch => {
				const temp = block.x + touch.delta.x;
				if (temp > blockrange.max) {
					block.x = blockrange.max;
				} else if (temp < blockrange.min) {
					block.x = blockrange.min;
				} else {
					block.x = temp;
				}
				changeNowPosition((block.x - blockrange.min) * 100 / blockrange.de);
				// print(props.nowposition);
			});
			clipnode.onMouseWheel(delta => {
				const temp = block.x + delta.y * block.width / 2;
				if (temp > blockrange.max) {
					block.x = blockrange.max;
				} else if (temp < blockrange.min) {
					block.x = blockrange.min;
				} else {
					block.x = temp;
				}
				changeNowPosition((block.x - blockrange.min) * 100 / blockrange.de);
			});
		} else {
			track.x = width - scrollbarwidth / 2;
			track.y = height / 2;
			// track.drawPolygon([Vec2(-width/2,-scrollbarwidth/2),Vec2(width/2,-scrollbarwidth/2),Vec2(width/2,scrollbarwidth/2),Vec2(-width/2,scrollbarwidth/2)],Color(0x55555555));
			track.drawPolygon([Vec2(-scrollbarwidth / 2, height / 2), Vec2(-scrollbarwidth / 2, -height / 2), Vec2(scrollbarwidth / 2, -height / 2), Vec2(scrollbarwidth / 2, height / 2)], Color(0x55555555));
			block.width = scrollbarwidth;
			setTotalwidth(totalwidth);
			block.onTapMoved(touch => {
				const temp = block.y + touch.delta.y;
				if (temp > blockrange.max) {
					block.y = blockrange.max;
				} else if (temp < blockrange.min) {
					block.y = blockrange.min;
				} else {
					block.y = temp;
				}
				changeNowPosition((blockrange.max - block.y) * 100 / blockrange.de);
				// print(props.nowposition);
			});
			clipnode.onMouseWheel(delta => {
				const temp = block.y + delta.y * block.height / 2;
				if (temp > blockrange.max) {
					block.y = blockrange.max;
				} else if (temp < blockrange.min) {
					block.y = blockrange.min;
				} else {
					block.y = temp;
				}
				changeNowPosition((blockrange.max - block.y) * 100 / blockrange.de);
			});
		}
	}

	// }


	const scrollBarNode: ScrollBarNode = { node: root, setTotalwidth };
	return scrollBarNode;
}
