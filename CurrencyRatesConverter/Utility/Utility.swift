//
//  Utility.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import Foundation

enum VCEvent{
    case none
    case reloadTable
    case reloadData
    case showError
}

enum StoryboardName: String {
    case main = "Main"
}

enum StoryboardID: String {
    case home
    case selectCurrency
    case validateIBAN
}
