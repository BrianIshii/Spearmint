//
//  BudgetSectionID.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

struct BudgetSectionID: BaseID {
    let id: String
    
    init() {
        let id = BudgetSectionID.newID()
        self.id = id
    }
    
    static func == (lhs: BudgetSectionID, rhs: BudgetSectionID) -> Bool {
        return lhs.id == rhs.id
    }
}

extension BudgetSectionID: SaveableKey {
}
