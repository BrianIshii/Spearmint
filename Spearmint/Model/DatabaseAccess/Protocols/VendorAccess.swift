//
//  VendorAccess.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/10/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol VendorAccess {
    func getAllVendors() -> [Vendor]
    func get(_ id: Vendor) -> Vendor?
    func append(_ vendor: Vendor)
    func update(_ vendor: Vendor)
    func remove(_ vendor: Vendor)
}
