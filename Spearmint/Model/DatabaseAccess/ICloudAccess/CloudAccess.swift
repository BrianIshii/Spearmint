//
//  CloudAccess.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/3/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class CloudAccess {
    var cloudKitService: CloudKitService
    var transactionCloudStore: TransactionCloudStore
    
    public init(cloudKitService: CloudKitService, transactionCloudStore: TransactionCloudStore) {
        self.cloudKitService = cloudKitService
        self.transactionCloudStore = transactionCloudStore
    }
}

extension CloudAccess {
    // add all features for transactions
}
