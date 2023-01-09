//
//  CalculatedViewController.swift
//  Holerite
//
//  Created by Vinicius on 03/01/23.
//

import UIKit

class CalculatedViewController: UIViewController {
    
    var calculatedView: CalculatedView?
    var calculatedViewModel = CalculatedViewModel()
    var incomeValue: Double
    var discountValue: Double
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        calculatedView?.tableview.dataSource = self
        calculatedView?.tableview.delegate = self
        calculatedViewModel.calculateNetSalary(income: incomeValue, discounts: discountValue)
        configureNavigationBar()
    }
    
    override func loadView() {
        
        self.calculatedView = CalculatedView()
        self.view = calculatedView
    }
    
    init(incomeSalary: Double, discounts: Double) {
        
        self.incomeValue = incomeSalary
        self.discountValue = discounts
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNavigationBar() {
        
        let closeButton = UIButton()
        closeButton.setTitle("FECHAR", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        closeButton.addTarget(self, action: #selector(tapCloseBarButton), for: .touchUpInside)
        
        let closeBarButtonItem = UIBarButtonItem(customView: closeButton)
        navigationItem.leftBarButtonItem = closeBarButtonItem
        navigationController?.navigationBar.backgroundColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
    }
    
    @objc private func tapCloseBarButton() {
        
        dismiss(animated: true)
    }
}

extension CalculatedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return calculatedViewModel.populatedCells?.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalculatedCell.identifier, for: indexPath) as? CalculatedCell,
              let cellConfiguration = calculatedViewModel.populatedCells?[indexPath.row] else { return UITableViewCell() }
        
        cell.configure(with: cellConfiguration, color: cellConfiguration.color)
        return cell
    }
}

extension CalculatedViewController: CalculatedViewModelDelegate {
    
    func calculateNetSalary() {
        
        calculatedView?.tableview.reloadData()
    }
}
