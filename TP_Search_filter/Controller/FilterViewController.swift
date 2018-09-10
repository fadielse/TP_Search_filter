//
//  FilterViewController.swift
//  TP_Search_filter
//
//  Created by fadielse on 09/09/18.
//  Copyright © 2018 fadielse. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate {
    func applyFilter(pmin: String, pmax: String, wholeSale: Bool, official: Bool, fshop: String)
}

final class FilterViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    
    var pmin = "100"
    var pmax = "8000000"
    var wholeSale = false
    var official = true
    var fshop = "2"
    
    var delegate: FilterViewControllerDelegate?
    
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
        setupCloseButton()
        setupApplyButton()
    }
    
    func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.bounces = false
        
        tableView.register(UINib(nibName: "FilterPriceTableViewCell", bundle: nil), forCellReuseIdentifier: "priceCell")
        tableView.register(UINib(nibName: "FilterShopTableViewCell", bundle: nil), forCellReuseIdentifier: "shopTypeCell")
    }
    
    func setupApplyButton() {
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Action
extension FilterViewController {
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func applyButtonTapped() {
        self.delegate?.applyFilter(pmin: pmin, pmax: pmax, wholeSale: wholeSale, official: official, fshop: fshop)
        closeButtonTapped()
    }
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
                cell.configureCell(pmin: pmin, pmax: pmax, wholeSale: wholeSale)
                
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
