//
//  ViewBuilder.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import UIKit

final class ViewBuilder {
    private init(){}
    
    static let sharedInstance = ViewBuilder()
    
    func instantiateViewController<T: UIViewController>(fromStoryboard storyboardName: StoryboardName, withIdentifier identifier: StoryboardID) -> T? {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier.rawValue) as? T
    }
}
