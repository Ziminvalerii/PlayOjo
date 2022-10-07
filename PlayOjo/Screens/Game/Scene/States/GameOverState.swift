//
//  GameOverState.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 05.10.2022.
//

import GameplayKit

class GameOverState: GKState {
    weak var gameSceneManager: GameSceneManager?
    var overlay: OverlayNode!
    var undoButton: UndoButton?
    var replayButton: ReplayButtonNode?
    init(gameSceneManager: GameSceneManager) {
        self.gameSceneManager = gameSceneManager
        guard let scene = gameSceneManager.scene else {return}
        self.overlay = OverlayNode(scenesize: gameSceneManager.scene!.size)
       
    }
    
    override func didEnter(from previousState: GKState?) {
        guard let gameSceneManager = gameSceneManager else {return}
        guard let scene = gameSceneManager.scene else {return}
        scene.addChild(overlay)
        undoButton = scene.childNode(withName: "undo button node") as? UndoButton
        replayButton = scene.childNode(withName: "replay button node") as? ReplayButtonNode
        replayButton?.shineAction()
        undoButton?.shineAction()
    }
    
    override func willExit(to nextState: GKState) {
        guard let gameSceneManager = gameSceneManager else {return}
        undoButton?.removeShineAction()
        replayButton?.removeShineAction()
        overlay.removeFromParent()
    }
}
