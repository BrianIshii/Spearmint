//
//  BudgetItemView.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/14/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetItemView: UIView {
    @IBOutlet weak var transactionTableView: TransactionTableView!
    
    private var dataSource: TransactionDataSource?
    
    var budgetItem: BudgetItem? {
        didSet {
            guard let budgetItem = budgetItem else { return }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        xibSetup()
        
        dataSource = TransactionDataSource(tableView: transactionTableView)
        transactionTableView.reloadData()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
