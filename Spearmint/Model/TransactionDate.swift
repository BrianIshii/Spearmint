//
//  Date.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/9/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class TransactionDate {
    static let userCalendar = Calendar.current
    
    static func getCurrentDate() -> String {
        let currentDateTime = Date()

        return DateFormatterFactory.mediumFormatter.string(from: currentDateTime)
    }
    
    static func getMonthAndDay(date: String) -> String {
        
        if let parsedDate = DateFormatterFactory.mediumFormatter.date(from: date) {
            return DateFormatterFactory.monthAndDayFormatter.string(from: parsedDate)
        }
        return ""
    }
    

}
