//
//  CalculatedViewModel.swift
//  Holerite
//
//  Created by Vinicius on 04/01/23.
//

import Foundation

protocol CalculatedViewModelDelegate: AnyObject {
    
    func didCalculateNetSalary()
}

class CalculatedViewModel {
    
    var cells: Cells?
    
    weak var delegate: CalculatedViewModelDelegate?
    
    var discountINSS = 0.08
    
    var IRRFRate = "0%"
    
    func calculateNetSalary(income: Double, discounts: Double) {
        
        let discountValueINSS = discountINSS * income
        
        let discountValueIRRF = calculateIRRF(of: income)
        
        let netSalary = income - discounts - discountValueINSS - discountValueIRRF
        
        generateCells(
            incomeSalary: income,
            discounts: discounts,
            INSSDiscountValue: discountValueINSS,
            IRRFDiscountValue: discountValueIRRF,
            netSalary: netSalary
        )
    }
    
    private func generateCells(
        incomeSalary: Double,
        discounts: Double,
        INSSDiscountValue: Double,
        IRRFDiscountValue: Double,
        netSalary: Double
    ) {
        cells = [
            
            CellModel(mainText: .income, subtext: nil, value: incomeSalary),
            
            CellModel(mainText: .discounts, subtext: nil, value: discounts),
            
            CellModel(mainText: .discountINSS, subtext: "8%", value: INSSDiscountValue),
            
            CellModel(mainText: .discountIRRF, subtext: IRRFRate, value: IRRFDiscountValue),
            
            CellModel(mainText: .finalSalary, subtext: nil, value: netSalary)
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
