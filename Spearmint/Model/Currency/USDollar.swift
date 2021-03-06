//
//  USDollar.swift
//  Spearmint
//
//  Created by Brian Ishii on 9/15/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

public class USDollar: Currency {
    public func fromString(_ total: String) -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = total
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: total, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, total.count), withTemplate: "")
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return "0.00"
        }
        
        return formatter.string(from: number)!
    }
    
    public func fromFloat(_ total: Float) -> String {
        return self.fromString(String(format: "%0.2f", total))
    }
    
    public func toFloat(_ total: String) -> Float {
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        
        let amountWithPrefix = regex.stringByReplacingMatches(in: total, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, total.count), withTemplate: "")
        
        return (amountWithPrefix as NSString).floatValue / 100
    }
    
    
}
