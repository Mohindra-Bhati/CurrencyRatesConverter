//
//  UIViewController+Extension.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import UIKit

extension UIViewController {
    func getAccessoryView() -> UIView{
        let doneToolbar: UIToolbar = UIToolbar(
            frame: CGRect.init(
                x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50
            )
        )
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        return doneToolbar
    }
    
    @objc private func doneButtonAction(){
        self.view.endEditing(true)
    }
}
