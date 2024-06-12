//
//  SelectCurrencyViewModel.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation
protocol SelectCurrencyViewModelProtocol {
    var currencyList: [Currency] { get }
    var filteredList: [Currency] { get set }
    var numberOfCurrencies: Int { get }
    
    func getCurrencyName(at index: Int) -> String
    func getIndexFor(currency: Currency) -> Int
    func getCurrency(at index: Int) -> Currency
    func updateDataSourceWith(searchText: String)
}

final class SelectCurrencyViewModelImpl:  SelectCurrencyViewModelProtocol{
    var currencyList: [Currency]
    var filteredList: [Currency] = []
    
    init(currencyList: [Currency]) {
        self.currencyList = currencyList
        self.filteredList = currencyList
    }
    
    var numberOfCurrencies: Int{
        filteredList.count
    }
    
    func getCurrencyName(at index: Int) -> String {
        filteredList[index].key
    }
    
    func getIndexFor(currency: Currency) -> Int {
        return currencyList.firstIndex(of: currency) ?? 0
    }
    
    func getCurrency(at index: Int) -> Currency {
        return filteredList[index]
    }
    
    func updateDataSourceWith(searchText: String) {
        filteredList = searchText.isEmpty ? currencyList : currencyList.filter { $0.key.range(of: searchText, options: .caseInsensitive) != nil }
    }
}
