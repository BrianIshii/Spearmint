//
//  TransactionListViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/6/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class TransactionListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var transactionTableView: UITableView!
    
    var transactions: [Transaction] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed(TransactionTableViewCell.xib, owner: self, options: nil)?.first as! TransactionTableViewCell
        
        let currentTransaction = transactions[indexPath.row]
        
        cell.transactionNameLabel.text = currentTransaction.name
        cell.transactionAmountLabel.text = String(currentTransaction.amount)
        cell.transactionDateLabel.text = TransactionDate.getMonthAndDay(date: currentTransaction.date)
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            transactions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            LocalAccess.updateTransactionPersistentStorage(transactions: transactions)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactions = LocalAccess.getAllTransactions()

        transactionTableView.delegate = self
        transactionTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    @IBAction func toggleTransactions(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            print("current month")
        } else {
            print("all transactions")
        }
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddTransactionViewController, let transaction = sourceViewController.transaction {
            
            let newIndexPath = IndexPath(row: transactions.count, section: 0)
            
            transactions.append(transaction)
            transactionTableView.insertRows(at: [newIndexPath], with: .automatic)
            
            transactionTableView.reloadData()
            
            LocalAccess.updateTransactionPersistentStorage(transactions: transactions)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
