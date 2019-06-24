//
//  ReusableCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/19/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol ReusableIdentifier: class {
    static var reuseIdentifier: String { get }
    static var xib: String { get }
}

extension ReusableIdentifier {
    static var reuseIdentifier: String {
        return "\(self)"
    }
    
    static var xib: String {
        return "\(self)"
    }
}
