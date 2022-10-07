//
//  ShopModel.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 01.10.2022.
//
import UIKit


enum ShopModel: CaseIterable {
    case bubbles
    case bottle
    case tips
    
    var values: [ShopProtocol] {
        switch self {
        case .bubbles:
            return BubblesShop.allCases
        case .bottle:
            return BottleShop.allCases
        case .tips:
            return TipsShop.allCases
        }
    }
}

protocol ShopProtocol {
    var image: UIImage {get}
    var price: Int {get}
}

enum BubblesShop: CaseIterable, ShopProtocol {
    case bubble1
    case bubble2
    case bubble3
    case bubble4
    
    var image: UIImage {
        //        switch self {
        //        case . {
        return UIImage(named: "bublesImage")!
        // }
    }
    
    var price: Int {
        switch self {
        case .bubble1:
            return 0
        case .bubble2:
            return 50
        case .bubble3:
            return 100
        case .bubble4:
            return 150
        }
    }
}

enum BottleShop: CaseIterable, ShopProtocol {
    case bottle1
    case bottle2
    case bottle3
    case bottle4
    
    var image: UIImage {
       return UIImage(named: "bottleTexture")!
    }
    
    var price: Int {
        switch self {
        case .bottle1:
            return 0
        case .bottle2:
            return 100
        case .bottle3:
            return 200
        case .bottle4:
            return 250
        }
    }
    
}

enum TipsShop: CaseIterable, ShopProtocol {
    case oneTip
    case threeTips
    case tenTips
    
    var image: UIImage {
        return UIImage(named: "lightImage")!
    }
    
    var purchaseIdenitfier: String? {
        switch self {
        case .oneTip:
            return nil
        case .threeTips:
            return "com.tip2.id"
        case .tenTips:
            return "com.tip3.id"
        }
    }
    
    var price: Int {
        switch self {
        case .oneTip:
            return 0
        case .threeTips:
            return 1
        case .tenTips:
            return 5
        }
    }
    
    var watchAdd: Bool {
        switch self {
        case .oneTip:
            return true
        case .threeTips:
            return false
        case .tenTips:
            return false
        }
    }
}
