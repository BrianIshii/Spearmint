//
//  CGVectorExtension.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/23/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import UIKit

extension CGVector {
    func dotProduct(_ vector: CGVector) -> CGFloat {
        return self.dx * vector.dx + self.dy * vector.dy
    }
    
    func crossProduct(_ vector: CGVector) -> CGFloat {
        return self.dx * vector.dy - self.dy * vector.dx
    }
    
    var magnitude: CGFloat {
        return (self.dx * self.dx + self.dy * self.dy).squareRoot()
    }
}
