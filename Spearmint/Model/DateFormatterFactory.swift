//
//  DateFormatterFactory.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/9/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
class DateFormatterFactory {
    static let monthAndDayFormatter = createMonthAndDayFormatter()
    static let mediumFormatter = createMediumFormatter()
    static let yearAndMonthFormatter = createYearAndMonthFormatter()
    
    static private func createMonthAndDayFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM-dd")
        
        return dateFormatter
    }
    
    static private func createMediumFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter
    }
    
    static private func createYearAndMonthFormatter() -> DateFormatter{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter
    }
}
