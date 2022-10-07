//
//  Router.swift
//  BitFair
//
//  Created by Tanya Koldunova on 14.09.2022.
//

import UIKit


protocol RouterProtocol {
    var navigationController: UINavigationController {get set}
    var builder: BuilderProtocol {get set}
    func start()
    func goToGame()
    func goToSettings()
    func goToInstruction()
}


class Router: RouterProtocol {
    var navigationController: UINavigationController
    
    var builder: BuilderProtocol
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func start() {
        let vc = builder.resolveStartViewController(router: self)
        navigationController.viewControllers = [vc]
    }
    
    func goToGame() {
        let vc = builder.resolveGameViewController(router: self)
        let navVC = NavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        navigationController.present(navVC, animated: true)
        self.navigationController = navVC
    }
    
    func goToInstruction() {
        let vc = builder.resolveInstructionScreen(router: self)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func goToSettings() {
        let viewController = builder.resolveSettingsViewController(router: self)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    
}
