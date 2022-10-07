//
//  StartScene.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 28.09.2022.
//

import SpriteKit

class StartScene: SKScene {
    weak var parentVC: UIViewController?
    lazy var backgroundNode: SKSpriteNode = setBackgroundNode()
    lazy var playButton = ButtonNode(with: .start)
    lazy var instruction = ButtonNode(with: .instruction)
    var touchable: [Touchable] = [Touchable]()
    override func sceneDidLoad() {
    }
    
    override func didMove(to view: SKView) {
        self.addChild(backgroundNode)
        setPhysicWorld()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchable.forEach { node in
            node.touchesBegan(touches, with: event)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    func playSound() {
        let sound = SKAction.playSoundFileNamed("collect.wav", waitForCompletion: false)
        self.run(sound)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension StartScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let y =  contact.contactPoint.y < 0 ? 2.0 : -2.0
        let x =  contact.contactPoint.x < 0 ? 2.0 : -2.0
        if let node = contact.bodyA.node as? DiffusionBall {
            node.physicsBody!.applyImpulse(CGVector(dx: x, dy: y))
        } else if let node = contact.bodyB.node as? DiffusionBall {
            node.physicsBody!.applyImpulse(CGVector(dx: x, dy: y))
        }
    }
}


extension StartScene: Dependable {
    func switchState(state: GameStates) {
        if state == .goToGame {
            if let parentVC = parentVC as? StartViewController {
                parentVC.goToGameVC()
            }
        } else if state == .goToInstruction {
            if let parentVC = parentVC as? StartViewController {
                parentVC.goToInstruction()
            }
        }
    }
}
