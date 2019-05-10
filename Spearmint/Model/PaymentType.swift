//
//  PaymentType.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/7/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

enum PaymentType: Int, Codable {
    case cash = 0
    case credit = 1
    case check = 2
    case other = 3
}
