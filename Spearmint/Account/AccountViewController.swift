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
        LocalAccess.addTransaction(Transaction(name: "transaction 1", transactionType: TransactionType.income, vendor: "Company 123", amount: 3000, date: "Jun 1, 2019", location: "", image: false, notes: "", budgetID: budget.dateString, items: ["Paycheck 1" : [Item(name: "Paycheck", amount: 3000, budgetItem: "Paycheck 1", budgetItemCategory: BudgetItemCategory.income)]]))
        
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
