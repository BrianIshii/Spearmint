//
//  BudgetItemCloudStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/5/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import CloudKit

class BudgetItemCloudStore: CloudStore {
    typealias Item = BudgetItem

    func createItem(from record: CKRecord) -> BudgetItem {
        return BudgetItem(name: "", category: BudgetItemCategory.debt, planned: 0)
    }
    
    func createRecord(_ item: BudgetItem) -> CKRecord {
        let recordID = CKRecord.ID(recordName: item.id.id)
        let record = CKRecord(recordType: "BudgetItem", recordID: recordID)
        
        record["name"] = item.name
        record["category"] = item.category.rawValue
        record["planned"] = item.planned as NSNumber
        record["actual"] = item.actual as NSNumber
        record["isActive"] = item.isActive ? 1 : 0

        for (k, v) in item.transactions {
            var transactionIDs: [NSString] = []
            for transactionID in v {
                transactionIDs.append(transactionID.id as NSString)
            }
            
            record[k.dateString] = transactionIDs
        }
        
        return record
    }
}
