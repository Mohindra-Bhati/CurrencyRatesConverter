//
//  NetworkingConstants.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation

enum AppConstants {
    static var appID_OpenExchange: String { return try! Configuration.value(for: "APP_ID_OPEN_EXCHANGE")}
    static var appID_ApiLayer: String { return try! Configuration.value(for: "APP_ID_API_LAYER")}
}

enum API {
    static var baseURL_OpenExchange: URL {
        return try! URL(string: "https://" + Configuration.value(for: "BASE_URL_OPEN_EXCHANGE"))!
    }
    
    static var baseURL_ApiLayer: URL {
        return try! URL(string: "https://" + Configuration.value(for: "BASE_URL_API_LAYER"))!
    }
}

enum EndPoints {
    static var getLatest: String {
        return "/api/latest.json"
    }
    
    static var validateIban: String {
        return "/bank_data/iban_validate"
    }
}
