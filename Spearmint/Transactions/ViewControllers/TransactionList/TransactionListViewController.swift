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
    
    private var dataSource: TransactionDataSource?
    var currentDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        transactionTableView.delegate = self
        
        navigationBar.prefersLargeTitles = true
//        let searchController = UISearchController(searchResultsController: nil)
//        navigationItem.searchController = searchController
        // Do any additional setup after loading the view.
        
        dataSource = TransactionDataSource(tableView: transactionTableView)
        transactionTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if TransactionStore.TransactionControllerNeedsUpdate {
            TransactionStore.TransactionControllerNeedsUpdate = false
        }
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {        
        if let sourceViewController = sender.source as? AddTransactionViewControllerOld, let transaction = sourceViewController.transaction {
            LocalAccess.addTransaction(transaction)
        }
        
        if let sourceViewController = sender.source as? AddTransactionViewController, let transaction = sourceViewController.transaction {
            LocalAccess.addTransaction(transaction)
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
        guard let dataSource = dataSource else { return }
        
        if segue.identifier == "selectTransaction" {
            if let destination = segue.destination as? TransactionViewController {
                let transaction = dataSource.transactions[transactionTableView.indexPathForSelectedRow!.row]
                destination.transaction = transaction
            }
        }
        
        if segue.identifier == ViewTransactionSegue.segueIdentifier {
            if let vc = segue.destination as? AddTransactionViewControllerOld {
                let selectedTransaction = dataSource.transactions[transactionTableView.indexPathForSelectedRow!.row]
                vc.transaction = selectedTransaction
            }
        }
    }
}

extension TransactionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let dataSource = dataSource else { return }
        
        if editingStyle == .delete {
            LocalAccess.deleteTransaction(dataSource.transactions[indexPath.row])
            dataSource.transactions.remove(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "selectTransaction", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
}