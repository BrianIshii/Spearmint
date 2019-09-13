//
//  AccountViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit
import CloudKit

class AccountViewController: UIViewController {

    var transactionRepository: TransactionRepository?
    var vendorRepository: VendorRepository?
    var tagRepository: TagRepository?
    var budgetRepository: BudgetRepository?
    var budgetItemRepository: BudgetItemRepository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let transactionRepository = AppDelegate.container.resolve(TransactionRepository.self) else {
            print("failed to resolve \(TransactionRepository.self)")
            return
        }
        self.transactionRepository = transactionRepository
        
        guard let vendorRepository = AppDelegate.container.resolve(VendorRepository.self) else {
            print("failed to resolve \(VendorRepository.self)")
            return
        }
        self.vendorRepository = vendorRepository
        
        guard let tagRepository = AppDelegate.container.resolve(TagRepository.self) else {
            print("failed to resolve \(TagRepository.self)")
            return
        }
        self.tagRepository = tagRepository
        
        guard let budgetRepository = AppDelegate.container.resolve(BudgetRepository.self) else {
            print("failed to resolve \(BudgetRepository.self)")
            return
        }
        self.budgetRepository = budgetRepository
        
        guard let budgetItemRepository = AppDelegate.container.resolve(BudgetItemRepository.self) else {
            print("failed to resolve \(BudgetItemRepository.self)")
            return
        }
        self.budgetItemRepository = budgetItemRepository
    }
    

    func clearCloudKitData() {
        let myContainer = CKContainer.default()
        let privateDatabase = myContainer.privateCloudDatabase
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Transaction", predicate: predicate)
        
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let records = records {
                for record in records {
                    CKContainer.default().privateCloudDatabase.delete(withRecordID: record.recordID) { (recordID, error) in
                        if let error = error {
                            print("deleting error: \(error)")
                        } else {
                            print("deleted success")
                        }
                    }
                }
            }
        }
        
        let tagPredicate = NSPredicate(value: true)
        let tagQuery = CKQuery(recordType: "Tag", predicate: tagPredicate)
        
        privateDatabase.perform(tagQuery, inZoneWith: nil) { (records, error) in
            if let records = records {
                for record in records {
                    CKContainer.default().privateCloudDatabase.delete(withRecordID: record.recordID) { (recordID, error) in
                        if let error = error {
                            print("deleting error: \(error)")
                        } else {
                            print("deleted success")
                        }
                    }
                }
            }
        }
        
        let vendorPredicate = NSPredicate(value: true)
        let vendorQuery = CKQuery(recordType: "Vendor", predicate: vendorPredicate)
        
        privateDatabase.perform(vendorQuery, inZoneWith: nil) { (records, error) in
            if let records = records {
                for record in records {
                    CKContainer.default().privateCloudDatabase.delete(withRecordID: record.recordID) { (recordID, error) in
                        if let error = error {
                            print("deleting error: \(error)")
                        } else {
                            print("deleted success")
                        }
                    }
                }
            }
        }
        
        let budgetPredicate = NSPredicate(value: true)
        let budgetQuery = CKQuery(recordType: "Budget", predicate: budgetPredicate)
        
        privateDatabase.perform(budgetQuery, inZoneWith: nil) { (records, error) in
            if let records = records {
                for record in records {
                    CKContainer.default().privateCloudDatabase.delete(withRecordID: record.recordID) { (recordID, error) in
                        if let error = error {
                            print("deleting error: \(error)")
                        } else {
                            print("deleted success")
                        }
                    }
                    
                }
            }
        }
        
        let budgetitemsPredicate = NSPredicate(value: true)
        let budgetitemsQuery = CKQuery(recordType: "Budgetitems", predicate: budgetitemsPredicate)
        
        privateDatabase.perform(budgetitemsQuery, inZoneWith: nil) { (records, error) in
            if let records = records {
                for record in records {
                    CKContainer.default().privateCloudDatabase.delete(withRecordID: record.recordID) { (recordID, error) in
                        if let error = error {
                            print("deleting error: \(error)")
                        } else {
                            print("deleted success")
                        }
                    }
                }
            }
        }
        
        _ = NSPredicate(value: true)
        let budgetItemQuery = CKQuery(recordType: "BudgetItem", predicate: budgetitemsPredicate)
        
        privateDatabase.perform(budgetItemQuery, inZoneWith: nil) { (records, error) in
            if let records = records {
                for record in records {
                    CKContainer.default().privateCloudDatabase.delete(withRecordID: record.recordID) { (recordID, error) in
                        if let error = error {
                            print("deleting error: \(error)")
                        } else {
                            print("deleted success")
                        }
                    }
                }
            }
        }
    }

    @IBAction func addTransaction(_ sender: Any) {
        guard let transactionRepository = transactionRepository else { return }
        guard let vendorRepository = vendorRepository else { return }
        guard let tagRepository = tagRepository else { return }
        guard let budgetRepository = budgetRepository else { return }
        guard let budgetItemRepository = budgetItemRepository else { return }

        let myContainer = CKContainer.default()
        
        let privateDatabase = myContainer.privateCloudDatabase
        
        let transactions = transactionRepository.getAllTransactions()
        for transaction in transactions {
            saveTransaction(transaction)
        }
        if let budget = budgetRepository.get(BudgetDate()) {

            let records = BudgetCloudStore().createRecords(budget)
            
            for record in records {
                privateDatabase.save(record) {
                    (record, error) in
                    if let error = error {
                        // Insert error handling
                        print("failed to save budget: \(error)")
                        return
                    }
                    print("success budget")
                    // Insert successfully saved record code
                }
            }
        }
        
        for tag in tagRepository.getAllTags() {
            let record = TagCloudStore().createRecord(tag)
            
            privateDatabase.save(record) {
                (record, error) in
                if let error = error {
                    // Insert error handling
                    print("failed to save tag: \(error)")
                    return
                }
                print("success tag")
                // Insert successfully saved record code
            }
        }
        
        for vendor in vendorRepository.getAllVendors() {
            let record = VendorCloudStore().createRecord(vendor)
            
            privateDatabase.save(record) {
                (record, error) in
                if let error = error {
                    print("failed to save vendor: \(error)")
                    return
                }
                print("success saved vendor")
            }
        }
        
        for budgetItem in budgetItemRepository.getAllBudgetItems() {
            let record = BudgetItemCloudStore().createRecord(budgetItem)
            
            privateDatabase.save(record) {
                (record, error) in
                if let error = error {
                    print("failed to save BudgetItem: \(error)")
                    return
                }
                print("success saved BudgetItem")
            }
        }
    }
    
    @IBAction func getTransactions(_ sender: Any) {
        guard let transactionRepository = transactionRepository else { return }
        guard let vendorRepository = vendorRepository else { return }
        guard let tagRepository = tagRepository else { return }
        guard let budgetRepository = budgetRepository else { return }

        let myContainer = CKContainer.default()
        let privateDatabase = myContainer.privateCloudDatabase
        
        let budgetPredicate = NSPredicate(value: true)
        let budgetQuery = CKQuery(recordType: "Budget", predicate: budgetPredicate)
        var hi = 0
        
        privateDatabase.perform(budgetQuery, inZoneWith: nil) { (records, error) in
            
            if let records = records {
                for record: CKRecord in records {
                    let budget = BudgetCloudStore().createItem(from: record)
                    budgetRepository.append(budget)
                    print("budget fetched")
                }
            }
            hi += 1
            
        }
        
        while hi == 0 {
            
        }
        
    
        let budgetitemsPredicate = NSPredicate(value: true)
        let budgetitemsQuery = CKQuery(recordType: "Budgetitems", predicate: budgetitemsPredicate)
        
        privateDatabase.perform(budgetitemsQuery, inZoneWith: nil) { (records, error) in
            
            if let records = records {
                for record: CKRecord in records {
                    var items: [BudgetItemCategory: [BudgetItemID]] = [:]
                    
                    for section in BudgetItemSectionStore.budgetItemSections {
                        
                        let temp = record.value(forKey: section.category.rawValue.replacingOccurrences(of: " ", with: "0")) as? [NSString] ?? []
                        var budgetItemIDs: [BudgetItemID] = []
                        for item in temp {
                            budgetItemIDs.append(BudgetItemID(item as String))
                        }
                        
                        items[section.category] = budgetItemIDs
                    }
                    
                    if let budget = budgetRepository.get(BudgetDate(record.recordID.recordName.dropLast().dropLast().dropLast().dropLast().dropLast().description)) {
                        budget.items = items
                        budgetRepository.update()
                    }
                    
                    print("budgetitems fetched")
                }
            }
            hi += 1
        }
        
        while hi == 1 {
            
        }
        let budgetItemPredicate = NSPredicate(value: true)
        let budgetItemQuery = CKQuery(recordType: "BudgetItem", predicate: budgetItemPredicate)
        
        privateDatabase.perform(budgetItemQuery, inZoneWith: nil) { (records, error) in
            
            guard let localAccess = AppDelegate.container.resolve(LocalAccess.self) else {
                print("failed to resolve \(LocalAccess.self)")
                return
            }
            if let records = records {
                for record: CKRecord in records {
                    
                    let budgetItem = BudgetItemCloudStore().createItem(from: record)
                    localAccess.append(budgetItem)
                    print("BudgetItem fetched")
                }
            }
            
            hi += 1
        }
        
        while hi == 2 {
            
        }
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Transaction", predicate: predicate)
        
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            guard let cloudAccess = AppDelegate.container.resolve(CloudAccess.self) else {
                print("failed to resolve cloud access")
                return
            }
            
            if let records = records {
                for record: CKRecord in records {
                    let transaction = cloudAccess.transactionCloudStore.createItem(from: record)
                    transactionRepository.append(transaction)
                }
            }
            hi += 1
        }
        
        while hi == 3 {
            
        }
        
        let tagPredicate = NSPredicate(value: true)
        let tagQuery = CKQuery(recordType: "Tag", predicate: tagPredicate)
        
        privateDatabase.perform(tagQuery, inZoneWith: nil) { (records, error) in
            
            if let records = records {
                for record: CKRecord in records {
                    let tag = TagCloudStore().createItem(from: record)
                    tagRepository.append(tag)
                }
            }
            hi += 1
        }
        while hi == 4 {
            
        }
        let vendorPredicate = NSPredicate(value: true)
        let vendorQuery = CKQuery(recordType: "Vendor", predicate: vendorPredicate)
        
        privateDatabase.perform(vendorQuery, inZoneWith: nil) { (records, error) in
            
            if let records = records {
                for record: CKRecord in records {
                    let vendor = VendorCloudStore().createItem(from: record)
                    vendorRepository.append(vendor)
                    print("vendor fetched")
                }
            }
        }
    }
    
    func saveTransaction(_ transaction: Transaction) {
        let myContainer = CKContainer.default()
        
        let privateDatabase = myContainer.privateCloudDatabase
        
        guard let cloudAccess = AppDelegate.container.resolve(CloudAccess.self) else {
            print("failed to resolve cloud access")
            return
        }
        
        let transactionRecord = cloudAccess.transactionCloudStore.createRecord(transaction)
        
        privateDatabase.save(transactionRecord) {
            (record, error) in
            if let error = error {
                // Insert error handling
                print("failed to save: \(error)")
                return
            }
            print("success")
            print(transaction.ID)
            // Insert successfully saved record code
        }
    }
    @IBAction func hi(_ sender: Any) {
        let alert = UIAlertController(title: "Clear All Cloud Kit Data", message: "This is an alert.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {
            _ in NSLog("cancel")}))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
        _ in NSLog("clearing Data")
            self.clearCloudKitData()
        }))

        self.present(alert, animated: true, completion: nil)
    }
}
