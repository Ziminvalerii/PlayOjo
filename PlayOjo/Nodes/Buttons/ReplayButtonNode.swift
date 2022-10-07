//
//  ReplayButtonNode.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 30.09.2022.
//

import SpriteKit

class ReplayButtonNode: SKSpriteNode {
    
    var shouldAcceptTouches: Bool = true {
        didSet {
            self.isUserInteractionEnabled = shouldAcceptTouches
        }
    }
    
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    
    convenience init() {
        self.init(imageNamed: "replayButtonTexture")
        self.size =  CGSize(width: 35, height: 35)
        self.zPosition = 8
        self.name = "replay button node"
        //self.addGlow()
    }
    
    func shineAction() {
        let action = SKAction.run({
            self.addGlow()
        })
        
        let removeAction = SKAction.run({
            let glow = self.childNode(withName: "glow node")
            if let glow = glow {
                glow.run(SKAction.fadeOut(withDuration: 0.5))
                glow.removeFromParent()
            }
        })
        self.run(SKAction.repeatForever(SKAction.sequence([action, SKAction.wait(forDuration: 0.5), removeAction, SKAction.wait(forDuration: 0.5)])), withKey: "glow action")
    }
    
    func removeShineAction() {
        self.removeAction(forKey: "glow action")
    }
}

extension ReplayButtonNode: ButtonType {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = self.scene else {return}
        if containsTouches(touches: touches, scene: scene, node: self) {
            delegate.switchState(state: .goToGame)
        }
    }
    
}
