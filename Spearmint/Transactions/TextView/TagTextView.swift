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
        
        //var tag: Int = 1
        for (index, tag) in tags.enumerated() {

//            let width = tag.size(withAttributes: [NSAttributedString.Key.font: UIFont(name:"verdana", size: 13.0)!])
//            let checkWholeWidth = CGFloat(xPos) + width.width + CGFloat(13.0) + CGFloat(25.5 )//13.0 is the width between lable and cross button and 25.5 is cross button width and gap to righht
//            if checkWholeWidth > UIScreen.main.bounds.size.width - 30.0 {
//                //we are exceeding size need to change xpos
//                xPos = 15.0
//                ypos = ypos + 29.0 + 8.0
//            }
            
            let tagView = createTagView(tag, index)
            self.addSubview(tagView)
        }
        
    }
    
    func createTagView(_ text: String,_ tagNumber: Int) -> UIView {
        let size = text.size(withAttributes: [NSAttributedString.Key.font: UIFont(name:"verdana", size: 13.0)!])

        let tagView = UIView(frame: CGRect(x: position.x, y: position.y, width: size.width + padding * 4 + size.height, height: size.height + padding * 2))
        tagView.layer.cornerRadius = 5
        tagView.backgroundColor = .black
        tagView.tag = tagNumber
        
        let textLabel = UILabel(frame: CGRect(x: padding, y: padding, width: size.width + padding * 2, height: size.height))
        textLabel.font = UIFont(name: "verdana", size: 13.0)
        textLabel.text = text
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.white
        textLabel.layer.masksToBounds = true
        textLabel.layer.cornerRadius = 5
        tagView.addSubview(textLabel)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: padding + size.width + padding * 2, y: padding, width: size.height, height: size.height)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = CGFloat(button.frame.size.width)/CGFloat(2.0)
        button.tag = tagNumber
        button.addTarget(self, action: #selector(removeTag(_:)), for: .touchUpInside)
        tagView.addSubview(button)
        //xPos = CGFloat(xPos) + CGFloat(width) + CGFloat(17.0) + CGFloat(43.0)
        
        position.x += size.width + padding * 4 + size.height + padding + padding
        return tagView
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
