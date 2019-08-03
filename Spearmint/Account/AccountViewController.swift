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
        let transactions = LocalAccess.Transactions.getAll()
        for transaction in transactions {
            saveTransaction(transaction)
        }
    }
    
    @IBAction func getTransactions(_ sender: Any) {
        let myContainer = CKContainer.default()
        
        let privateDatabase = myContainer.privateCloudDatabase
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Transaction", predicate: predicate)
        
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            if let records = records {
                for record: CKRecord in records {
                    let transaction = Transaction(record)
                    LocalAccess.Transactions.append(transaction)
                }
            }
        }
    }
    
    func saveTransaction(_ transaction: Transaction) {
        let myContainer = CKContainer.default()
        
        let privateDatabase = myContainer.privateCloudDatabase
        
        let transactionRecord = transaction.createRecord()
        
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
