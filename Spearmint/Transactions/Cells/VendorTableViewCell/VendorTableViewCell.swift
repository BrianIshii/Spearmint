//
//  VendorTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/7/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class VendorTableViewCell: UITableViewCell, ReusableIdentifier {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: VendorTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension VendorTableViewCell: ConfigurableCell {
    func configure(object: Transaction) {
    }
    
    func configure() {
    }
}
