//
//  Budget.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class Budget: Codable {
    
    var date: String
    var items: [BudgetItem]
    
    init(date: String, items: [BudgetItem]) {
        self.date = date
        self.items = items
    }
}
