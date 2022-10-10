//
//  PlayingState.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 28.09.2022.
//

import GameplayKit

class PlayingState: GKState {
    weak var gameSceneManager: GameSceneManager?
    lazy var backgroundNode: SKSpriteNode = createBackground()
    var undoButton: UndoButton!
    lazy var replayButton = ReplayButtonNode()
    lazy var menuButton = MenuButtonNode()
    lazy var lavelLabel = LevelLabel(custom: true)
    lazy var coinsLabel = CoinsLabel()
    lazy var backButton = BackButton()
    
    
    init(gameSceneManager: GameSceneManager) {
        self.gameSceneManager = gameSceneManager
        self.undoButton = UndoButton(levelFactory: gameSceneManager.levelFactory)
       
    }
    override func didEnter(from previousState: GKState?) {
        if previousState is GameOverState {
            return
        }
        guard let gameSceneManager = gameSceneManager else {return}
        guard let scene = gameSceneManager.scene else {return}
        scene.addChild(backgroundNode)
        let bottles = gameSceneManager.levelFactory.createFlacons()
        bottles.forEach { node in
            scene.addChild(node)
            gameSceneManager.toucheble.append(node)
            node.applyBubleAction()
        }
        undoButton.position = CGPoint(x: scene.size.width/2 - undoButton.size.width/2 - 16, y: scene.size.height/2 - undoButton.size.height/2 - 48)
        replayButton.position = CGPoint(x: undoButton.frame.minX - 32, y: undoButton.position.y)
        backButton.position = CGPoint(x: -scene.size.width/2 + backButton.size.width/2 + 16, y: undoButton.position.y)
        menuButton.position = CGPoint(x: backButton.position.x + backButton.size.width/2 + menuButton.size.width/2 + 8, y: undoButton.position.y)
        lavelLabel.position = CGPoint(x: 0, y: scene.size.height/2 - lavelLabel.frame.size.height/2 - 120)
        coinsLabel.position = CGPoint(x: 0, y: lavelLabel.frame.minY - 24 /* coinsLabel.size.width/2*/)
        lavelLabel.setText()
        undoButton.freeUndoActions = 2
        gameSceneManager.toucheble.append(undoButton)
        gameSceneManager.toucheble.append(replayButton)
        gameSceneManager.toucheble.append(menuButton)
        gameSceneManager.toucheble.append(backButton)
        scene.addChild(undoButton)
        scene.addChild(replayButton)
        scene.addChild(menuButton)
        scene.addChild(lavelLabel)
        scene.addChild(coinsLabel)
        scene.addChild(backButton)
    }

    
    override func willExit(to nextState: GKState) {
        guard let gameSceneManager = gameSceneManager else {return}
        guard let scene = gameSceneManager.scene else {return}
        if nextState is PlayingState {
            scene.removeAllChildren()
            scene.removeAllActions()
            gameSceneManager.toucheble.removeAll()
        }
    }

}


extension PlayingState {
    func createBackground()->SKSpriteNode {
        guard let scene = gameSceneManager?.scene else {return SKSpriteNode()}
        let backgroundNode = SKSpriteNode(imageNamed: "playBackgroundTexture")
        backgroundNode.size = scene.size
        backgroundNode.zPosition = 1.0
        return backgroundNode
    }
    
    
    func createlevelLabel()->SKLabelNode {
        let label = SKLabelNode(text: "Level \(UserDefaultsValues.levelIndex+1)", size: 32, shadow: .black)
        label.numberOfLines = 6
        label.zPosition = 21
        label.name = "button"
        return label
    }
    
   
}

