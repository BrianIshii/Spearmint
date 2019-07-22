//
//  Savable.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/23/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol Saveable: class, Codable {
    associatedtype Key: SaveableKey
    var id: Key { get }
    static var urlString: String { get }
}

extension Saveable {
    static var urlString: String {
        return "\(self)"
    }
}
