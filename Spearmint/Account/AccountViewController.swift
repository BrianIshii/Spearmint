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
        let transaction = Transaction(name: "name", transactionType: TransactionType.expense, vendor: VendorID(), amount: 10.00, date: TransactionDate(), location: "location", image: false, notes: "notes", budgetDate: BudgetDate(), items: [BudgetItemID():[]])
        
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
