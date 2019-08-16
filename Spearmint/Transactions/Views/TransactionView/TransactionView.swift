//
//  TransactionView.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/6/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class TransactionView: UIView {
    @IBOutlet weak var transactionTypeSegementedControl: TransactionTypeSegmentedControl!
    @IBOutlet weak var moneyTextField: MoneyTextField!
    @IBOutlet weak var vendorTextField: VendorTextField!
    @IBOutlet weak var dateTextField: DateTextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var categoryTextView: BudgetItemTextView!
    @IBOutlet weak var tagTextView: TagTextView!
    @IBOutlet weak var deleteTransactionButton: UIButton!
    @IBOutlet weak var tagTextViewHeight: NSLayoutConstraint!
    
    var delegate: TransactionViewDelegate?
    
    var transaction: Transaction? {
        didSet {
            
            guard let transaction = transaction else { return }
            
            self.transactionTypeSegementedControl.selectedSegmentIndex = transaction.transactionType.rawValue
            self.moneyTextField.text = Currency.currencyFormatter(transaction.amount)
            self.vendorTextField.text = LocalAccess.getVendor(transaction.vendor)?.name ?? "hi"
            self.dateTextField.text = transaction.date.medium
            self.categoryButton.setTitle("Category", for: UIControl.State.normal)
            self.tagTextView.tags = transaction.tags
            self.tagTextView.createTagViews()
            
            self.categoryTextView.budgetItems = Array(transaction.items.keys)
            self.categoryTextView.createCategoryViews()
            self.deleteTransactionButton.isHidden = false
        }
    }
    
    var tags: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        xibSetup()
        self.subviews.first?.layer.cornerRadius = 10
        self.subviews.first?.backgroundColor = UIColor.init(red: 253, green: 245, blue: 232, alpha: 1)
        
        self.subviews.first?.layer.shadowOpacity = 0.43
        self.subviews.first?.layer.shadowRadius = 4
        self.subviews.first?.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.subviews.first?.layer.shadowColor = UIColor.black.cgColor
        
        self.vendorTextField.suggestionViewDelegate = self
        
        self.deleteTransactionButton.isHidden = true
        self.tagTextView.tagTextViewDelegate = self
        tagTextViewHeight.constant = (TagTextView.padding +
                                        TagTextView.padding +
            " ".size(withAttributes: [NSAttributedString.Key.font: UIFont(name:"verdana", size: 13.0)!]).height +
                                        TagTextView.padding +
                                        TagTextView.padding)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("awake")
    }
    
    func disableUserInteraction() {
        transactionTypeSegementedControl.isUserInteractionEnabled = false
        moneyTextField.isUserInteractionEnabled = false
        vendorTextField.isUserInteractionEnabled = false
        dateTextField.isUserInteractionEnabled = false
        categoryButton.isUserInteractionEnabled = false
        tagTextView.isUserInteractionEnabled = true
        tagTextView.isEditable = false
        categoryTextView.isUserInteractionEnabled = true
        categoryTextView.isEditable = false
    }
    
    func enableUserInteraction() {
        transactionTypeSegementedControl.isUserInteractionEnabled = true
        moneyTextField.isUserInteractionEnabled = true
        vendorTextField.isUserInteractionEnabled = true
        dateTextField.isUserInteractionEnabled = true
        categoryButton.isUserInteractionEnabled = true
        tagTextView.isUserInteractionEnabled = true
        tagTextView.isEditable = true
        categoryTextView.isUserInteractionEnabled = true
        categoryTextView.isEditable = true

    }
    @IBAction func CancelButton(_ sender: Any) {
        guard let delegate = delegate else { return }

        delegate.dismiss()
    }
    
    @IBAction func selectCategory(_ sender: UIButton) {
        guard let delegate = delegate else { return }
        
        delegate.didSelectCategoryButton()
    }

    @IBAction func deleteTransaction(_ sender: UIButton) {
        guard let delegate = delegate else { return }
        
        if let transaction = transaction {
            LocalAccess.deleteTransaction(transaction)
        }
        
        delegate.dismiss()
    }
}

extension TransactionView: TagTextViewDelegate {
    func presentTagView(tag: String) {
        guard let delegate = delegate else { return }

        delegate.didSelectTag(text: tag)
    }
}

extension TransactionView: SuggestionViewDelegate {
    func addSuggestion(_ suggestion: String) {
        
        vendorTextField.text = suggestion
        vendorTextField.resignFirstResponder()
        
        guard let vendor = LocalAccess.getVendor(suggestion) else { return }
        guard let budgetItemID = vendor.budgetItemID else { return }
        categoryTextView.budgetItems.append(budgetItemID)
        categoryTextView.createCategoryViews()
    }
}
