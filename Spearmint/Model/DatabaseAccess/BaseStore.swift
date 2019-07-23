//
//  BaseStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/21/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class BaseStore<V: Saveable>: Store {
    var items: [Key : Item] = [:]
    //var observers: [ItemObserver] = []
    var localPersistanceService: LocalPersistanceService
    
    typealias Key = V.Key
    typealias Item = V
    //typealias ItemObserver = O
    
    init(localPersistanceService: LocalPersistanceService) {
        self.localPersistanceService = localPersistanceService
        self.items = localPersistanceService.getDictionary(key: Key.self, object: Item.self)
    }
    
    func append(_ item: Item) {
        items[item.id] = item
        update()
    }
    
    func remove(_ key: Key) {
        items.removeValue(forKey: key)
        update()
    }
    
    func get(_ key: Key) -> Item? {
        return items[key]
    }
    
    func getAll() -> [Item] {
        return items.values.map({ $0 })
    }
    
    func update() {
        localPersistanceService.updateDictionary(data: items)
//        for observer in observers {
//            observer.update()
//        }
    }
}
