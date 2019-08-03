//
//  BudgetItemViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetItemViewControllerOld: UIViewController {

    var budgetItem: BudgetItem?
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var editButton: UIBarButtonItem!
    weak var editBudgetItemView: AddBudgetItemSectionViewController?
    weak var tableView: BudgetTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = budgetItem {
            navBar.topItem?.title = item.name
        }
        
        editButton.title = "Edit"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onEdit(_ sender: UIBarButtonItem) {
        if editButton.title == "Edit" {
            editButton.title = "Save"
            if let vc = editBudgetItemView {
              vc.enableEditing()
            }
        } else {
            editButton.title = "Edit"
            if let vc = editBudgetItemView {
                let index = vc.budgetCategoryPicker.selectedRow(inComponent: 0)
                let category: BudgetItemCategory = BudgetItemSectionStore.budgetItemSections[index].category
                let name = vc.nameTextField.text!
                let plannedAmount = Currency.currencyToFloat(vc.plannedAmountTextField.text!)
                budgetItem?.planned = plannedAmount
                budgetItem?.category = category
                budgetItem?.name = name
                vc.disableEditing()
            }
        }
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        if let destination = tableView {
            BudgetStoreOld.update()
            destination.tableView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? AddBudgetItemSectionViewController {
            destination.budgetItem = budgetItem
            editBudgetItemView = destination
        }
    }
 

}
