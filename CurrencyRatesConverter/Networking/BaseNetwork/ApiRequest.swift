//
//  ApiRequest.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation

protocol ApiRequest {
    associatedtype ResponseType: Decodable

    var url: URL { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var queryParameters: [String: String]? { get set }
    func urlWithQueries() -> URL
}

extension ApiRequest {
    var method: String { return "GET" }
    var headers: [String: String]? { return nil }
    var body: Data? { return nil }
   
    var requiredQueryParams: [String: String] {
         var combinedDict: [String: String] = ["app_id": AppConstants.appID_OpenExchange]
        if let queryParams = queryParameters {
            combinedDict = queryParams.merging(combinedDict) { (current, _) in current }
        }
        return combinedDict
    }

    func urlWithQueries() -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.queryItems = requiredQueryParams.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
}
