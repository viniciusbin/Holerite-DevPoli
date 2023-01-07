//
//  CalculatedViewModel.swift
//  Holerite
//
//  Created by Vinicius on 04/01/23.
//

import Foundation
import UIKit

protocol CalculatedViewModelDelegate: AnyObject {
    
    func didCalculateNetSalary()
}

class CalculatedViewModel {
    
    var populatedCells: Cells?
    
    weak var delegate: CalculatedViewModelDelegate?
    
    var discountINSS = 0.08
    
    var IRRFRate = "0%"
    
    var greenColor = UIColor(red: 66.0/255.0, green: 166.0/255.0, blue: 64.0/255.0, alpha: 1.0)
    var grayColor = UIColor(red: 142.0/255.0, green: 142.0/255.0, blue: 142.0/255.0, alpha: 1.0)
    var redColor = UIColor(red: 219.0/255.0, green: 66.0/255.0, blue: 57.0/255.0, alpha: 1.0)
    
    func calculateNetSalary(income: Double, discounts: Double) {
        
        let discountValueINSS = discountINSS * income
        
        let discountValueIRRF = calculateIRRF(of: income)
        
        let netSalary = income - discounts - discountValueINSS - discountValueIRRF
        
        createCells(
            incomeSalary: income,
            discounts: discounts,
            INSSDiscountValue: discountValueINSS,
            IRRFDiscountValue: discountValueIRRF,
            netSalary: netSalary
        )
    }
    
    private func createCells(incomeSalary: Double, discounts: Double, INSSDiscountValue: Double, IRRFDiscountValue: Double, netSalary: Double) {
        var salaryColor: UIColor
        if netSalary > 0 {
            salaryColor = greenColor
        } else if netSalary < 0 {
            salaryColor = redColor
            } else {
                salaryColor = grayColor
        }
        
        populatedCells = [
            CellModel(mainText: .income, subtext: nil, value: incomeSalary, color: greenColor, strikethrough: .normal),
            CellModel(mainText: .discounts, subtext: nil, value: discounts, color: discounts > 0 ? redColor : grayColor, strikethrough: discounts == 0 ? .strikethroug : .normal),
            CellModel(mainText: .discountINSS, subtext: "8%", value: INSSDiscountValue, color: redColor, strikethrough: INSSDiscountValue == 0 ? .strikethroug : .normal),
            CellModel(mainText: .discountIRRF, subtext: IRRFRate, value: IRRFDiscountValue, color: IRRFDiscountValue > 0 ? redColor : grayColor, strikethrough: IRRFDiscountValue == 0 ? .strikethroug : .normal),
            CellModel(mainText: .finalSalary, subtext: nil, value: netSalary, color: salaryColor, strikethrough: netSalary == 0 ? .strikethroug : .normal)
        ]
        
        delegate?.didCalculateNetSalary()
    }
    
  
    private func calculateIRRF(of incomeSalary: Double) -> Double {
        
        switch incomeSalary {
            
        case let salary where salary < 1903.98:
            return 0
        
        case let salary where salary < 2826.65:
            IRRFRate = "7,5%"
            
            return incomeSalary * 0.075
        
        case let salary where salary < 3751.05:
            IRRFRate = "15%"
            
            return incomeSalary * 0.15
        
        case let salary where salary < 4664.68:
            IRRFRate = "22,5%"
            
            return incomeSalary * 0.225
            
        default:
            IRRFRate = "27,5%"
            
            return incomeSalary * 0.275
        }
    }
}
