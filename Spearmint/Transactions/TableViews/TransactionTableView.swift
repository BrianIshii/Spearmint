//
//  TransactionTableView.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/14/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class TransactionTableView: UITableView {
    var transactionTableViewDelegate: TransactionTableViewDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        self.transactionTableViewDelegate = nil
        super.init(frame: frame, style: style)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.transactionTableViewDelegate = nil
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        self.delegate = self
    }
}

extension TransactionTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let transactionTableViewDelegate = transactionTableViewDelegate else { return }
        
        transactionTableViewDelegate.performSegue(withIdentifier: TransactionSegue.segueIdentifier, sender: nil)
    }
}
