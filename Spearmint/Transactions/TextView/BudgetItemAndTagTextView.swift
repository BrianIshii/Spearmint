//
//  BudgetItemAndTagTextView.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/14/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class BudgetItemAndTagTextView: UITextView {
    let padding: CGFloat = CGFloat(4)
    var position: CGPoint = CGPoint(x: 0, y: 0)
    var budgetItems: [BudgetItemID] = []
    var tags: [String] = []
    var count: Int = 1

    func createViews() {
        for tempView in subviews {
            tempView.removeFromSuperview()
        }
        
        position.x = padding
        position.y = padding
        
        for (index, budgetItemID) in budgetItems.enumerated() {
            if let budgetItem = LocalAccess.budgetItemStore.getBudgetItem(budgetItemID) {
                let budgetItemView = createBudgetItemView(budgetItem.name, index)
                self.addSubview(budgetItemView)
            }
        }
        
        for (index, tag) in tags.enumerated() {
            let tagView = createTagView(tag, index)
            self.addSubview(tagView)
        }
    }
    
    func createTagView(_ text: String,_ tagNumber: Int) -> UIView {
        var backgroundColor = UIColor.black
        if let tag = LocalAccess.Tags.get(TagID(text)) {
            backgroundColor = tag.color.uiColor
        }
        
        let padding = TagTextView.padding
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
        tagView.backgroundColor = backgroundColor
        tagView.tag = tagNumber
        
        let textLabel = UILabel(frame: CGRect(x: padding, y: padding, width: tagLabelWidth, height: tagLabelHeight))
        //let selectTag = UITapGestureRecognizer(target: self, action: #selector(selectTag(_:)))
        //selectTag.accessibilityLabel = text
        textLabel.font = UIFont(name: "verdana", size: 13.0)
        textLabel.text = text
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.white
        textLabel.layer.masksToBounds = true
        textLabel.layer.cornerRadius = 5
        textLabel.isUserInteractionEnabled = true
        //textLabel.addGestureRecognizer(selectTag)
        tagView.addSubview(textLabel)
        
        if self.isEditable {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: tagLabelWidth + padding, y: padding, width: tagButtonWidth, height: tagButtonHeight)
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = CGFloat(button.frame.size.width)/CGFloat(2.0)
            button.tag = tagNumber
            //button.addTarget(self, action: #selector(removeTag(_:)), for: .touchUpInside)
            tagView.addSubview(button)
        }
        
        position.x += tagViewWidth + padding
        return tagView
    }
    
    func createBudgetItemView(_ text: String,_ budgetItemNumber: Int) -> UIView {
        var backgroundColor = UIColor.black
        
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
        //let selectBudgetItem = UITapGestureRecognizer(target: self, action: #selector(selectBudgetItem(_:)))
        //selectBudgetItem.accessibilityLabel = text
        textLabel.font = UIFont(name: "verdana", size: 13.0)
        textLabel.text = text
        textLabel.textAlignment = .center
        textLabel.textColor = backgroundColor
        textLabel.layer.masksToBounds = true
        textLabel.layer.cornerRadius = 5
        textLabel.isUserInteractionEnabled = true
        //textLabel.addGestureRecognizer(selectBudgetItem)
        budgetItemView.addSubview(textLabel)
        
        if self.isEditable {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: budgetItemLabelWidth + padding, y: padding, width: budgetItemButtonWidth, height: budgetItemButtonHeight)
            button.backgroundColor = backgroundColor
            button.layer.cornerRadius = CGFloat(button.frame.size.width)/CGFloat(2.0)
            button.tag = budgetItemNumber
            //button.addTarget(self, action: #selector(removeBudgetItem(_:)), for: .touchUpInside)
            budgetItemView.addSubview(button)
        }
        
        position.x += budgetItemViewWidth + padding
        return budgetItemView
    }
}
