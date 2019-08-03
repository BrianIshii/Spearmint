//
//  CloudKitService.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/3/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitService {
    fileprivate let myContainer = CKContainer.default()
    fileprivate let privateDatabase = CKContainer.default().privateCloudDatabase
    fileprivate let publicDatabase  = CKContainer.default().publicCloudDatabase
    
    func getRecords() -> [CKRecord] {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Transaction", predicate: predicate)
        var recordArray: [CKRecord] = []
        
        privateDatabase.perform(query, inZoneWith: nil) {(records, error) in
            if let error = error {
                print("failed to get records: \(error)")
                return
            }
            
            if let records = records {
                recordArray = records
            }
        }
        
        return recordArray
    }
    
    func saveRecord(_ record: CKRecord) {
        privateDatabase.save(record) {
            (record, error) in
            if let error = error {
                print("failed to save record: \(error)")
                return
            }
            print("success record saved")
        }
    }
}
