//
//  BudgetDataSource.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetDataSource: NSObject {
    fileprivate let tableView: UITableView
    var sections: [BudgetItemSection] = BudgetItemSectionStore.budgetItemSections
    var currentBudget: Budget?
    var canRearrangeSections = false

    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        
        tableView.register(UINib.init(nibName: BudgetItemTableViewCell.xib, bundle: nil), forCellReuseIdentifier: BudgetItemTableViewCell.reuseIdentifier)
        tableView.register(UINib.init(nibName: BudgetSectionTableViewCell.xib, bundle: nil), forCellReuseIdentifier: BudgetSectionTableViewCell.reuseIdentifier)
        
        tableView.dataSource = self
    }
}

extension BudgetDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if canRearrangeSections {
            return ""
        } else {
            return sections[section].category.rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sections[section].isExpanded {
            return CGFloat(32)
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if canRearrangeSections {
            return 1
        } else {
            if let count = currentBudget?.items.keys.count {
                return count
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if canRearrangeSections {
            return (currentBudget?.items.keys.count)!
        } else {
            if sections[section].isExpanded {
                if let count = currentBudget?.items[sections[section].category]?.count {
                    return count
                } else {
                    return 0
                }
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        let item = sections[sourceIndexPath.row]
        sections.remove(at: sourceIndexPath.row)
        sections.insert(item, at: destinationIndexPath.row)

        tableView.reloadData()
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if canRearrangeSections {
            let cell = tableView.dequeueReusableCell(withIdentifier: BudgetSectionTableViewCell.reuseIdentifier, for: indexPath) as! BudgetSectionTableViewCell
            
            cell.budgetCategoryLabel.text = sections[indexPath.row].category.rawValue
            cell.backgroundColor = UIColor(red: 232/255, green: 233/255, blue: 237/255, alpha: 1)
            cell.budgetCategoryLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.setEditing(true, animated: true)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: BudgetItemTableViewCell.reuseIdentifier, for: indexPath)
            configure(cell: cell, indexPath: indexPath)
            
            return cell
        }
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
