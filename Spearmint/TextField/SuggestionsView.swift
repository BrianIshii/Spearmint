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

    weak var textField: VendorTextField?
    
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
        if let tf = textField {
            tf.text = leftItem.title
            let _ = tf.textFieldShouldReturn(tf)
        }
    }
    
    @objc func clickedMiddleSuggestion() {
        if let tf = textField {
            tf.text = middleItem.title
            let _ = tf.textFieldShouldReturn(tf)
        }
    }
    
    @objc func clickedRightSuggestion() {
        if let tf = textField {
            tf.text = rightItem.title
            let _ =  tf.textFieldShouldReturn(tf)
        }
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
    
    func update() {
        leftItem.title = "yooo"
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
