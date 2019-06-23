//
//  AmountTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/7/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class AmountTableViewCell: UITableViewCell, ReusableIdentifier {
    static let xib = "AmountTableViewCell"

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: MoneyTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension AmountTableViewCell: ConfigurableCell {
    func configure(object: Transaction) {
        textField.text = Currency.currencyFormatter(object.amount)
    }
    
    func configure() {
    }
}
