//
//  ButtonNode.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 28.09.2022.
//

import SpriteKit

enum ButtonTypeEnum {
    case start
    case instruction
    case next
    
    var imageNamed: String {
        switch self {
        case .start:
            return "startButtonTexture"
        case .instruction:
            return "instructionButtonTexture"
        case .next:
            return "nextButtonTexture"
        }
    }
}

class ButtonNode: SKSpriteNode {
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
    
    var type: ButtonTypeEnum = .start
    
    convenience init(with type: ButtonTypeEnum) {
        self.init(imageNamed: type.imageNamed)
        //    self.size = CGSize(width: 300, height: 120)
        self.zPosition = 12
        self.name = "button node - \(type.imageNamed)"
        self.type = type
        //   self.addChild(label)
        
    }
    
    func animate() {
        self.size = CGSize(width: 0, height: 0)
        self.run(SKAction.resize(byWidth: 300, height: 120, duration: 1.5))
    }
    
    func setText(text: String) {
        let text = NSAttributedString(string: text, attributes: [.font : UIFont(name: "Arial", size: 17)!, .foregroundColor: UIColor.white])
    }
}

extension ButtonNode: ButtonType {
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = self.scene else {return}
        if containsTouches(touches: touches, scene: scene, node: self) {
            if self.type == .instruction {
                delegate.switchState(state: .goToInstruction)
            } else {
                delegate.switchState(state: .goToGame)
            }
        }
        //        else if containsTouches(touches: touches, scene: scene, nodeNames: ["button node - Next", "button  label node - Next"]) {
        //            delegate.switchState(state: .goToGame)
        //        }
        
    }
}
