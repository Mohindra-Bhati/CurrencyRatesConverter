//
//  GetLatestRateServiceManager.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation
protocol ServiceProviderProtocol {
    var networkProvider: BaseNetworkProtocol? { get }
    init(networkProvider: BaseNetworkProtocol?)
    func performRequest(completion: @escaping (_ response: ExchangeRatesResponse?, _ error: Error?) -> Void)
}

final class GetLatestRateServiceManager: ServiceProviderProtocol {
    
    let networkProvider: BaseNetworkProtocol?
    
    init(networkProvider: BaseNetworkProtocol? = Networking.shared) {
        self.networkProvider = networkProvider
    }
    
    func performRequest(completion: @escaping (_ response: ExchangeRatesResponse?, _ error: Error?) -> Void) {
        let request = GetLatestRatesRequest()
        networkProvider?.performNetworkRequest(request) { response in
            switch response {
            case .success(let value):
                CacheManager.sharedInstance.saveObject(value)
                completion(value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
