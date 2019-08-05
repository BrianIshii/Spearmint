//
//  BudgetItemID.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/11/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

struct BudgetItemID: BaseID {
    let id: String
    
    init() {
        let id = BudgetItemID.newID()
        self.id = id
    }
    
    init(_ id: String) {
        self.id = id
    }
    
    static func == (lhs: BudgetItemID, rhs: BudgetItemID) -> Bool {
        return lhs.id == rhs.id
    }
}

extension BudgetItemID: SaveableKey {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
