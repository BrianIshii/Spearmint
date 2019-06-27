//
//  BudgetItemCategory.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/11/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

enum BudgetItemCategory: String, Codable {
    case income = "Income"
    case giving = "Giving"
    case savings = "Savings"
    case housing = "Housing"
    case transportation = "Transportation"
    case food = "Food"
    case personal = "Personal"
    case lifestyle = "Life Style"
    case health = "Health"
    case insurance = "Insurance"
    case debt = "Debt"
    case other = "Other"
}
