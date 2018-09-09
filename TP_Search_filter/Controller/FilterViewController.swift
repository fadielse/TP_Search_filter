//
//  FilterViewController.swift
//  TP_Search_filter
//
//  Created by fadielse on 09/09/18.
//  Copyright © 2018 fadielse. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
}

// MARK: - Layout
extension FilterViewController {
    
}

// MARK: - Setup
extension FilterViewController {
    func setupSubviews() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        tableView.register(UINib(nibName: "FilterPriceTableViewCell", bundle: nil), forCellReuseIdentifier: "priceCell")
        tableView.register(UINib(nibName: "FilterShopTableViewCell", bundle: nil), forCellReuseIdentifier: "shopTypeCell")
    }
}

// MARK: - Action
extension FilterViewController {
    
}

// MARK: - TableView Delegate
extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath) as? FilterPriceTableViewCell {
                cell.configureCell()
                
                return cell
            } else {
                return FilterPriceTableViewCell()
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "shopTypeCell", for: indexPath) as? FilterShopTableViewCell {
                cell.configureCell()
                
                return cell
            } else {
                return FilterShopTableViewCell()
            }
        default:
            return FilterShopTableViewCell()
        }
    }
}
