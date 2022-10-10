//
//  BrightnessTableViewCell.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 08.10.2022.
//

import UIKit

class BrightnessTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
//            titleLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
//            titleLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
//            titleLabel.layer.shadowRadius = 4
//            titleLabel.layer.shadowOpacity = 1.0
//            titleLabel.layer.bounds = titleLabel.bounds
//            titleLabel.layer.position = titleLabel.center
        }
    }
    @IBOutlet weak var sliderView: UISlider! {
        didSet {
            sliderView.setThumbImage(UIImage(named: "thumbImage")!, for: .normal)
            sliderView.value = UserDefaultsValues.brightness
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func sliderValueChanged(_ sender: Any) {
        UserDefaultsValues.brightness = Float(sliderView.value)
        UIScreen.main.brightness = CGFloat(UserDefaultsValues.brightness)
    }
    
}
