//
//  TagID.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

struct TagID: BaseID {
    let id: String
    
    init(_ id: String) {
        self.id = id
    }
    
    static func == (lhs: TagID, rhs: TagID) -> Bool {
        return lhs.id == rhs.id
    }
}

extension TagID: SaveableKey {
}
