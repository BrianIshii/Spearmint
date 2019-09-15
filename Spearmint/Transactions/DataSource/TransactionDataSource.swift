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
    var transactionRepository: TransactionRepository?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        
        tableView.dataSource = self
        
        guard let transactionRepository = AppDelegate.container.resolve(TransactionRepository.self) else {
            print("failed to resolve \(TransactionRepository.self)")
            return
        }
        self.transactionRepository = transactionRepository
        transactionRepository.addTransactionObserver(self)
    }
}

extension TransactionDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed(TransactionTableViewCell.xib, owner: self, options: nil)?.first as! TransactionTableViewCell
        
        configure(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func configure(cell: UITableViewCell, indexPath: IndexPath) {
        if let cell = cell as? TransactionTableViewCell {
            let object = transactions[indexPath.row]
            
            cell.configure(object: object)
        }
    }
}

extension TransactionDataSource: TransactionObserver {
    func update() {
        guard let transactionRepository = transactionRepository else { return }
        transactions = Array(transactionRepository.getAllTransactions()).sorted(by: >)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
