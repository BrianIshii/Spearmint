//
//  Currency.swift
//  Spearmint
//
//  Created by Brian Ishii on 9/15/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

public protocol Currency {
    func fromString(_ total: String) -> String
    func fromFloat(_ total: Float) -> String
    func toFloat(_ total: String) -> Float
}
