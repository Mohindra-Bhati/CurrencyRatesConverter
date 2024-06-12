//
//  GetLatestRateTask.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation
protocol GetLatestRateTaskProtocol {
    var serviceProvider: ServiceProviderProtocol? { get }
    init(serviceProvider: ServiceProviderProtocol?)
    func execute(completion: @escaping (_ response: ExchangeRatesResponse?, _ error:Error?) -> Void)
}

final class GetLatestRateTask: GetLatestRateTaskProtocol {
    let serviceProvider: ServiceProviderProtocol?
    
    init(serviceProvider: ServiceProviderProtocol? = GetLatestRateServiceManager()) {
        self.serviceProvider = serviceProvider
    }
    
    func execute(completion: @escaping (_ response: ExchangeRatesResponse?, _ error:Error?) -> Void) {
        if let response = CacheManager.sharedInstance.getObject() {
            print("Data Loaded from the cache")
            completion(response, nil)
        } else {
            serviceProvider?.performRequest(completion: completion)
        }
    }
}


