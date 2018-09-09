//
//  FilterPriceTableViewCell.swift
//  TP_Search_filter
//
//  Created by fadielse on 09/09/18.
//  Copyright © 2018 fadielse. All rights reserved.
//

import UIKit
import WARangeSlider

class FilterPriceTableViewCell: UITableViewCell {
    @IBOutlet weak var minPriceLabel: UILabel!
    @IBOutlet weak var maxPriceLabel: UILabel!
    @IBOutlet weak var wholeSaleSwitch: UISwitch!
    
    func configureCell() {
        self.selectionStyle = .none
    }
    
}
