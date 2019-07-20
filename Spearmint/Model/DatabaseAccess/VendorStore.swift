//
//  VendorStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/23/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class VendorStore {
    fileprivate var vendorDictionary: [VendorID: Vendor] = [:]
    fileprivate var vendorKeys: [String: VendorID] = [:]

    init() {
        let dictionary = getVendorDictionary()
        for (k,v) in dictionary {
            vendorKeys[v.name] = v.vendorID
        }
        self.vendorDictionary = getVendorDictionary()
    }
    
    public func addVendor(vendor: Vendor) {
        vendorDictionary[vendor.vendorID] = vendor
        vendorKeys[vendor.name] = vendor.vendorID
        updateVendorDictionary()
    }
    
    public func hasVendor(_ name: String) -> Bool {
        return vendorKeys.keys.contains(name)
    }
    
    public func getVendor(_ name: String) -> Vendor? {
        if let vendorID = vendorKeys[name] {
            return vendorDictionary[vendorID]
        } else {
            return nil
        }
    }
    
    public func getVendor(_ vendorID: VendorID) -> Vendor? {
        return vendorDictionary[vendorID]
    }
    
    public func query(_ substring: String) -> [(String, VendorID)] {
        return vendorKeys.filter {$0.key.contains(substring)}
    }

    fileprivate func getVendorDictionary() -> [VendorID: Vendor] {
        return LocalAccess.getDictionary(key: VendorID.self, object: Vendor.self)
    }
    
    fileprivate func updateVendorDictionary() {
        LocalAccess.updateDictionary(data: vendorDictionary)
    }
}
