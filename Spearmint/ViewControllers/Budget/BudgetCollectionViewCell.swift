//
//  BudgetCollectionViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/10/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetCollectionViewCell: UICollectionViewCell {
    static let xib = "BudgetCollectionViewCell"

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
}
