//
//  AccountViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addDemoTransactions(_ sender: Any) {
        let dictionary = BudgetStore.budgetDictionary
        
        let budget = dictionary[Budget.dateToString(Date())]!
        LocalAccess.addTransaction(Transaction(name: "transaction 1", transactionType: TransactionType.income, merchant: "Company 123", amount: 3000, date: "Jun 1, 2019", location: "", image: false, notes: "", budgetID: budget.dateString, items: [Item(name: "Paycheck", amount: 3000, budgetItem: "Paycheck 1", budgetItemCategory: BudgetItemCategory.income)]))
        LocalAccess.addTransaction(Transaction(name: "transaction 2", transactionType: TransactionType.income, merchant: "Company 123", amount: 3000, date: "Jun 14, 2019", location: "", image: false, notes: "", budgetID: budget.dateString, items: [Item(name: "Paycheck", amount: 3000, budgetItem: "Paycheck 1", budgetItemCategory: BudgetItemCategory.income)]))
        
        LocalAccess.addTransaction(Transaction(name: "transaction 3", transactionType: TransactionType.expense, merchant: "Renting Company", amount: 2000, date: "Jun 1, 2019", location: "", image: false, notes: "", budgetID: budget.dateString, items: [Item(name: "Rent", amount: 2000, budgetItem: "Mortgage/Rent", budgetItemCategory: BudgetItemCategory.housing)]))
        
        LocalAccess.addTransaction(Transaction(name: "transaction 4", transactionType: TransactionType.expense, merchant: "Shell Gas Station", amount: 60, date: "Jun 3, 2019", location: "", image: false, notes: "", budgetID: budget.dateString, items: [Item(name: "gas", amount: 60, budgetItem: "Gas", budgetItemCategory: BudgetItemCategory.transportation)]))
        LocalAccess.addTransaction(Transaction(name: "transaction 5", transactionType: TransactionType.expense, merchant: "Chevron", amount: 65, date: "Jun 15, 2019", location: "", image: false, notes: "", budgetID: budget.dateString, items: [Item(name: "gas", amount: 65, budgetItem: "Gas", budgetItemCategory: BudgetItemCategory.transportation)]))
        LocalAccess.addTransaction(Transaction(name: "transaction 6", transactionType: TransactionType.expense, merchant: "Shell Gas Station", amount: 67, date: "Jun 28, 2019", location: "", image: false, notes: "", budgetID: budget.dateString, items: [Item(name: "gas", amount: 67, budgetItem: "Gas", budgetItemCategory: BudgetItemCategory.transportation)]))
        
        LocalAccess.addTransaction(Transaction(name: "transaction 7", transactionType: TransactionType.expense, merchant: "Cal Fresh", amount: 67, date: "Jun 2, 2019", location: "", image: false, notes: "", budgetID: budget.dateString, items: [Item(name: "groceries", amount: 67, budgetItem: "Groceries", budgetItemCategory: BudgetItemCategory.food)]))
        
        
        
        LocalAccess.addTransaction(Transaction(name: "transaction 65", transactionType: TransactionType.expense, merchant: "Dick's Sporting Goods", amount: 200, date: "Jun 20, 2019", location: "", image: false, notes: "", budgetID: budget.dateString, items: [Item(name: "Brooks Glycerin Mens size 10", amount: 200, budgetItem: "Personal Items", budgetItemCategory: BudgetItemCategory.personal)]))
        
        LocalAccess.addTransaction(Transaction(name: "transaction 66", transactionType: TransactionType.expense, merchant: "Vanguard Investments", amount: 2000, date: "Jun 1, 2019", location: "", image: false, notes: "", budgetID: budget.dateString, items: [Item(name: "Roth IRA", amount: 2000, budgetItem: "Retirement", budgetItemCategory: BudgetItemCategory.savings)]))
        
         LocalAccess.addTransaction(Transaction(name: "transaction  6", transactionType: TransactionType.expense, merchant: "Vertex Climbing", amount: 63, date: "Jun 1, 2019", location: "", image: false, notes: "", budgetID: budget.dateString, items: [Item(name: "Roth IRA", amount: 63, budgetItem: "Rock Climbing Gym", budgetItemCategory: BudgetItemCategory.health)]))
        
        
        print("done")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
