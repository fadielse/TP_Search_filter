//
//  ShopTypeViewController.swift
//  TP_Search_filter
//
//  Created by fadielse on 09/09/18.
//  Copyright © 2018 fadielse. All rights reserved.
//

import UIKit

protocol ShopTypeDelegate {
    func finishSelectShop(selectedShop: [ShopType])
}

final class ShopTypeViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    
    var fshop: String = "2"
    var official: Bool = true
    var delegate: ShopTypeDelegate?
    var shopList: [ShopType] = [.goldMerchant, .officialStore]
    var selectedShop: [ShopType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
}

// MARK: - Layout
extension ShopTypeViewController {
    
}

// MARK: - Setup
extension ShopTypeViewController {
    func setupSubviews() {
        setupSelectedShop()
        setupCloseButton()
        setupTableView()
        setupResetButton()
        setupApplyButton()
    }
    
    func setupSelectedShop() {
        selectedShop.removeAll()
        
        if self.fshop == "2" {
            selectedShop.append(.goldMerchant)
        }
        
        if self.official {
            selectedShop.append(.officialStore)
        }
    }
    
    func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FilterShopListTableViewCell", bundle: nil), forCellReuseIdentifier: "shopListCell")
    }
    
    func setupResetButton() {
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    func setupApplyButton() {
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Action
extension ShopTypeViewController {
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func removeShopList(type: ShopType) {
        selectedShop.remove(at: selectedShop.index(of: type)!)
    }
    
    func addShopList(type: ShopType) {
        selectedShop.append(type)
    }
    
    @objc func resetButtonTapped() {
        selectedShop.removeAll()
        selectedShop = [.goldMerchant, .officialStore]
        
        tableView.reloadData()
    }
    
    @objc func applyButtonTapped() {
        self.delegate?.finishSelectShop(selectedShop: selectedShop)
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableView Delegate
extension ShopTypeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "shopListCell", for: indexPath) as? FilterShopListTableViewCell {
            cell.configureCell(type: shopList[indexPath.row], rowSelected: selectedShop.contains(shopList[indexPath.row]), indexpath: indexPath)
            
            return cell
        } else {
            return FilterShopTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedShop.contains(shopList[indexPath.row]) {
            removeShopList(type: shopList[indexPath.row])
        } else {
            addShopList(type: shopList[indexPath.row])
        }
        
        tableView.reloadData()
    }
}
