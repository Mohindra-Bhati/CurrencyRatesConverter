//
//  SelectCurrencyViewController.swift
//  CurrencyRatesConverte
//
//  Created by Mohindra Bhati on 12/06/24.
//

import UIKit
protocol SelectCurrencyProtocol: AnyObject {
    func didSelectCurrencyAt(index: Int, currency: Currency?)
}

class SelectCurrencyViewController: UIViewController {

    @IBOutlet private weak var selectCurrencyTableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    weak var delegate: SelectCurrencyProtocol?
    var viewModel: SelectCurrencyViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableView()
        self.setupSearchBar()

    }
    private func registerTableView(){
        selectCurrencyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    private func setupSearchBar(){
        searchBar.inputAccessoryView = getAccessoryView()
    }
}

extension SelectCurrencyViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfCurrencies ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel?.getCurrency(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let textLabel = cell.textLabel {
            textLabel.text = model?.key
            textLabel.textColor = .black
            textLabel.font = UIFont.systemFont(ofSize: 16)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currency =  self.viewModel?.getCurrency(at: indexPath.row),
           let index = viewModel?.getIndexFor(currency: currency) {
            self.delegate?.didSelectCurrencyAt(index: index, currency: currency)
            self.dismiss(animated: true)
        }
    }
}

extension SelectCurrencyViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel?.updateDataSourceWith(searchText: searchText)
        selectCurrencyTableView.reloadData()
    }
}
