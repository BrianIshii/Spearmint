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
        
        for (index, budgetItemID) in budgetItems.enumerated() {
            if let budgetItem = LocalAccess.budgetItemStore.getBudgetItem(budgetItemID) {
                let tagView = createCategoryView(budgetItem.name, index)
                self.addSubview(tagView)
            }
        }
    }
    
    func createCategoryView(_ text: String,_ tagNumber: Int) -> UIView {
        var backgroundColor = UIColor.black
        if let tag = LocalAccess.Tags.getTag(text) {
            backgroundColor = tag.color.uiColor
        }
        
        let size = text.size(withAttributes: [NSAttributedString.Key.font: UIFont(name:"verdana", size: 13.0)!])
        let width = padding + padding + size.width + padding + padding
        let tagViewWidth = self.isEditable ? width + size.height + padding : width
        let tagViewHeight =  padding + size.height + padding
        let tagLabelWidth = padding + size.width + padding
        let tagLabelHeight = size.height
        let tagButtonWidth = size.height
        let tagButtonHeight = size.height
        
        let tagView = UIView(frame: CGRect(x: position.x, y: position.y, width: tagViewWidth, height: tagViewHeight))
        tagView.layer.cornerRadius = 5
        tagView.backgroundColor = .white
        tagView.layer.borderColor = backgroundColor.cgColor
        tagView.layer.borderWidth = 2
        tagView.tag = tagNumber
        
        let textLabel = UILabel(frame: CGRect(x: padding, y: padding, width: tagLabelWidth, height: tagLabelHeight))
        let selectTag = UITapGestureRecognizer(target: self, action: #selector(selectBudgetItem(_:)))
        selectTag.accessibilityLabel = text
        textLabel.font = UIFont(name: "verdana", size: 13.0)
        textLabel.text = text
        textLabel.textAlignment = .center
        textLabel.textColor = backgroundColor
        textLabel.layer.masksToBounds = true
        textLabel.layer.cornerRadius = 5
        textLabel.isUserInteractionEnabled = true
        textLabel.addGestureRecognizer(selectTag)
        tagView.addSubview(textLabel)
        
        if self.isEditable {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: tagLabelWidth + padding, y: padding, width: tagButtonWidth, height: tagButtonHeight)
            button.backgroundColor = backgroundColor
            button.layer.cornerRadius = CGFloat(button.frame.size.width)/CGFloat(2.0)
            button.tag = tagNumber
            button.addTarget(self, action: #selector(removeBudgetItem(_:)), for: .touchUpInside)
            tagView.addSubview(button)
        }
        
        position.x += tagViewWidth + padding
        return tagView
    }
    
    @objc func selectBudgetItem(_ sender: UIGestureRecognizer) {
        guard let categoryTextViewDelegate = budgetItemTextViewDelegate else { return }
        guard let text = sender.accessibilityLabel else { return }
        
        categoryTextViewDelegate.presentCategory()
    }
    
    @objc func removeBudgetItem(_ sender: AnyObject) {
        budgetItems.remove(at: sender.tag)
        createCategoryViews()
    }
}
