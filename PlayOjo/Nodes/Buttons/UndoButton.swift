//
//  UndoButton.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 29.09.2022.
//

import SpriteKit

class UndoButton: SKSpriteNode {
    var shouldAcceptTouches: Bool = true {
        didSet {
            //self.isUserInteractionEnabled = shouldAcceptTouches
        }
    }
    var freeUndoActions: Int = 2 {
        didSet {
            if freeUndoActions <= 0 {
                setUpWatchAdd()
            } else {
                setUpForActions()
            }
        }
    }
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    
    lazy var watchAdTexture = SKTexture(imageNamed: "watchAdIcon")
    lazy var undoTexture = SKTexture(imageNamed: "undoIcon")
    lazy var forCoinsTexture = SKTexture(imageNamed: "coins")
    var levelFactory: LevelFactory!
    var label: SKLabelNode = {
        let text = NSAttributedString(string: "2", attributes: [.font : UIFont(name: "Arial", size: 16)!, .foregroundColor: UIColor.white])
        var label = SKLabelNode(attributedText: text)
        label.numberOfLines = 6
        label.zPosition = 1
        label.name = "undo  label node"
        return label
    }()
    var icon: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "undoIcon")
        node.size = CGSize(width: 20, height: 20)
        node.zPosition = 1
        node.name = "undo icon node"
        return node
    }()
    
    convenience init(levelFactory: LevelFactory) {
        self.init(imageNamed: "iconButtonTexture")
        self.zPosition = 8
        self.size = CGSize(width: 70, height: 45)
        self.name = "undo button node"
        label.position = CGPoint(x: self.frame.minX + 16, y: -label.frame.size.height/4)
        icon.position = CGPoint(x: label.frame.maxX + icon.size.width/2 + 4, y: -label.frame.size.height/4 + icon.size.height/2)
        self.addChild(label)
        self.addChild(icon)
        self.levelFactory = levelFactory
    }
    
    func setUpForActions() {
        icon.texture = undoTexture
        setText(text: freeUndoActions.description)
    }
    
    func setUpWatchAdd() {
        if UserDefaultsValues.coinsCount >= 50 {
            icon.texture = forCoinsTexture
            setText(text: "50")
        } else {
            icon.texture = watchAdTexture
            setText(text: "ad")
        }
    }
    
    func setText(text: String) {
        let text = NSAttributedString(string: text, attributes: [.font : UIFont(name: "Arial", size: 16)!, .foregroundColor: UIColor.white])
        label.attributedText = text
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

extension UndoButton: ButtonType {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = self.scene else {return}
        if containsTouches(touches: touches, scene: scene, nodeNames: ["undo icon node", "undo  label node", "undo button node"]) {
            if icon.texture == watchAdTexture {
                delegate.recieveMessage(with: GameStates.showAd, completion: {
                    self.freeUndoActions += 2
                })
            } else if icon.texture == forCoinsTexture {
                UserDefaultsValues.coinsCount -= 50
                if let coinLabel = scene.childNode(withName: "coins node") as? CoinsLabel {
                    coinLabel.setText()
                }
                freeUndoActions += 2
            } else {
                if levelFactory.prevous.count > 0 {
                    let buble = levelFactory.prevous.removeLast()
                    buble.returnToThePrevPos()
                    freeUndoActions -= 1
                }
            }
        }
    }
    
}
