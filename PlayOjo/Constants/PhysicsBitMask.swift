//
//  PhysicsBitMask.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 29.09.2022.
//

import Foundation

enum PhysicsBitMask {
    case bottleBorder
    case buble
    
    var bitmask: UInt32 {
        switch self {
        case .bottleBorder:
            return 0x1<<1
        case .buble:
            return 0x1<<2
        }
    }
}
