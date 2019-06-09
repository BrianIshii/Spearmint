//
//  SummaryPieChartViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class SummaryPieChartViewController: UIViewController {

    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var balanceLabel: UILabel!
    
    var budget: Budget?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        update()
        pieChartView.setNeedsDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        update()
        pieChartView.setNeedsDisplay()
    }

    private func update() {
        // Do any additional setup after loading the view.
        if let b = budget {
            let totalIncome = b.totalIncome
            balanceLabel.text = Currency.currencyFormatter(totalIncome)
            
            var total = Float(0.0)
            var temp: [Float] = []
            for key in BudgetItemSectionStore.budgetItemSections {
                if let expenses = b.totalExpenses[key.category] {
                    let percentage = Float(expenses / totalIncome)
                    temp.append(percentage)
                    total += percentage
                }
            }
            let rest = 1 - total
            temp.append(rest)
            pieChartView.segments = temp
        }
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
