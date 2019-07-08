//
//  DateTextField.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/5/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class DateTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        self.inputView = datePicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneButton))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //let prac = UIBarButtonItem(title: "food", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        toolBar.setItems([flexSpace, doneButton], animated: false)
        
        self.inputAccessoryView = toolBar
        self.delegate = self
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        text = DateFormatterFactory.mediumFormatter.string(from: sender.date)
    }
    
    @objc func doneButton(_ cell: UITableViewCell) {
        let _ = textFieldShouldReturn(self)
    }
}

extension DateTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
