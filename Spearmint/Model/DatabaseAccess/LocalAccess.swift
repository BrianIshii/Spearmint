//
//  LocalAccess.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/18/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class LocalAccess {
    public static let reset: Bool = false
    public static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    public static let vendorStore: VendorStore = VendorStore()
    public static let Tags: TagStore = TagStore()
    public static let budgetItemStore: BudgetItemStore = BudgetItemStore()

    public static func deleteTransaction(_ transaction: Transaction) {
        TransactionStore.deleteTransaction(transaction)
        BudgetStore.deleteTransaction(transaction)
        ImageStore.deleteImage(transaction.id)
    }
    
    public static func addTransaction(_ transaction: Transaction) {
        TransactionStore.addTransaction(transaction)
        BudgetStore.addTransaction(transaction)
        vendorStore.addVendor(vendor: Vendor(name: transaction.vendor))
        print("added transaction")
    }
    
    public static func getDictionary
        <K: SaveableKey, V: Saveable>(key: K.Type, object: V.Type) -> [K: V] {
        do {
            let url = documentsDirectory.appendingPathComponent(V.urlString)
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let dictionary = try decoder.decode([K: V].self, from: data)
            
            return dictionary
        } catch {
            print(error)
        }
        
        return [:]
    }
    
    public static func updateDictionary<K: SaveableKey, V: Saveable>(data: [K: V]) {
        let encoder = JSONEncoder()
        do {
            let url = documentsDirectory.appendingPathComponent(V.urlString)
            let jsonData = try encoder.encode(data)
            try jsonData.write(to: url)
        } catch {
            print(error)
        }
    }
    
    public static func getData<SaveableObject: Saveable>(saveable: SaveableObject.Type) -> [SaveableObject] {
        do {
            let url = documentsDirectory.appendingPathComponent(SaveableObject.urlString)
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let array = try decoder.decode([SaveableObject].self, from: data)
            
            return array
        } catch {
            print(error)
        }
        
        return []
    }
    public static func updateData<SaveableObject: Saveable>(data: [SaveableObject]) {
        let encoder = JSONEncoder()
        do {
            let url = documentsDirectory.appendingPathComponent(SaveableObject.urlString)
            let jsonData = try encoder.encode(data)
            try jsonData.write(to: url)
        } catch {
            print(error)
        }
    }
}
