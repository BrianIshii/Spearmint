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
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    var budgetSections: [BudgetItemSection] = BudgetItemSectionStore.budgetItemSections

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
            bottomLabel.text = Currency.currencyFormatter(totalIncome)
            topLabel.text = "Income"

            var total = Float(0.0)
            var temp: [Float] = []
            for key in BudgetItemSectionStore.budgetItemSections {
                if key.category == BudgetItemCategory.income {
                    temp.append(0.0)
                } else {
                    if let expenses = b.totalExpenses[key.category] {
                        let percentage = Float(expenses / totalIncome)
                        temp.append(percentage)
                        total += percentage
                    } else {
                        temp.append(0.0)
                    }
                }
            }
            let rest = 1 - total
            temp.append(rest)
            pieChartView.segments = temp
        }
    }
    
    func changeSection(_ index: Int) {
        if index < 1 {
            if let b = budget {
                bottomLabel.text = Currency.currencyFormatter(b.totalIncome)
            } else {
                bottomLabel.text = ""
            }
            
            topLabel.text = "Income"
        } else {
            topLabel.text = budgetSections[index].category.rawValue
            let numPercent = Int(pieChartView.segments[index] * 100)
            bottomLabel.text = "\(numPercent.description) %"
        }
        pieChartView.updatePath(index)

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
