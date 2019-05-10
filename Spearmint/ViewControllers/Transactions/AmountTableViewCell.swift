//
//  AmountTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/7/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class AmountTableViewCell: UITableViewCell, UITextFieldDelegate {
    static let xib = "AmountTableViewCell"

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        textField.delegate = self
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.text = Currency.currencyFormatter(total: textField.text!)
    }

}
