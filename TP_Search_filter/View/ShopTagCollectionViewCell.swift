//
//  CollectionViewCell.swift
//  TP_Search_filter
//
//  Created by fadielse on 10/09/18.
//  Copyright © 2018 fadielse. All rights reserved.
//

import UIKit

class ShopTagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var shopButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    func configureCell() {
        
    }

    override func layoutSubviews() {
        layoutingSubviews()
    }
}

// MARK: - Layout
extension ShopTagCollectionViewCell {
    func layoutingSubviews() {
        layoutingWrapperView()
        layoutingDeleteButton()
    }
    
    func layoutingWrapperView() {
        wrapperView.layer.borderWidth = 1.0
        wrapperView.layer.borderColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1.0).cgColor
        wrapperView.layer.cornerRadius = wrapperView.frame.height / 2
        wrapperView.clipsToBounds = true
    }
    
    func layoutingDeleteButton() {
        deleteButton.layer.borderWidth = 2.0
        deleteButton.layer.borderColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1.0).cgColor
        deleteButton.layer.cornerRadius = deleteButton.frame.height / 2
        deleteButton.clipsToBounds = true
    }
}
