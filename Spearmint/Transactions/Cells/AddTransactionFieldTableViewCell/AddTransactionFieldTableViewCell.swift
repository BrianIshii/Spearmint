//
//  AddTransactionFieldTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/30/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class AddTransactionFieldTableViewCell: UITableViewCell, ReusableIdentifier {
    @IBOutlet weak var field: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension AddTransactionFieldTableViewCell: ConfigurableCell {
    func configure(object: String) {
        field.text = object
    }
    
    func configure() {
    }
}
