//
//  VendorID.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/23/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

struct VendorID: Codable {
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
    
    static func == (left: VendorID, right: VendorID) -> Bool {
        return left.description() == right.description()
    }
}
