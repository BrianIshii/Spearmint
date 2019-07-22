//
//  TransactionID.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/8/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

struct TransactionID: BaseID {
    let id: String
    
    init() {
        let id = TransactionID.newID()
        self.id = id
    }
    
    static func == (left: TransactionID, right: TransactionID) -> Bool {
        return left.id == right.id
    }
}

extension TransactionID: SaveableKey {
}
