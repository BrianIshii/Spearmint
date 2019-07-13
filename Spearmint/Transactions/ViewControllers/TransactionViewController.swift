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
        
        self.view.backgroundColor = .clear
        self.view.isOpaque = false
        transactionView.layer.cornerRadius = 10
        transactionView.disableUserInteraction()
        transactionView.delegate = self
        
        guard let transaction = transaction else { return }
        
        transactionView.transaction = transaction
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

extension TransactionViewController: TransactionViewDelegate {
    func didSelectCategoryButton() {
        let _ = UIStoryboardSegue.init(identifier: AddBudgetItemSegue.segueIdentifier, source: self, destination: AddBudgetItemsViewController())
        
        performSegue(withIdentifier: AddBudgetItemSegue.segueIdentifier, sender: nil)
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
