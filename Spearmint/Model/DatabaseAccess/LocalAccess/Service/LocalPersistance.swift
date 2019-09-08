//
//  LocalPersistance.swift
//  Spearmint
//
//  Created by Brian Ishii on 9/7/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

public protocol LocalPersistance {
    func getDictionary<K: SaveableKey, V: Saveable>(key: K.Type, object: V.Type) -> [K: V]
    func updateDictionary<K: SaveableKey, V: Saveable>(data: [K: V])
    func getData<SaveableObject: Saveable>(saveable: SaveableObject.Type) -> [SaveableObject]
    func updateData<SaveableObject: Saveable>(data: [SaveableObject])
}
