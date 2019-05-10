//
//  Budget.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class Budget: Codable {
    
    var name: String
    var date: String
    var items: [BudgetItem]
    
    init(name: String, date: String, items: [BudgetItem]) {
        self.name = name
        self.date = date
        self.items = items
    }
}
