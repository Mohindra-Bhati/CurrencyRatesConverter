//
//  ValidateIBANViewBuilder.swift
//  CurrencyRatesConverter
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation
import UIKit

protocol ValidateIBANViewBuilder {
    func buildValidateIBANView() -> ValidateIBANViewController
}

extension ViewBuilder: ValidateIBANViewBuilder {
    func buildValidateIBANView() -> ValidateIBANViewController {
        let vc: ValidateIBANViewController = self.instantiateViewController(fromStoryboard: .main, withIdentifier: .validateIBAN) as! ValidateIBANViewController
        return vc
    }
    
//    func buildSelectCurrencyView(list: [Currency], delegate: SelectCurrencyProtocol) -> SelectCurrencyViewController {
//        let vc: SelectCurrencyViewController = self.instantiateViewController(fromStoryboard: .main, withIdentifier: .selectCurrency) as! SelectCurrencyViewController
//        vc.delegate = delegate
//        vc.viewModel = SelectCurrencyViewModelImpl(currencyList: list)
//        vc.modalPresentationStyle = .popover
//        return vc
//    }
}

