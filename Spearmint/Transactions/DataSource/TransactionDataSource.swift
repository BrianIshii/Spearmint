//
//  TransactionDataSource.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/18/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class TransactionDataSource: NSObject {
    fileprivate let tableView: UITableView
    var transactions: [Transaction] = []
    var viewedTransactions: [Transaction] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        
        tableView.dataSource = self
    }
    
    public func toggleCurrentAndAllTransactions(index: Int) {
        if (index == 0) {
            setListToCurrentMonthTransactions()
        } else {
            setListToAllTransactions()
        }
    }
    
    private func setListToCurrentMonthTransactions() {
        var array = transactions.filter { (t) -> Bool in
            t.isInCurrentMonth()
        }
        
        viewedTransactions = array
        tableView.reloadData()
    }
    
    private func setListToAllTransactions() {
        viewedTransactions = transactions
        tableView.reloadData()
    }
}

extension TransactionDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewedTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed(TransactionTableViewCell.xib, owner: self, options: nil)?.first as! TransactionTableViewCell
        
        configure(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func configure(cell: UITableViewCell, indexPath: IndexPath) {
        if let cell = cell as? TransactionTableViewCell {
            let object = viewedTransactions[indexPath.row]
            
            cell.configure(object: object)
        }
    }
    
    
    
}
