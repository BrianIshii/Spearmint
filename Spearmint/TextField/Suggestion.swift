//
//  Suggestion.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/22/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import UIKit

struct Suggestion {
    let text: String
    let textColor: UIColor?
    let backgroundColor: UIColor?
    
    init(text: String) {
        self.text = text
        self.textColor = nil
        self.backgroundColor = nil
    }
    
    init(text: String, textColor: UIColor, backgroundColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}
