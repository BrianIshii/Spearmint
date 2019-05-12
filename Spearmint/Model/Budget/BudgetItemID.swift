//
//  BudgetItemID.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/11/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

struct BudgetItemID: Codable {
    private let id: String
    
    init() {
        self.id = NSUUID().uuidString
    }
    
    init(id: String) {
        self.id = id
    }
    
    func description() -> String {
        return id
    }
}
