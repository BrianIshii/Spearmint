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

class AddTransactionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var addImageView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    static let segueIdentifier = "addTransactionViewControllerSegue"
    private let addImageViewSegueIdentifier = "AddImageSegue"
    
    var transaction: Transaction?
    var amountTextField: UITextField!
    var vendorTextField: VendorTextField!
    var dateLabel: UILabel!
    var selectedImage: UIImageView!
    var items: [Item] = []
    var itemsDictionary: [[Item]] = []
    var budgetItems: [BudgetItem] = []
    static let defaultFields: Int = 5
    var isKeyboardPresent: Bool = false
    var keyboardHeight: CGFloat = 0
    var tableViewOriginalY: CGFloat = 0
    var numberOfSections: Int = 1
    var canAddItems: Bool = true
//    var NavigationBarOriginalY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
                
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            self.view.frame.origin.y -= keyboardSize.height
//        }
        print("k appear")
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if (!isKeyboardPresent) {
                tableViewOriginalY = tableView.frame.origin.y
                tableView.frame.origin.y -= keyboardSize.height
                
//                NavigationBarOriginalY = navigationBar.frame.origin.y
//                navigationBar.frame.origin.y += keyboardSize.height
                
                isKeyboardPresent = true
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("k disappear")
        if (isKeyboardPresent) {
            tableView.frame.origin.y = tableViewOriginalY
            
//            navigationBar.frame.origin.y = NavigationBarOriginalY
            isKeyboardPresent = false
        }
    }
    
    @objc func tappedImageView(_ sender: UIGestureRecognizer) {
        print("hi")
    }
    
    private func configureDateCell(cell: UITableViewCell, indexPath: IndexPath) {
        if let cell = cell as? DateTableViewCell {
            if let t = transaction {
                cell.dateLabel.text = t.date
                cell.datePicker.date = DateFormatterFactory.mediumFormatter.date(from: t.date)!
            } else {
                cell.dateLabel.text = TransactionDate.getCurrentDate()
            }
            dateLabel = cell.dateLabel

            //cell.configure(object: object)
        }
    }
    
    private func configureAmountCell(cell: UITableViewCell, indexPath: IndexPath) {
        if let cell = cell as? AmountTableViewCell {
            if let t = transaction {
                cell.textField.text = Currency.currencyFormatter(t.amount)
            }
            amountTextField = cell.textField

            //cell.configure(object: object)
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
        switch segue.identifier {
        case AddBudgetItemSegue.segueIdentifier:
            let date = dateLabel.text!
            
            if let vc = segue.destination as? AddBudgetItemsViewController {
                vc.budgetDate = Budget.dateToString(DateFormatterFactory.mediumFormatter.date(from: date)!)
            }
        case addImageViewSegueIdentifier:
            if let image = selectedImage.image, let vc = segue.destination as? AddImageViewController {
                vc.image = image
            }
        default:
            break
        }
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            // not saved
            return
        }
        
        let name = "test1"
        let date = dateLabel.text!
        let merchant = vendorTextField.text!
        let transactionType = segmentedControl.selectedSegmentIndex == TransactionType.expense.rawValue ? TransactionType.expense : TransactionType.income
        let amount = Currency.currencyToFloat(amountTextField.text!)
        
        let budgetKey = Budget.dateToString(DateFormatterFactory.mediumFormatter.date(from: date)!)
        let budget = BudgetStore.budgetDictionary[budgetKey]
        let hasImage = ((selectedImage.image?.isEqualTo(UIImage(imageLiteralResourceName: "default")))!) ? false : true
        
        var transactionItems: [Item] = []
        
        for (section, items) in itemsDictionary.enumerated() {
            for (row, item) in items.enumerated() {
                let indexPath = IndexPath(row: row, section: section + 1)
                if let cell = tableView.cellForRow(at: indexPath) as? ItemTableViewCell {
                    item.amount = cell.textField.getAmount()
                    item.name = cell.nameTextField.text ?? ""
                }
                
                transactionItems.append(item)
            }
        }
        
        for (index, item) in items.enumerated() {
            if let cell = tableView.cellForRow(at: IndexPath(row: index + AddTransactionViewController.defaultFields, section: 0)) as? ItemTableViewCell {
                item.amount = cell.textField.getAmount()
            }
        }
        
        
        transaction = Transaction(name: name, transactionType: transactionType, merchant: merchant, amount: Float(amount), date: date, location: "N/A", image: hasImage, notes: "notes", budgetID: budgetKey, items: transactionItems)
        
        if hasImage {
            ImageStore.saveImage(selectedImage.image!, transactionID: transaction!.id)
        }
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddBudgetItemsViewController, let selectedBudgetItems = sourceViewController.selectedBudgetItems {
            updateItems(selectedBudgetItems)
            canAddItems = false
        } else if let sourceViewController = sender.source as? AddImageViewController, let image = sourceViewController.image {
            print("unwind")
            if let vendor = sourceViewController.addContentsViewController?.vendor {
                vendorTextField.text = vendor
            }
            if let total = sourceViewController.addContentsViewController?.total {
                amountTextField.text = total
            }
            
            selectedImage.image = image
        }
    }
    
    
    fileprivate func updateItems(_ budgetItems: [BudgetItem]) {
        self.budgetItems = budgetItems

        for (index, budgetItem) in budgetItems.enumerated() {
            var newIndexPaths: [IndexPath] = []

            itemsDictionary.append([])
            
            numberOfSections += 1
            tableView.insertSections([numberOfSections - 1], with: UITableView.RowAnimation.automatic)

            let item: Item
            if budgetItems.count == 1 {
                item = Item(name: "", amount: Currency.currencyToFloat(amountTextField.text!), budgetItem: budgetItem.name, budgetItemCategory: budgetItem.category)
            } else  {
                item = Item(name: "", amount: 0, budgetItem: budgetItem.name, budgetItemCategory: budgetItem.category)
            }
            itemsDictionary[numberOfSections - 2].append(item)

            newIndexPaths.append(IndexPath(row: 0, section: numberOfSections - 1))
            tableView.insertRows(at: newIndexPaths, with: UITableView.RowAnimation.automatic)
        }
    }
}

extension AddTransactionViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section != 0 else { return nil }
        return budgetItems[section - 1].name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return AddTransactionViewController.defaultFields + items.count
        } else {
            return itemsDictionary[section - 1].count + 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == rows.image.rawValue {
                return CGFloat(100)
            } else if indexPath.row ==  rows.date.rawValue {
                return CGFloat(240)
            }
            return CGFloat(60)
        }
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
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
                
                if let t = transaction, t.hasImage == true {
                    cell.recieptImageView.image = ImageStore.getImage(transactionID: t.id)
                } else {
                    cell.recieptImageView.image = UIImage(imageLiteralResourceName: "default")
                }
                selectedImage = cell.recieptImageView
                cell.controller = self
                return cell
            case rows.vendor.rawValue:
                let cell = Bundle.main.loadNibNamed(VendorTableViewCell.xib, owner: self, options: nil)?.first as! VendorTableViewCell
                
                vendorTextField = cell.textField
                
                return cell
            default:
                let cell = Bundle.main.loadNibNamed(ItemTableViewCell.xib, owner: self, options: nil)?.first as! ItemTableViewCell
                
                let item = items[indexPath.row - AddTransactionViewController.defaultFields]
                
                return cell
            }
        } else {
            if indexPath.row < itemsDictionary[indexPath.section - 1].count {
                let cell = Bundle.main.loadNibNamed(ItemTableViewCell.xib, owner: self, options: nil)?.first as! ItemTableViewCell
                
                let item = itemsDictionary[indexPath.section - 1][indexPath.row]
                
                if item.amount > 0 {
                    cell.textField.text = Currency.currencyFormatter(item.amount)
                }
                
                return cell
            } else {
                let cell = Bundle.main.loadNibNamed(AddItemTableViewCell.xib, owner: self, options: nil)?.first as! AddItemTableViewCell
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case rows.items.rawValue:
                if (canAddItems) {
                    performSegue(withIdentifier: AddBudgetItemSegue.segueIdentifier, sender: nil)
                }
            case rows.image.rawValue:
                performSegue(withIdentifier: addImageViewSegueIdentifier, sender: nil)
            default:
                return
            }
        } else {
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
