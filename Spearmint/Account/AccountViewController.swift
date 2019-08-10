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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addDemoTransactions(_ sender: Any) {
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
        
        let budgetItemPredicate = NSPredicate(value: true)
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
        let myContainer = CKContainer.default()
        
        let privateDatabase = myContainer.privateCloudDatabase
        
        let transactions = LocalAccess.Transactions.getAll()
        for transaction in transactions {
            saveTransaction(transaction)
        }
        if let budget = LocalAccess.Budgets.get(BudgetDate()) {

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
        
        for tag in LocalAccess.Tags.getAll() {
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
        
        for vendor in LocalAccess.Vendors.getAll() {
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
        
        for budgetItem in LocalAccess().getAllBudgetItems() {
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
//        let cloudService = CloudKitService()
//        
//        cloudService.getRecords("Budget") { (records) in
//            if let records = records {
//                for record: CKRecord in records {
//                    let budget = BudgetCloudStore().createItem(from: record)
//                    LocalAccess.Budgets.append(budget)
//                    print("budget fetched")
//                }
//            }
//        }
        
        let myContainer = CKContainer.default()
        let privateDatabase = myContainer.privateCloudDatabase
        
        let budgetPredicate = NSPredicate(value: true)
        let budgetQuery = CKQuery(recordType: "Budget", predicate: budgetPredicate)
        var hi = 0
        
        privateDatabase.perform(budgetQuery, inZoneWith: nil) { (records, error) in
            
            if let records = records {
                for record: CKRecord in records {
                    let budget = BudgetCloudStore().createItem(from: record)
                    LocalAccess.Budgets.append(budget)
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
                    
                    if let budget = LocalAccess.Budgets.get(BudgetDate(record.recordID.recordName.dropLast().dropLast().dropLast().dropLast().dropLast().description)) {
                        budget.items = items
                        LocalAccess.Budgets.update()
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
            
            if let records = records {
                for record: CKRecord in records {
                    
                    let budgetItem = BudgetItemCloudStore().createItem(from: record)
                    LocalAccess().append(budgetItem)
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
            
            if let records = records {
                for record: CKRecord in records {
                    let transaction = CloudAccess.instance.transactionCloudStore.createItem(from: record)
                    LocalAccess.Transactions.append(transaction)
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
                    LocalAccess.Tags.append(tag)
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
                    LocalAccess.Vendors.append(vendor)
                    print("vendor fetched")
                }
            }
        }
    }
    
    func saveTransaction(_ transaction: Transaction) {
        let myContainer = CKContainer.default()
        
        let privateDatabase = myContainer.privateCloudDatabase
        
        let transactionRecord = CloudAccess.instance.transactionCloudStore.createRecord(transaction)
        
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
}
