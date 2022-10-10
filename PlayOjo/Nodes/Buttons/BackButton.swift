//
//  BackButton.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 07.10.2022.
//

import SpriteKit

class BackButton: SKSpriteNode {
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
        self.init(imageNamed: "backButtonTexture")
        self.size = CGSize(width: 45, height: 45)
        self.zPosition = 12
        self.name = "back button"
    }
}

extension BackButton: ButtonType {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = self.scene else {return}
        if containsTouches(touches: touches, scene: scene, node: self) {
            delegate.switchState(state: .back)
        }
    }
}
