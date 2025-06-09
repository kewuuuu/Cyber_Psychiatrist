// @preview-file on clear nolog
import { React, toNode, useRef } from 'DoraX';
import { Node, Sprite, Content, Size, Vec2 } from 'Dora';
import { designSize, winsize, fontName } from "Script/config";

const autoSize = (orisize: Size.Type,tagetsize: Size.Type) => {
	const scale = Math.min(tagetsize.height / orisize.height, tagetsize.width / orisize.width);
	return Size(orisize.mul(Vec2(scale,scale)));
}

export const CG = (node: Node.Type, foldername: string,intervals: number) =>{
	node.removeAllChildren();
	// const frames = [
	// 	Sprite(`Image/art.clip|${name}1`) ?? Sprite(),
	// 	Sprite(`Image/art.clip|${name}2`) ?? Sprite()
	// ];
	const names = Content.getAllFiles(foldername);
	// print(names[0]);
	const frames: Sprite.Type[] = [];
	for (let name of names) {
		const frame = Sprite(foldername+'/'+name) ?? Sprite();
		// frame.visible = false;
		frame.size=autoSize(frame.size,designSize);
		frame.addTo(node);
		// print(frame.size)
		frames.push(frame);
	}
}
