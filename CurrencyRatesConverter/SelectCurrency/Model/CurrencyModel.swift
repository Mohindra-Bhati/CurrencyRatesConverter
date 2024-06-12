//
//  CurrencyModel.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation

struct Currency: Equatable{
    let key: String
    let value: Double
    
    func getCurrencyWithAmount(_ amount: Double, from: Double)-> CurrencyWithAmount{
        let _amount = amount * (value / from)
        return .init(
            name: key,
            amount: _amount
        )
    }
    
    static func == (lhs:Currency, rhs:Currency)-> Bool{
        return lhs.key == rhs.key && lhs.value == rhs.value
    }
}
