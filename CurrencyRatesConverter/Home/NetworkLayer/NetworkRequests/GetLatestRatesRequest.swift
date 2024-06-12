//
//  GetLatestRatesRequest.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation
struct GetLatestRatesRequest: ApiRequest {
    var queryParameters: [String : String]?
    
    typealias ResponseType = ExchangeRatesResponse
    
    var url: URL {
        return URL(string: "\(API.baseURL_OpenExchange)\(EndPoints.getLatest)")!
    }
    
    var method: String {
        return "GET"
    }
}
