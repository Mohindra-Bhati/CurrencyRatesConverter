//
//  ValidateIBANViewModel.swift
//  CurrencyRatesConverter
//
//  Created by Mohindra Bhati on 12/06/24.
//

protocol ValidateIBANViewModelProtocol {
    var observer: ((VCEvent)->Void)? { set get }
    var validateIBANModel: ValidateIBANResponse? { set get }
    
    func validateIBAN(number: String)
}

final class ValidateIBANViewModelImpl: ValidateIBANViewModelProtocol{
    var validateIBANAPIManager: ValidateIBANTaskProtocol
    var validateIBANModel: ValidateIBANResponse? = nil
    var observer: ((VCEvent) -> Void)? = nil
    
    init(apiManager: ValidateIBANTaskProtocol){
        self.validateIBANAPIManager = apiManager
    }
    
    func validateIBAN(number: String) {
        let params = ["iban_number": number]
        self.validateIBANAPIManager.execute(params: params, completion: { [weak self] (response, error) in
            if let responseModel = response {
                self?.validateIBANModel = responseModel
                self?.observer?(.reloadData)
            } else {
                debugPrint("Error: \(error.debugDescription)")
                self?.observer?(.showError)
            }
        })
    }
  
}
