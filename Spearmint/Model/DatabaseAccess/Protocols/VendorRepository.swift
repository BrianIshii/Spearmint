//
//  VendorAccess.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/10/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol VendorRepository {
    func getAllVendors() -> [Vendor]
    func get(_ id: VendorID) -> Vendor?
    func get(_ name: String) -> Vendor?
    func hasVendor(_ name: String) -> Bool
    func append(_ vendor: Vendor)
    func update(_ vendor: Vendor)
    func remove(_ vendor: Vendor)
    func queryVendors(_ substring: String) -> [(String, VendorID)]
}
