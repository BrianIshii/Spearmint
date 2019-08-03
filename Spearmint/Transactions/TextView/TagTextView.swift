//
//  TagTextView.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/13/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class TagTextView: UITextView {
    static let padding: CGFloat = CGFloat(4)
    
    var tags: [String] = []
    var position: CGPoint = CGPoint(x: 0, y: 0)
    var tagCount: Int = 1
    
    var view: SuggestionsView
    var tagTextViewDelegate: TagTextViewDelegate?
    
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

        view.delegate = self
        self.inputAccessoryView = view
        
        self.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        self.layer.cornerRadius = 5
    }
    
    func createTagViews() {
        for tempView in subviews {
            tempView.removeFromSuperview()
        }
        
        let padding = TagTextView.padding
        
        position.x = padding
        position.y = padding
        
        for (index, tag) in tags.enumerated() {
            let tagView = createTagView(tag, index)
            //let tagView = TagView.createTagView(text: tag, tagNumber: index, position: position, isEditable: self.isEditable, selectTag: #selector(selectTag(_:)), removeTag: #selector(removeTag(_:)))
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
        let selectTag = UITapGestureRecognizer(target: self, action: #selector(selectTag(_:)))
        selectTag.accessibilityLabel = text
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
    
    @objc func selectTag(_ sender: UIGestureRecognizer) {
        guard let tagTextViewDelegate = tagTextViewDelegate else { return }
        guard let text = sender.accessibilityLabel else { return }
        
        tagTextViewDelegate.presentTagView(tag: text)
    }
    
    @objc func removeTag(_ sender: AnyObject) {
        tags.remove(at: sender.tag)
        tagCount -= 1
        createTagViews()
    }
}

extension TagTextView: SuggestionViewDelegate {
    func addSuggestion(_ suggestion: String) {
        if suggestion.count > 0 {
            self.tags[tagCount - 1] = suggestion
            createTagViews()
            view.clearSuggestions()
            self.tags.append(self.text)
            self.text = ""
            tagCount += 1
        }
    }
}

extension TagTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text ?? "")
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
            tagCount += 1
        } else if text == "" {
            if self.tags[tagCount - 1].count == 0 {
                self.tags.remove(at: tagCount - 1)
                tagCount -= 1
                createTagViews()
                return false
            }
            
            let string = self.tags[tagCount - 1].prefix(self.tags[tagCount - 1].count - 1)
            self.tags[tagCount - 1] = String(string)
        } else {
            self.tags[tagCount - 1] += text
        }
        
        if self.tags.count > 0 {
            let suggestions = LocalAccess.queryTags(self.tags[self.tags.count - 1])
            view.addSuggestions(suggestions.map({ Suggestion(text: $0.text) }))
        }
        
        createTagViews()
        return false
    }
}
