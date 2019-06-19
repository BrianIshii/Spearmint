////
////  BudgetItemsTableView.swift
////  Spearmint
////
////  Created by Brian Ishii on 5/12/19.
////  Copyright © 2019 Brian Ishii. All rights reserved.
////
//
//import UIKit
//
//class BudgetItemListTableView: UITableView {
//
//    override init(frame: CGRect, style: UITableView.Style) {
//        super.init(frame: frame, style: style)
//        setUp()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setUp()
//    }
//    
//    func setUp() {
//        register(UINib.init(nibName: BudgetItemTableViewCell.xib, bundle: nil), forCellReuseIdentifier: BudgetItemTableViewCell.reuseIdentifier)
//        register(UINib.init(nibName: BudgetSectionTableViewCell.xib, bundle: nil), forCellReuseIdentifier: BudgetSectionTableViewCell.reuseIdentifier)
//
//        reloadData()
//    }
//    
////    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
////        let label = UILabel()
////        label.text = sections[section].category.rawValue
////        label.backgroundColor = UIColor.lightGray
////        return label
////    }
////
////    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
////        if sections[section].isExpanded {
////            return CGFloat(32)
////        } else {
////            return 0
////        }
////    }
////
////    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
////        let label = UILabel()
////        label.text = "Add Item"
////        return label
////    }
////
////    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
////        if sections[section].isExpanded {
////            return CGFloat(32)
////        } else {
////            return 0
////        }
////    }
////
////    func numberOfSections(in tableView: UITableView) -> Int {
////        if canRearrangeSections {
////            return 1
////        } else {
////            if let count = currentBudget?.items.keys.count {
////                return count
////            } else {
////                return 1
////            }
////        }
////    }
////
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        if canRearrangeSections {
////            return (currentBudget?.items.keys.count)!
////        } else {
////            if sections[section].isExpanded {
////                if let count = currentBudget?.items[sections[section].category]?.count {
////                    return count
////                } else {
////                    return 0
////                }
////            } else {
////                return 1
////            }
////        }
////    }
////
//////    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//////        performSegue(withIdentifier: ViewBudgetItemSegue.segueIdentifier, sender: nil)
//////    }
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        if canRearrangeSections {
////            let cell = tableView.dequeueReusableCell(withIdentifier: BudgetSectionTableViewCell.reuseIdentifier, for: indexPath) as! BudgetSectionTableViewCell
////
////            cell.budgetCategoryLabel.text = sections[indexPath.row].category.rawValue
////            cell.setEditing(true, animated: true)
////            return cell
////        } else {
////            let cell = tableView.dequeueReusableCell(withIdentifier: BudgetItemTableViewCell.reuseIdentifier, for: indexPath)
////            configure(cell: cell, indexPath: indexPath)
////            return cell
////        }
////    }
////
////    private func configure(cell: UITableViewCell, indexPath: IndexPath) {
////        if let cell = cell as? BudgetItemTableViewCell {
////            let object = currentBudget!.items[sections[indexPath.section].category]![indexPath.row]
////            cell.configure(object: object)
////        }
////    }
////
////    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
////        return canRearrangeSections
////    }
////
////
////    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
////
////        let item = sections[sourceIndexPath.row]
////        sections.remove(at: sourceIndexPath.row)
////        sections.insert(item, at: destinationIndexPath.row)
////
////        tableView.reloadData()
////    }
//    
//
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//
//}
