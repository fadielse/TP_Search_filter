//
//  Products.swift
//  TP_Search_filter
//
//  Created by fadielse on 10/09/18.
//  Copyright © 2018 fadielse. All rights reserved.
//

import Foundation

final class Products: NSObject {
    var list: [Product] = []
    
    init?(dictionary: [[String: Any]]) {
        for product in dictionary {
            if let data = Product(dictionary: product) {
                list.append(data)
            } else {
                return nil
            }
        }
    }
}

extension Products: ResponseDataConvertible {
    convenience init?(rawData: Any) {
        if let dictionary = rawData as? [[String: Any]] {
            self.init(dictionary: dictionary)
        } else {
            return nil
        }
    }
}
