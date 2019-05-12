//
//  BudgetItemSection.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/12/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
struct BudgetItemSection: Codable {
    var category: BudgetItemCategory
    var isExpanded: Bool

    init(category: BudgetItemCategory) {
        self.category = category
        self.isExpanded = true
    }
    
    mutating func collapse() {
        self.isExpanded = false
    }
    
    mutating func expand() {
        self.isExpanded = true
    }
}
