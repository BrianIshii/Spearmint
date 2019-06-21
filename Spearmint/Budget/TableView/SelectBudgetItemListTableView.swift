//
//  SelectBudgetItemListTableView.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/12/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class SelectBudgetItemListTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var sections: [BudgetItemSection] = BudgetItemSectionStore.budgetItemSections
    var currentBudget: Budget?
    var canRearrangeSections = false
    var enableSelection = false
    var selectedBudgetItems: [BudgetItem] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        register(UINib.init(nibName: BudgetItemTableViewCell.xib, bundle: nil), forCellReuseIdentifier: BudgetItemTableViewCell.reuseIdentifier)
        register(UINib.init(nibName: SelectBudgetItemTableViewCell.xib, bundle: nil), forCellReuseIdentifier: SelectBudgetItemTableViewCell.reuseIdentifier)
        delegate = self
        dataSource = self
        
        reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = sections[section].category.rawValue
        label.backgroundColor = UIColor.lightGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sections[section].isExpanded {
            return CGFloat(32)
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if sections[section].isExpanded {
            return CGFloat(32)
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = currentBudget?.items.keys.count {
            return count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectBudgetItemTableViewCell.reuseIdentifier, for: indexPath) as! SelectBudgetItemTableViewCell
        
        let currentBudgetItem = currentBudget!.items[sections[indexPath.section].category]![indexPath.row]
        
        cell.textField.text = String(format: "%.2f", currentBudgetItem.planned - currentBudgetItem.actual)

        cell.budgetItemName.text = currentBudgetItem.name
        cell.progressBar.progress = currentBudgetItem.actual / currentBudgetItem.planned
        cell.textField.isEnabled = false
        cell.checkmarkImageView?.image = UIImage(named: "checkmark")
        cell.checkmarkImageView?.isHidden = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let item = sections[sourceIndexPath.row]
        sections.remove(at: sourceIndexPath.row)
        sections.insert(item, at: destinationIndexPath.row)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectBudgetItemTableViewCell
        let budgetItem = (currentBudget?.items[sections[indexPath.section].category]![indexPath.row])!
        cell.checkmarkImageView?.isHidden = !cell.checkmarkImageView!.isHidden
        if cell.checkmarkImageView.isHidden {
            if let index = selectedBudgetItems.firstIndex(where: {(b) -> Bool in b == budgetItem}) {
                selectedBudgetItems.remove(at: index)
            }
            
        } else {
            selectedBudgetItems.append(budgetItem)
        }
    }
    
    func getCheckedCells() -> [BudgetItem] {
        return selectedBudgetItems
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

