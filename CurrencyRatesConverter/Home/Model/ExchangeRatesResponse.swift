//
//  ExchangeRatesResponse.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation

struct ExchangeRatesResponse: Codable {
        let disclaimer: String
        let license: String
        let timestamp: TimeInterval
        let base: String
        let rates: [String: Double]
    
    lazy var exCurrencies: [Currency] = {
        return rates.map { (key: String, value: Double) in
            return Currency(key: key, value: value)
        }
    }()
}

struct CurrencyWithAmount{
    let name: String
    let amount: Double
}
