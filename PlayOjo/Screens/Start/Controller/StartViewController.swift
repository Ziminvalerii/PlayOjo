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
    //case instruction
    case settings
}

class StartViewController: UIViewController {
    var type: ControllerType = .start
    var router: RouterProtocol!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var sliderView: UISlider! {
        didSet {
            sliderView.setThumbImage(UIImage(named: "thumbImage")!, for: .normal)
            sliderView.value = UserDefaultsValues.brightness
        }
    }
    @IBOutlet weak var brightnessLabel: UILabel! {
        didSet {
            brightnessLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
            brightnessLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
            brightnessLabel.layer.shadowRadius = 4
            brightnessLabel.layer.shadowOpacity = 1.0
            brightnessLabel.layer.bounds = brightnessLabel.bounds
            brightnessLabel.layer.position = brightnessLabel.center
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        settingsView.isHidden = type == .settings ? false : true
        
        for font in UIFont.familyNames {
            print(font)
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
    @IBAction func soundOnButton(_ sender: Any) {
        UserDefaultsValues.soundOff = false
        if let view = self.view as! SKView? {
            guard let scene = view.scene as? StartScene else {return}
            scene.playSound()
        }
    }
    @IBAction func soundOffButtonPressed(_ sender: Any) {
        UserDefaultsValues.soundOff = true
        
    }
    @IBAction func musicButtonPressed(_ sender: Any) {
        
        UserDefaultsValues.musicOff = false
        if !UserDefaultsValues.musicOff {
            playBackgroundMusic()
        }
    }
    @IBAction func musicOffButtonPressed(_ sender: Any) {
        UserDefaultsValues.musicOff = true
        if UserDefaultsValues.musicOff {
            stopPlaying()
        }
    }
    @IBAction func vibrationOnButtonPressed(_ sender: Any) {
        UserDefaultsValues.vibrationOff = false
        playVibration()
    }
    @IBAction func vibrationOffButtonPressed(_ sender: Any) {
        UserDefaultsValues.vibrationOff = true
    }
    @IBAction func sliderValueChanged(_ sender: Any) {
        UserDefaultsValues.brightness = Float(sliderView.value)
        UIScreen.main.brightness = CGFloat(UserDefaultsValues.brightness)
    }
    
    func goToGameVC() {
        router.goToGame()
    }
    
    func goToInstruction() {
        router.goToInstruction()
    }
}

