//
//  AddTransactionViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/7/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

enum rows : Int, Codable {
    case date = 1
    case amount = 3
    case items = 4
    case vendor = 2
    case image = 0
}
class AddTransactionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var addImageView: UITableView!
    
    static let segueIdentifier = "addTransactionViewControllerSegue"
    
    var transaction: Transaction?
    var amountTextField: UITextField!
    var vendorTextField: UITextField!
    var dateLabel: UILabel!
    var items: [Item] = []
    static let defaultFields: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddTransactionViewController.defaultFields + items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case rows.date.rawValue:
            let cell = Bundle.main.loadNibNamed(DateTableViewCell.xib, owner: self, options: nil)?.first as! DateTableViewCell
            configureDateCell(cell: cell, indexPath: indexPath)
            return cell
        case rows.amount.rawValue:
            let cell = Bundle.main.loadNibNamed(AmountTableViewCell.xib, owner: self, options: nil)?.first as! AmountTableViewCell
            configureAmountCell(cell: cell, indexPath: indexPath)
            return cell
        case rows.items.rawValue:
            let cell = Bundle.main.loadNibNamed(AddTransactionBudgetItemTableViewCell.xib, owner: self, options: nil)?.first as! AddTransactionBudgetItemTableViewCell
            
            return cell
        case rows.image.rawValue:
            let cell = Bundle.main.loadNibNamed(ImageViewTableViewCell.xib, owner: self, options: nil)?.first as! ImageViewTableViewCell
            
            cell.controlller = self
            return cell
        case rows.vendor.rawValue:
            let cell = Bundle.main.loadNibNamed(VendorTableViewCell.xib, owner: self, options: nil)?.first as! VendorTableViewCell
            
            vendorTextField = cell.textField
            vendorTextField.delegate = self
            
            return cell
        default:
            let cell = Bundle.main.loadNibNamed(ItemTableViewCell.xib, owner: self, options: nil)?.first as! ItemTableViewCell
            
            let item = items[indexPath.row - AddTransactionViewController.defaultFields]
            
            cell.itemName.text = item.name
            
            return cell
        }
    }
    
    private func configureDateCell(cell: UITableViewCell, indexPath: IndexPath) {
        if let cell = cell as? DateTableViewCell {
            
            cell.dateLabel.text = TransactionDate.getCurrentDate()
            dateLabel = cell.dateLabel
            
            //cell.configure(object: object)
        }
    }
    
    private func configureAmountCell(cell: UITableViewCell, indexPath: IndexPath) {
        if let cell = cell as? AmountTableViewCell {
            
            amountTextField = cell.textField

            //cell.configure(object: object)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == rows.items.rawValue) {
            performSegue(withIdentifier: AddBudgetItemSegue.segueIdentifier, sender: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toggleExpenseIncomeSegmentedControl(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == TransactionType.expense.rawValue) {
            print("expense")
        } else {
            print("income")
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == AddBudgetItemSegue.segueIdentifier {
            let date = dateLabel.text!

            if let vc = segue.destination as? AddBudgetItemsViewController {
                vc.budgetDate = Budget.dateToString(DateFormatterFactory.mediumFormatter.date(from: date)!)
            }
        }
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            // not saved
            return
        }
        
        let name = "test1"
        let date = dateLabel.text!
        let merchant = vendorTextField.text!
        let transactionType = segmentedControl.selectedSegmentIndex == TransactionType.expense.rawValue ? TransactionType.expense : TransactionType.income
        let amount = Currency.currencyToFloat(total: amountTextField.text!)
        
        let budgetKey = Budget.dateToString(DateFormatterFactory.mediumFormatter.date(from: date)!)
        let budget = BudgetStore.budgetDictionary[budgetKey]
        
        for (index, item) in items.enumerated() {
            if let cell = tableView.cellForRow(at: IndexPath(row: index + AddTransactionViewController.defaultFields, section: 0)) as? ItemTableViewCell {
                item.amount = cell.textField.getAmount()
            }
        }
        
        
        transaction = Transaction(name: name, transactionType: transactionType, merchant: merchant, amount: Float(amount), date: date, location: "N/A", image: "N/A", notes: "notes", budgetID: budgetKey, items: items)
        
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddBudgetItemsViewController, let selectedBudgetItems = sourceViewController.selectedBudgetItems {
            
            var newIndexPaths: [IndexPath] = []
            for (index, budgetItem) in selectedBudgetItems.enumerated() {
                items.append(Item(name: budgetItem.name, amount: 0, budgetItem: budgetItem.id, budgetItemCategory: budgetItem.category))
                newIndexPaths.append(IndexPath(row: AddTransactionViewController.defaultFields + index, section: 0))
            }
            
            tableView.insertRows(at: newIndexPaths, with: UITableView.RowAnimation.automatic)

        }
    }
}
