//
//  CGFloatExtension.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/29/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import UIKit
extension CGFloat {
    func isBetween(_ start: CGFloat, _ end: CGFloat) -> Bool {
        if self >= start && self <= end {
            return true
        }
        
        return false
    }
}
