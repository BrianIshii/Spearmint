//
//  AddBudgetItemsViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/12/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class AddBudgetItemsViewController: UIViewController {

    @IBOutlet weak var tableView: SelectBudgetItemListTableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var selectedBudgetItems: [BudgetItem]?
    var budgetDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let bd = budgetDate {
            tableView.currentBudget = BudgetStore.getBudget(bd)
        }
        tableView.reloadData()
        tableView.enableSelection = true
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            // not saved
            return
        }
        
        selectedBudgetItems = tableView.getCheckedCells()
    }
 
}
