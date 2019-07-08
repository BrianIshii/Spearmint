//
//  TransactionView.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/6/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class TransactionView: UIView {
    @IBOutlet weak var transactionTypeSegementedControl: TransactionTypeSegmentedControl!
    @IBOutlet weak var moneyTextField: MoneyTextField!
    @IBOutlet weak var vendorTextField: VendorTextField!
    @IBOutlet weak var dateTextField: DateTextField!
    @IBOutlet weak var categoryButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        xibSetup()
        self.subviews.first?.layer.cornerRadius = 10
        self.subviews.first?.backgroundColor = UIColor.init(red: 253, green: 245, blue: 232, alpha: 1)
        
        self.subviews.first?.layer.shadowOpacity = 0.43
        self.subviews.first?.layer.shadowRadius = 4
        self.subviews.first?.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.subviews.first?.layer.shadowColor = UIColor.black.cgColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("awake")
    }
    
    func disableUserInteraction() {
        transactionTypeSegementedControl.isUserInteractionEnabled = false
        moneyTextField.isUserInteractionEnabled = false
        vendorTextField.isUserInteractionEnabled = false
        dateTextField.isUserInteractionEnabled = false
        categoryButton.isUserInteractionEnabled = false
    }
    
    func enableUserInteraction() {
        transactionTypeSegementedControl.isUserInteractionEnabled = true
        moneyTextField.isUserInteractionEnabled = true
        vendorTextField.isUserInteractionEnabled = true
        dateTextField.isUserInteractionEnabled = true
        categoryButton.isUserInteractionEnabled = true
    }
//
//
//    static func instanceFromNib() -> UIView {
//        return UINib(nibName: "TransactionView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
//    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
