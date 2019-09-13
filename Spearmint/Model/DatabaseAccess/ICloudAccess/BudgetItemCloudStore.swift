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
        let id = record.recordID.recordName as String 
        
        let name = record.value(forKeyPath: "name") as? String ?? ""
        let category = record.value(forKeyPath: "category") as? BudgetItemCategory ?? BudgetItemCategory.other
        let planned = record.value(forKeyPath: "planned") as? Float ?? 0.0
        let actual = record.value(forKeyPath: "actual") as? Float ?? 0.0
        let isActiveValue = record.value(forKeyPath: "isActive") as? Int ?? 0
        let isActive = isActiveValue == 1

        var transactions: [BudgetDate: [TransactionID]] = [:]
        guard let budgetRepository = AppDelegate.container.resolve(BudgetRepository.self) else {
            print("failed to resolve \(BudgetRepository.self)")
            return BudgetItem(name: "bad", category: BudgetItemCategory.other)
        }
        
        for budget in budgetRepository.getAll() {
            let transactionIDStrings = record.value(forKeyPath: "BudgetItem\(budget.month)\(budget.year)") as? [NSString] ?? []
            var transactionIDs: [TransactionID] = []
            for transactionIDString in transactionIDStrings {
                transactionIDs.append(TransactionID(transactionIDString as String))
            }
            transactions[budget.budgetDate] = transactionIDs

        }
        
        return BudgetItem(id: BudgetItemID(id), name: name, category: category, planned: planned, actual: actual, isActive: isActive, transactions: transactions)
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
            
            record["\(BudgetItem.self)\(k.month)\(k.year)"] = transactionIDs
        }
        
        return record
    }
}
