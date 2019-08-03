//
//  BudgetDataSource.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/14/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetDataSource: NSObject {
    fileprivate let tableView: UITableView
    var sections: [BudgetItemSection] = BudgetItemSectionStore.budgetItemSections
    var currentBudget: Budget?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        
        tableView.register(UINib.init(nibName: BudgetItemTableViewCell.xib, bundle: nil), forCellReuseIdentifier: BudgetItemTableViewCell.reuseIdentifier)
        tableView.register(UINib.init(nibName: SelectBudgetItemTableViewCell.xib, bundle: nil), forCellReuseIdentifier: SelectBudgetItemTableViewCell.reuseIdentifier)
        tableView.dataSource = self

        let budget = BudgetStoreOld.getBudget(BudgetDate())
        
        if budget == nil {
            let b = Budget(BudgetDate(), items: LocalAccess.budgetItemStore.getBudgetItems())
            BudgetStoreOld.addBudget(b)
            currentBudget = b
        } else {
            currentBudget = budget
        }
        
        tableView.reloadData()
    }
}

extension BudgetDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].category.rawValue
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let budget = currentBudget else { return 1 }

        return budget.items.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let budget = currentBudget else { return 1 }
        guard let items = budget.items[sections[section].category] else { return 1 }
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let budgetItem = getBudgetItem(indexPath: indexPath) else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: SelectBudgetItemTableViewCell.reuseIdentifier, for: indexPath) as! SelectBudgetItemTableViewCell
        
        cell.textField.text = String(format: "%.2f", budgetItem.planned - budgetItem.actual)
        
        cell.budgetItemName.text = budgetItem.name
        cell.progressBar.progress = budgetItem.actual / budgetItem.planned
        cell.textField.isEnabled = false
        cell.checkmarkImageView?.image = UIImage(named: "checkmark")
        cell.checkmarkImageView?.isHidden = true
        
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

