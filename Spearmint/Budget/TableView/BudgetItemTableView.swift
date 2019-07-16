//
//  BudgetItemTableView.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/14/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetItemTableView: UITableView {

    var budgetItemTableViewDelegate: BudgetItemTableViewDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        self.budgetItemTableViewDelegate = nil
        super.init(frame: frame, style: style)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.budgetItemTableViewDelegate = nil
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        self.delegate = self
    }
}

extension BudgetItemTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let budgetItemTableViewDelegate = budgetItemTableViewDelegate else { return }
        
        budgetItemTableViewDelegate.performSegue(withIdentifier: BudgetItemSegue.SegueIdentifier, sender: nil)
    }
}
