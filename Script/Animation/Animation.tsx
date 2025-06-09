// @preview-file on clear nolog
import { React, toNode, useRef } from 'DoraX';
import { Node, Sprite, sleep } from 'Dora';


//播放动画
export const playAnimation = (node: Node.Type, names: string[], interval: number, loop: boolean) => {
	node.removeAllChildren();
	// const frames = [
	// 	Sprite(`Image/art.clip|${name}1`) ?? Sprite(),
	// 	Sprite(`Image/art.clip|${name}2`) ?? Sprite()
	// ];
	const frames: Sprite.Type[] = [];
	for (let name of names) {
		const frame = Sprite(name) ?? Sprite();
		frame.visible = false;
		frame.addTo(node);
		frames.push(frame);
	}
	let i = 0;
	frames[i].visible = true;
	node.loop(() => {
		sleep(interval);
		frames[(i + 1) % names.length].visible = true;
		frames[i].visible = false;
		i = (i + 1) % names.length;
		return !loop;
	});
};