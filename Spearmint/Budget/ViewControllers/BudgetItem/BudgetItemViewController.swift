//
//  BudgetItemViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/15/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetItemViewController: UIViewController {
 
    @IBOutlet weak var budgetItemView: BudgetItemView!
    var budgetItem: BudgetItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let budgetItem = budgetItem else { return }
        
        if let transactionIDs = budgetItem.transactions[BudgetDate()] {
            var transactions: [Transaction] = []
            for id in transactionIDs {
                transactions.append(TransactionStore.getTransaction(id)!)
            }
            budgetItemView.addTransactions(transactions: transactions)
        } else {
            budgetItemView.addTransactions(transactions: [])
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissTemp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
