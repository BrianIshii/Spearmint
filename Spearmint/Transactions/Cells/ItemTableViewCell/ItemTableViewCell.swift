//
//  ItemTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/12/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    static let xib = "ItemTableViewCell"

    @IBOutlet weak var itemName: UILabel!
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