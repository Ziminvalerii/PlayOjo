//
//  BubleNode.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 29.09.2022.
//

import Foundation
import SpriteKit

class BubleNode: SKSpriteNode {
    weak var currentBottle: BottleNode?
    weak var previousBottle: BottleNode?
    var type: BubleTextures!
    convenience init(type: BubleTextures) {
        self.init(texture: type.texture)
        self.size = CGSize(width: 40, height: 40)
        self.zPosition = 5
        self.name = "bubble"
        self.type = type
        self.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsBitMask.buble.bitmask
        self.physicsBody?.collisionBitMask = PhysicsBitMask.bottleBorder.bitmask | PhysicsBitMask.buble.bitmask
    }
    
    func setSelected() {
        guard let scene = self.scene as? GameScene else {return}
        scene.enumerateChildNodes(withName: "bubble") { node, error in
            node.physicsBody?.pinned = false
        }
        self.run(SKAction.sequence([SKAction.move(to: CGPoint(x: currentBottle!.position.x, y: currentBottle!.frame.maxY + 24), duration: 0.4), SKAction.run {
            self.physicsBody?.pinned = true
        }]))
    }
    
    func unselected() {
        self.physicsBody?.pinned = false
    }
    
    func placeBuble(to bottle: BottleNode, completion: @escaping()->Void) {
        guard let scene = self.scene as? GameScene else {return}
        self.currentBottle?.bubbles.removeLast()
        self.previousBottle = currentBottle
        self.currentBottle = bottle
        self.physicsBody?.pinned = false
        self.physicsBody?.affectedByGravity = false
        currentBottle?.bubbles.append(self)
        var actions = [SKAction]()
        scene.enumerateChildNodes(withName: "bottle") { node, error in
            if self.previousBottle != node {
                let range = self.previousBottle!.position.x - self.previousBottle!.size.width ... self.previousBottle!.position.x + self.previousBottle!.size.width
                //let nodeLeftSideRange = node.position.x - self.previousBottle!.size.width/2 ... node.position.x
              //  let nodeRightSideRange = node.position.x ... node.position.x+self.previousBottle!.size.width/2
             //   let predicate = (range ~= nodeLeftSideRange) || (range ~= nodeRightSideRange) //range.contains()
                if range.contains(node.position.x) /* predicate */&& self.previousBottle?.frame.maxY != self.currentBottle?.frame.maxY {
                    let positionX = self.previousBottle!.frame.maxY > self.currentBottle!.frame.maxY ? self.previousBottle!.frame.minX : self.currentBottle!.frame.minX
               actions.append(SKAction.moveTo(x: positionX - self.size.width/2, duration: 0.2))
            }
            }
        }
        if bottle.frame.maxY != self.previousBottle?.frame.maxY {
            actions.append(SKAction.moveTo(y: bottle.frame.maxY + 24, duration: 0.6))
        }
        
        actions.append(SKAction.moveTo(x: bottle.position.x, duration: 0.6))
        actions.append(SKAction.run {
            self.physicsBody?.affectedByGravity = true
            completion()
        })
        self.run(SKAction.sequence(actions))
    }
    
    func returnToThePrevPos() {
        guard let scene = self.scene as? GameScene else {return}
        if let previousBottle = previousBottle {
            self.physicsBody?.pinned = false
            self.physicsBody?.affectedByGravity = false
            var actions = [SKAction]()
            actions.append(SKAction.move(to: CGPoint(x:currentBottle!.position.x, y: currentBottle!.frame.maxY + 24), duration: 0.4))
            scene.enumerateChildNodes(withName: "bottle") { node, error in
                if self.currentBottle != node {
                    let range = self.currentBottle!.position.x - self.currentBottle!.size.width ... self.currentBottle!.position.x + self.currentBottle!.size.width
                    if range.contains(node.position.x) && self.previousBottle?.frame.maxY != self.currentBottle?.frame.maxY {
                        let positionX = self.currentBottle!.frame.maxY > self.previousBottle!.frame.maxY ? self.currentBottle!.frame.minX : self.previousBottle!.frame.minX
                   actions.append(SKAction.moveTo(x: positionX - self.size.width/2, duration: 0.2))
                }
                }
            }
            if currentBottle?.frame.maxY != previousBottle.frame.maxY {
                actions.append(SKAction.moveTo(y: previousBottle.frame.maxY + 24, duration: 0.6))
            }
            actions.append(SKAction.move(to: CGPoint(x: previousBottle.position.x, y: previousBottle.frame.maxY + 24), duration: 0.6))
            actions.append(SKAction.run {
                self.physicsBody?.affectedByGravity = true
                let temp = self.previousBottle
                self.previousBottle = self.currentBottle
                self.currentBottle = temp
                self.previousBottle?.bubbles.removeLast()
                self.currentBottle?.bubbles.append(self)
                self.currentBottle?.checkPossibility()
            })
            self.run(SKAction.sequence(actions))
        }
       
    }
}
