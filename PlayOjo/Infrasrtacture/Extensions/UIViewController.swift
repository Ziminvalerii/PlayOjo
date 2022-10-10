//
//  UIViewController.swift
//  BitFair
//
//  Created by Tanya Koldunova on 13.09.2022.
//

import UIKit

extension UIViewController {

    static func instantiateMyViewController(name: ViewControllerKeys) -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name.rawValue) as! Self
        return vc
    }
    
    func setCustomBackButton() {
       // self.navigationController?.navigationBar.backItem = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "backButtonTexture")))
      //  self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "backButtonTexture")))
    }
    
}

enum ViewControllerKeys: String {
    case game = "Game"
    case start = "Start"
    case subscription = "subscription"
    case shop = "Shop"
    case instruction = "Instruction"
}

class NavigationController: UINavigationController {
    override var shouldAutorotate: Bool {
        return true// topViewController?.shouldAutorotate ?? super.shouldAutorotate
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
