//
//  BudgetDataSource.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetDataSource: NSObject {
    fileprivate let tableView: BudgetItemListTableView
    var sections: [BudgetItemSection] = BudgetItemSectionStore.defaultSections
    var currentBudget: Budget?
    var canRearrangeSections = false

    
    init(tableView: BudgetItemListTableView) {
        self.tableView = tableView
        super.init()
        
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
            cell.setEditing(true, animated: true)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: BudgetItemTableViewCell.reuseIdentifier, for: indexPath)
            configure(cell: cell, indexPath: indexPath)
            return cell
        }
    }

private func configure(cell: UITableViewCell, indexPath: IndexPath) {
    if let cell = cell as? BudgetItemTableViewCell {
        let object = currentBudget!.items[sections[indexPath.section].category]![indexPath.row]
        cell.configure(object: object)
    }
}
    
}
