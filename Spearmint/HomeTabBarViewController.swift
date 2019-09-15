//
//  HomeTabBarViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 9/15/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let transactionListViewController = TransactionListViewController()
        transactionListViewController.tabBarItem = UITabBarItem(title: "Transactions", image: UIImage(contentsOfFile: "round_receipt_white_36pt"), tag: 0)
        let budgetViewController = BudgetViewController()
        let summaryViewController = MasterSummaryViewController()
        let analysisViewController = AnalysisViewController()
        let accountViewController = AccountViewController()
        
        let tabBarList = [transactionListViewController,
                          budgetViewController,
                          summaryViewController,
                          analysisViewController,
                          accountViewController]
        
        self.viewControllers = tabBarList
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
