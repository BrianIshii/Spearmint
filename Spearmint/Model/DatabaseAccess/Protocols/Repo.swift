//
//  BaseStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/21/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol Repo {
    associatedtype Key: SaveableKey
    associatedtype Item: Saveable

    var items: [Key: Item] { get set }
    
    func append(_ item: Item)
    func remove(_ key: Key)
    func get(_ key: Key) -> Item?
    func getAll() -> [Item]
}
