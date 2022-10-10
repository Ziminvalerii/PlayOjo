//
//  BottleButton.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 29.09.2022.
//

import SpriteKit

class BottleNode: SKSpriteNode {
    var shouldAcceptTouches: Bool = true {
        didSet {
            self.isUserInteractionEnabled = shouldAcceptTouches
        }
    }
    var levelFactory: LevelFactory!
    var bubbles = [BubleNode]()
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    private var start: Bool = false
    
    lazy var collectSound = SKAction.playSoundFileNamed("collect.wav", waitForCompletion: false)
    lazy var fallSound = SKAction.playSoundFileNamed("fall.wav", waitForCompletion: false)
    lazy var foregrounNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "bottleTexture1")
        node.size = CGSize(width: 50, height: 200)
        node.zPosition = 6
        node.alpha = 1
        return node
    }()
    convenience init(levelFactory: LevelFactory) {
        self.init(imageNamed: "bottleTexture1")
        self.size = CGSize(width: 50, height: 200)
        self.zPosition = 4
        self.alpha = 1
        self.name = "bottle"
        self.addChild(foregrounNode)
        self.levelFactory = levelFactory
        let leftBorder = createBorder(ground: false)
        leftBorder.position = CGPoint(x:  -self.size.width/2 + leftBorder.size.width/2, y: 0)
        let rightBorder = createBorder(ground: false)
        rightBorder.position =  CGPoint(x:  self.size.width/2 - rightBorder.size.width/2, y: 0)
        let groundBorder = createBorder(ground: true)
        groundBorder.position = CGPoint(x: 0, y: -self.size.height/2 + groundBorder.size.height/2)
        self.addChild(leftBorder)
        self.addChild(rightBorder)
        self.addChild(groundBorder)
    }
    
    func playSound(_ scene: SKScene) {
        if !UserDefaultsValues.soundOff {
            self.scene?.run(collectSound)
        }
    }
    
    func playFallSound(_ scene: SKScene) {
        if !UserDefaultsValues.soundOff {
            self.scene?.run(fallSound)
        }
    }
    
    func createBorder(ground: Bool) -> SKSpriteNode {
        let border = SKSpriteNode(color: .clear, size: CGSize(width: ground ? self.size.width : 1.0, height: ground ? 1 : self.size.height))
        border.physicsBody = SKPhysicsBody(rectangleOf: border.size)
        border.physicsBody?.isDynamic = false
        border.physicsBody?.categoryBitMask = PhysicsBitMask.bottleBorder.bitmask
        border.physicsBody?.collisionBitMask = PhysicsBitMask.buble.bitmask
        return border
    }
    
    func applyBubleAction() {
        guard let scene = self.scene else {return}
        var i =  0
        start = true
        let action = SKAction.repeat(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run {
            scene.addChild(self.bubbles[i])
            i+=1
            self.playFallSound(scene) //playSound(scene)
        }]), count: bubbles.count)
        scene.run(SKAction.sequence([action, SKAction.run({self.start = false})]))
    }
}

extension BottleNode: ButtonType {
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = scene as? GameScene else {return}
        if start {
            return
        }
        if containsTouches(touches: touches, scene: scene, node: foregrounNode) {
            if ((scene.selectedBuble?.type == bubbles.last?.type && scene.selectedBuble?.currentBottle != self) || bubbles.isEmpty)  && bubbles.count < 4 {
                print("place ball")
                self.levelFactory.prevous.append(scene.selectedBuble!)
                scene.selectedBuble?.placeBuble(to: self, completion: {
                    if scene.selectedBuble?.currentBottle == self {
                        scene.selectedBuble = nil
                    }
                    self.checkPossibility()
                    self.checkIfOneBottleSorted()
                    self.checkIfBottleSorted()
                })
            } else if scene.selectedBuble == nil || scene.selectedBuble?.type != bubbles.last?.type {
                print("select ball")
                playFallSound(scene)
                scene.selectedBuble = bubbles.last
                scene.selectedBuble?.setSelected()
            } else {
                print("unselect ball")
                playFallSound(scene)
                scene.selectedBuble?.unselected()
                scene.selectedBuble = nil
            }
        }
    }
    
    func checkIfOneBottleSorted() {
        guard let scene = self.scene else {return}
        if self.bubbles.count == 4 {
            let hasAllItemsEqual = bubbles.dropFirst().allSatisfy({ $0.type == self.bubbles.first?.type})
            if hasAllItemsEqual {
                let posx = scene.size.width - (-self.position.x + scene.size.width/2)
                let posY = scene.size.height - (self.position.y + scene.size.height/2)// self.position.y + scene.size.height/2
                playSound(scene)
                playVibration()
                delegate.receiveMessage(with: CGPoint(x: posx, y: posY))
            }
        } else {
            playFallSound(scene)
        }
    }
    
    func checkPossibility() {
        guard let scene = self.scene else {return}
        let bottles = scene.children.filter({
            if let bottle = $0 as? BottleNode {
                return bottle.name == "bottle"
            } else {
                return false
            }
        })
        guard let bottles = bottles as? [BottleNode] else {return}
        var canNotSortedBottles = [BottleNode]()
        for bottle in bottles {
            if bottle.bubbles.count > 0 {
                if !canNotSortedBottles.contains(where: {$0.bubbles.last?.texture?.description == bottle.bubbles.last?.texture?.description}) {
                    canNotSortedBottles.append(bottle)
                } else {
                    let unSortedEl = canNotSortedBottles.filter({$0.bubbles.last?.texture?.description == bottle.bubbles.last?.texture?.description})
                    if bottle.bubbles.count == 4 && unSortedEl.first?.bubbles.count == 4 {
                        canNotSortedBottles.append(bottle)
                    }
                }
            }
        }
        
        if canNotSortedBottles.count == bottles.count {
            delegate.switchState(state: .gameOver)
        } else {
            delegate.switchState(state: .checkGameOver)
        }
    }
    
    func checkIfBottleSorted() {
        guard let scene = scene else {return}
        let bottles = scene.children.filter({
            if let bottle = $0 as? BottleNode {
                return bottle.name == "bottle" && !bottle.bubbles.isEmpty
            } else {
                return false
            }
        })
        guard let bottles = bottles as? [BottleNode] else {return}
        var win = Array(repeating: false, count: bottles.count)
        for i in 0 ..< bottles.count {
            let hasAllItemsEqual = bottles[i].bubbles.dropFirst().allSatisfy({ $0.type == bottles[i].bubbles.first?.type && bottles[i].bubbles.count == 4 })
            win[i] = hasAllItemsEqual
        }
        if win.dropFirst().allSatisfy({$0 == true}) {
            playVibration()
            self.delegate.switchState(state: .goToWin)
        }
        
    }
}
