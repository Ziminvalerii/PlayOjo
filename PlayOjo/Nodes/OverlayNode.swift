//
//  OverlayNode.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 05.10.2022.
//

import Foundation
import SpriteKit

class OverlayNode: SKSpriteNode {
    convenience init(scenesize: CGSize) {
        self.init(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.4), size: scenesize)
        self.zPosition = 6
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
    }
}
