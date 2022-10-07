//
//  ShopCollectionViewCell.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 01.10.2022.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var selectedButton: UIButton! {
        didSet {
            selectedButton.isHidden = true
        }
    }
    
    override var isSelected: Bool {
            didSet {
                self.layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.clear.cgColor
                self.layer.borderWidth = 1.0
                selectedButton.isHidden = !isSelected
            }
          }
    
    func configure(model: ShopProtocol) {
        itemImage.image = model.image
    }
    
}
