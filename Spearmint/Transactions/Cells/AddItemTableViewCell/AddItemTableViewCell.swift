//
//  AddItemTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/5/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class AddItemTableViewCell: UITableViewCell, ReusableIdentifier {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension AddItemTableViewCell: ConfigurableCell {
    func configure(object: Transaction) {
    }
    
    func configure() {
    }
}
