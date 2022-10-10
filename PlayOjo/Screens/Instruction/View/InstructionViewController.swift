//
//  InstructionViewController.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 07.10.2022.
//

import UIKit
import SpriteKit

class InstructionViewController: BaseViewController<InstructionPresenterProtocol> {
    @IBOutlet weak var howToPlay1: UILabel! {
        didSet {
            configureShadow(label: howToPlay1)
        }
    }
    @IBOutlet weak var howToplay2: UILabel! {
        didSet {
            configureShadow(label: howToplay2)
        }
    }
    @IBOutlet weak var howToPlay3: UILabel! {
    didSet {
        configureShadow(label: howToPlay3)
    }
}
    
    @IBOutlet weak var mainText1: UILabel! {
        didSet {
            configureShadow(label: mainText1)
        }
    }
    @IBOutlet weak var mainText2: UILabel! {
        didSet {
            configureShadow(label: mainText2)
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainText3: UILabel! {
        didSet {
            configureShadow(label: mainText3)
        }
    }
    
    private var index:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomBackButton()
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "StartScene") as? StartScene {
                scene.scaleMode = .aspectFill
                scene.parentVC = self
                view.presentScene(scene)
                
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
        let frame = view.frame
        widthConstraint.constant =  frame.width
    }
    
    private func scrollToIndex(index: Int) {
        scrollView.scrollRectToVisible(CGRect(x: CGFloat(index) * widthConstraint.constant,
                                              y: 0,
                                              width: view.frame.width,
                                              height: view.frame.height), animated: true)
    }
    
    
    func configureShadow(label: UILabel) {
        label.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.layer.shadowRadius = 4
        label.layer.shadowOpacity = 1.0
        label.layer.bounds = label.bounds
        label.layer.position = label.center
    }

    @IBAction func prevButtonPressed(_ sender: Any) {
        guard index > 0 else { return }
        index -= 1
        scrollToIndex(index: index-1)
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        if index < 3 {
            scrollToIndex(index: index)
            index += 1
        } else {
            presenter.dismissVC()
            
        }
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
