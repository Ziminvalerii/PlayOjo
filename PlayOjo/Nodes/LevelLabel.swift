//
//  LevelLabel.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 09.10.2022.
//

import SpriteKit

class LevelLabel: SKLabelNode {
    
    convenience init(custom: Bool) {
        self.init(text: "Level \(UserDefaultsValues.levelIndex+1)", size: 32, shadow: .black)
        self.numberOfLines = 6
        self.zPosition = 21
        self.name = "button"
    }
    
    func setText() {
        let text = NSAttributedString(string: "Level \(UserDefaultsValues.levelIndex+1)", attributes: [.font : UIFont(name: "Arial Rounded MT Bold", size: 32)!, .foregroundColor: UIColor.green])
        self.attributedText = text
    }
    
    func animateLabel(sceneSize: CGSize, to position: CGPoint) {
        self.position = CGPoint(x: sceneSize.width/2, y: position.y)
        self.run(SKAction.sequence([SKAction.wait(forDuration: 0.1), SKAction.move(to: position, duration: 1.0)]))
    }
}
