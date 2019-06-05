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
    case total = 1
}

class AddContentsFromImageViewController: UIViewController, UITextFieldDelegate {

    var vendor: String?
    var total: String?
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toggleFields(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case Fields.vendor.rawValue:
            total = textField.text
            textField.text = vendor ?? ""
        default:
            vendor = textField.text
            textField.text = total ?? ""
        }
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
