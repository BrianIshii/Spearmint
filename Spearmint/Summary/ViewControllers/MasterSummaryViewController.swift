//
//  MasterSummaryViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class MasterSummaryViewController: UIViewController {

    weak var summaryPieChartViewController: SummaryPieChartViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if BudgetStore.budgetViewControllerNeedsUpdate {
            summaryPieChartViewController?.budget = BudgetStore.getBudget(BudgetDate(Date()))
        }
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let destination = segue.destination
        
        if let vc = destination as? SummaryPieChartViewController {
            vc.budget = BudgetStore.getBudget(BudgetDate(Date()))
            summaryPieChartViewController = vc
        }
        
        if let vc = destination as? SummaryPickerViewController {
            vc.masterSummaryViewController = self
        }
    }
 

}
