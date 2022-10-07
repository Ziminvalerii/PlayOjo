//
//  StartScene+Nodes.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 28.09.2022.
//

import SpriteKit

extension StartScene {
    func setBackgroundNode()->SKSpriteNode {
        let node = SKSpriteNode(imageNamed: "startBackgroundTexture")
        node.size = self.size
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.zPosition = 1.0
        if let parentVC = parentVC as? StartViewController {
        if parentVC.type == .start {
            configureButtons(node: node)
        }
        }
        self.run(SKAction.repeat(SKAction.run(createEndlessBubles), count: 10))
        playButton.animate()
        instruction.animate()
        return node
    }
    
    func configureButtons(node: SKNode) {
        playButton.position = CGPoint(x: 0, y: 100)
        instruction.position = CGPoint(x: 0, y: -100)
        touchable.append(playButton)
        touchable.append(instruction)
        node.addChild(playButton)
        node.addChild(instruction)
    }
    
    func createEndlessBubles() {
        let node = DiffusionBall()
        let randomX = CGFloat.random(in: -self.size.width/2 + node.size.width/2 ... self.size.width/2 + node.size.width/2 )
        node.position = CGPoint(x: randomX, y: 0/*self.size.height/2*/)
        node.applyDiffusion()
        self.addChild(node)
        let randX = CGFloat.random(in: -10.0...10.0)
        let randY = CGFloat.random(in: -10.0...10.0)
        node.physicsBody!.applyImpulse(CGVector(dx: randX, dy: randY))
    }
    
    func setPhysicWorld() {
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0)
        let rect = CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
        self.physicsBody?.categoryBitMask = PhysicsBitMask.bottleBorder.bitmask
        self.physicsBody?.collisionBitMask = PhysicsBitMask.buble.bitmask
        self.physicsBody?.contactTestBitMask = PhysicsBitMask.buble.bitmask
        self.physicsWorld.contactDelegate = self
    }
    
}


