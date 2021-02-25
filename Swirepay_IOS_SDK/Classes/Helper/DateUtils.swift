//
//  DateUtils.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 25/02/21.
//

import Foundation

public class DateUtils {
    
    public static func getStringFromDate(withFormat strFormat: String, date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strFormat
        dateFormatter.timeZone = TimeZone.ReferenceType.system
        return dateFormatter.string(from: date)
    }
}
