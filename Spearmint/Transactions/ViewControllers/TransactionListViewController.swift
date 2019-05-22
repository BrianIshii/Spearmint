//
//  TransactionListViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/6/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class TransactionListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var transactions: [Transaction] = []
    var viewedTransactions: [Transaction] = []
    var currentDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactions = Array(TransactionStore.transactions.values).sorted(by: >)
        setListToCurrentMonthTransactions()
        
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
        
        navigationBar.prefersLargeTitles = true
//        let searchController = UISearchController(searchResultsController: nil)
//        navigationItem.searchController = searchController
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewedTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed(TransactionTableViewCell.xib, owner: self, options: nil)?.first as! TransactionTableViewCell
        
        let currentTransaction = viewedTransactions[indexPath.row]
        
        cell.transactionAmountLabel.text = Currency.currencyFormatter(String(format: "%.2f", currentTransaction.amount))

        switch currentTransaction.transactionType {
        case .expense:
            cell.transactionAmountLabel.textColor = UIColor.red
        case.income:
            cell.transactionAmountLabel.textColor = UIColor.green
        }
        cell.transactionVendorLabel.text = currentTransaction.vendor
        cell.transactionDateLabel.text = TransactionDate.getMonthAndDay(date: currentTransaction.date)
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            LocalAccess.deleteTransaction(transactions[indexPath.row])
            transactions.remove(at: indexPath.row)
            
            toggleCurrentAndAllTransactions(index: segmentedControl.selectedSegmentIndex)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: ViewTransactionSegue.segueIdentifier, sender: nil)
    }
    
    @IBAction func toggleTransactions(_ sender: UISegmentedControl) {
        toggleCurrentAndAllTransactions(index: sender.selectedSegmentIndex)
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddTransactionViewController, let transaction = sourceViewController.transaction {
            LocalAccess.addTransaction(transaction)
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
        
        viewedTransactions = array
        transactionTableView.reloadData()
    }
    
    private func setListToAllTransactions() {
        viewedTransactions = transactions
        transactionTableView.reloadData()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == ViewTransactionSegue.segueIdentifier {
            if let vc = segue.destination as? AddTransactionViewController {
                let selectedTransaction = transactions[transactionTableView.indexPathForSelectedRow!.row]
                vc.transaction = selectedTransaction
            }
        }
    }
}
