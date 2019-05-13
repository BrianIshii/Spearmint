//
//  TransactionBudgetItemTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/11/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class AddTransactionBudgetItemTableViewCell: UITableViewCell {
    static let xib = "AddTransactionBudgetItemTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    @IBAction func selectBudgetItem(_ sender: UIButton) {
//        print("hi")
//
//    }
}
