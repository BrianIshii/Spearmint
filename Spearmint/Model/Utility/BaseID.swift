//
//  BaseID.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/13/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol BaseID: Codable {
    var id: String { get }
}

extension BaseID {
    
    static func newID() -> String {
        return NSUUID().uuidString
    }
    
    static func == (left: BaseID, right: BaseID) -> Bool {
        return left.id == right.id
    }
}
