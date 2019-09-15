//
//  AddBudgetItemSectionViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/25/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class AddBudgetItemSectionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var plannedAmountTextField: MoneyTextField!
    @IBOutlet weak var budgetCategoryPicker: UIPickerView!
    
    var budgetItem: BudgetItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        budgetCategoryPicker.delegate = self
        budgetCategoryPicker.dataSource = self
        
        nameTextField.delegate = self
        
        if let item = budgetItem {
            nameTextField.text = item.name
            plannedAmountTextField.text = CurrencyOld.currencyFormatter(item.planned)
            for (index, section) in BudgetItemSectionStore.budgetItemSections.enumerated() {
                if section.category == item.category {
                    budgetCategoryPicker.selectRow(index, inComponent: 0, animated: true)
                }
            }
            
            disableEditing()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func enableEditing() {
        nameTextField.isUserInteractionEnabled = true
        plannedAmountTextField.isUserInteractionEnabled = true
        budgetCategoryPicker.isUserInteractionEnabled = true
    }
    
    func disableEditing() {
        nameTextField.isUserInteractionEnabled = false
        plannedAmountTextField.isUserInteractionEnabled = false
        budgetCategoryPicker.isUserInteractionEnabled = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return BudgetItemSectionStore.budgetItemSections.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return BudgetItemSectionStore.budgetItemSections[row].category.rawValue
    }
}
