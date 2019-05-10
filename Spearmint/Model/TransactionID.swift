//
//  TransactionID.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/8/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

struct TransactionID: Codable {
    let id: String
    
    init() {
        self.id = NSUUID().uuidString
    }
    
    init(id: String) {
        self.id = id
    }
}
