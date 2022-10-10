//
//  WinState.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 01.10.2022.
//

import GameplayKit

class WinState: GKState {
    weak var gameSceneManager: GameSceneManager?
    var winOverlay: WinOverlay!
    init(gameSceneManager: GameSceneManager) {
        self.gameSceneManager = gameSceneManager
        self.winOverlay = WinOverlay(scenesize: gameSceneManager.scene!.size)
    }
    
    override func didEnter(from previousState: GKState?) {
        guard let gameSceneManager = gameSceneManager else {return}
        guard let scene = gameSceneManager.scene else {return}
        scene.enumerateChildNodes(withName: "bottle") { node, error in
            node.isUserInteractionEnabled = false
        }
        scene.addChild(winOverlay)
        gameSceneManager.toucheble.append(winOverlay.nextButton)
        gameSceneManager.updatable.append(winOverlay)
        winOverlay.applyCoinsFallAction()
        if UserDefaultsValues.levelIndex > gameSceneManager.levelFactory.levels.count-1 {
            UserDefaultsValues.levelIndex = 0
        } else {
        UserDefaultsValues.levelIndex += 1
        }
        gameSceneManager.levelFactory.setCurrentLevel()
    }
    
    override func willExit(to nextState: GKState) {
        
        guard let gameSceneManager = gameSceneManager else {return}
        guard let scene = gameSceneManager.scene else {return}
        scene.enumerateChildNodes(withName: "bottle") { node, error in
            node.isUserInteractionEnabled = true
        }
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        scene.removeAllChildren()
        scene.removeAllActions()
        gameSceneManager.toucheble.removeAll()
    }
}
