//
//  CalculatedCell.swift
//  Holerite
//
//  Created by Vinicius on 04/01/23.
//

import UIKit

class CalculatedCell: UITableViewCell {
    
    static let identifier = "CalculatedCell"
    
    var verifySubtext = false
    
    lazy var mainTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Salário bruto"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 2.000,00"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var subtextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "8%"
        
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    private func configureMainTextLabel() {
        
        contentView.addSubview(mainTextLabel)
        
        NSLayoutConstraint.activate([
            mainTextLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
    
    private func configureValueLabel() {
        
        contentView.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func configureTextAndSubtextLabels() {
        
        contentView.addSubview(mainTextLabel)
        contentView.addSubview(subtextLabel)
        
        NSLayoutConstraint.activate([
            mainTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            mainTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            subtextLabel.topAnchor.constraint(equalTo: mainTextLabel.bottomAnchor, constant: 2),
            subtextLabel.leadingAnchor.constraint(equalTo: mainTextLabel.leadingAnchor)
        ])
    }
    
    private func configureCell() {
        
        if verifySubtext {
            configureTextAndSubtextLabels()
        } else {
            configureMainTextLabel()
        }
        
        configureValueLabel()
    }
    
    func configure(with cell: CellModel, color: UIColor) {
        mainTextLabel.text = cell.mainText.rawValue
        
        valueLabel.text = String(format: "R$ %.2f", cell.value)
        valueLabel.textColor = color
        
        if let subtext = cell.subtext {
            subtextLabel.text = subtext
            
            verifySubtext = true
        }
        
        configureCell()
    }

}
