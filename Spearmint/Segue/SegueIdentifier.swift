//
//  SegueIdentifier.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/21/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol SegueIdentifier: class {
    static var SegueIdentifier: String { get }
}

extension SegueIdentifier {
    static var SegueIdentifier: String {
        return "\(self)"
    }
}
