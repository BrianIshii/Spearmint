//
//  Color.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/13/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import UIKit

class Color: Codable {
    var red: Int
    var green: Int
    var blue: Int
    var alpha: Int
    
    init(red: Int, green: Int, blue: Int, alpha: Int = 1) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    var uiColor: UIColor {
        return UIColor(red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255), alpha: CGFloat(alpha))
    }
}
