//
//  CurrencyConversionViewController.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import UIKit

class CurrencyConversionViewController: UIViewController {
    
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var currentSelectionButton: UIButton!
    @IBOutlet private weak var currencyTableView: UITableView!
    
    var viewModel: CurrencyConversionViewModel = CurrencyConversionViewModelImpl(apiManager: GetLatestRateTask())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitalData()
        self.registerObserver()
        self.registerTableView()
        self.setupAmountField()
    }
    
    private func registerTableView(){
        currencyTableView.register(CurrencyCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func registerObserver(){
        viewModel.observer = {[weak self] event in
            switch event{
            case .reloadTable:
                DispatchQueue.main.async{
                    self?.setInitalData()
                    self?.currencyTableView.reloadData()
                }
            default:
                print("")
            }
        }
    }
    
    @IBAction func currencySelectionButtonTapped(_ sender: UIButton) {
        self.navigationController?.present(ViewBuilder.sharedInstance.buildSelectCurrencyView(list: viewModel.getCurrencyList(), delegate: self), animated: true)
    }
    
    @IBAction func validateIBANButtonTapped(_ sender: UIButton) {
        self.navigationController?.present(ViewBuilder.sharedInstance.buildValidateIBANView(), animated: true)
    }
}

extension CurrencyConversionViewController: SelectCurrencyProtocol {
    func didSelectCurrencyAt(index: Int, currency: Currency?) {
        self.currentSelectionButton.setTitle(viewModel.getCurrencyName(at: index), for: .normal)
        self.viewModel.selectedCurrency = viewModel.getCurrencyRate(at: index)
        self.updateCurrency(
            amount: Double(amountTextField.text ?? "0") ?? 0
        )
    }
}

//MARK: Utility Methods
extension CurrencyConversionViewController{
    
    private func setInitalData(){
        self.amountTextField.delegate = self
        guard viewModel.numberOfCurrencies != 0 else { return }
        let KWDIndex = viewModel.getKWDIndex()
        self.currentSelectionButton.setTitle(viewModel.getCurrencyName(at: KWDIndex), for: .normal)
        self.viewModel.selectedCurrency = viewModel.getCurrencyRate(at: KWDIndex)
        self.updateCurrency(
            amount: Double(amountTextField.text ?? "0") ?? 0
        )
    }
    
    func updateCurrency(amount: Double){
        viewModel.amount = amount
        currencyTableView.reloadData()
    }
    
    private func setupAmountField(){
        amountTextField.inputAccessoryView = getAccessoryView()
    }
}

//MARK: TableView Methods
extension CurrencyConversionViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCurrencies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.getCurrency(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyCell
        cell.configure(model: model)
        return cell
    }
}

extension CurrencyConversionViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateCurrency(
            amount: Double(textField.text ?? "0") ?? 0
        )
    }
}
