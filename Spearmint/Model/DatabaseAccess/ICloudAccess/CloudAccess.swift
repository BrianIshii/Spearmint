//
//  CloudAccess.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/3/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class CloudAccess {
    public static var instance: CloudAccess = CloudAccess(cloudKitService: CloudKitService(), transactionCloudStore: TransactionCloudStore())
    var cloudKitService: CloudKitService
    var transactionCloudStore: TransactionCloudStore
    
    private init(cloudKitService: CloudKitService, transactionCloudStore: TransactionCloudStore) {
        self.cloudKitService = cloudKitService
        self.transactionCloudStore = transactionCloudStore
    }
}

extension CloudAccess {
    // add all features for transactions
}
