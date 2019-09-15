//
//  AddBudgetItemViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class AddBudgetItemViewController: UIViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet var budgetItemView: BudgetItemView!
    
    var budgetItem: BudgetItem?
    weak var addBudgetItemSectionViewController: AddBudgetItemSectionViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        budgetItemView.transactionTableView.transactionTableViewDelegate = self

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? AddBudgetItemSectionViewController {
            destination.budgetItem = budgetItem
            addBudgetItemSectionViewController = destination
        }
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            // not saved
            return
        }
        if let controller = addBudgetItemSectionViewController {
            let index = controller.budgetCategoryPicker.selectedRow(inComponent: 0)
            let category: BudgetItemCategory = BudgetItemSectionStore.budgetItemSections[index].category
            let name = controller.nameTextField.text!
            let plannedAmount = CurrencyOld.currencyToFloat(controller.plannedAmountTextField.text!)
            
            budgetItem = BudgetItem(name: name, category: category, planned: plannedAmount)
        }
    }
}

extension AddBudgetItemViewController: TransactionTableViewDelegate {
}
