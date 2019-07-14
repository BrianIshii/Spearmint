//
//  BaseDate.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/13/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
class BaseDate: Codable {
    var dateString: String = ""
    
    init () {
        self.dateString = dateToString(Date())
    }
    init(_ date: Date) {
        self.dateString = dateToString(date)
    }
    
    init(_ date: String) {
        self.dateString = date
    }
    
    var date: Date {
        return DateFormatterFactory.StandardDateFormatter.date(from: dateString) ?? Date()
    }
    
    var second: String {
        return DateFormatterFactory.SecondFormatter.string(from: date)
    }
    
    var minute: String {
        return DateFormatterFactory.MinuteFormatter.string(from: date)
    }
    
    var hour: String {
        return DateFormatterFactory.HourFormatter.string(from: date)
    }
    
    var day: String {
        return DateFormatterFactory.DayFormatter.string(from: date)
    }
    
    var month: String {
        return DateFormatterFactory.MonthFormatter.string(from: date)
    }
    
    var year: String {
        return DateFormatterFactory.YearFormatter.string(from: date)
    }
    
    var medium: String {
        return DateFormatterFactory.MediumFormatter.string(from: date)
    }
    
    func dateToString(_ date: Date) -> String {
        return DateFormatterFactory.StandardDateFormatter.string(from: date)
    }
    
    static func > (lft: BaseDate, rht: BaseDate) -> Bool {
        return lft.dateString > rht.dateString
    }
    
    static func < (lft: BaseDate, rht: BaseDate) -> Bool {
        return lft.dateString < rht.dateString
    }
    
    static func == (lhs: BaseDate, rhs: BaseDate) -> Bool {
        return lhs.dateString == rhs.dateString
    }
}
