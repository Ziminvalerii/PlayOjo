//
//  GameScene.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 28.09.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
    var gameManager: GameSceneManager!
    lazy var stateMachine: GKStateMachine = GKStateMachine(states: [
        PlayingState(gameSceneManager: gameManager!),
        WinState(gameSceneManager: gameManager!),
        GameOverState(gameSceneManager: gameManager!)
        ])
    var selectedBuble: BubleNode?
    weak var parentVC: GameViewController?
    
    override func sceneDidLoad() {
        self.size = UIScreen.main.bounds.size
        gameManager = GameSceneManager(scene: self)
        self.stateMachine.enter(PlayingState.self)
    }
    
    override func didMove(to view: SKView) {
        print("moved")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameManager.toucheble.forEach { node in
            node.touchesBegan(touches, with: event)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        gameManager.updatable.forEach { node in
            node.update()
        }
    }
}

extension GameScene: Dependable {
    func switchState(state: GameStates) {
        if state == .goToGame {
            if stateMachine.currentState is GameOverState {
                stateMachine.enter(PlayingState.self)
            }
            stateMachine.enter(PlayingState.self)
        } else if state == .showMenu {
            self.isPaused = true
            parentVC?.showMenuView()
        } else if state == .goToWin {
            stateMachine.enter(WinState.self)
            parentVC?.showWinAnimation()
        } else if state == .gameOver {
            stateMachine.enter(GameOverState.self)
        } else if state == .checkGameOver {
            if let state = stateMachine.currentState as? GameOverState {
                stateMachine.enter(PlayingState.self)
            }
        } else if state == .back {
            parentVC?.navigationController?.popViewController(animated: true)
        }
    }
    
    func receiveMessage<T>(with arguments: T) {
        if let arguments = arguments as? CGPoint {
            parentVC?.showConfetti(position: arguments)
        }
    }
    
    func recieveMessage<T>(with argumets: T, completion: @escaping () -> Void) {
        if let arguments = argumets as? GameStates {
            if arguments == .showAd {
                parentVC?.showRewardedAd {
                    completion()
                }
            }
        }
    }
}
