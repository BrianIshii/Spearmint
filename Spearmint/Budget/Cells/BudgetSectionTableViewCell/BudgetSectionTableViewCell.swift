//
//  BudgetSectionTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/12/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetSectionTableViewCell: UITableViewCell {
    static let xib = "BudgetSectionTableViewCell"
    static let reuseIdentifier = "budgetSectionCell"
    
    @IBOutlet weak var budgetCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override var showsReorderControl: Bool {
        get {
            return true // short-circuit to on
        }
        set { }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing == false {
            return // ignore any attempts to turn it off
        }
        
        super.setEditing(editing, animated: animated)
    }
}
