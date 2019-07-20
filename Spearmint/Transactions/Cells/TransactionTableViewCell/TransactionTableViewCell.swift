//
//  TransactionTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/6/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    static let xib = "TransactionTableViewCell"
    
    @IBOutlet weak var transactionAmountLabel: UILabel!
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var transactionVendorLabel: UILabel!
    @IBOutlet weak var textView: BudgetItemAndTagTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        
        // add corner radius on `contentView`
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TransactionTableViewCell: ConfigurableCell {
    func configure(object: Transaction) {
        
        transactionAmountLabel.text = Currency.currencyFormatter(String(format: "%.2f", object.amount))
        
        switch object.transactionType {
        case .expense:
            transactionAmountLabel.textColor = UIColor.red
        case.income:
            transactionAmountLabel.textColor = UIColor.green
        }
        transactionVendorLabel.text = object.vendor
        transactionDateLabel.text = "\(object.date.threeCharacterMonth) \(object.date.day)"
        
        textView.tags = object.tags
        
        for (k, _) in object.items {
            textView.budgetItems.append(k)
        }
        
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.createViews()
    }
    
    func configure() {
        
    }
}
