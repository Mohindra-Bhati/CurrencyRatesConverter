//
//  SelectCurrencyBuilder.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation
import UIKit

protocol SelectCurrencyBuilder {
    func buildSelectCurrencyView(list: [Currency], delegate: SelectCurrencyProtocol) -> SelectCurrencyViewController
}

extension ViewBuilder: SelectCurrencyBuilder {
    func buildSelectCurrencyView(list: [Currency], delegate: SelectCurrencyProtocol) -> SelectCurrencyViewController {
        let vc: SelectCurrencyViewController = self.instantiateViewController(fromStoryboard: .main, withIdentifier: .selectCurrency) as! SelectCurrencyViewController
        vc.delegate = delegate
        vc.viewModel = SelectCurrencyViewModelImpl(currencyList: list)
        vc.modalPresentationStyle = .popover
        return vc
    }
}
