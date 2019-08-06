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
//        let dictionary = BudgetStore.budgetDictionary
//        
//        let budget = dictionary[BudgetDate(Date())]!
//        LocalAccess.addTransaction(Transaction(name: "transaction 1", transactionType: TransactionType.income, vendor: "Company 123", amount: 3000, date: "Jun 1, 2019", location: "", image: false, notes: "", budgetDate: budget.id, items: ["Paycheck 1" : [Item(name: "Paycheck", amount: 3000, budgetItem: "Paycheck 1", budgetItemCategory: BudgetItemCategory.income)]]))
//        
//        print("done")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
                    // Insert error handling
                    print("failed to save vendor: \(error)")
                    return
                }
                print("success saved vendor")
                // Insert successfully saved record code
            }
        }
        
        //for budgetItem in LocalAccess.budgetItemStore.
    }
    
    @IBAction func getTransactions(_ sender: Any) {
        let myContainer = CKContainer.default()
        
        let privateDatabase = myContainer.privateCloudDatabase
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Transaction", predicate: predicate)
        
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            if let records = records {
                for record: CKRecord in records {
                    let transaction = CloudAccess.instance.transactionCloudStore.createItem(from: record)
                    LocalAccess.Transactions.append(transaction)
                }
            }
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
        
        let budgetPredicate = NSPredicate(value: true)
        let budgetQuery = CKQuery(recordType: "Budget", predicate: budgetPredicate)
        
        privateDatabase.perform(budgetQuery, inZoneWith: nil) { (records, error) in
            
            if let records = records {
                for record: CKRecord in records {
                    let budget = BudgetCloudStore().createItem(from: record)
                    LocalAccess.Budgets.append(budget)
                    print("budget fetched")
                }
            }
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
                    }
                    
                    print("budgetitems fetched")
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
