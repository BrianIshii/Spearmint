//
//  ItemTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/12/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell, ReusableIdentifier {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textField: MoneyTextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameTextField.placeholder = "name"
        nameTextField.delegate = self
        textField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension ItemTableViewCell: ConfigurableCell {
    func configure(object: Item) {
        if object.amount > 0 {
            textField.text = Currency.currencyFormatter(object.amount)
        }
        
        if object.name != "" {
            nameTextField.text = object.name
        }
    }
    
    func configure() {
    }
}

extension ItemTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
