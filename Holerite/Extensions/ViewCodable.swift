//
//  ViewCodable.swift
//  Holerite
//
//  Created by Vinicius on 03/01/23.
//

import Foundation
import UIKit

public protocol ViewCodable {
    func buildHierarchy()
    func setupConstraints()
    func applyAdditionalChanges()
}

public extension ViewCodable {
    func setupView() {
        buildHierarchy()
        setupConstraints()
        applyAdditionalChanges()
    }
    
    func applyAdditionalChanges() {}
}

