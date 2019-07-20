//
//  BudgetDate.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/26/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class BudgetDate: BaseDate, SaveableKey {
    static func == (lhs: BudgetDate, rhs: BudgetDate) -> Bool {
        return lhs.month == rhs.month && lhs.year == rhs.year
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(month)
        hasher.combine(year)
    }
}
