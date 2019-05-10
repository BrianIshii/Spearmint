//
//  BudgetItem.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class BudgetItem: Codable {
    
    var name: String
    var planned: Float
    var actual: Float
    
    init(name: String, planned: Float, actual: Float) {
        self.name = name
        self.planned = planned
        self.actual = actual
    }
}
