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
    private let addImageViewSegueIdentifier = "AddImageSegue"
    
    var transaction: Transaction?
    var amountTextField: UITextField!
    var vendorTextField: UITextField!
    var dateLabel: UILabel!
    var selectedImage: UIImageView!
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == rows.image.rawValue {
            return CGFloat(100)
        } else if indexPath.row ==  rows.date.rawValue {
            return CGFloat(240)
        }
        return CGFloat(60)
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
            
            if let t = transaction, t.hasImage == true {
                cell.recieptImageView.image = ImageStore.getImage(transactionID: t.id)
            } else {
                cell.recieptImageView.image = UIImage(imageLiteralResourceName: "default")
            }
            selectedImage = cell.recieptImageView
            cell.controller = self
            
//            let tap = UIGestureRecognizer(target: self, action: #selector(self.tappedImageView(_:)))
//            cell.isUserInteractionEnabled = true
//            cell.imageView?.addGestureRecognizer(tap)
//            cell.imageView?.isUserInteractionEnabled = true
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
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case rows.items.rawValue:
            performSegue(withIdentifier: AddBudgetItemSegue.segueIdentifier, sender: nil)
        case rows.image.rawValue:
            performSegue(withIdentifier: addImageViewSegueIdentifier, sender: nil)
        default:
            return
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
        
        
        for (index, item) in items.enumerated() {
            if let cell = tableView.cellForRow(at: IndexPath(row: index + AddTransactionViewController.defaultFields, section: 0)) as? ItemTableViewCell {
                item.amount = cell.textField.getAmount()
            }
        }
        
        
        transaction = Transaction(name: name, transactionType: transactionType, merchant: merchant, amount: Float(amount), date: date, location: "N/A", image: hasImage, notes: "notes", budgetID: budgetKey, items: items)
        
        if hasImage {
            ImageStore.saveImage(selectedImage.image!, transactionID: transaction!.id)
        }
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddBudgetItemsViewController, let selectedBudgetItems = sourceViewController.selectedBudgetItems {
            
            var newIndexPaths: [IndexPath] = []
            for (index, budgetItem) in selectedBudgetItems.enumerated() {
                items.append(Item(name: budgetItem.name, amount: 0, budgetItem: budgetItem.id, budgetItemCategory: budgetItem.category))
                newIndexPaths.append(IndexPath(row: AddTransactionViewController.defaultFields + index, section: 0))
            }
            
            tableView.insertRows(at: newIndexPaths, with: UITableView.RowAnimation.automatic)
        } else if let sourceViewController = sender.source as? AddImageViewController, let image = sourceViewController.image {
            print("unwind")
            selectedImage.image = image
        }
    }
    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        // Dismiss the picker if the user canceled.
//        dismiss(animated: true, completion: nil)
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        
//        // The info dictionary may contain multiple representations of the image. You want to use the original.
//        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
//            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
//        }
//        
//        // Set photoImageView to display the selected image.
//        self.selectedImage.image = selectedImage
//        
//        // Dismiss the picker.
//        dismiss(animated: true, completion: nil)
//    }
//    
//    func selectImage() {
//        let imagePickerController = UIImagePickerController()
//        
//        
//        // Make sure ViewController is notified when the user picks an image.
//        imagePickerController.delegate = self
//        imagePickerController.sourceType = .photoLibrary
//        
//        present(imagePickerController, animated: true, completion: nil)
//    }
}
