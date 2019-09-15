//
//  VendorStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/4/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class VendorStore: BaseRepo<Vendor> {
    fileprivate var vendorKeys: [String: VendorID] = [:]

    override init(localPersistanceService: LocalPersistanceService) {
        super.init(localPersistanceService: localPersistanceService)
        for (_, v) in self.items {
            vendorKeys[v.name] = v.id
        }
    }
}

extension VendorStore {
    public func query(_ substring: String) -> [(String, VendorID)] {
        return vendorKeys.filter {$0.key.contains(substring)}
    }
}

extension VendorStore: VendorRepository {
    func getAllVendors() -> [Vendor] {
        return getAll()
    }
    
    func hasVendor(_ name: String) -> Bool {
        return self.get(name) != nil
    }
    
    func get(_ name: String) -> Vendor? {
        if let vendorID = vendorKeys[name] {
            return items[vendorID]
        } else {
            return nil
        }
    }
    
    func update(_ vendor: Vendor) {
    }
    
    func remove(_ vendor: Vendor) {
    }
    
    func queryVendors(_ substring: String) -> [(String, VendorID)] {
        return query(substring)
    }
}
