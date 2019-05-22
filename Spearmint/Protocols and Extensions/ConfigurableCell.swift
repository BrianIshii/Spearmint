//
//  ConfigurableCell.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/19/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol ConfigurableCell {
    associatedtype Object
    func configure(object: Object)
    func configure()
}
