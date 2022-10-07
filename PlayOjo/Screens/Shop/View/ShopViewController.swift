//
//  ShopViewController.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 01.10.2022.
//

import UIKit

class ShopViewController: BaseViewController<ShopPresenterProtocol>, ShopViewProtocol {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var shopCollectionView: UICollectionView! {
        didSet {
            shopCollectionView.delegate = presenter
            shopCollectionView.dataSource = presenter
        }
    }
    @IBOutlet weak var buyButton: UIButton! {
        didSet {
            buyButton.layer.cornerRadius = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.shopCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        self.shopCollectionView.delegate?.collectionView!(self.shopCollectionView, didSelectItemAt:  IndexPath(row: 0, section: 0))//collectionView(self.shopCollectionView, didSelectRowAt: IndexPath(row: 0, section: 0))

    }
    @IBAction func segmentChangeValue(_ sender: Any) {
        reloadData()
    }
    
    func reloadData() {
        shopCollectionView.reloadData()
    }
    
    func getSegmentIndex()->Int {
        return segmentControl.selectedSegmentIndex
    }
    
    func configureBuyButton(_ model: ShopProtocol) {
        buyButton.isHidden = false
        let text = model.price > 0 ? model.price.description : "Get"
        if text == "Get" {
            buyButton.backgroundColor = .gray
            buyButton.setTitleColor(.black, for: .normal)
            buyButton.setImage(UIImage(), for: .normal)
        } else {
            buyButton.backgroundColor = .orange
            buyButton.setTitleColor(.white, for: .normal)
            buyButton.setImage(UIImage(named: "coins"), for: .normal)
        }
        buyButton.setTitle(text, for: .normal)
        if let model = model as? TipsShop {
            buyButton.setImage(UIImage(), for: .normal)
            if model.watchAdd {
                buyButton.setTitle("Watch add", for: .normal)
            } else if model.purchaseIdenitfier != nil {
                if let product = presenter.products?.first(where: {$0.subsctiption.rawValue == model.purchaseIdenitfier!}) {
                    buyButton.setTitle("Buy for \(product.price!)", for: .normal)
                } else {
                    buyButton.isHidden = true
                }
            }
           
        }
//        if realMoney || watchAd {
//
//            return
//        }
    }
  
    @IBAction func buyButtonPressed(_ sender: Any) {
        if let selectedModel = presenter.selectedModel as? TipsShop {
            presenter.buyProduct(model: selectedModel)
        } else {
            guard let selectedModel = presenter.selectedModel else {return}
            if UserDefaultsValues.coinsCount > selectedModel.price {
                UserDefaultsValues.coinsCount -= selectedModel.price
            }
        }
    }
    

}
