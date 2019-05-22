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

        pieChartView.segments = [0.2, 0.4, 0.3, 0.1]
        // Do any additional setup after loading the view.
        if let b = budget {
            balanceLabel.text = Currency.currencyFormatter(b.totalIncome)
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
