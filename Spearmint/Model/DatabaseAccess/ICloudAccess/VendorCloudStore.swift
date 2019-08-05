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
        let id = record.recordID.recordName as String ?? ""
        let name = record.value(forKeyPath: "name") as? String ?? ""
        let budgetItemCategory = record.value(forKeyPath: "budgetCategory") as? BudgetItemCategory
        let budgetItemIDString = record.value(forKeyPath: "budgetItemID") as? String
        var budgetItemID: BudgetItemID?
        if let budgetItemIDString = budgetItemIDString {
            budgetItemID = BudgetItemID(budgetItemIDString)
        } else {
            budgetItemID = nil
        }
        
        let transactionIDStrings = record.value(forKey: "transactionIDs") as? [NSString] ?? []
        var transactionIDs: [TransactionID] = []
        
        for transactionID in transactionIDStrings {
            transactionIDs.append(TransactionID(transactionID as String))
        }
        
        return Vendor(id: VendorID(id), name: name, budgetCategory: budgetItemCategory, budgetItemID: budgetItemID, transactionIDs: transactionIDs)
    }
    
    func createRecord(_ item: Vendor) -> CKRecord {
        let recordID = CKRecord.ID(recordName: item.id.id)
        let record = CKRecord(recordType: "Vendor", recordID: recordID)
        
        record["name"] = item.name as NSString
        
        if let budgetCategory = item.budgetCategory,
            let budgetItemID = item.budgetItemID {
            record["budgetCategory"] = budgetCategory.rawValue as NSString
            record["budgetItemID"] = budgetItemID.id as NSString
        }
        
        var ids: [NSString] = []
        for id in item.transactionIDs {
            ids.append(id.id as NSString)
        }
        
        record["transactionIDs"] = ids as NSArray
        
        return record
    }
}
