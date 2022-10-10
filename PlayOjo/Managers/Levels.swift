//
//  Levels.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 29.09.2022.
//

import SpriteKit

enum BubleTextures {
    case buble1
    case buble2
    case buble3
    case buble4
    case buble5
    case buble6
    case buble7
    case buble8
    case buble9
    case buble10
    
    var texture: SKTexture {
        switch self {
        case .buble1:
            return SKTexture(imageNamed: "ball1")
        case .buble2:
            return SKTexture(imageNamed: "ball2")
        case .buble3:
            return SKTexture(imageNamed: "ball3")
        case .buble4:
            return SKTexture(imageNamed: "ball4")
        case .buble5:
            return SKTexture(imageNamed: "ball5")
        case .buble6:
            return SKTexture(imageNamed: "ball6")
        case .buble7:
            return SKTexture(imageNamed: "ball7")
        case .buble8:
            return SKTexture(imageNamed: "ball8")
        case .buble9:
            return SKTexture(imageNamed: "ball9")
        case .buble10:
            return SKTexture(imageNamed: "ball10")
        
        }
    }
}

enum Levels: CaseIterable {
    case first
    case second
    case third
    case forth
    case fifth
    case sixth
    case seventh
    case eighth
    case ninth
    case tenth
    case eleventh
//    case twelve
//    case thirteen
//    case fourteen
//    case fifteen
    
    var flaskCount: Int {
        return bublesInFlaks.count
//        switch self {
//        case .first:
//            return bublesInFlaks.count
//        case .second:
//            return bublesInFlaks.count
//        case .third:
//            return bublesInFlaks.count
//        case .forth:
//            return bublesInFlaks.count
//        case .fifth:
//            return bublesInFlaks.count
//        case .sixth:
//            return bublesInFlaks.count
//        case .seventh:
//            return bublesInFlaks.count
//        case .eighth:
//            return 5
//        }
    }
    
    var bublesInFlaks: [(Int, [BubleTextures])] {
        switch self {
        case .first:
            return [(0, [.buble1, .buble2, .buble2, .buble1]),
                    (1, [.buble2, .buble1, .buble1, .buble2]),
                    (2, [BubleTextures]())
            ]
        case .second:
            return [(0, [.buble1, .buble2, .buble1, .buble3]),
                    (1, [.buble1, .buble3, .buble2, .buble2]),
                    (2, [.buble3, .buble2, .buble1, .buble3]),
                    (3, [BubleTextures]()),
                    (4, [BubleTextures]())
            ]
        case .third:
            return [(0, [.buble1, .buble2, .buble3, .buble1]),
                    (1, [.buble2, .buble1, .buble3, .buble2]),
                    (2, [.buble3, .buble1, .buble2, .buble3]),
                    (3, [BubleTextures]()),
                    (4, [BubleTextures]())
                      ]
        case .forth:
            return [(0, [.buble1, .buble3, .buble1, .buble1]),
                    (1, [.buble4, .buble4, .buble4, .buble2]),
                    (2, [.buble3, .buble3, .buble4, .buble2]),
                    (3, [.buble2, .buble2, .buble1, .buble3]),
                    (4, [BubleTextures]())
            ]
        case .fifth:
            return [(0, [.buble3, .buble2, .buble1, .buble2]),
                    (1, [.buble4, .buble4, .buble3, .buble2]),
                    (2, [.buble4, .buble4, .buble3, .buble2]),
                    (3, [.buble1, .buble1, .buble1, .buble3]),
                    (4, [BubleTextures]())
            ]
        case .sixth:
            return [(0, [.buble4, .buble4, .buble3, .buble1]),
                    (1, [.buble3, .buble1, .buble5, .buble2]),
                    (2, [.buble3, .buble1, .buble2, .buble5]),
                    (3, [.buble3, .buble5, .buble5, .buble2]),
                    (4, [.buble1, .buble2, .buble4, .buble4]),
                    (5, [BubleTextures]()),
                    (6 , [BubleTextures]())
            ]
        case .seventh:
            return [(0, [.buble6, .buble6, .buble5, .buble2]),
                    (1, [.buble3, .buble3, .buble5, .buble2]),
                    (2, [.buble1, .buble4, .buble1, .buble2]),
                    (3, [.buble4, .buble1, .buble4, .buble3]),
                    (4, [.buble5, .buble5, .buble2, .buble3]),
                    (5, [.buble6, .buble6, .buble4, .buble1]),
                    (6, [BubleTextures]()),
            ]
        case .eighth:
            return [(0, [.buble4, .buble2, .buble3, .buble3]),
                    (1, [.buble5, .buble1, .buble2, .buble3]),
                    (2, [.buble6, .buble4, .buble5, .buble1]),
                    (3, [.buble6, .buble6, .buble4, .buble1]),
                    (4, [.buble4, .buble6, .buble5, .buble1]),
                    (5, [.buble2, .buble2, .buble3, .buble5]),
                    (6, [BubleTextures]()),
            ]
        case .ninth:
            return [(0, [.buble5, .buble2, .buble4, .buble2]),
                    (1, [.buble3, .buble1, .buble5, .buble6]),
                    (2, [.buble2, .buble7, .buble7, .buble4]),
                    (3, [.buble5, .buble3, .buble3, .buble4]),
                    (4, [.buble1, .buble1, .buble4, .buble6]),
                    (5, [.buble2, .buble6, .buble7, .buble7]),
                    (6, [.buble6, .buble5, .buble3, .buble1]),
                    (7, [BubleTextures]()),
                    (8, [BubleTextures]()),
            ]
        case .tenth:
            return [(0, [.buble5, .buble2, .buble4, .buble2]),
                    (1, [.buble3, .buble1, .buble5, .buble6]),
                    (2, [.buble2, .buble7, .buble7, .buble4]),
                    (3, [.buble5, .buble3, .buble3, .buble4]),
                    (4, [.buble1, .buble1, .buble4, .buble6]),
                    (5, [.buble2, .buble6, .buble7, .buble7]),
                    (6, [.buble6, .buble5, .buble3, .buble1]),
                    (7, [BubleTextures]()),
                    (8, [BubleTextures]()),
            ]
        case .eleventh:
            return [(0, [.buble2, .buble3, .buble3, .buble6]),
                    (1, [.buble5, .buble4, .buble3, .buble7]),
                    (2, [.buble6, .buble4, .buble1, .buble6]),
                    (3, [.buble4, .buble1, .buble2, .buble7]),
                    (4, [.buble3, .buble7, .buble5, .buble6]),
                    (5, [.buble4, .buble2, .buble5, .buble1]),
                    (6, [.buble1, .buble7, .buble5, .buble2]),
                    (7, [BubleTextures]()),
                    (8, [BubleTextures]()),
            ]
//        case .twelve:
//            return [(Int, [BubleTextures])]()
//        case .thirteen:
//            return [(Int, [BubleTextures])]()
//        case .fourteen:
//            return [(Int, [BubleTextures])]()
//        case .fifteen:
//            return [(Int, [BubleTextures])]()
        }
    }
}
