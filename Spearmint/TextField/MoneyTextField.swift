//
//  MoneyTextField.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/11/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class MoneyTextField: UITextField, UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        self.borderStyle = UITextField.BorderStyle.none
        self.placeholder = "$0.00"
        self.keyboardType = UIKeyboardType.numberPad
        self.delegate = self
        
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneButtonClicked))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBar.setItems([flexSpace, doneButton], animated: false)
        self.inputAccessoryView =  toolBar
    }
    
    func getAmount() -> Float {
        if let text = self.text {
            return Currency.currencyToFloat(total: text)
        } else {
            return 0.0
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @objc func doneButtonClicked(_ textField: UITextField) {
        let _ = textFieldShouldReturn(self)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.text = Currency.currencyFormatter(total: textField.text!)
    }
}
