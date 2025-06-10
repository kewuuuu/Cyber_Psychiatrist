// @preview-file on clear nolog
import { React, toNode, useRef } from 'DoraX';
import { App, Node, Sprite, Vec2, cycle, sleep, thread, wait } from 'Dora';


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
interface PathSegment {
  start: Vec2.Type;
  end: Vec2.Type;
  distance: number;
  time: number;
}

export const NodeMove = (node: Node.Type, speed: number, pos: Vec2.Type[], loop: boolean) => {
  // 处理边界情况
  if (pos.length < 1) {
    print("nodemove: 至少需要一个位置点");
    return null;
  }
  
  // 创建一个移动路径数组
  const pathSegments: PathSegment[] = [];
  
  // 如果只有一个点，就保持位置不变
  if (pos.length === 1) {
    pathSegments.push({ 
      start: pos[0], 
      end: pos[0], 
      distance: 0, 
      time: 0 
    });
  } else {
    for (let i = 0; i < pos.length - 1; i++) {
      const start = pos[i];
      const end = pos[i + 1];
      
      // 计算两点之间的距离
      const dx = end.x - start.x;
      const dy = end.y - start.y;
      const distance = Math.sqrt(dx * dx + dy * dy);
      
      // 计算这段路径的移动时间（以秒为单位）
      // speed是每0.1秒移动的距离，所以每秒移动的速度是 speed * 10
      // 时间 = 距离 / 速度
      const time = distance / (speed * 10);
      
      pathSegments.push({ start, end, distance, time });
    }
    
    // 如果需要循环，添加最后一段到第一段的路径
    if (loop) {
      const start = pos[pos.length - 1];
      const end = pos[0];
      
      // 计算两点之间的距离
      const dx = end.x - start.x;
      const dy = end.y - start.y;
      const distance = Math.sqrt(dx * dx + dy * dy);
      
      // 计算这段路径的移动时间（以秒为单位）
      const time = distance / (speed * 10);
      
      pathSegments.push({ start, end, distance, time });
    }
  }
  
  // 设置初始位置
  node.position = pos[0];
  
  // 使用thread函数处理移动逻辑
  return thread(function () {
    let currentNode = 0;  // 当前正在移动的路径段索引
    
    while (true) {
      // 如果是最后一段且不需要循环，则退出协程
      if (!loop && currentNode >= pathSegments.length) {
        break;
      }
      currentNode=currentNode % pathSegments.length;
      // 取出当前路径段
      const segment = pathSegments[currentNode];
      
      // 设置初始时间
      let finished = false;
      
      // 创建一个循环来更新位置，直到这段路径移动结束
      // 使用cycle函数每帧更新位置
      cycle(segment.time, function (time: number) {
        // 根据百分比计算当前位置
        const currentPos = Vec2(
          segment.start.x + (segment.end.x - segment.start.x) * time,
          segment.start.y + (segment.end.y - segment.start.y) * time
        );
        
        // 更新node的位置
        node.position = currentPos;
				if(time===1){
					finished=true;
				}
      });
      
      wait(() => {
				return finished;
			});
      
      // 进入下一段路径
      currentNode=(currentNode+1) ;
    }
  });
};