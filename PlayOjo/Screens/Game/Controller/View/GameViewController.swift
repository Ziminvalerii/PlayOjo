//
//  GameViewController.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 28.09.2022.
//

import UIKit
import SpriteKit
import GameplayKit
import Lottie

class GameViewController: BaseViewController<GamePresenterProtocol>, GameViewProtocol {
    
    lazy var confettieView = AnimationView(name: "confetti")
    lazy var winView = AnimationView(name: "win")

    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomBackButton()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.parentVC =  self
                view.presentScene(scene)
            }
            self.navigationController?.navigationBar.isHidden = true
            view.ignoresSiblingOrder = true
//            view.showsFPS = true
//            view.showsNodeCount = true
//            view.showsPhysics = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let view = self.view as! SKView? {
            view.scene?.isPaused = false
        }
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func showMenuView() {
        presenter.goToSettings()
    }
    
    func getVC()->UIViewController {
        return self
    }
    
    func showConfetti(position: CGPoint) {
        confettieView.frame = CGRect(origin: position, size: CGSize(width: 400, height: 400))
        confettieView.center = position
        confettieView.loopMode = .playOnce
        confettieView.animationSpeed = 0.5
        self.view.addSubview(confettieView)
       // confettieView.play()
        confettieView.play()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.confettieView.removeFromSuperview()
        })
    }
    
    func showWinAnimation() {
        winView.frame = self.view.bounds//CGRect(origin: CGPoint.zero, size: UI>)
        winView.center = self.view.center
        winView.loopMode = .playOnce
        self.view.addSubview(winView)
        winView.animationSpeed = 1.4
        winView.play()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.4, execute: {
            self.winView.removeFromSuperview()
        })
    }
    
    func showRewardedAd(completion: @escaping()->Void) {
        stopPlaying()
        presenter.adManager.showRewardedAds(at: self) { reward in
            if reward != nil {
                completion()
                playBackgroundMusic()
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
   
}
