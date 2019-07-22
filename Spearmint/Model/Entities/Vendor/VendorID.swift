//
//  VendorID.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/23/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

struct VendorID: BaseID {
    let id: String
    
    init() {
        let id = VendorID.newID()
        self.id = id
    }
    
    static func == (lhs: VendorID, rhs: VendorID) -> Bool {
        return lhs.id == rhs.id
    }
}

extension VendorID: SaveableKey {
}
