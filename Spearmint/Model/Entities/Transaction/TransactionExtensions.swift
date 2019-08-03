//
//  TransactionExtensions.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/3/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import CloudKit

extension Transaction {
    
    convenience init(_ record: CKRecord) {
        var id: String
        if let temp = record.recordID.recordName as? String {
            id = temp
        } else {
            id = ""
        }
        
        var name = ""
        if let temp = record.value(forKeyPath: "name") as? String {
            name = temp
        }
        
        var transactionType = TransactionType.expense
        if let temp = record.value(forKeyPath: "transactionType") as? Int {
            switch temp {
            case 0:
                transactionType = TransactionType.expense
            default:
                transactionType = TransactionType.income
            }
        }
        
        var vendorID: VendorID
        if let temp = record.value(forKeyPath: "vendorID") as? String {
            vendorID = VendorID(temp)
        } else {
            vendorID = VendorID()
        }
        
        var amount: Float
        if let temp = record.value(forKeyPath: "amount") as? Float {
            amount = temp
        } else {
            amount = 0.0
        }
        
        var transactionDate: TransactionDate
        var budgetDate: BudgetDate
        if let temp = record.value(forKeyPath: "date") as? Date {
            transactionDate = TransactionDate(temp)
            budgetDate = BudgetDate(temp)
        } else {
            transactionDate = TransactionDate(Date())
            budgetDate = BudgetDate(Date())
        }
        
        self.init(id: TransactionID(id), name: name, transactionType: transactionType, vendor: vendorID, amount: amount, date: transactionDate, location: "", image: false, notes: "", budgetDate: budgetDate, items: [:])
    }
    
    func createRecord() -> CKRecord {
        let transactionRecordID = CKRecord.ID(recordName: ID)
        let transactionRecord = CKRecord(recordType: "Transaction", recordID: transactionRecordID)
        
        transactionRecord["name"] = name as NSString
        transactionRecord["transactionType"] = transactionType.rawValue as NSNumber
        transactionRecord["paymentType"] = paymentType as NSString
        transactionRecord["vendorID"] = vendor.id as NSString
        transactionRecord["amount"] = amount as NSNumber
        transactionRecord["date"] = date.date as NSDate
        if tags.count > 0 {
            transactionRecord["tags"] = tags as NSArray
        }
        transactionRecord["notes"] = notes as NSString
        transactionRecord["amount"] = amount as NSNumber
        var budgetItemIDs: [NSString] = []
        var items: [NSString] = []
        for (k, v) in self.items {
            budgetItemIDs.append(k.id as NSString)
            for item in v {
                items.append(item.budgetItemName as NSString)
            }
        }
        
        if budgetItemIDs.count > 0 {
            transactionRecord["budgetItemIDs"] = budgetItemIDs as NSArray
        }
        if items.count > 0 {
            transactionRecord["items"] = items as NSArray
        }
        
        return transactionRecord
    }
}
