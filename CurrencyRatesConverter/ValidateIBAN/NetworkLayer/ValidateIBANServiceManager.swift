//
//  ValidateIBANServiceManager.swift
//  CurrencyRatesConverter
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation
protocol ValidateIBANServiceProviderProtocol {
    var networkProvider: BaseNetworkProtocol? { get }
    init(networkProvider: BaseNetworkProtocol?)
    func performRequest(params: [String: String]?, completion: @escaping (_ response: ValidateIBANResponse?, _ error: Error?) -> Void)
}

final class ValidateIBANServiceManager: ValidateIBANServiceProviderProtocol {
    let networkProvider: BaseNetworkProtocol?
    
    init(networkProvider: BaseNetworkProtocol? = Networking.shared) {
        self.networkProvider = networkProvider
    }
    
    func performRequest(params: [String: String]?, completion: @escaping (_ response: ValidateIBANResponse?, _ error: Error?) -> Void) {
        var request = ValidateIBANRequest()
        request.queryParameters = params
        networkProvider?.performNetworkRequest(request) { response in
            switch response {
            case .success(let value):
                completion(value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

