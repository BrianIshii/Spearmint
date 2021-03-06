//
//  CategoryTextView.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/13/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetItemTextView: UITextView {
    let padding: CGFloat = CGFloat(4)
    var position: CGPoint = CGPoint(x: 0, y: 0)
    var budgetItems: [BudgetItemID] = []
    var budgetItemCount: Int = 1
    
    var budgetItemTextViewDelegate: BudgetItemTextViewDelegate?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    private func setUp() {
        self.autocorrectionType = .no
        
        
        self.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        self.layer.cornerRadius = 5
    }
    
    func createCategoryViews() {
        for tempView in subviews {
            tempView.removeFromSuperview()
        }
        
        position.x = padding
        position.y = padding
        
        guard let budgetItemRepository = AppDelegate.container.resolve(BudgetItemRepository.self) else {
            print("failed to resolve \(BudgetItemRepository.self)")
            return
        }
        for (index, budgetItemID) in budgetItems.enumerated() {
            if let budgetItem = budgetItemRepository.get(budgetItemID) {
                let budgetItemView = createBudgetItemView(budgetItem.name, index)
                self.addSubview(budgetItemView)
            }
        }
    }
    
    func createBudgetItemView(_ text: String,_ budgetItemNumber: Int) -> UIView {
        let backgroundColor = UIColor.black
        
        let size = text.size(withAttributes: [NSAttributedString.Key.font: UIFont(name:"verdana", size: 13.0)!])
        let width = padding + padding + size.width + padding + padding
        let budgetItemViewWidth = self.isEditable ? width + size.height + padding : width
        let budgetItemViewHeight =  padding + size.height + padding
        let budgetItemLabelWidth = padding + size.width + padding
        let budgetItemLabelHeight = size.height
        let budgetItemButtonWidth = size.height
        let budgetItemButtonHeight = size.height
        
        let budgetItemView = UIView(frame: CGRect(x: position.x, y: position.y, width: budgetItemViewWidth, height: budgetItemViewHeight))
        budgetItemView.layer.cornerRadius = 5
        budgetItemView.backgroundColor = .white
        budgetItemView.layer.borderColor = backgroundColor.cgColor
        budgetItemView.layer.borderWidth = 2
        budgetItemView.tag = budgetItemNumber
        
        let textLabel = UILabel(frame: CGRect(x: padding, y: padding, width: budgetItemLabelWidth, height: budgetItemLabelHeight))
        let selectBudgetItem = UITapGestureRecognizer(target: self, action: #selector(selectBudgetItem(_:)))
        selectBudgetItem.accessibilityLabel = text
        textLabel.font = UIFont(name: "verdana", size: 13.0)
        textLabel.text = text
        textLabel.textAlignment = .center
        textLabel.textColor = backgroundColor
        textLabel.layer.masksToBounds = true
        textLabel.layer.cornerRadius = 5
        textLabel.isUserInteractionEnabled = true
        textLabel.addGestureRecognizer(selectBudgetItem)
        budgetItemView.addSubview(textLabel)
        
        if self.isEditable {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: budgetItemLabelWidth + padding, y: padding, width: budgetItemButtonWidth, height: budgetItemButtonHeight)
            button.backgroundColor = backgroundColor
            button.layer.cornerRadius = CGFloat(button.frame.size.width)/CGFloat(2.0)
            button.tag = budgetItemNumber
            button.addTarget(self, action: #selector(removeBudgetItem(_:)), for: .touchUpInside)
            budgetItemView.addSubview(button)
        }
        
        position.x += budgetItemViewWidth + padding
        return budgetItemView
    }
    
    @objc func selectBudgetItem(_ sender: UIGestureRecognizer) {
        guard let categoryTextViewDelegate = budgetItemTextViewDelegate else { return }
        guard let _ = sender.accessibilityLabel else { return }
        
        categoryTextViewDelegate.presentBudgetItem()
    }
    
    @objc func removeBudgetItem(_ sender: AnyObject) {
        budgetItems.remove(at: sender.tag)
        createCategoryViews()
    }
}
