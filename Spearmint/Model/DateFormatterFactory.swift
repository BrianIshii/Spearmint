//
//  DateFormatterFactory.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/9/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
class DateFormatterFactory {
    static let locale = Locale(identifier: "en_US")
    
    static let StandardDateFormatter = createFormatter("yyyy-MM-dd'T'HH:mm:ss")
    static let SecondFormatter = createFormatter("ss")
    static let MinuteFormatter = createFormatter("mm")
    static let HourFormatter = createFormatter("HH")
    static let DayFormatter = createFormatter("dd")
    static let MonthFormatter = createFormatter("MM")
    static let MonthThreeCharacterFormatter = createFormatter("MMM")
    static let YearFormatter = createFormatter("yyyy")
    static let YearTwoCharacterFormatter = createFormatter("yy")
    
    static let MonthAndDayFormatter = createFormatter("MMMM-dd")
    static let YearAndMonthFormatter = createFormatter("yyyy-MM")
    static let MediumFormatter = createMediumFormatter()

    static private func createFormatter(_ template: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.setLocalizedDateFormatFromTemplate(template)
        
        return dateFormatter
    }
    
    static private func createMediumFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter
    }
}
