import { React, toNode } from 'DoraX';
import { Director, Node, Sprite, Size, App, Vec2, View, tolua, TypeName, Camera2D } from 'Dora';
import { Button } from 'Script/UI/Button'; // 确保路径正确

const designSize = Size(1280, 720);
const winsize = Size(1600, 900);

// 更新视图大小
const updateViewSize = () => {
    const camera = tolua.cast(Director.currentCamera, TypeName.Camera2D);
    if (camera) {
        camera.zoom = View.size.height / designSize.height;
    }
};

// 自动调整窗口
const adjustWinSize = () => {
    App.winSize = winsize;
    print(`Visual size: ${App.visualSize}`);
};

// 启动场景
const StartUp = () => {
    const buttonWidth = 200;
    const buttonHeight = 100;
    const buttonx = 0;
    const buttony: number[] = [
        designSize.height / 5 * 4 - designSize.height/2,
        designSize.height / 5 * 3 - designSize.height/2,
        designSize.height / 5 * 2 - designSize.height/2,
        designSize.height / 5 - designSize.height/2
    ];

    const newGameClick = (switched: boolean) => {
        print(`新游戏点击, switched: ${switched ? "on" : "off"}`);
    };

    const continueGameClick = (switched: boolean) => {
        print(`继续游戏点击, switched: ${switched ? "on" : "off"}`);
    };

    const loadSaveClick = (switched: boolean) => {
        print(`加载游戏点击, switched: ${switched ? "on" : "off"}`);
    };

    const exitClick = (switched: boolean) => {
        print(`退出游戏点击, switched: ${switched ? "on" : "off"}`);
        // App.quit();
    };
		const root = Node();
		const bt1 = toNode(<Button 
                    type="click"
                    x={buttonx}
                    y={buttony[0]}
                    width={buttonWidth}
                    height={buttonHeight}
                    onClick={newGameClick}
                    text="新游戏"
                />);
		const bt2 = toNode(<Button 
                    type="click"
                    x={buttonx}
                    y={buttony[1]}
                    width={buttonWidth}
                    height={buttonHeight}
                    onClick={continueGameClick}
                    text="继续游戏"
                />);
		const bt3 = toNode(<Button 
                    type="click"
                    x={buttonx}
                    y={buttony[2]}
                    width={buttonWidth}
                    height={buttonHeight}
                    onClick={loadSaveClick}
                    text="读取存档"
                />);
		const bt4 = toNode(<Button 
                    type="click"
                    x={buttonx}
                    y={buttony[3]}
                    width={buttonWidth}
                    height={buttonHeight}
                    onClick={exitClick}
                    text="退出游戏"
                />);
    return root;
};




// 初始化
updateViewSize();
adjustWinSize();
Director.entry.onAppChange(settingName => {
    if (settingName === 'Size') {
        updateViewSize();
    }
});

// 启动场景
StartUp();
// <node>
            
//                 <Button 
//                     type="click"
//                     x={buttonx}
//                     y={buttony[0]}
//                     width={buttonWidth}
//                     height={buttonHeight}
//                     onClick={newGameClick}
//                     text="新游戏"
//                 />
//                 <Button 
//                     type="click"
//                     x={buttonx}
//                     y={buttony[1]}
//                     width={buttonWidth}
//                     height={buttonHeight}
//                     onClick={continueGameClick}
//                     text="继续游戏"
//                 />
//                 <Button 
//                     type="click"
//                     x={buttonx}
//                     y={buttony[2]}
//                     width={buttonWidth}
//                     height={buttonHeight}
//                     onClick={loadSaveClick}
//                     text="加载游戏"
//                 />
//                 <Button 
//                     type="click"
//                     x={buttonx}
//                     y={buttony[3]}
//                     width={buttonWidth}
//                     height={buttonHeight}
//                     onClick={exitClick}
//                     text="退出游戏"
//                 />
//         </node>