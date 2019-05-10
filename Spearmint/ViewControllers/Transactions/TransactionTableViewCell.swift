//
//  TransactionTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/6/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    static let xib = "TransactionTableViewCell"
    
    @IBOutlet weak var transactionAmountLabel: UILabel!
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var transactionVendorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
