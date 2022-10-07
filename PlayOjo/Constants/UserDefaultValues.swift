//
//  UserDefaultValues.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 28.09.2022.
//

import Foundation

public struct UserDefaultsValues {
    enum Keys {
        static let musicOffKey = "com.musicOff.key"
        static let soundOffKey = "com.soundOff.key"
        static let vibrationOffKey = "com.vibrationOff.key"
        static let coinsCountKey = "com.coinsCount.key"
        static let levelIndexKey = "com.levelIndex.key"
        static let brightnessKey = "com.brightness.key"
    }
    
    static var musicOff: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.musicOffKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.musicOffKey)
        }
    }
    
    static var soundOff: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.soundOffKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.soundOffKey)
        }
    }
    
    static var vibrationOff: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.vibrationOffKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.vibrationOffKey)
        }
    }
    
    static var coinsCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.coinsCountKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.coinsCountKey)
        }
    }
    
    static var levelIndex: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.levelIndexKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.levelIndexKey)
        }
    }
    
    static var brightness: Float {
        get {
            return UserDefaults.standard.float(forKey: Keys.brightnessKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.brightnessKey)
        }
    }
    
    static var isFirstLaunch: Bool {
        get {
            return !UserDefaults.standard.bool(forKey: Keys.soundOffKey)
        } set {
            UserDefaults.standard.set(!newValue, forKey: Keys.soundOffKey)
        }
    }
    
}
