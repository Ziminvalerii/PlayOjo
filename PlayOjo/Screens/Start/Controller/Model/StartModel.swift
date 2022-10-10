//
//  StartModel.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 08.10.2022.
//

import Foundation


enum SettingModel: CaseIterable {
    case sound
    case music
    case vibration
    
    var title: String {
        switch self {
        case .sound:
            return "Sound"
        case .music:
            return "Music"
        case .vibration:
            return "Vibration"
        }
    }
    
    var isOn: Bool {
        switch self {
        case .sound:
            return !UserDefaultsValues.soundOff
        case .music:
            return !UserDefaultsValues.musicOff
        case .vibration:
            return !UserDefaultsValues.vibrationOff
        }
    }
}
