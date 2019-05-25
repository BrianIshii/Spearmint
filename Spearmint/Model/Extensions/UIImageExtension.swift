//
//  UIImageExtension.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

extension UIImage {
    
    func isEqualTo(_ image: UIImage) -> Bool {
        let data1: NSData = self.pngData()! as NSData
        let data2: NSData = image.pngData()! as NSData
        return data1.isEqual(data2)
    }
    
}
