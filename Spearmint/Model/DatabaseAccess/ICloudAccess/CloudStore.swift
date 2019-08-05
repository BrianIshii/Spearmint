//
//  CloudKitSaveable.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/3/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import CloudKit

protocol CloudStore {
    associatedtype Item: Saveable

    func createItem(from record: CKRecord) -> Item
    func createRecord(_ item: Item) -> CKRecord
}
