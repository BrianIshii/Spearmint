//
//  TransactionViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/6/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {

    var transaction: Transaction?
    
    @IBOutlet weak var transactionView: TransactionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactionView.layer.cornerRadius = 10
        
        transactionView.disableUserInteraction()
        guard let transaction = transaction else { return }
        
        transactionView.transactionTypeSegementedControl.selectedSegmentIndex = transaction.transactionType.rawValue
        transactionView.moneyTextField.text = Currency.currencyFormatter(transaction.amount)
        transactionView.vendorTextField.text = transaction.vendor
        transactionView.dateTextField.text = transaction.date
        transactionView.categoryButton.setTitle(transaction.items.keys.first, for: UIControl.State.normal)

        self.view.backgroundColor = .clear
        self.view.isOpaque = false

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
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
