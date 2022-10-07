//
//  MenuView.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 30.09.2022.
//

import UIKit

class MenuView: UIView {
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = .white
            containerView.layer.cornerRadius = 10.0
            containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            containerView.layer.shadowOpacity = 1
            containerView.layer.shadowRadius = 4.0
            containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
            containerView.clipsToBounds = true
        }
    }
    @IBOutlet weak var soundButton: UIButton! {
        didSet {
            soundButton.setImage(UserDefaultsValues.musicOff ? UIImage(named: "soundOffImage") : UIImage(named: "soundOnImage"), for: .normal)
        }
    }
    @IBOutlet weak var shopButton: UIButton!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.layer.cornerRadius = 10.0
            backButton.layer.borderColor = UIColor.white.cgColor
            backButton.layer.borderWidth = 3.0
        }
    }
    
    convenience init() {
        let size = CGSize(width: 220, height: 248)
        self.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        guard let view = loadFromNib(nib: MenuView.self) else {return}
        view.frame = self.frame
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        addSubview(view)
    }
    
    @IBAction func soundButtonPressed(_ sender: Any) {
        UserDefaultsValues.musicOff = !UserDefaultsValues.soundOff
        soundButton.setImage(UserDefaultsValues.musicOff ? UIImage(named: "soundOffImage") : UIImage(named: "soundOnImage"), for: .normal)
        if UserDefaultsValues.musicOff {
            stopPlaying()
        } else {
            playBackgroundMusic()
        }
    }
}
