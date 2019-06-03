//
//  ImageFrameView.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/3/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class ImageFrameView: UIView {

    var text: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
