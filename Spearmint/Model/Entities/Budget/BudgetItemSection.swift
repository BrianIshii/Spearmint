//
//  BudgetItemSection.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/12/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class BudgetItemSection: Saveable {
    var id: BudgetSectionID
    var category: BudgetItemCategory
    var isExpanded: Bool

    init(category: BudgetItemCategory) {
        self.id = BudgetSectionID()
        self.category = category
        self.isExpanded = true
    }
    
    public func collapse() {
        self.isExpanded = false
    }
    
    public func expand() {
        self.isExpanded = true
    }
}
