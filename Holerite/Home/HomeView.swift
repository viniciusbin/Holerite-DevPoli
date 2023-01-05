//
//  HomeView.swift
//  Holerite
//
//  Created by Vinicius on 03/01/23.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func tapCalculateButton()
}

class HomeView: UIView {
    
    private weak var delegate: HomeViewProtocol?
    
    func delegate(delegate: HomeViewProtocol) {
        self.delegate = delegate
    }
    
    var incomeSalaryValue: Double {
        if let salaryNumber = Double(incomeTextField.text ?? ""), incomeTextField.text?.isEmpty == false {
            return salaryNumber
        }
        
        return 0
    }
    
    var discountValue: Double {
        if let discountNumber = Double(discountTextField.text ?? ""), discountTextField.text?.isEmpty == false {
            return discountNumber
        }
        
        return 0
    }
    
    lazy var incomeTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "  Salario bruto"
        textfield.backgroundColor = .white
        textfield.clipsToBounds = true
        textfield.layer.cornerRadius = 4.0
        textfield.layer.borderWidth = 0.1
        return textfield
    }()
    
    lazy var discountTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "  Descontos"
        textfield.backgroundColor = .white
        textfield.clipsToBounds = true
        textfield.layer.cornerRadius = 4.0
        textfield.layer.borderWidth = 0.1
        return textfield
    }()
    
    lazy var calculateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Calcular", for: .normal)
        button.backgroundColor = UIColor(red: 79.0/255.0, green: 166.0/255.0, blue: 246.0/255.0, alpha: 1.0)
        button.addTarget(self, action: #selector(tappedCalculateButton), for: .touchUpInside)
        button.layer.cornerRadius  = 4.0
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tappedCalculateButton() {
        self.delegate?.tapCalculateButton()
    }

}

extension HomeView: ViewCodable {
    func buildHierarchy() {
        addSubview(incomeTextField)
        addSubview(discountTextField)
        addSubview(calculateButton)
    }
    
    func setupConstraints() {
        
        let sa = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            incomeTextField.topAnchor.constraint(equalTo: sa.topAnchor, constant: 16),
            incomeTextField.leadingAnchor.constraint(equalTo: sa.leadingAnchor, constant: 16),
            incomeTextField.trailingAnchor.constraint(equalTo: sa.trailingAnchor, constant: -16),
            incomeTextField.heightAnchor.constraint(equalToConstant: 44),
            
            discountTextField.topAnchor.constraint(equalTo: incomeTextField.bottomAnchor, constant: 12),
            discountTextField.leadingAnchor.constraint(equalTo: sa.leadingAnchor, constant: 16),
            discountTextField.trailingAnchor.constraint(equalTo: sa.trailingAnchor, constant: -16),
            discountTextField.heightAnchor.constraint(equalToConstant: 44),
            
            calculateButton.topAnchor.constraint(equalTo: discountTextField.bottomAnchor, constant: 22),
            calculateButton.widthAnchor.constraint(equalToConstant: 150),
            calculateButton.heightAnchor.constraint(equalToConstant: 50),
            calculateButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
    }
    
    func applyAdditionalChanges() {
        backgroundColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
    }
    
    
}
