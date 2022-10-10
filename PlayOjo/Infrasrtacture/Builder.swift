//
//  Builder.swift
//  BitFair
//
//  Created by Tanya Koldunova on 14.09.2022.
//

import Foundation

protocol BuilderProtocol {
    func resolveGameViewController(router: RouterProtocol) -> GameViewController
    func resolveStartViewController(router: RouterProtocol) -> StartViewController
    func resolveMenuView()->MenuView
    func resolveSettingsViewController(router: RouterProtocol) -> StartViewController
    func resolveInstructionScreen(router: RouterProtocol) -> InstructionViewController
}

class Builder: BuilderProtocol {
    
    func resolveGameViewController(router: RouterProtocol) -> GameViewController {
        let vc = GameViewController.instantiateMyViewController(name: .game)
        vc.presenter = GamePresenter(view: vc, router: router, adManager: AdsManager())
        return vc
    }
    
    func resolveStartViewController(router: RouterProtocol) -> StartViewController {
        let vc = StartViewController.instantiateMyViewController(name: .start)
        vc.presenter = StartPresenter(view: vc)
        vc.router = router
        return vc
    }
    
    func resolveInstructionScreen(router: RouterProtocol) -> InstructionViewController {
        let vc = InstructionViewController.instantiateMyViewController(name: .instruction)
        vc.presenter = InstructionPresenter(router: router)
        return vc
    }
    
    func resolveSettingsViewController(router: RouterProtocol) -> StartViewController {
        let vc = StartViewController.instantiateMyViewController(name: .start)
        vc.presenter = StartPresenter(view: vc)
        vc.type = .settings
        vc.router = router
        return vc
    }
    
    func resolveMenuView()->MenuView {
        let view = MenuView()
        return view
    }

}
