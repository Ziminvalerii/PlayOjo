//
//  DiffusionBall.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 06.10.2022.
//

import SpriteKit

class DiffusionBall: SKSpriteNode {
    var diffusionTextures = [SKTexture(imageNamed: "ballTexture1"), SKTexture(imageNamed: "ballTexture2")]
    convenience init() {
        self.init(imageNamed: "ballTexture1")
        self.zPosition = 2
        self.name = "diffusion ball"
        self.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0.5
        self.physicsBody?.friction = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.categoryBitMask = PhysicsBitMask.buble.bitmask
        self.physicsBody?.collisionBitMask =  PhysicsBitMask.buble.bitmask | PhysicsBitMask.bottleBorder.bitmask
        self.physicsBody?.contactTestBitMask =  PhysicsBitMask.buble.bitmask | PhysicsBitMask.bottleBorder.bitmask
        self.size = CGSize(width: 40, height: 40)
    }
    
    func applyDiffusion() {
        let resizing = [SKAction.resize(toWidth: 160, height: 160, duration: 1.0),
                        SKAction.resize(toWidth: 180, height: 160, duration: 1.0),
                        SKAction.resize(toWidth: 160, height: 180, duration: 1.0),
                        SKAction.resize(toWidth: 160, height: 160, duration: 1.0),
                        SKAction.resize(toWidth: 220, height: 160, duration: 1.0),
                        SKAction.resize(toWidth: 160, height: 220, duration: 1.0),
        ]
        var action = [SKAction]()
        action.append(resizing[random(to: resizing.count-1)])
        action.append(resizing[random(to: resizing.count-1)])
        action.append(resizing[random(to: resizing.count-1)])
        action.append(resizing[random(to: resizing.count-1)])
        action.append(resizing[random(to: resizing.count-1)])
        self.run(SKAction.repeatForever(SKAction.sequence(action)))
//        self.run(SKAction.repeatForever(
//            SKAction.animate(with: diffusionTextures,
//                             timePerFrame: 0.1,
//                             resize: false,
//                             restore: true)),
//                 withKey:"diffusion")
    }
    
    func random(to: Int)->Int {
        return Int.random(in: 0...to)
    }
}
