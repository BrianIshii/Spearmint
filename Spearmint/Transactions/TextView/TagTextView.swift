//
//  TagTextView.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/13/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class TagTextView: UITextView {
    let padding: CGFloat = CGFloat(4)
    var tags: [String] = []
    var position: CGPoint = CGPoint(x: 0, y: 0)
    var view: SuggestionsView
    var tagCount: Int = 1
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        self.view = SuggestionsView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 45))
        super.init(frame: frame, textContainer: textContainer)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.view = SuggestionsView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 45))
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    private func setUp() {
        self.delegate = self
        self.autocorrectionType = .no
        
        view.textField = self
        self.inputAccessoryView = view
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func createTagViews() {
        for tempView in subviews {
            tempView.removeFromSuperview()
        }
        
        position.x = padding
        position.y = padding
        
        for (index, tag) in tags.enumerated() {
            let tagView = createTagView(tag, index)
            self.addSubview(tagView)
        }
    }
    
    func createTagView(_ text: String,_ tagNumber: Int) -> UIView {
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
        tagView.backgroundColor = .black
        tagView.tag = tagNumber
        
        let selectTag = UITapGestureRecognizer(target: self, action: #selector(selectTag(_:)))
        let textLabel = UILabel(frame: CGRect(x: padding, y: padding, width: tagLabelWidth, height: tagLabelHeight))
        textLabel.font = UIFont(name: "verdana", size: 13.0)
        textLabel.text = text
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.white
        textLabel.layer.masksToBounds = true
        textLabel.layer.cornerRadius = 5
        textLabel.isUserInteractionEnabled = true
        textLabel.addGestureRecognizer(selectTag)
        tagView.addSubview(textLabel)
        
        if self.isEditable {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: tagLabelWidth + padding, y: padding, width: tagButtonWidth, height: tagButtonHeight)
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = CGFloat(button.frame.size.width)/CGFloat(2.0)
            button.tag = tagNumber
            button.addTarget(self, action: #selector(removeTag(_:)), for: .touchUpInside)
            tagView.addSubview(button)
        }
        
        position.x += tagViewWidth + padding
        return tagView
    }
    
    @objc func selectTag(_ sender: AnyObject) {
        print("Select tag")
    }
    
    @objc func removeTag(_ sender: AnyObject) {
        tags.remove(at: sender.tag)
        tagCount -= 1
        createTagViews()
    }
}

extension TagTextView: SuggestionViewDelegate {
    func addSuggestion(_ suggestion: String) {
        return
    }
}

extension TagTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if tagCount < 1 {
            tagCount = 1
        }
        
        while self.tags.count < tagCount {
            self.tags.append(self.text)
        }
        
        if text == "\n" {
            self.resignFirstResponder()
            return false
        }
        
        if text == " " {
            self.tags.append(self.text)
            self.text = ""
            createTagViews()
            tagCount += 1
            return false
        }
        
        self.tags[tagCount - 1] += text
        createTagViews()
        return false
    }
}
