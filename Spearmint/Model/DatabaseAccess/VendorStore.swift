//
//  VendorStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/23/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class VendorStore {
    public static var vendorDictionary: [String: Vendor] = getVendorDictionary()

    static func getVendorDictionary() -> [String: Vendor] {
        return LocalAccess.getDictionary(saveable: Vendor.self)
    }
    
    static func updateVendorDictionary() {
        LocalAccess.updateDictionary(data: vendorDictionary)
    }
}
