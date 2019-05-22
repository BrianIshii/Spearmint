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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension BudgetItemTableViewCell: ConfigurableCell {
    func configure(object: BudgetItem) {
        budgetItemName.text = object.name
        progressBar.progress = object.actual / object.planned
        textField.text = String(format: "%.2f", object.planned - object.actual)
    }
    
    func configure() {
        
    }
}

