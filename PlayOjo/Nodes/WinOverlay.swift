//
//  WinOverlay.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 01.10.2022.
//

import SpriteKit

class WinOverlay: SKSpriteNode {
    var titleLabel: SKLabelNode = {
        let text = NSAttributedString(string: "You win", attributes: [.font : UIFont(name: "Arial", size: 64)!, .foregroundColor: UIColor.white])
        var label = SKLabelNode(text: "You won", size: 64, shadow: .black)
        label.numberOfLines = 6
        label.zPosition = 21
        label.name = "title label"
        label.zRotation = 0.5
        return label
    }()
    
    lazy var nextButton: ButtonNode = ButtonNode(with: .next)
    lazy var collectSound = SKAction.playSoundFileNamed("collect.wav", waitForCompletion: false)
    
    convenience init(scenesize: CGSize) {
        self.init(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.4), size: scenesize)
        self.zPosition = 10.0
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        nextButton.position = CGPoint(x: 0, y: -scenesize.height/2 + nextButton.size.height/2 + 64)
        self.addChild(titleLabel)
        self.addChild(nextButton)
    }
    
    func applyCoinsFallAction() {
        self.run(SKAction.repeat(SKAction.sequence([SKAction.run(createCoins), SKAction.wait(forDuration: TimeInterval(Float.random(in: 0...0.1)))]), count: 20))
    }
    
    func playSound(_ scene: SKScene) {
        if !UserDefaultsValues.soundOff {
            self.scene?.run(collectSound)
        }
    }
    
    func createCoins() {
        guard let scene = self.scene else {return}
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        let coins = SKSpriteNode(imageNamed: "coins")
        coins.size = CGSize(width: 40, height: 40)
        coins.zPosition = 18
        coins.name = "coins node"
        let x = CGFloat.random(in: -scene.size.width/2+coins.size.width/2 ... scene.size.width/2-coins.size.width/2)
        coins.position = CGPoint(x: x, y: scene.size.height/2 - coins.size.height/2)
        coins.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        coins.physicsBody?.categoryBitMask = 0x0
        coins.physicsBody?.contactTestBitMask = 0x0
        coins.physicsBody?.collisionBitMask = 0x0
        coins.physicsBody?.isDynamic = true
        coins.physicsBody?.affectedByGravity = true
        coins.physicsBody?.allowsRotation = true
        scene.addChild(coins)
    }
}

extension WinOverlay: Updatable {
    func update() {
        guard let scene = self.scene else {return}
        scene.enumerateChildNodes(withName: "coins node") { node, error in
            if node.position.y < -scene.size.height/2 {
                UserDefaultsValues.coinsCount += 1
                if let coinLabel = scene.childNode(withName: "coins node") as? CoinsLabel {
                coinLabel.setText()
                }
                self.playSound(scene)
                node.removeFromParent()
                print("dissapear")
            }
        }
    }
}
