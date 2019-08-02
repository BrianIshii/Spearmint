//
//  SuggestionsView.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/29/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class SuggestionsView: UIView {
    var leftItem: UIButton!
    var middleItem: UIButton!
    var rightItem: UIButton!

    var delegate: SuggestionViewDelegate?
    
    var suggestions: [Suggestion]
    
    override init(frame: CGRect) {
        suggestions = []
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        suggestions = []
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        
        leftItem = UIButton()
        leftItem.addTarget(self, action: #selector(self.clickedLeftSuggestion), for: UIControl.Event.touchUpInside)
        leftItem.backgroundColor = .blue
        
        middleItem = UIButton()
        middleItem.addTarget(self, action: #selector(self.clickedMiddleSuggestion), for: UIControl.Event.touchUpInside)
        middleItem.backgroundColor = .red

        rightItem = UIButton()
        rightItem.addTarget(self, action: #selector(self.clickedRightSuggestion), for: UIControl.Event.touchUpInside)
        rightItem.backgroundColor = .white

        self.addSubview(leftItem)
        leftItem.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(middleItem)
        middleItem.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(rightItem)
        rightItem.translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }
    
    private func setConstraints() {
        self.addConstraints([
            NSLayoutConstraint(item: leftItem, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: middleItem, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightItem, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: leftItem, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: middleItem, attribute: .leading, relatedBy: .equal, toItem: leftItem, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightItem, attribute: .leading, relatedBy: .equal, toItem: middleItem, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightItem, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: leftItem, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: middleItem, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightItem, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: leftItem, attribute: .width, relatedBy: .equal, toItem: middleItem, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: middleItem, attribute: .width, relatedBy: .equal, toItem: rightItem, attribute: .width, multiplier: 1, constant: 0),
            ])
        self.updateConstraints()
    }
    
    @objc func clickedLeftSuggestion() {
        guard let delegate = delegate else { return }
        
        delegate.addSuggestion(leftItem.titleLabel?.text ?? "")
    }
    
    @objc func clickedMiddleSuggestion() {
        guard let delegate = delegate else { return }

        delegate.addSuggestion(middleItem.titleLabel?.text ?? "")
    }
    
    @objc func clickedRightSuggestion() {
        guard let delegate = delegate else { return }

        delegate.addSuggestion(middleItem.titleLabel?.text ?? "")
    }
    
    func addSuggestions(_ suggestions: [Suggestion]) {
        var suggestions = suggestions
        
        while suggestions.count < 3 {
            suggestions.append(Suggestion(text: ""))
        }
        
        self.suggestions = suggestions
        
        setItem(item: leftItem, suggestion: suggestions[0])
        setItem(item: middleItem, suggestion: suggestions[1])
        setItem(item: rightItem, suggestion: suggestions[2])
    }
    
    func setItem(item: UIButton, suggestion: Suggestion) {
        item.titleLabel?.text = suggestion.text
        if let textColor = suggestion.textColor {
            item.tintColor = textColor
        }
        if let backgroundColor = suggestion.backgroundColor {
            item.backgroundColor = backgroundColor
        }
    }
    
    func clearSuggestions() {
        suggestions = []
        leftItem.titleLabel?.text = ""
        middleItem.titleLabel?.text = ""
        rightItem.titleLabel?.text = ""
    }
}
