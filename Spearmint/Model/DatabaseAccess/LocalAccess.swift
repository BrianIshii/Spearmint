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
    
    private static let vendors: VendorStore = VendorStore()
    private static let Tags: TagStore = TagStore()
    public static let budgetItemStore: BudgetItemStore = BudgetItemStore()
    public static let Transactions: TransactionStore = TransactionStore()
    
    public static func deleteTransaction(_ transaction: Transaction) {
        Transactions.deleteTransaction(transaction)
        BudgetStore.deleteTransaction(transaction)
        ImageStore.deleteImage(transaction.id)
    }
    
    public static func addTransaction(_ transaction: Transaction) {
        Transactions.addTransaction(transaction)
        BudgetStore.addTransaction(transaction)
        budgetItemStore.addTransaction(transaction)
        for text in transaction.tags {
            if let tag = Tags.getTag(text) {
                tag.transactionIDs.append(transaction.id)
            } else {
                Tags.addTag(Tag(text: text, color: Color(red: 255, green: 0, blue: 0, alpha: 1), transactionIDs: [transaction.id]))
            }
        }
//        vendors.addVendor(vendor: Vendor(name: transaction.vendor))
        print("added transaction")
    }
    
    public static func hasVendor(_ name: String) -> Bool {
        return vendors.hasVendor(name)
    }
    
    public static func getVendor(_ name: String) -> Vendor? {
        return vendors.getVendor(name)
    }
    
    public static func getVendor(_ vendorID: VendorID) -> Vendor? {
        return vendors.getVendor(vendorID)
    }
    
    public static func queryVendors(_ substring: String) -> [(String, VendorID)] {
        return vendors.query(substring)
    }
    
    public static func queryTags(_ substring: String) -> [Tag] {
        return Tags.query(substring)
    }
    
    public static func addTag(_ tag: Tag) {
        Tags.addTag(tag)
    }
    
    public static func getTag(_ text: String) -> Tag? {
        return Tags.getTag(text)
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
