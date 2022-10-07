//
//  ShopPresenter.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 01.10.2022.
//

import UIKit

protocol ShopViewProtocol: AnyObject {
    func reloadData()
    func getSegmentIndex()->Int
    func configureBuyButton(_ model: ShopProtocol)
}

protocol ShopPresenterProtocol: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    init(view: ShopViewProtocol)
    var selectedModel: ShopProtocol? {get set}
    var products: [ProductSub]? {get set}
    func buyProduct(model: TipsShop)
}

class ShopPresenter: NSObject, ShopPresenterProtocol {
    weak var view: ShopViewProtocol?
    var model = ShopModel.allCases
    private var iapManager = IAPManager()
    var products: [ProductSub]?
    var selectedModel: ShopProtocol? {
        didSet {
            if let selectedModel = selectedModel {
                view?.configureBuyButton(selectedModel)
            }
           
        }
    }
    required init(view: ShopViewProtocol) {
        self.view = view
        super.init()
        requestProduct()
    }
    
    
    func requestProduct() {
        iapManager.requestProducts { products in
            self.products = products
//            DispatchQueue.main.async {
//                if self.model[self.currentIndex].purchaseIdentifier != nil {
//                self.configureButtons(model: self.model[self.currentIndex])
//                }
//            }
        }
    }
    
    func buyProduct(model: TipsShop) {
        if let product = products?.first(where: {$0.subsctiption.rawValue == model.purchaseIdenitfier}) {
            iapManager.buyProduct(product.product) { success, productId in
                if success {
                   // self.getBuyProduct(model: model)
                }
            }
        }
    }

}

extension ShopPresenter {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let index = view?.getSegmentIndex() ?? 0
        return model[index].values.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shop cell", for: indexPath) as! ShopCollectionViewCell
        let index = view?.getSegmentIndex() ?? 0
        cell.configure(model: model[index].values[indexPath.row])
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected")
        let index = view?.getSegmentIndex() ?? 0
        let model = model[index].values[indexPath.row]
        self.selectedModel = model
//        if let model = model as? TipsShop {
//            view?.configureBuyButton(text: model.price.description, realMoney: true, watchAd: model.watchAdd)
//        } else {
//            let text = model.price > 0 ? model.price.description : "Get"
//            view?.configureBuyButton(text: text, realMoney: false, watchAd: false)
//        }
    }
    
    func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 151, height: 152)
    }
    
}
