//
//  AddContentsFromImageViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/3/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

enum Fields: Int {
    case vendor = 0
    case items = 1
    case total = 2
}

class AddContentsFromImageViewController: UIViewController, UITextFieldDelegate {

    var addItemAmount: Bool = false
    var previousIndexPath: IndexPath?
    var vendor: String?
    var total: String?
    var itemsDictionary: [[Item]] = []
    var budgetItems: [BudgetItem] = []
    var numberOfSections: Int = 1
    var canAddItems: Bool = true
    var previous: Int?
    var previousVC: AddImageViewController?
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.clearButtonMode = UITextField.ViewMode.always
        textField.inputView = UIView()
        textField.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        
    }
    
    @IBAction func toggleFields(_ sender: UISegmentedControl) {
        if let previous = previous {
            setField(previous)
        }
        
        switch sender.selectedSegmentIndex {
        case Fields.vendor.rawValue:
            textField.isHidden = false
            tableView.isHidden = true
            textField.text = vendor ?? ""
        case Fields.total.rawValue:
            textField.isHidden = false
            tableView.isHidden = true
            textField.text = total ?? ""
        case Fields.items.rawValue:
            tableView.isHidden = false
            textField.isHidden = true
        default:
            break
        }
        
        self.previous = sender.selectedSegmentIndex
    }
    
    func setField(_ field: Int) {
        switch field {
        case Fields.vendor.rawValue:
            vendor = textField.text
        case Fields.total.rawValue:
            total = textField.text
        case Fields.items.rawValue:
            break
        default:
            break
        }
    }
    
    func update() {
        switch segmentedControl.selectedSegmentIndex {
        case Fields.vendor.rawValue:
            vendor = textField.text
        case Fields.total.rawValue:
            total = textField.text
        case Fields.items.rawValue:
            break
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == AddBudgetItemSegue.segueIdentifier{
            if let vc = segue.destination as? AddBudgetItemsViewController {
                vc.budgetDate = BudgetDate(Date())
            }
        }
    }
    
    func unwindFromAddItems(_ vc: AddBudgetItemsViewController) {
        if let selectedBudgetItems = vc.selectedBudgetItems {
            updateItems(selectedBudgetItems)
            canAddItems = false
        }
    }
    
    fileprivate func updateItems(_ budgetItems: [BudgetItem]) {
        self.budgetItems = budgetItems
        
        for (_, budgetItem) in budgetItems.enumerated() {
            var newIndexPaths: [IndexPath] = []
            
            itemsDictionary.append([])
            
            numberOfSections += 1
            tableView.insertSections([numberOfSections - 1], with: UITableView.RowAnimation.automatic)
            
            let item = Item(name: "", amount: 0, budgetItem: budgetItem.name, budgetItemCategory: budgetItem.category)
            
            itemsDictionary[numberOfSections - 2].append(item)
            
            newIndexPaths.append(IndexPath(row: 0, section: numberOfSections - 1))
            tableView.insertRows(at: newIndexPaths, with: UITableView.RowAnimation.automatic)
        }
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddBudgetItemsViewController, let selectedBudgetItems = sourceViewController.selectedBudgetItems {
            updateItems(selectedBudgetItems)
            canAddItems = false
        }
    }
    
    func saveItems() {
        for (section, items) in itemsDictionary.enumerated() {
            for (row, item) in items.enumerated() {
                let indexPath = IndexPath(row: row, section: section + 1)
                if let cell = tableView.cellForRow(at: indexPath) as? ItemTableViewCell {
                    item.amount = cell.textField.getAmount()
                    item.name = cell.nameTextField.text ?? ""
                }
            }
        }
    }
}

extension AddContentsFromImageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section != 0 else { return nil }
        return budgetItems[section - 1].name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return itemsDictionary[section - 1].count + 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = Bundle.main.loadNibNamed(AddTransactionBudgetItemTableViewCell.xib, owner: self, options: nil)?.first as! AddTransactionBudgetItemTableViewCell
            
            return cell
        } else {
            if indexPath.row < itemsDictionary[indexPath.section - 1].count {
                let cell = Bundle.main.loadNibNamed(ItemTableViewCell.xib, owner: self, options: nil)?.first as! ItemTableViewCell
                
                let item = itemsDictionary[indexPath.section - 1][indexPath.row]
                
                if item.amount > 0 {
                    cell.textField.text = Currency.currencyFormatter(item.amount)
                }
                cell.textField.clearButtonMode = UITextField.ViewMode.always
                cell.textField.inputView = UIView()
                cell.textField.inputAccessoryView = nil
                cell.nameTextField.clearButtonMode = UITextField.ViewMode.always
                cell.nameTextField.inputView = UIView()

                return cell
            } else {
                let cell = Bundle.main.loadNibNamed(AddItemTableViewCell.xib, owner: self, options: nil)?.first as! AddItemTableViewCell
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if (canAddItems) {
                previousVC!.performSegue(withIdentifier: AddBudgetItemSegue.segueIdentifier, sender: nil)
            }
        } else {
            if let previous = previousIndexPath {
                if previous == indexPath {
                    addItemAmount = !addItemAmount
                }
            }
            
            previousIndexPath = indexPath
            
            print(addItemAmount)
            let budgetIndex = indexPath.section - 1
            if indexPath.row == itemsDictionary[budgetIndex].count {
                let budgetItem = budgetItems[budgetIndex]
                let item = Item(name: "", amount: 0, budgetItem: budgetItem.name, budgetItemCategory: budgetItem.category)
                itemsDictionary[budgetIndex].append(item)
                
                let newIndexPaths = [IndexPath(row: itemsDictionary[budgetIndex].count - 1, section: indexPath.section)]
                tableView.insertRows(at: newIndexPaths, with: UITableView.RowAnimation.automatic)
            }
        }
    }
}
