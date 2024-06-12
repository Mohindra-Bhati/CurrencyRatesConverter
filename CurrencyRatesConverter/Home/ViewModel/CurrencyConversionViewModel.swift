//
//  CurrencyConversionViewModel.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation
protocol CurrencyConversionViewModel {
    
    var amount: Double { set get }
    var numberOfCurrencies: Int { get }
    var selectedCurrency: Double { set get }
    var observer: ((VCEvent)->Void)? { set get }
    var currencyAPIManager: GetLatestRateTaskProtocol { get }
    
    func getCurrencyName(at: Int) -> String
    func getCurrencyRate(at: Int) -> Double
    func getCurrency(at: Int) -> CurrencyWithAmount
    func getCurrencyList() -> [Currency]
    func getKWDIndex() -> Int
}

final class CurrencyConversionViewModelImpl: CurrencyConversionViewModel{
    
    var currencyAPIManager: GetLatestRateTaskProtocol
    var amount: Double = 0
    var selectedCurrency: Double = 1
    var observer: ((VCEvent) -> Void)? = nil
    
    init(apiManager: GetLatestRateTaskProtocol){
        self.currencyAPIManager = apiManager
        self.getCurencyData()
    }
     
    var currencyModel: ExchangeRatesResponse = .init(
        disclaimer: "",
        license: "",
        timestamp: 123,
        base: "",
        rates: [:]
    )
    
    var numberOfCurrencies: Int{
        currencyModel.exCurrencies.count
    }
    
    func getCurencyData(){
        self.currencyAPIManager.execute(completion: { [weak self] (response, error) in
            if let responseModel = response {
                self?.currencyModel = responseModel
                self?.observer?(.reloadTable)
            } else {
                debugPrint("Error: \(error.debugDescription)")
            }
        })
    }
    
    func getCurrencyName(at index: Int) -> String {
        currencyModel.exCurrencies[index].key
    }
    
    func getCurrencyRate(at index: Int) -> Double {
        currencyModel.exCurrencies[index].value
    }
    
    func getCurrency(at index: Int) -> CurrencyWithAmount {
        let fc = currencyModel.exCurrencies[index]
        return fc.getCurrencyWithAmount(amount, from: selectedCurrency)
    }
    
    func getCurrencyList() -> [Currency] {
        return currencyModel.exCurrencies
    }
    
    func getKWDIndex() -> Int {
        guard let curr = currencyModel.exCurrencies.filter({$0.key == "KWD"}).first else { return 0 }
        return currencyModel.exCurrencies.firstIndex(of: curr) ?? 0
    }
}
