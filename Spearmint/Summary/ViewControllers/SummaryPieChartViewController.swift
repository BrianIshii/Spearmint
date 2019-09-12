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
        
        guard let transactionRepository = AppDelegate.container.resolve(TransactionRepository.self) else {
            print("failed to resolve \(TransactionRepository.self)")
            return
        }
        transactionRepository.addTransactionObserver(self)
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
    
    func changeSection(_ index: Int) {
        guard let pieChartDataSource = pieChartDataSource else { return }
        pieChartDataSource.selectSegment(index)
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
        guard let budgetRepository = AppDelegate.container.resolve(BudgetRepository.self) else {
            print("failed to resolve \(BudgetRepository.self)")
            return
        }
        let currentBudget = budgetRepository.getCurrentBudget()
        let totalExpenses = currentBudget.totalExpenses
        
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
