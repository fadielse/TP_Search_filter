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
    
    var pmin: String = "100"
    var pmax: String = "8000000"
    var wholeSale: Bool = true
    var official: Bool = true
    var fshop: String = "2"
    
    var delegate: FilterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
}

// MARK: - Setup
extension FilterViewController {
    func setupSubviews() {
        setupTableView()
        setupCloseButton()
        setupApplyButton()
        setupResetButton()
    }
    
    func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    func setupResetButton() {
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
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
    
    @objc func resetButtonTapped() {
        pmin = "100"
        pmax = "8000000"
        wholeSale = false
        official = true
        fshop = "2"
        
        tableView.reloadData()
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
                cell.delegate = self
                
                return cell
            } else {
                return FilterPriceTableViewCell()
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "shopTypeCell", for: indexPath) as? FilterShopTableViewCell {
                cell.configureCell(official: official, fshop: fshop)
                cell.delegate = self
                
                return cell
            } else {
                return FilterShopTableViewCell()
            }
        default:
            return FilterShopTableViewCell()
        }
    }
}

// MARK: - FilterPrice Delegate
extension FilterViewController: FilterPriceDelegate {
    func priceCellValueChanged(pmin: String, pmax: String, wholeSale: Bool) {
        self.pmin = pmin
        self.pmax = pmax
        self.wholeSale = wholeSale
    }
}

// MARK: - FilterShop Delegate
extension FilterViewController: FilterShopDelegate {
    func shopSelected(shopList: [ShopType]) {
        self.official = shopList.contains(.officialStore) ? true : false
        self.fshop = shopList.contains(.goldMerchant) ? "2" : "1"
    }
    
    func openShopList() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "shopListVC") as! ShopTypeViewController
        vc.delegate = self
        vc.fshop = fshop
        vc.official = official
        
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - FilterShop Delegate
extension FilterViewController: ShopTypeDelegate {
    func finishSelectShop(selectedShop: [ShopType]) {
        self.official = selectedShop.contains(.officialStore)
        self.fshop = selectedShop.contains(.goldMerchant) ? "2" : "1"
        
        tableView.reloadData()
    }
}
