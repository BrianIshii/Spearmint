//
//  VendorCloudStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/4/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import CloudKit

class VendorCloudStore: CloudStore {
    typealias Item = Vendor
    
    func createItem(from record: CKRecord) -> Vendor {
        <#code#>
    }
    
    func createRecord(_ item: Vendor) -> CKRecord {
        <#code#>
    }
}
