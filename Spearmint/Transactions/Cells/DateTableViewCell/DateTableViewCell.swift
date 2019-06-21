//
//  DateTableViewCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/7/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    static let xib = "DateTableViewCell"

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.delegate = self
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        textField.inputView = datePicker

        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneButton))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //let prac = UIBarButtonItem(title: "food", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        toolBar.setItems([flexSpace, doneButton], animated: false)
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        textField.text = DateFormatterFactory.mediumFormatter.string(from: sender.date)
    }
    
    @objc func doneButton(_ cell: UITableViewCell) {
        let _ = textFieldShouldReturn(self.textField)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        textField.text = DateFormatterFactory.mediumFormatter.string(from: sender.date)
    }
    
}

extension DateTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension DateTableViewCell: UIPickerViewDelegate {
    
}
