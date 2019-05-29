//
//  VendorTextField.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/29/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class VendorTextField: UITextField, UITextFieldDelegate {
    var view: SuggestionsView
    
    override init(frame: CGRect) {
        view = SuggestionsView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 45))
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        view = SuggestionsView(frame: CGRect(x: 0, y: 0, width: 0, height: 45))
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        self.borderStyle = UITextField.BorderStyle.none
        self.placeholder = "vendor"
        self.keyboardType = UIKeyboardType.default
        self.autocorrectionType = .no
        self.delegate = self
        
        view.frame.size.width = self.frame.width
        view.textField = self
        self.inputAccessoryView = view
            //            let accessoryView = UIView(frame: .zero)
//            accessoryView.backgroundColor = .lightGray
//            accessoryView.alpha = 0.6
//            return accessoryView
//            }(
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
