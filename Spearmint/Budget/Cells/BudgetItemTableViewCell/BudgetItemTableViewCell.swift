//
//  BudgetItemTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/10/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetItemTableViewCell: UITableViewCell, ReusableIdentifier {
    static let xib = "BudgetItemTableViewCell"

    @IBOutlet weak var budgetItemName: UILabel!
    @IBOutlet weak var textField: MoneyTextField!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension BudgetItemTableViewCell: ConfigurableCell {
    func configure(object: BudgetItem) {
        budgetItemName.text = object.name
        if object.actual > object.planned {
            progressBar.progress = 1
            progressBar.progressTintColor = .red
            textField.text = "-" + Currency.currencyFormatter(object.planned - object.actual) + " left"
            textField.textColor = .red
        } else {
            progressBar.progress = object.actual / object.planned
            progressBar.progressTintColor = .blue
            textField.text = Currency.currencyFormatter(object.planned - object.actual) + " left"
            textField.textColor = .black

        }

    }
    
    func configure() {
        
    }
}

