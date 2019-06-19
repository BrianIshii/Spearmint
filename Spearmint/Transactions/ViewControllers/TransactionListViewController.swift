//
//  TransactionListViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/6/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class TransactionListViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    private var dataSource: TransactionDataSource?
    var transactions: [Transaction] = []
    var viewedTransactions: [Transaction] = []
    var currentDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactions = Array(TransactionStore.transactions.values).sorted(by: >)
        
        transactionTableView.delegate = self
        
        navigationBar.prefersLargeTitles = true
//        let searchController = UISearchController(searchResultsController: nil)
//        navigationItem.searchController = searchController
        // Do any additional setup after loading the view.
        
        dataSource = TransactionDataSource(tableView: transactionTableView)
        
        guard let dataSource = dataSource else { return }
        
        dataSource.transactions = Array(TransactionStore.transactions.values).sorted(by: >)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let dataSource = dataSource else { return }

        if TransactionStore.TransactionControllerNeedsUpdate {
            TransactionStore.TransactionControllerNeedsUpdate = false
            transactions = Array(TransactionStore.transactions.values).sorted(by: >)
            dataSource.toggleCurrentAndAllTransactions(index: 0)
            segmentedControl.selectedSegmentIndex = 0
        }
    }
    
    @IBAction func toggleTransactions(_ sender: UISegmentedControl) {
        guard let dataSource = dataSource else { return }

        dataSource.toggleCurrentAndAllTransactions(index: sender.selectedSegmentIndex)
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {
        guard let dataSource = dataSource else { return }
        
        if let sourceViewController = sender.source as? AddTransactionViewController, let transaction = sourceViewController.transaction {
            LocalAccess.addTransaction(transaction)
            transactions.append(transaction)
            transactions.sort(by: >)
            
            dataSource.toggleCurrentAndAllTransactions(index: segmentedControl.selectedSegmentIndex)
        }
        
        if let selectedIndexPath = transactionTableView.indexPathForSelectedRow {
            transactionTableView.deselectRow(at: selectedIndexPath, animated: true)
        }
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

extension TransactionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let dataSource = dataSource else { return }
        
        if editingStyle == .delete {
            LocalAccess.deleteTransaction(transactions[indexPath.row])
            transactions.remove(at: indexPath.row)
            
            dataSource.toggleCurrentAndAllTransactions(index: segmentedControl.selectedSegmentIndex)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: ViewTransactionSegue.segueIdentifier, sender: nil)
    }
}
