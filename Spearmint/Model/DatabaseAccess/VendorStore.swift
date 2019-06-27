//
//  VendorStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/23/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class VendorStore {
    fileprivate var vendorDictionary: [String: Vendor] = [:]
    fileprivate var vendorKeys: [String: String] = [:]

    init() {
        let dictionary = getVendorDictionary()
        for (k,v) in dictionary {
            vendorKeys[v.name] = k
        }
        self.vendorDictionary = getVendorDictionary()
    }
    
    public func addVendor(vendor: Vendor) {
        vendorDictionary[vendor.vendorID.description()] = vendor
        vendorKeys[vendor.name] = vendor.vendorID.description()
        updateVendorDictionary()
    }
    
    public func query(_ substring: String) -> [(String, String)] {
        return vendorKeys.filter {$0.key.contains(substring)}
    }

    fileprivate func getVendorDictionary() -> [String: Vendor] {
        return LocalAccess.getDictionary(saveable: Vendor.self)
    }
    
    fileprivate func updateVendorDictionary() {
        LocalAccess.updateDictionary(data: vendorDictionary)
    }
}
