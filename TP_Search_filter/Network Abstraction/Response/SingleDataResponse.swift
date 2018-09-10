//
//  SingleDataResponse.swift
//  Real Weather
//
//  Created by FADIELSE on 07.08.18.
//  Copyright © 2018 Fadielse. All rights reserved.
//

protocol ResponseDataConvertible {
    init?(rawData: Any)
}

struct SingleDataResponse<T: ResponseDataConvertible>: Response {
    let data: T?
    
    init?(json: Any) {
        guard
            let json = json as? [String: Any]
            else {
                return nil
        }
        
        if let rawData = json["data"] as? [[String: Any]] {
            self.data = T(rawData: rawData)
        } else {
            self.data = nil
        }
    }
}
