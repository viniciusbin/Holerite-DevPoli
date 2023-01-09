//
//  HomeViewController.swift
//  Holerite
//
//  Created by Vinicius on 03/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var homeView: HomeView = {
        let view = HomeView()
        return view
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Holerite"
        navigationController?.navigationBar.backgroundColor = .white
        homeView.delegate(delegate: self)
    }
    
    override func loadView() {
        
        self.view = homeView
    }
}

extension HomeViewController: HomeViewProtocol {
    func tapCalculateButton() {
        
        let calculatedViewController = CalculatedViewController(incomeSalary: homeView.incomeSalaryValue, discounts: homeView.discountValue)
        let calculatedNavigationController = UINavigationController(rootViewController: calculatedViewController)
        
        homeView.cleanTextfield()
        homeView.enableButton()
        navigationController?.present(calculatedNavigationController, animated: true)
    }
}
