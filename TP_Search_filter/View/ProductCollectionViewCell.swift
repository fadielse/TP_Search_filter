//
//  ProductCollectionViewCell.swift
//  TP_Search_filter
//
//  Created by fadielse on 10/09/18.
//  Copyright © 2018 fadielse. All rights reserved.
//

import UIKit
import SDWebImage

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var product: Product!
    
    func configureCell(withData data: Product) {
        self.product = data
        
        setupSubviews()
    }
}

// MARK: - Setup
extension ProductCollectionViewCell {
    func setupSubviews() {
        setupProductImage()
        setupNameLabel()
        setupPriceLabel()
    }
    
    func setupProductImage() {
        productImage.sd_setImage(with: URL(string: product.imageUri), placeholderImage: #imageLiteral(resourceName: "placeholder"), options: .allowInvalidSSLCertificates, completed: nil)
    }
    
    func setupNameLabel() {
        nameLabel.text = product.name
    }
    
    func setupPriceLabel() {
        priceLabel.text = product.price
    }
}
