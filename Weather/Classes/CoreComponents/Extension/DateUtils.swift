//
//  DateUtils.swift
//  Weather
//
//  Created by Jithin on 10/1/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import Foundation


class DateUtils {
    
    static let sharedInstane = DateUtils()
    static let formatJSONDate = "yyyy-MM-dd"
    static let formatJSONDateTime = "yyyy-MM-dd HH:mm:ss"
    static let formatJSONDateTimeMillis = "yyyy-MM-dd HH:mm:ss.SSS"    
    static let formatDateOnlySlanding = "dd/MM/yyyy"
    static let formatTime = "hh:mm a"
    static let formatShortTime = "h:mm a"
    
    
    /// Get the system time from milliseconds
    ///
    /// - Parameter milliSeonds: millisecond as Double
    /// - Returns: time value as String
    func convertWeatherTimeDate(milliSeonds: Double) -> String{
        let date = NSDate(timeIntervalSince1970: milliSeonds)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let locale = NSLocale.current
        let formatterCheck : String = DateFormatter.dateFormat(fromTemplate: "j", options:0, locale:locale)!
        if formatterCheck.contains("a") {
            formatter.dateFormat = "h:mm a"
        } else {
            formatter.dateFormat = "HH:mm"
        }
        let dateString = formatter.string(from: date as Date)
        return dateString
    }
    
}
