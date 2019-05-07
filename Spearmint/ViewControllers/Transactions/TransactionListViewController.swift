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
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactions = Transaction.dummyTransactions

        transactionTableView.delegate = self
        transactionTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
