//
//  InstructionButton.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 08.10.2022.
//

import SpriteKit

class InstructionButton: SKSpriteNode {
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
        self.init(imageNamed: "infoButtonTexture")
        self.size = CGSize(width: 35, height: 35)
        self.zPosition = 21
        self.name = "info button"
    }
}

extension InstructionButton: ButtonType {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = self.scene else {return}
        if containsTouches(touches: touches, scene: scene, node: self) {
            delegate.switchState(state: .goToInstruction)
        }
    }
}
