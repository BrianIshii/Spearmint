//
//  AddContentsFromImageViewController.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/3/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

enum Fields: Int {
    case vendor = 0
    case items = 1
    case total = 2
}

class AddContentsFromImageViewController: UIViewController, UITextFieldDelegate {

    var vendor: String?
    var total: String?
    var previous: Int?
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toggleFields(_ sender: UISegmentedControl) {
        if let previous = previous {
            setField(previous)
        }
        
        
        switch sender.selectedSegmentIndex {
        case Fields.vendor.rawValue:
            textField.isHidden = false
            textField.text = vendor ?? ""
        case Fields.total.rawValue:
            textField.isHidden = false
            textField.text = total ?? ""
        case Fields.items.rawValue:
            textField.isHidden = true
        default:
            break
        }
        
        self.previous = sender.selectedSegmentIndex
    }
    
    func setField(_ field: Int) {
        switch field {
        case Fields.vendor.rawValue:
            vendor = textField.text
        case Fields.total.rawValue:
            total = textField.text
        case Fields.items.rawValue:
            break
        default:
            break
        }
    }
    
    func update() {
        switch segmentedControl.selectedSegmentIndex {
        case Fields.vendor.rawValue:
            vendor = textField.text
        case Fields.total.rawValue:
            total = textField.text
        case Fields.items.rawValue:
            break
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
