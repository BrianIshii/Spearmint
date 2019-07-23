//
//  SuggestionsView.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/29/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class SuggestionsView: UIView {
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var leftItem: UIBarButtonItem!
    @IBOutlet weak var middleItem: UIBarButtonItem!
    @IBOutlet weak var rightItem: UIBarButtonItem!

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
        let newToolBar = UIToolbar()
        newToolBar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let b1 = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.clickedLeftSuggestion))
        let b2 = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(self.clickedMiddleSuggestion))
        let b3 = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(self.clickedRightSuggestion))
        newToolBar.setItems([b1, flexSpace, b2, flexSpace, b3], animated: false)
        
        toolBar = newToolBar
        leftItem = b1
        middleItem = b2
        rightItem = b3
        self.addSubview(newToolBar)
    }
    
    @objc func clickedLeftSuggestion() {
        guard let delegate = delegate else { return }
        
        delegate.addSuggestion(leftItem.title ?? "")
    }
    
    @objc func clickedMiddleSuggestion() {
        guard let delegate = delegate else { return }

        delegate.addSuggestion(middleItem.title ?? "")
    }
    
    @objc func clickedRightSuggestion() {
        guard let delegate = delegate else { return }

        delegate.addSuggestion(middleItem.title ?? "")
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
    
    func setItem(item: UIBarButtonItem, suggestion: Suggestion) {
        item.title = suggestion.text
        if let textColor = suggestion.textColor {
            item.tintColor = textColor
        }
    }
    
    func clearSuggestions() {
        suggestions = []
        leftItem.title = ""
        middleItem.title = ""
        rightItem.title = ""
    }
}
