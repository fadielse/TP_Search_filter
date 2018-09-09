//
//  FilterShopTableViewCell.swift
//  TP_Search_filter
//
//  Created by fadielse on 09/09/18.
//  Copyright © 2018 fadielse. All rights reserved.
//

import UIKit

class FilterShopTableViewCell: UITableViewCell {
    @IBOutlet weak var shopSelectButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func configureCell() {
        self.selectionStyle = .none
        
        setupSubviews()
    }
}

// MARK: - Setup
extension FilterShopTableViewCell {
    func setupSubviews() {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "ShopTagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "shopTagCell")
    }
}

// MARK: - CollectionView Delegate
extension FilterShopTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shopTagCell", for: indexPath) as? ShopTagCollectionViewCell {
            return cell
        } else {
            return ShopTagCollectionViewCell()
        }
    }
}
