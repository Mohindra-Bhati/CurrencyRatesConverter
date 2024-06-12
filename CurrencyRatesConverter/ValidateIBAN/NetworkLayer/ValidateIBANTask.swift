//
//  ValidateIBANTask.swift
//  CurrencyRatesConverter
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation
protocol ValidateIBANTaskProtocol {
    var serviceProvider: ValidateIBANServiceProviderProtocol? { get }
    init(serviceProvider: ValidateIBANServiceProviderProtocol?)
    func execute(params: [String : String]?, completion: @escaping (_ response: ValidateIBANResponse?, _ error:Error?) -> Void)
}

final class ValidateIBANTask: ValidateIBANTaskProtocol {
    let serviceProvider: ValidateIBANServiceProviderProtocol?
    
    init(serviceProvider: ValidateIBANServiceProviderProtocol? = ValidateIBANServiceManager()) {
        self.serviceProvider = serviceProvider
    }
    
    func execute(params: [String : String]?, completion: @escaping (_ response: ValidateIBANResponse?, _ error:Error?) -> Void) {
        serviceProvider?.performRequest(params: params, completion: completion)
    }
}
