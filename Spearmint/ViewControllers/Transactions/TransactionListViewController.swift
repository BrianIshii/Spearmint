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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var transactionCount = 0
    var transactions: [Transaction] = []
    var currentDate: Date = Date()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed(TransactionTableViewCell.xib, owner: self, options: nil)?.first as! TransactionTableViewCell
        
        let currentTransaction = transactions[indexPath.row]
        
        cell.transactionAmountLabel.text = Currency.currencyFormatter(total: String(currentTransaction.amount))
        cell.transactionVendorLabel.text = currentTransaction.vendor
        cell.transactionDateLabel.text = TransactionDate.getMonthAndDay(date: currentTransaction.date)
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            LocalAccess.deleteTransaction(transaction: transactions[indexPath.row])
            transactions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactions = Array(LocalAccess.transactions.values).sorted(by: >)
        setListToCurrentMonthTransactions()
        
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    @IBAction func toggleTransactions(_ sender: UISegmentedControl) {
        toggleCurrentAndAllTransactions(index: sender.selectedSegmentIndex)
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddTransactionViewController, let transaction = sourceViewController.transaction {
            
            LocalAccess.addTransaction(transaction: transaction)
            transactions.append(transaction)
            transactions.sort(by: >)
            
            toggleCurrentAndAllTransactions(index: segmentedControl.selectedSegmentIndex)
        }
    }
    
    private func toggleCurrentAndAllTransactions(index: Int) {
        if (index == 0) {
            //print("current month")
            setListToCurrentMonthTransactions()
        } else {
            //print("all transactions")
            setListToAllTransactions()
        }
    }
    
    private func setListToCurrentMonthTransactions() {
        var array = transactions.filter { (t) -> Bool in
            t.isInCurrentMonth()
        }
        
        transactionCount = array.count
        transactionTableView.reloadData()
    }
    
    private func setListToAllTransactions() {
        transactionCount = transactions.count
        transactionTableView.reloadData()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
