//
//  CalculatedModel.swift
//  Holerite
//
//  Created by Vinicius on 04/01/23.
//

import Foundation

struct CellModel {
            
        let mainText: CellTexts
        let subtext: String?
        let value: Double
    }

    typealias Cells = [CellModel]

enum CellTexts: String {
    
    case income = "Salário Bruto"
    case discounts = "Descontos"
    case discountINSS = "Desconto INSS"
    case discountIRRF = "Desconto IRRF"
    case finalSalary = "Salário Líquido"
}