//
//  InstructionPresenter.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 07.10.2022.
//

import Foundation


protocol InstructionPresenterProtocol: AnyObject {
    var router: RouterProtocol {get set}
    init(router: RouterProtocol)
    func dismissVC()
}

class InstructionPresenter: InstructionPresenterProtocol {
    var router: RouterProtocol
    
    required init(router: RouterProtocol) {
        self.router = router
    }
    
    
    func dismissVC() {
        self.router.navigationController.popViewController(animated: true)
    }
}
