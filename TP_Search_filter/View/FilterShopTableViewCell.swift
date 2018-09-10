//
//  FilterShopTableViewCell.swift
//  TP_Search_filter
//
//  Created by fadielse on 09/09/18.
//  Copyright © 2018 fadielse. All rights reserved.
//

import UIKit

protocol FilterShopDelegate {
    func shopSelected(shopList: [ShopType])
    func openShopList()
}

enum ShopType: String {
    case goldMerchant = "Gold Merchant"
    case officialStore = "Official Store"
}

class FilterShopTableViewCell: UITableViewCell {
    @IBOutlet weak var shopSelectButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var official: Bool = true
    var fshop: String = "2"
    var delegate: FilterShopDelegate?
    
    var shopList: [ShopType] = []
    
    var rowCount: Int = 0
    
    func configureCell(official: Bool, fshop: String) {
        self.selectionStyle = .none
        
        self.official = official
        self.fshop = fshop
        
        shopList.removeAll()
        
        if self.fshop == "2" {
            shopList.append(.goldMerchant)
        }
        
        if self.official {
            shopList.append(.officialStore)
        }
        
        setupSubviews()
    }
}

// MARK: - Setup
extension FilterShopTableViewCell {
    func setupSubviews() {
        setupShopSelectButton()
        setupCollectionView()
    }
    
    func setupShopSelectButton() {
        shopSelectButton.addTarget(self, action: #selector(shopSelectButtonTapped), for: .touchUpInside)
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "ShopTagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "shopTagCell")
        collectionView.reloadData()
    }
}

// MARK: - Action
extension FilterShopTableViewCell {
    @objc func shopSelectButtonTapped() {
        self.delegate?.openShopList()
    }
}

// MARK: - CollectionView Delegate
extension FilterShopTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shopTagCell", for: indexPath) as? ShopTagCollectionViewCell {
            cell.configureCell(type: shopList[indexPath.row])
            cell.delegate = self
            
            return cell
        } else {
            return ShopTagCollectionViewCell()
        }
    }
}

// MARK: - Shop Tag Delegate
extension FilterShopTableViewCell: ShopTagDelegate {
    func deleteShop(type: ShopType) {
        shopList.remove(at: shopList.index(of: type)!)
        collectionView.reloadData()
        
        self.delegate?.shopSelected(shopList: shopList)
    }
}
