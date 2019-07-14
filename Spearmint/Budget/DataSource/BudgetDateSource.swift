//
//  BudgetDateSource.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/14/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetDateSource: NSObject {
    fileprivate let tableView: UITableView
    var sections: [BudgetItemSection] = BudgetItemSectionStore.budgetItemSections
    var currentBudget: Budget?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        
        tableView.register(UINib.init(nibName: BudgetItemTableViewCell.xib, bundle: nil), forCellReuseIdentifier: BudgetItemTableViewCell.reuseIdentifier)
        
        tableView.dataSource = self
    }
}

extension BudgetDateSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = currentBudget?.items[sections[section].category]?.count {
            return count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BudgetItemTableViewCell.reuseIdentifier, for: indexPath)
        configure(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func configure(cell: UITableViewCell, indexPath: IndexPath) {
        guard let budgetItem = getBudgetItem(indexPath: indexPath) else { return }
        
        if let cell = cell as? BudgetItemTableViewCell {
            cell.configure(object: budgetItem)
        }
    }
    
    public func getBudgetItem(indexPath: IndexPath) -> BudgetItem? {
        guard let budget = currentBudget else { return nil }
        guard let budgetItemIDs = budget.items[sections[indexPath.section].category] else { return nil }
        guard let budgetItem = LocalAccess.budgetItemStore.getBudgetItem(budgetItemIDs[indexPath.row]) else { return nil }
        return budgetItem
    }
}
