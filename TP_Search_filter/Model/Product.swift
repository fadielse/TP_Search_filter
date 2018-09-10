//
//  Product.swift
//  TP_Search_filter
//
//  Created by fadielse on 10/09/18.
//  Copyright © 2018 fadielse. All rights reserved.
//

import Foundation

struct wholeSalePrice {
    let countMin: Int
    let countMax: Int
    let price: String
}

final class Product: NSObject {
    let name: String
    let imageUri: String
    let price: String
    var wholeSale: [wholeSalePrice] = []
    
    init?(dictionary: [String: Any]) {
        if let tmpName = dictionary["name"] as? String {
            name = tmpName
        } else {
            return nil
        }
        
        if let tmpImageUri = dictionary["image_uri"] as? String {
            imageUri = tmpImageUri
        } else {
            return nil
        }
        
        if let tmpPrice = dictionary["price"] as? String {
            price = tmpPrice
        } else {
            return nil
        }
        
        if let tmpWholeSalePrices = dictionary["wholesale_price"] as? [[String: Any]] {
            for tmpWholeSalePrice in tmpWholeSalePrices {
                var tmpCountMin: Int
                var tmpCountMax: Int
                var tmpPrice: String
                
                if let countMin = tmpWholeSalePrice["count_min"] as? Int {
                    tmpCountMin = countMin
                } else {
                    return nil
                }
                
                if let countMax = tmpWholeSalePrice["count_max"] as? Int {
                    tmpCountMax = countMax
                } else {
                    return nil
                }
                
                if let price = tmpWholeSalePrice["price"] as? String {
                    tmpPrice = price
                } else {
                    return nil
                }
                
                wholeSale.append(wholeSalePrice(countMin: tmpCountMin, countMax: tmpCountMax, price: tmpPrice))
            }
        }
    }
}

extension Product: ResponseDataConvertible {
    convenience init?(rawData: Any) {
        if let dictionary = rawData as? [String: Any] {
            self.init(dictionary: dictionary)
        } else {
            return nil
        }
    }
}
