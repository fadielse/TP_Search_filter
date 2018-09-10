//
//  CollectionViewCell.swift
//  TP_Search_filter
//
//  Created by fadielse on 10/09/18.
//  Copyright © 2018 fadielse. All rights reserved.
//

import UIKit

protocol ShopTagDelegate {
    func deleteShop(type: ShopType)
}

class ShopTagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var type: ShopType!
    var delegate: ShopTagDelegate?

    func configureCell(type: ShopType) {
        self.type = type
        
        setupSubviews()
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

// MARK: - Setup
extension ShopTagCollectionViewCell {
    func setupSubviews() {
        setupShopButton()
        setupDeleteButton()
    }
    
    func setupShopButton() {
        nameLabel.text = type.rawValue
    }
    
    func setupDeleteButton() {
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Action
extension ShopTagCollectionViewCell {
    @objc func deleteButtonTapped() {
        self.delegate?.deleteShop(type: self.type)
    }
}
