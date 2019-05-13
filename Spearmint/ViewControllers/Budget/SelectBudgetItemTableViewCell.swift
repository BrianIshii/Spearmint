//
//  SelectBudgetItemTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/12/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class SelectBudgetItemTableViewCell: UITableViewCell {
    static let xib = "SelectBudgetItemTableViewCell"
    static let reuseIdentifier = "selectBudgetItemCell"
    
    @IBOutlet weak var budgetItemName: UILabel!
    @IBOutlet weak var textField: MoneyTextField!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
