//
//  StartViewController.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 28.09.2022.
//

import UIKit
import SpriteKit

enum ControllerType {
    case start
    case settings
}

class StartViewController: BaseViewController<StartPresenterProtocol>, StartViewProtocol {
    var type: ControllerType = .start
    var router: RouterProtocol!
   
    @IBOutlet weak var settingsTableView: UITableView! {
        didSet {
           
            settingsTableView.delegate = presenter
            settingsTableView.dataSource = presenter
        }
    }
    @IBOutlet weak var instructionButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = nil
        
        setCustomBackButton()
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "StartScene") as? StartScene {
                scene.scaleMode = .aspectFill
                scene.parentVC = self
                view.presentScene(scene)
                
            }
//            view.ignoresSiblingOrder = true
//            view.showsFPS = true
//            view.showsNodeCount = true
        }
        
        for font in UIFont.familyNames {
            print(font)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        settingsTableView.isHidden = !(type == .settings)
        self.navigationController?.setNavigationBarHidden(type == .start, animated: false)
        instructionButton.isHidden = !(type == .start)
        settingsButton.isHidden = !(type == .start)
        if let view = self.view as? StartScene {
            view.setText()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
    
    func reloadData() {
        settingsTableView.reloadData()
    }
    
    func playSound() {
        if let view = self.view as! SKView? {
            guard let scene = view.scene as? StartScene else {return}
            scene.playSound()
        }
    }
    
    func goToSettings() {
        router.goToSettings()
    }
    
    @IBAction func instructionButtonPressed(_ sender: Any) {
        goToInstruction()
    }
    @IBAction func settingsButtonPressed(_ sender: Any) {
        goToSettings()
    }
    
    func goToGameVC() {
        router.goToGame()
    }
    
    func goToInstruction() {
        router.goToInstruction()
    }
}


