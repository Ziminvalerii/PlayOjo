//
//  VibrationManager.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 07.10.2022.
//

import Foundation
import AudioToolbox


func playVibration() {
    if !UserDefaultsValues.vibrationOff {
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}
