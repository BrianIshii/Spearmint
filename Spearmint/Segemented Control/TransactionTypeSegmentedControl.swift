//
//  TransactionTypeSegmentedControl.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/6/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class TransactionTypeSegmentedControl: UISegmentedControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        self.backgroundColor = .clear
        self.tintColor = .clear
        self.setTitleTextAttributes([
            //            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 18) as Any,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        
        self.setTitleTextAttributes([
            //            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 18) as Any,
            NSAttributedString.Key.foregroundColor: UIColor.black
            ], for: .selected)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
