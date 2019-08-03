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
        let transactions = LocalAccess.Transactions.getAllTransactions()
        for (k, transaction) in transactions {
            saveTransaction(transaction)
        }
    }
    
    @IBAction func getTransactions(_ sender: Any) {
        let myContainer = CKContainer.default()
        
        let privateDatabase = myContainer.privateCloudDatabase
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Transaction", predicate: predicate)
        
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            var transactions: [String: Transaction] = [:]
            if let records = records {
                for record: CKRecord in records {
                    var id: String
                    if let temp = record.recordID.recordName as? String {
                        id = temp
                    } else {
                        id = ""
                    }
                    
                    var name = ""
                    if let temp = record.value(forKeyPath: "name") as? String {
                        name = temp
                    }
                    
                    var transactionType = TransactionType.expense
                    if let temp = record.value(forKeyPath: "transactionType") as? Int {
                        switch temp {
                        case 0:
                            transactionType = TransactionType.expense
                        default:
                            transactionType = TransactionType.income
                        }
                    }
                    
                    var vendorID: VendorID
                    if let temp = record.value(forKeyPath: "vendorID") as? String {
                        vendorID = VendorID(temp)
                    } else {
                        vendorID = VendorID()
                    }
                    
                    var amount: Float
                    if let temp = record.value(forKeyPath: "amount") as? Float {
                        amount = temp
                    } else {
                        amount = 0.0
                    }
                    
                    var transactionDate: TransactionDate
                    var budgetDate: BudgetDate
                    if let temp = record.value(forKeyPath: "date") as? Date {
                        transactionDate = TransactionDate(temp)
                        budgetDate = BudgetDate(temp)
                    } else {
                        transactionDate = TransactionDate(Date())
                        budgetDate = BudgetDate(Date())
                    }
                    
                    let transaction = Transaction(id: TransactionID(id), name: name, transactionType: transactionType, vendor: vendorID, amount: amount, date: transactionDate, location: "", image: false, notes: "", budgetDate: budgetDate, items: [:])
                    
                    transactions[id] = transaction
                }
                
                LocalAccess.Transactions.transactions = transactions
                LocalAccess.Transactions.update()
            }
        }
    }
    
    func saveTransaction(_ transaction: Transaction) {
        let myContainer = CKContainer.default()
        
        let privateDatabase = myContainer.privateCloudDatabase
        
        let transactionRecordID = CKRecord.ID(recordName: transaction.ID)
        let transactionRecord = CKRecord(recordType: "Transaction", recordID: transactionRecordID)
        
        transactionRecord["name"] = transaction.name as NSString
        transactionRecord["transactionType"] = transaction.transactionType.rawValue as NSNumber
        transactionRecord["paymentType"] = transaction.paymentType as NSString
        transactionRecord["vendorID"] = transaction.vendor.id as NSString
        transactionRecord["amount"] = transaction.amount as NSNumber
        transactionRecord["date"] = transaction.date.date as NSDate
        if transaction.tags.count > 0 {
            transactionRecord["tags"] = transaction.tags as NSArray
        }
        transactionRecord["notes"] = transaction.notes as NSString
        transactionRecord["amount"] = transaction.amount as NSNumber
        var budgetItemIDs: [NSString] = []
        var items: [NSString] = []
        for (k, v) in transaction.items {
            budgetItemIDs.append(k.id as NSString)
            for item in v {
                items.append(item.budgetItemName as NSString)
            }
        }
        
        if budgetItemIDs.count > 0 {
            transactionRecord["budgetItemIDs"] = budgetItemIDs as NSArray
        }
        if items.count > 0 {
            transactionRecord["items"] = items as NSArray
        }
        
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
