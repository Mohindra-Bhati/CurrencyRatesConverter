//
//  ValidateIBANViewController.swift
//  CurrencyRatesConverter
//
//  Created by Mohindra Bhati on 12/06/24.
//

import UIKit

class ValidateIBANViewController: UIViewController {
    
    @IBOutlet private weak var ibanNumberTextField: UITextField!
    @IBOutlet private weak var validateIbanButton: UIButton!
    @IBOutlet private weak var bankCodeValueLabel: UILabel!
    @IBOutlet private weak var bankNameValueLabel: UILabel!
    @IBOutlet private weak var bankZipValueLabel: UILabel!
    @IBOutlet private weak var bankCityValueLabel: UILabel!
    @IBOutlet private weak var bankBicValueLabel: UILabel!
    @IBOutlet weak var detailsHolderView: UIStackView!
    
    var viewModel: ValidateIBANViewModelProtocol = ValidateIBANViewModelImpl(apiManager: ValidateIBANTask())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInitialData()
        self.registerObserver()
    }
    
    @IBAction func validateIBanTapped(_ sender: UIButton) {
        self.ibanNumberTextField.textColor = .black
        viewModel.validateIBAN(number: ibanNumberTextField.text ?? "")
    }
}
    
extension ValidateIBANViewController {
    private func setupInitialData() {
        self.detailsHolderView.isHidden = true
    }
    
    private func registerObserver(){
        viewModel.observer = {[weak self] event in
            switch event{
            case .reloadData:
                DispatchQueue.main.async{
                    self?.setData()
                }
            case .showError:
                DispatchQueue.main.async{
                    self?.ibanNumberTextField.textColor = .red
                    self?.detailsHolderView.isHidden = true
                }
            default:
                print("")
            }
        }
    }
    
    private func setData() {
        if let model = viewModel.validateIBANModel?.bankData {
            self.ibanNumberTextField.textColor = .green
            self.bankCodeValueLabel.text = model.bankCode
            self.bankNameValueLabel.text = model.name
            self.bankZipValueLabel.text = model.zip
            self.bankCityValueLabel.text = model.city
            self.bankBicValueLabel.text = model.bic
            self.detailsHolderView.isHidden = false
        } else {
            self.detailsHolderView.isHidden = true
            self.ibanNumberTextField.textColor = .red
        }
    }
}
