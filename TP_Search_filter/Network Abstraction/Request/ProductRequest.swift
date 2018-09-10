//
//  WeatherDetailRequest.swift
//  Real Weather
//
//  Created by FADIELSE on 07.08.18.
//  Copyright © 2018 Fadielse. All rights reserved.
//

import Foundation

struct ProductRequest {
    let q: String
    let pmin: String
    let pmax: String
    let wholesale: Bool
    let official: Bool
    let fshop: String
    let start: String
    let rows: String
}

extension ProductRequest: Request {
    var baseURL: URL {
        return URL(fileURLWithPath: kAPIURL)
    }
    
    var path: String {
        return "/search/v2.5/product"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        return [
            "q": q,
            "pmin": pmin,
            "pmax": pmax,
            "wholesale": wholesale,
            "official": official,
            "fshop": fshop,
            "start": start,
            "rows":rows
        ]
    }
    
    typealias ResponseType = SingleDataResponse<Products>
}
