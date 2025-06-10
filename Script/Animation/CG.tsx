// @preview-file on clear nolog
import { React, toNode, useRef } from 'DoraX';
import { Node, Sprite, Content, Size, Vec2, thread, wait, sleep } from 'Dora';
import { designSize, winsize, fontName } from "Script/config";
import { NodeMove } from 'Script/Animation/Animation';

const autoSize = (orisize: Size.Type, tagetsize: Size.Type) => {
	const scale = Math.min(tagetsize.height / orisize.height, tagetsize.width / orisize.width);
	return Size(orisize.mul(Vec2(scale, scale)));
}

export const CG = (node: Node.Type,foldername: string, speed:number, intervals: number[], pos: Vec2.Type[]) => {
	node.removeAllChildren();
	// const frames = [
	// 	Sprite(`Image/art.clip|${name}1`) ?? Sprite(),
	// 	Sprite(`Image/art.clip|${name}2`) ?? Sprite()
	// ];
	const names = Content.getAllFiles(foldername);
	// print(names[0]);
	let i = 0;
	const frames: Sprite.Type[] = [];
	for (let name of names) {
		const frame = Sprite(foldername + '/' + name) ?? Sprite();
		// frame.visible = false;
		frame.position = pos[i];
		frame.size = autoSize(frame.size, designSize);
		frame.addTo(node);
		// print(frame.size)
		frames.push(frame);
		i++;
	}
	return thread(() => {
		i = 0;
		for (i = 0; i < pos.length; i++) {
			const moveCoroutine = NodeMove(frames[i], speed, [pos[i], Vec2(0, 0)], false);
			sleep(intervals[i]);
		}
	});

}
