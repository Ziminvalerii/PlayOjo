//
//  Range.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 09.10.2022.
//

import Foundation

extension Range {
    static func ~=(lhs: Self, rhs: Self) -> Bool {
        rhs.clamped(to: lhs) == rhs
    }
}

extension ClosedRange {
    static func ~=(lhs: Self, rhs: Self) -> Bool {
        rhs.clamped(to: lhs) == rhs
    }
}
