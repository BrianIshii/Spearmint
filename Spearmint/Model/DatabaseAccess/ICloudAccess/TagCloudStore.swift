//
//  TagStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/3/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import CloudKit

class TagCloudStore: CloudStore {
    typealias Item = Tag

    func createItem(from record: CKRecord) -> Tag {
        let id = record.recordID.recordName as String 
        let red = record.value(forKeyPath: "red") as? Int ?? 0
        let green = record.value(forKeyPath: "green") as? Int ?? 0
        let blue = record.value(forKeyPath: "blue") as? Int ?? 0
        let alpha = record.value(forKeyPath: "alpha") as? Int ?? 0
        
        let color = Color(red: red, green: green, blue: blue, alpha: alpha)

        let transactionIDStrings = record.value(forKey: "transactionIDs") as? [NSString] ?? []
        var transactionIDs: [TransactionID] = []
        
        for transactionID in transactionIDStrings {
            transactionIDs.append(TransactionID(transactionID as String))
        }
        
        return Tag(id: TagID(id), text: id, color: color, transactionIDs: transactionIDs)
    }
    
    func createRecord(_ item: Tag) -> CKRecord {
        let recordID = CKRecord.ID(recordName: item.id.id)
        let record = CKRecord(recordType: "Tag", recordID: recordID)
        
        record["red"] = item.color.red as NSNumber
        record["green"] = item.color.green as NSNumber
        record["blue"] = item.color.blue as NSNumber
        record["alpha"] = item.color.alpha as NSNumber
        
        var ids: [NSString] = []
        for id in item.transactionIDs {
            ids.append(id.id as NSString)
        }

        record["transactionIDs"] = ids as NSArray
        
        return record
    }
    
    
    
}
