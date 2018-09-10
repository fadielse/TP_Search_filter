//
//  ProductViewController.swift
//  TP_Search_filter
//
//  Created by fadielse on 09/09/18.
//  Copyright © 2018 fadielse. All rights reserved.
//

import UIKit
import KRPullLoader

final class ProductViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterButton: UIButton!
    
    var q = "Samsung"
    var pmin = "100"
    var pmax = "8000000"
    var wholeSale = false
    var official = true
    var fshop = "2"
    var start = "0"
    var rows = "10"
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search"

        setupSubviews()
        getProducts(isLoadMore: false, usingCompletionHandler: {})
    }
}

// MARK: - Layout
extension ProductViewController {
    
}

// MARK: - Setup
extension ProductViewController {
    func setupSubviews() {
        setupFilterButton()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        collectionView.addPullLoadableView(refreshView, type: .refresh)
        
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        collectionView.addPullLoadableView(loadMoreView, type: .loadMore)
    }
    
    func setupFilterButton() {
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Action
extension ProductViewController {
    @objc func filterButtonTapped() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "filterVC") as! FilterViewController
        vc.delegate = self
        
        vc.pmin = pmin
        vc.pmax = pmax
        vc.wholeSale = wholeSale
        vc.official = official
        vc.fshop = fshop
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func getProducts(isLoadMore: Bool, usingCompletionHandler completionHandler: @escaping () -> Void) {
        ProductRequest(q: q,
                       pmin: pmin,
                       pmax: pmax,
                       wholesale: wholeSale,
                       official: official,
                       fshop: fshop,
                       start: start,
                       rows: rows).send { result in
                        
            completionHandler()
                        
            switch result {
            case .success(let response):
                
                if !isLoadMore {
                    self.products.removeAll()
                }
                
                for product in (response.data?.list)! {
                    self.products.append(product)
                }

                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - CollectionView Delegate
extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width / 2) - 6, height: (250 / 180) * (self.view.frame.width / 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 5, 10, 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCollectionViewCell {
            cell.configureCell(withData: products[indexPath.row])
            
            return cell
        } else {
            return ProductCollectionViewCell()
        }
    }
}

// MARK: - KRPullLoadView delegate
extension ProductViewController: KRPullLoadViewDelegate {
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
            switch state {
            case let .loading(completionHandler):
                start = "\(Int(start)! + 10)"
                
                self.getProducts(isLoadMore: true, usingCompletionHandler: {
                    completionHandler()
                })
                
            default: break
            }
            return
        }
        
        switch state {
        case .none:
            pullLoadView.messageLabel.text = ""
            
        case let .pulling(offset, threshould):
            if offset.y > threshould {
                pullLoadView.messageLabel.text = "..."
            } else {
                pullLoadView.messageLabel.text = "Release to refresh"
            }
            
        case let .loading(completionHandler):
            pullLoadView.messageLabel.text = "Updating..."
            self.getProducts(isLoadMore: false, usingCompletionHandler: {
                completionHandler()
            })
        }
    }
}

// MARK: - FilterViewController Delegate
extension ProductViewController: FilterViewControllerDelegate {
    func applyFilter(pmin: String, pmax: String, wholeSale: Bool, official: Bool, fshop: String) {
        self.pmin = pmin
        self.pmax = pmax
        self.wholeSale = wholeSale
        self.official = official
        self.fshop = fshop
        
        getProducts(isLoadMore: false, usingCompletionHandler: {})
    }
}
