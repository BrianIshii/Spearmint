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

    var textField: SuggestionViewDelegate?
    
    var suggestions: [String]
    
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
        guard let textField = textField else { return }
        
        textField.addSuggestion(leftItem.title ?? "")
    }
    
    @objc func clickedMiddleSuggestion() {
        guard let textField = textField else { return }

        textField.addSuggestion(middleItem.title ?? "")
    }
    
    @objc func clickedRightSuggestion() {
        guard let textField = textField else { return }

        textField.addSuggestion(middleItem.title ?? "")
    }
    
    func addSuggestions(_ suggestions: [String]) {
        var suggestions = suggestions
        
        while suggestions.count < 3 {
            suggestions.append("")
        }
        
        leftItem.title = suggestions[0]
        middleItem.title = suggestions[1]
        rightItem.title = suggestions[2]
        
    }
}
