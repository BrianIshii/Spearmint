//
//  Repository.swift
//  Spearmint
//
//  Created by Brian Ishii on 9/11/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol Repository {
    associatedtype Key: SaveableKey
    associatedtype Item: Saveable
    
    func getCurrentBudget() -> Item
    func getAll() -> [Item]
    func get(_ id: Key) -> Item?
    func append(_ budget: Item)
    func update(_ budget: Item)
    func remove(_ budget: Item)
}
