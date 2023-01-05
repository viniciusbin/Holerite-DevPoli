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
       
}

extension CalculatedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculatedViewModel.cells?.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalculatedCell.identifier, for: indexPath) as? CalculatedCell,
                
              let cellConfiguration = calculatedViewModel.cells?[indexPath.row] else { return UITableViewCell() }

        cell.configure(with: cellConfiguration)

        return cell
    }
    
    
}

extension CalculatedViewController: CalculatedViewModelDelegate {
    
    func didCalculateNetSalary() {
        
        calculatedView?.tableview.reloadData()
    }
}
