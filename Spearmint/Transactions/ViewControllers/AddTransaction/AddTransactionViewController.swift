//
//  TempViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/5/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class AddTransactionViewController: UIViewController {
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var transactionView: TransactionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var transaction: Transaction?
    var budgetItems: [BudgetItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.view.isOpaque = false
        
        transactionView.delegate = self
        transactionView.moneyTextField.becomeFirstResponder()
        transactionView.dateTextField.text = DateFormatterFactory.MediumFormatter.string(from: Date())
        
        navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationBar.isHidden = false
    }
    
    @IBAction func canel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func unwind(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? AddBudgetItemsViewController, let budgetItems = sourceViewController.selectedBudgetItems {
            //budgetItems.forEach({ (item) -> Void in print(item.name)})
//            transactionView.categoryButton.setTitle(budgetItems.first?.name, for: UIControl.State.normal)
            
            self.budgetItems = budgetItems
            transactionView.categoryTextView.budgetItems = budgetItems.map({ $0.id })
            transactionView.categoryTextView.createCategoryViews()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationViewController = segue.destination as? AddBudgetItemsViewController {
            destinationViewController.budgetDate = BudgetDate(Date())
        }
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            // not saved
            return
        }
        
        addTransaction()
    }
    
    fileprivate func addTransaction() {
        guard let vendorAccess = AppDelegate.container.resolve(VendorRepository.self) else {
            print("failed to resolve \(VendorRepository.self)")
            return
        }
        
        let name = ""
        let dateString = transactionView.dateTextField.text!
        let date = DateFormatterFactory.MediumFormatter.date(from: dateString) ?? Date()
        let vendorString = transactionView.vendorTextField.text!
        let transactionType = transactionView.transactionTypeSegementedControl.selectedSegmentIndex == TransactionType.expense.rawValue ? TransactionType.expense : TransactionType.income
        let amount = CurrencyOld.currencyToFloat(transactionView.moneyTextField.text!)
        let budgetKey = BudgetDate()
        //_ = LocalAccess.Budgets.budgetDictionary[budgetKey]
        let hasImage = false
        
        var transactionItems: [BudgetItemID: [Item]] = [:]
        
        if let budgetItems = budgetItems {
            for budgetItem in budgetItems {
                transactionItems[budgetItem.id] = []
            }
        }
        
        let vendor: Vendor
        
        if vendorAccess.hasVendor(vendorString) {
            vendor = vendorAccess.get(vendorString)!
        } else {
            if let budgetItems = budgetItems, let budgetItem = budgetItems.first {
                vendor = Vendor(name: vendorString, budgetCategory: budgetItem.category, budgetItemID: budgetItem.id)
            } else {
                vendor = Vendor(name: vendorString)
            }
            vendorAccess.append(vendor)
        }
        
        let tags = transactionView.tagTextView.tags
        
        transaction = Transaction(name: name, transactionType: transactionType, vendor: vendor.id, amount: Float(amount), date: TransactionDate(date), location: "N/A", image: hasImage, tags: tags, notes: "notes", budgetDate: budgetKey, items: transactionItems)
    }
}

extension AddTransactionViewController: TransactionViewDelegate {
    func didSelectCategoryButton() {
        _ = UIStoryboardSegue.init(identifier: AddBudgetItemSegue.SegueIdentifier, source: self, destination: AddBudgetItemsViewController())

        performSegue(withIdentifier: AddBudgetItemSegue.SegueIdentifier, sender: nil)
    }
    
    func didSelectTag(text: String) {
        let _ = UIStoryboardSegue.init(identifier: "selectTag", source: self, destination: TagViewController())
        
        performSegue(withIdentifier: "selectTag", sender: self)
    }
    
    func didSelectVendor(_ vendorID: VendorID) {
        print("hi")
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
