// @preview-file on clear nolog
import { React, toNode, useRef } from 'DoraX';
import { Content, } from 'Dora';

// 存档信息接口
export interface SaveSummary {
  slot: number;
  progress: string;
  playTime: string;
  exists: boolean;
}

export interface SaveDetail extends SaveSummary {
  items: number[];
}

// 存档管理类
export class SaveManager {
  private saveDir: string = "Save";
  
  constructor() {
    this.ensureSaveDir();
  }
  
  // 确保存档目录存在
  private ensureSaveDir() {
    if (!Content.isdir(this.saveDir)) {
      Content.mkdir(this.saveDir);
    }
  }
  
  // 获取存档文件路径
  private getSavePath(slot: number): string {
    return `${this.saveDir}/save${slot}`;
  }
  
  // 获取所有存档概要信息
  getAllSavesSummary(maxSlots: number): SaveSummary[] {
    const saves: SaveSummary[] = [];
    
    for (let slot = 0; slot < maxSlots; slot++) {
      const savePath = this.getSavePath(slot);
      
      if (Content.exist(savePath)) {
        const content = Content.load(savePath);
        const lines = content.split('\n').filter(line => line.trim() !== '');
        if (lines.length >= 2) {
          saves.push({
            slot,
            progress: lines[0],
            playTime: lines[1],
            exists: true
          });
        }
      } else {
        saves.push({
          slot,
          progress: "新存档",
          playTime: "00:00:00",
          exists: false
        });
      }
    }
    
    return saves;
  }
  
  // 获取指定存档的详细信息
  getSaveDetail(slot: number): SaveDetail | null {
    const savePath = this.getSavePath(slot);
    
    if (!Content.exist(savePath)) {
      return {
        slot,
        progress: "新存档",
        playTime: "00:00:00",
        items: [],
        exists: false
      };
    }
    
    const content = Content.load(savePath);
    if (!content) return null;
    
    const lines = content.split('\n').filter(line => line.trim() !== '');
    if (lines.length < 3) return null;
    
    // 解析道具ID列表
    const items = lines[2] !== "" 
      ? lines[2].split(',').map(id => parseInt(id.trim())) 
      : [];
    
    return {
      slot,
      progress: lines[0],
      playTime: lines[1],
      items,
      exists: true
    };
  }
  
  // 保存游戏到指定存档槽
  saveGame(slot: number, progress: string, playTime: string, items: number[]): boolean {
    // 获取当前时间作为存档时间
    
    // 将道具列表转换为字符串
    const itemStr = items.join(',');
    
    // 构建存档内容
    const content = `${progress}\n${playTime}\n${itemStr}`;
    
    // 保存到文件
    const savePath = this.getSavePath(slot);
    return Content.save(savePath, content);
  }

	deleteSave(slot: number): boolean {
		return Content.remove(this.getSavePath(slot));
	}
}
