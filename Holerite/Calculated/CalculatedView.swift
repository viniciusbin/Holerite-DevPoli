//
//  CalculatedView.swift
//  Holerite
//
//  Created by Vinicius on 03/01/23.
//

import UIKit

class CalculatedView: UIView {
    
    lazy var tableview: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 60
        tableView.allowsSelection = false
        tableView.register(CalculatedCell.self, forCellReuseIdentifier: CalculatedCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CalculatedView: ViewCodable{
    func buildHierarchy() {
        
        addSubview(tableview)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableview.heightAnchor.constraint(equalToConstant: 299)
        ])
    }
    
    func applyAdditionalChanges() {
        
        backgroundColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
    }
}
