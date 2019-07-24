//
//  PieChartSegment.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/23/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import UIKit

class PieChartSegment {
    var text: String
    var color: UIColor
    var value: Double
    
    init(text: String, color: UIColor, value: Double) {
        self.text = text
        self.color = color
        self.value = value
    }
}
