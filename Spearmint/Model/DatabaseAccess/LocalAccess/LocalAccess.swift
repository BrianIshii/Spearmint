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
    
    private static let cloudKitService = CloudKitService()
    private static let localPersistanceService = LocalPersistanceService()

    public static let Vendors: VendorStore = VendorStore(localPersistanceService: localPersistanceService)
    public static let Tags: TagStore = TagStore(localPersistanceService: localPersistanceService)
    public static let budgetItemStore: BudgetItemStore = BudgetItemStore()
    public static let Transactions: TransactionStore = TransactionStore(localPersistanceService: localPersistanceService)
    public static let Budgets: BudgetStore = BudgetStore(localPersistanceService: localPersistanceService)
    
    public static func deleteTransaction(_ transaction: Transaction) {
        Transactions.remove(transaction.id)
        if let budget = Budgets.get(transaction.budgetDate) {
            budget.transactions.removeAll(where: {transaction.id == $0})
            Budgets.update()
        }
        ImageStore.deleteImage(transaction.id)
    }
    
    public static func addTransaction(_ transaction: Transaction) {
        if let budget = Budgets.get(transaction.budgetDate) {
            budget.transactions.append(transaction.id)
            Budgets.update()
        }
        
        for (budgetItemID, v) in transaction.items {
            if let budgetItem = budgetItemStore.getBudgetItem(budgetItemID) {
                budgetItem.addTransaction(transaction)
                budgetItemStore.updateBudgetItemDictionary()
            }
        }
        
        for text in transaction.tags {
            if let tag = Tags.get(TagID(text)) {
                tag.transactionIDs.append(transaction.id)
                Tags.update()
            } else {
                Tags.append(Tag(text: text, color: Color(red: 255, green: 0, blue: 0, alpha: 1), transactionIDs: [transaction.id]))
            }
        }
        
        if let vendor = Vendors.get(transaction.vendor) {
            vendor.addTransaction(transaction)
        }

        Transactions.append(transaction)
        cloudKitService.saveRecord(CloudAccess.instance.transactionCloudStore.createRecord(transaction))
        print("added transaction")
    }
    
    public static func addVendor(_ vendor: Vendor) {
        Vendors.append(vendor)
    }
    public static func hasVendor(_ name: String) -> Bool {
        return Vendors.get(name) != nil
    }
    
    public static func getVendor(_ name: String) -> Vendor? {
        return Vendors.get(name)
    }
    
    public static func getVendor(_ vendorID: VendorID) -> Vendor? {
        return Vendors.get(vendorID)
    }
    
    public static func queryVendors(_ substring: String) -> [(String, VendorID)] {
        return Vendors.query(substring)
    }
    
    public static func queryTags(_ substring: String) -> [Tag] {
        return Tags.query(substring)
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
