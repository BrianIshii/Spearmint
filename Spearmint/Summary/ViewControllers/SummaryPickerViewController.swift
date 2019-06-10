//
//  SummaryPickerViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/9/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class SummaryPickerViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    weak var masterSummaryViewController: MasterSummaryViewController?
    
    var budgetSections: [BudgetItemSection] = BudgetItemSectionStore.budgetItemSections
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        budgetSections = BudgetItemSectionStore.budgetItemSections
        pickerView.selectRow(0, inComponent: 0, animated: true)
        pickerView.reloadInputViews()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SummaryPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return budgetSections.count
    }
 
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return budgetSections[row].category.rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let master = masterSummaryViewController, let pieChartViewController = master.summaryPieChartViewController {
            pieChartViewController.changeSection(row)
//            pieChartViewController.pieChartView.setNeedsDisplay()
        }
    }
}
