//
//  swift
//  Spearmint
//
//  Created by Brian Ishii on 5/18/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class LocalAccess {
    public let reset: Bool = false
    public let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    private let localPersistanceService: LocalPersistanceService

    private let Vendors: VendorStore
    private let Tags: TagStore
    private let BudgetItems: BudgetItemStore
    private let Transactions: TransactionStore
    public let Budgets: BudgetStore
    
    public init(localPersistanceService: LocalPersistanceService) {
        self.localPersistanceService = localPersistanceService
        self.Vendors = VendorStore(localPersistanceService: localPersistanceService)
        self.Tags = TagStore(localPersistanceService: localPersistanceService)
        self.BudgetItems = BudgetItemStore(localPersistanceService: localPersistanceService)
        self.Transactions = TransactionStore(localPersistanceService: localPersistanceService)
        self.Budgets = BudgetStore(localPersistanceService: localPersistanceService)
    }

    public func deleteTransaction(_ transaction: Transaction) {
        Transactions.remove(transaction.id)
        if let budget = Budgets.get(transaction.budgetDate) {
            budget.transactions.removeAll(where: {transaction.id == $0})
            Budgets.update()
        }
        ImageStore.deleteImage(transaction.id)
    }
    
    public func addTransaction(_ transaction: Transaction) {
        if let budget = Budgets.get(transaction.budgetDate) {
            budget.transactions.append(transaction.id)
            Budgets.update()
        }
        
        for (budgetItemID, _) in transaction.items {
            if let budgetItem = BudgetItems.get(budgetItemID) {
                budgetItem.addTransaction(transaction)
                BudgetItems.update()
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
        //cloudKitService.saveRecord(CloudAccess.instance.transactionCloudStore.createRecord(transaction))
        print("added transaction")
    }
    
    public func queryTags(_ substring: String) -> [Tag] {
        return Tags.query(substring)
    }
    
    public func getDictionary
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
    
    public func updateDictionary<K: SaveableKey, V: Saveable>(data: [K: V]) {
        let encoder = JSONEncoder()
        do {
            let url = documentsDirectory.appendingPathComponent(V.urlString)
            let jsonData = try encoder.encode(data)
            try jsonData.write(to: url)
        } catch {
            print(error)
        }
    }
    
    public func getData<SaveableObject: Saveable>(saveable: SaveableObject.Type) -> [SaveableObject] {
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
    public func updateData<SaveableObject: Saveable>(data: [SaveableObject]) {
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

extension LocalAccess: BudgetRepository {
    func getCurrentBudget() -> Budget {
        if let budget = Budgets.get(BudgetDate()) {
            return budget
        } else {
            let budget = Budget(BudgetDate(), items: BudgetItems.activeBudgetItems)
            Budgets.append(budget)
            return budget
        }
    }
    
    func getAll() -> [Budget] {
        return Budgets.getAll()
    }
    
    func get(_ budgetDate: BudgetDate) -> Budget? {
        return Budgets.get(budgetDate)
    }
    
    func append(_ budget: Budget) {
        Budgets.append(budget)
    }
    
    func update(_ budget: Budget) {
        //
    }
    
    func remove(_ budget: Budget) {
        Budgets.remove(budget.id)
    }
}

extension LocalAccess: BudgetItemRepository {
    
    func getAllBudgetItems() -> [BudgetItem] {
        return BudgetItems.getAll()
    }
    
    func get(_ id: BudgetItemID) -> BudgetItem? {
        return BudgetItems.get(id)
    }
    
    func append(_ budgetItem: BudgetItem) {
        BudgetItems.append(budgetItem)
    }
    
    func update(_ budgetItem: BudgetItem) {
        //BudgetItems.
    }
    
    func update() {
        Budgets.update()
    }
    
    func remove(_ budgetItem: BudgetItem) {
        BudgetItems.remove(budgetItem.id)
    }
}

extension LocalAccess: VendorRepository {
    public func append(_ vendor: Vendor) {
        Vendors.append(vendor)
    }
    
    public func hasVendor(_ name: String) -> Bool {
        return Vendors.get(name) != nil
    }
    
    public func get(_ name: String) -> Vendor? {
        return Vendors.get(name)
    }
    
    public func get(_ vendorID: VendorID) -> Vendor? {
        return Vendors.get(vendorID)
    }
    
    public func update(_ vendor: Vendor) {
    }
    
    public func remove(_ vendor: Vendor) {
    }
    
    public func queryVendors(_ substring: String) -> [(String, VendorID)] {
        return Vendors.query(substring)
    }
    
    public func getAllVendors() -> [Vendor] {
        return Vendors.getAll()
    }
}

extension LocalAccess: TransactionRepository {
    public func getAllTransactions() -> [Transaction] {
        return Transactions.getAll()
    }
    
    public func get(_ id: TransactionID) -> Transaction? {
        return Transactions.get(id)
    }
    
    public func append(_ transaction: Transaction) {
        Transactions.append(transaction)
    }
    
    public func update(_ transaction: Transaction) {
        Transactions.update()
        Transactions.updateObservers()
    }
    
    public func remove(_ transaction: Transaction) {
        Transactions.remove(transaction.id)
    }
    
    public func addTransactionObserver(_ observer: TransactionObserver) {
        Transactions.observers.append(observer)
    }
}

extension LocalAccess: TagRepository {
    public func append(_ tag: Tag) {
        Tags.append(tag)
    }
    public func get(_ tagID: TagID) -> Tag? {
        return Tags.get(tagID)
    }
    public func getAllTags() -> [Tag] {
        return Tags.getAll()
    }
}
