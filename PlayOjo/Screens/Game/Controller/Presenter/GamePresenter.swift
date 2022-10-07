//
//  GamePresenter.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 28.09.2022.
//

import UIKit

protocol GameViewProtocol: AnyObject {
    
}

protocol GamePresenterProtocol: AnyObject {
    init(view: GameViewProtocol, router: RouterProtocol, adManager: AdsManager)
    var adManager: AdsManager {get set}
    func showMenuView() -> UIView
    func goToSettings()
}

class GamePresenter: GamePresenterProtocol {
    weak var view: GameViewProtocol?
    var router: RouterProtocol
    var adManager: AdsManager
    private lazy var overlay: UIView = {
        let overlay = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return overlay
    }()
    required init(view: GameViewProtocol, router: RouterProtocol, adManager: AdsManager) {
        self.view = view
        self.router = router
        self.adManager = adManager
    }
    
    func showMenuView() -> UIView {
        let view = router.builder.resolveMenuView()
        view.center = overlay.center
        view.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        view.shopButton.addTarget(self, action: #selector(shopButtonTapped(_:)), for: .touchUpInside)
        overlay.addSubview(view)
        return overlay
    }
        
    @objc func backButtonTapped(_ sender:UIButton) {
        overlay.removeFromSuperview()
    }
    
    @objc func shopButtonTapped(_ sender:UIButton) {
        router.goToSettings()
    }
    
    func goToSettings() {
        router.goToSettings()
    }
    
}
