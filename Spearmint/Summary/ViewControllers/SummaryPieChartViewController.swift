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
    var totalExpenses = Float(0.0)
    var pieChartDataSource: PieChartViewDataSource?
    var budget: Budget?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let pieChartView = pieChartView else { return }

        pieChartDataSource = PieChartViewDataSource(pieChartView)
        update()
        
        LocalAccess.Transactions.observers.append(self)
        //pieChartView.setNeedsDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //pieChartView.setNeedsDisplay()
    }

    private func getColor(_ budgetItemCategory: BudgetItemCategory) -> UIColor {
        switch budgetItemCategory {
        case .income:
            return UIColor.green
        case .giving:
            return UIColor.red
        case .savings:
            return UIColor.orange
        case .housing:
            return UIColor.blue
        case .transportation:
            return UIColor.purple
        case .food:
            return UIColor.magenta
        case .personal:
            return UIColor.yellow
        case .lifestyle:
            return UIColor.cyan
        case .health:
            return UIColor.brown
        case .insurance:
            return UIColor.black
        case .debt:
            return UIColor.lightGray
        case .other:
            return UIColor.darkGray
        }
    }
    
//    private func update() {
//        guard let pieChartDataSource = pieChartDataSource else { return }
//        let budget = BudgetStore.getCurrentBudget()
//        let totalExpenses = budget.totalExpenses
//        for category in budgetSections {
//            if let expenses = totalExpenses[category.category] {
//                if expenses > 0 {
//                    pieChartDataSource.addSegment(PieChartSegment(text: category.category.rawValue, color: getColor(category.category), value: Double(expenses)))
//                }
//            }
//
//        }

        // Do any additional setup after loading the view.
//        if let b = BudgetStore.getBudget(BudgetDate(Date())) {
//            let totalIncome = b.totalIncome
//
//
//            totalExpenses = Float(0.0)
//            var total = Float(0.0)
//            var temp: [Float] = []
//            for key in BudgetItemSectionStore.budgetItemSections {
//                if key.category == BudgetItemCategory.income {
//                    temp.append(0.0)
//                } else {
//                    if let expenses = b.totalExpenses[key.category] {
//                        totalExpenses += expenses
//                        let percentage = Float(expenses / totalIncome)
//                        if percentage.isNaN {
//                            temp.append(0.0)
//                        } else {
//                            temp.append(percentage)
//                            total += percentage
//                        }
//
//                    } else {
//                        temp.append(0.0)
//                    }
//                }
//            }
//            let rest = 1 - total
//            temp.append(rest)
//
//            budgetSections = BudgetItemSectionStore.budgetItemSections
//
//            bottomLabel.text = Currency.currencyFormatter(totalIncome - totalExpenses) + " left"
//            topLabel.text = "Income"
//            pieChartView.segments = temp
//        }
//    }
    
    func changeSection(_ index: Int) {
        guard let pieChartDataSource = pieChartDataSource else { return }
        pieChartDataSource.selectSegment(index)
//        if index < 1 {
//            if let b = budget {
//                bottomLabel.text = Currency.currencyFormatter(b.totalIncome - totalExpenses) + " left"
//            } else {
//                bottomLabel.text = ""
//            }
//
//            topLabel.text = "Income"
//        } else {
//            topLabel.text = budgetSections[index].category.rawValue
//
//            let percent = pieChartView.segments[index]
//            guard !(percent.isNaN || percent.isInfinite) else {
//                bottomLabel.text = "0 %"
//                return // or do some error handling
//            }
//
////            let numPercent = Int(pieChartView.segments[index] * 100)
//            bottomLabel.text = String(format: "%.2f", pieChartView.segments[index] * 100) + "%"
//        }
        //pieChartView.updatePath(index)

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

extension SummaryPieChartViewController: TransactionObserver {
    func update() {
        guard let pieChartDataSource = pieChartDataSource else { return }
        let budget = BudgetStore.getCurrentBudget()
        let totalExpenses = budget.totalExpenses
        var segments: [PieChartSegment] = []

        for category in budgetSections {
            if let expenses = totalExpenses[category.category] {
                if expenses > 0 {
                    segments.append(PieChartSegment(text: category.category.rawValue, color: getColor(category.category), value: Double(expenses)))
                }
            }
        }
        
        pieChartDataSource.setSegments(segments)
    }
}
