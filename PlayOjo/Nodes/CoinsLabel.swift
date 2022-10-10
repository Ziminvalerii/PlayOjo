//
//  CoinsLabel.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 07.10.2022.
//

import SpriteKit

class CoinsLabel: SKSpriteNode {
    
    var image: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "coins")
        node.size = CGSize(width: 30, height: 30)
        node.zPosition = 21
        let x = 85 - node.size.width/2-8
        node.position = CGPoint(x: x, y: 0)
        return node
    }()
    
    var label: SKLabelNode = {
        let node = SKLabelNode(text: "Coins: \(UserDefaultsValues.coinsCount)", size: 24, shadow: .black)
        node.numberOfLines = 6
        node.zPosition = 21
        node.name = "coins label"
        let x =  -85 + node.frame.size.width/2+8
        node.position = CGPoint(x: x, y: -node.frame.size.height/2)
        return node
    }()
    
    convenience init() {
        self.init(color: .clear, size: CGSize(width: 170, height: 40))
        self.zPosition = 20
        self.name = "coins node"
        self.addChild(image)
        self.addChild(label)
    }
    
    func animateLabel(sceneSize: CGSize, to position: CGPoint) {
        self.position = CGPoint(x: -sceneSize.width/2, y: position.y)
        self.run(SKAction.sequence([SKAction.wait(forDuration: 0.1), SKAction.move(to: position, duration: 1.0)]))
    }
    
    func setSize(size: CGFloat) {
        self.size = CGSize(width: size*140/24, height: 40)
        label.setSizeWithShadow(text: "Coins: \(UserDefaultsValues.coinsCount)", size: size)
        image.position = CGPoint(x: self.size.width/2 - image.size.width/2, y: 0)
        let x =  -self.size.width/2 + label.frame.size.width/2 - 8
        label.position = CGPoint(x: x, y: -label.frame.size.height/2)
    }
    
    func setText() {
        let text = NSAttributedString(string: "Coins: \(UserDefaultsValues.coinsCount)", attributes: [.font : UIFont(name: "Arial Rounded MT Bold", size: 24)!, .foregroundColor: UIColor.green])
        label.attributedText = text
    }
}
