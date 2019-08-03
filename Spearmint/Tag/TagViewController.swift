//
//  TagViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/13/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class TagViewController: UIViewController {
    @IBOutlet weak var transactionTableView: TransactionTableView!
    
    var tag: Tag?
    var dataSource: TransactionDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let tag = tag else { return }
        
        let transactions = tag.transactionIDs.map({ LocalAccess.Transactions.get($0)! })
        dataSource = TransactionDataSource(tableView: transactionTableView)
        
        guard let dataSource = dataSource else { return }
        
        dataSource.transactions = transactions
        transactionTableView.reloadData()
    }
    
    @IBAction func tempDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
