//
//  FilterShopListTableViewCell.swift
//  TP_Search_filter
//
//  Created by fadielse on 09/09/18.
//  Copyright © 2018 fadielse. All rights reserved.
//

import UIKit

protocol shopListDelegate {
    func applyShopList(shopList: [ShopType])
}

class FilterShopListTableViewCell: UITableViewCell {
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bottomLineLeading: NSLayoutConstraint!
    
    var type: ShopType!
    var rowSelected: Bool = true
    var indexPath: IndexPath!
    var delegate: shopListDelegate?
    
    func configureCell(type: ShopType, rowSelected: Bool, indexpath: IndexPath) {
        self.selectionStyle = .none
        
        self.type = type
        self.rowSelected = rowSelected
        self.indexPath = indexpath
        
        setupSubviews()
    }
    
    override func layoutSubviews() {
        layoutingSubviews()
    }
}

// MARK: - Layout
extension FilterShopListTableViewCell {
    func layoutingSubviews() {
    }
}

// MARK: - Setup
extension FilterShopListTableViewCell {
    func setupSubviews() {
        setupNameLabel()
        setupBottomLine()
        setupCheckImage()
    }
    
    func setupNameLabel() {
        nameLabel.text = type.rawValue
    }
    
    func setupBottomLine() {
        bottomLineLeading.constant = self.indexPath.row == 1 ? 0 : 40
    }
    
    func setupCheckImage() {
        checkImage.image = rowSelected ? #imageLiteral(resourceName: "check_icon") : #imageLiteral(resourceName: "uncheck_icon")
    }
}
