//
//  ValidateIBANRequest.swift
//  CurrencyRatesConverter
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation
struct ValidateIBANRequest: ApiRequest {
    var queryParameters: [String : String]?
    
    typealias ResponseType = ValidateIBANResponse
    
    var url: URL {
        return URL(string: "\(API.baseURL_ApiLayer)\(EndPoints.validateIban)")!
    }
    
    var method: String {
        return "GET"
    }
    
    var headers: [String : String]? {
        return ["apikey": AppConstants.appID_ApiLayer]
    }
}
