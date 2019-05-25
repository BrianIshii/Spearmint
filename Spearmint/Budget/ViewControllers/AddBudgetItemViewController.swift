//
//  AddBudgetItemViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class AddBudgetItemViewController: UIViewController {

    var budgetItem: BudgetItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        budgetItem = BudgetItem(name: "cats", category: BudgetItemCategory.food, planned: 200.00)
    }
 

}
