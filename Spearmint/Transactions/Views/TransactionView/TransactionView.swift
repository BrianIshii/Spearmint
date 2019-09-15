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
    @IBOutlet weak var editButton: UIButton!
    
    var delegate: TransactionViewDelegate?
    var transactionRepository: TransactionRepository?
    var isEditing: Bool = false
    
    var transaction: Transaction? {
        didSet {
            
            guard let transaction = transaction else { return }
            
            self.transactionTypeSegementedControl.selectedSegmentIndex = transaction.transactionType.rawValue
            self.moneyTextField.text = CurrencyOld.currencyFormatter(transaction.amount)
            guard let vendorAccess = AppDelegate.container.resolve(VendorRepository.self) else { //TODO: remove
                print("failed to resolve \(VendorRepository.self)")
                return
            }
            self.vendorTextField.text = vendorAccess.get(transaction.vendor)?.name ?? "hi"
            self.dateTextField.text = transaction.date.medium
            self.categoryButton.setTitle("Category", for: UIControl.State.normal)
            self.tagTextView.tags = transaction.tags
            self.tagTextView.createTagViews()
            
            self.categoryTextView.budgetItems = Array(transaction.items.keys)
            self.categoryTextView.createCategoryViews()
            self.deleteTransactionButton.isHidden = false
            self.editButton.isHidden = false
            
            
            guard let transactionRepository = AppDelegate.container.resolve(TransactionRepository.self) else { //TODO: remove
                print("failed to resolve \(TransactionRepository.self)")
                return
            }
            
            self.transactionRepository = transactionRepository
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
        self.editButton.setTitle("Edit", for: .normal)
        self.editButton.isHidden = self.transaction == nil
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
            guard let transactionRepository = AppDelegate.container.resolve(TransactionRepository.self) else {
                print("failed to resolve \(TransactionRepository.self)")
                return
            }
            transactionRepository.remove(transaction)
        }
        
        delegate.dismiss()
    }
    
    @IBAction func DidPressEdit(_ sender: UIButton) {
        if isEditing {
            guard let transactionRepository = transactionRepository else { return }
            guard let transaction = transaction else { return }
            disableUserInteraction()
            editButton.setTitle("Edit", for: .normal)
            updateTransaction()
            transactionRepository.update(transaction)
        } else {
            enableUserInteraction()
            editButton.setTitle("Done", for: .normal)
        }
        
        isEditing = !isEditing
    }
    
    func updateTransaction() {
        guard let transaction = transaction else { return }
        guard let vendorAccess = AppDelegate.container.resolve(VendorRepository.self) else {
            print("failed to resolve \(VendorRepository.self)")
            return
        }
        
        transaction.name = ""
        let dateString = self.dateTextField.text!
        transaction.date = TransactionDate(DateFormatterFactory.MediumFormatter.date(from: dateString) ?? Date())
        let vendorString = self.vendorTextField.text!
        transaction.transactionType = self.transactionTypeSegementedControl.selectedSegmentIndex == TransactionType.expense.rawValue ? TransactionType.expense : TransactionType.income
        transaction.amount = CurrencyOld.currencyToFloat(self.moneyTextField.text!)
        transaction.budgetDate = BudgetDate()
        //_ = LocalAccess.Budgets.budgetDictionary[budgetKey]
        transaction.hasImage = false
        
        let vendor: Vendor
        
        if vendorAccess.hasVendor(vendorString) {
            vendor = vendorAccess.get(vendorString)!
        } else {
            vendor = Vendor(name: vendorString)
            vendorAccess.append(vendor)
        }
        transaction.vendor = vendor.id

        
        transaction.tags = self.tagTextView.tags
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
        
        guard let vendorRepository = AppDelegate.container.resolve(VendorRepository.self) else {
            print("failed to resolve \(VendorRepository.self)")
            return
        }
        guard let vendor = vendorRepository.get(suggestion) else { return }
        guard let budgetItemID = vendor.budgetItemID else { return }
        categoryTextView.budgetItems.append(budgetItemID)
        categoryTextView.createCategoryViews()
    }
}
