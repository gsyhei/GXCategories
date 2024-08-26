//
//  Date+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/10/21.
//  Copyright © 2020 Gin. All rights reserved.
//

import Foundation

public extension Date {
    /// DateFormatter单例
    static let gx_dateFormatter: DateFormatter = {
        let instance = DateFormatter()
        return instance
    }()
    
    // MARK: - 日期属性
    
    var year: Int {
        return NSCalendar.current.component(.year, from: self)
    }
    
    var month: Int {
        return NSCalendar.current.component(.month, from: self)
    }
    
    var day: Int {
        return NSCalendar.current.component(.day, from: self)
    }
    
    var hour: Int {
        return NSCalendar.current.component(.hour, from: self)
    }
    
    var minute: Int {
        return NSCalendar.current.component(.minute, from: self)
    }
    
    var second: Int {
        return NSCalendar.current.component(.second, from: self)
    }
    
    var nanosecond: Int {
        return NSCalendar.current.component(.nanosecond, from: self)
    }
    
    var weekday: Int {
        return NSCalendar.current.component(.weekday, from: self)
    }
    
    var weekdayOrdinal: Int {
        return NSCalendar.current.component(.weekdayOrdinal, from: self)
    }
    
    var weekOfMonth: Int {
        return NSCalendar.current.component(.weekOfMonth, from: self)
    }
    
    var weekOfYear: Int {
        return NSCalendar.current.component(.weekOfYear, from: self)
    }
    
    var yearForWeekOfYear: Int {
        return NSCalendar.current.component(.yearForWeekOfYear, from: self)
    }
    
    var quarter: Int {
        return NSCalendar.current.component(.quarter, from: self)
    }
    
    var isLeapMonth: Bool {
        return NSCalendar.current.dateComponents([.month], from: self).isLeapMonth ?? false
    }
    
    var isLeapYear: Bool {
        let year = self.year
        return ((year % 400 == 0) || (year % 100 != 0 && year % 4 == 0))
    }
    
    var isToday: Bool {
        return NSCalendar.current.isDateInToday(self)
    }
    
    var isYesterday: Bool {
        return NSCalendar.current.isDateInYesterday(self)
    }
    
    // MARK: - 日期增加（年/月/周/日/时/分/秒）
    
    func dateByAdding(years: Int) -> Date? {
        var components: DateComponents = DateComponents()
        components.year = years
        return NSCalendar.current.date(byAdding: components, to: self)
    }
    
    func dateByAdding(months: Int) -> Date? {
        var components: DateComponents = DateComponents()
        components.month = months
        return NSCalendar.current.date(byAdding: components, to: self)
    }
    
    func dateByAdding(weeks: Int) -> Date? {
        var components: DateComponents = DateComponents()
        components.weekOfYear = weeks
        return NSCalendar.current.date(byAdding: components, to: self)
    }
    
    func dateByAdding(days: Int) -> Date? {
        var components: DateComponents = DateComponents()
        components.day = days
        return NSCalendar.current.date(byAdding: components, to: self)
    }
    
    func dateByAdding(hours: Int) -> Date? {
        var components: DateComponents = DateComponents()
        components.hour = hours
        return NSCalendar.current.date(byAdding: components, to: self)
    }
    
    func dateByAdding(minutes: Int) -> Date? {
        var components: DateComponents = DateComponents()
        components.minute = minutes
        return NSCalendar.current.date(byAdding: components, to: self)
    }
    
    func dateByAdding(seconds: Int) -> Date? {
        var components: DateComponents = DateComponents()
        components.second = seconds
        return NSCalendar.current.date(byAdding: components, to: self)
    }
    
    // MARK: - 日期和字符串的转换
    
    func string(format: String, locale: Locale = Locale.current, timeZone: TimeZone = TimeZone.current) -> String {
        Date.gx_dateFormatter.dateFormat = format
        Date.gx_dateFormatter.locale = locale
        Date.gx_dateFormatter.timeZone = timeZone
        return Date.gx_dateFormatter.string(from: self)
    }
    
    func stringWithISOFormat(timeZone: TimeZone = TimeZone.current) -> String {
        Date.gx_dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        Date.gx_dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        Date.gx_dateFormatter.timeZone = timeZone
        return Date.gx_dateFormatter.string(from: self)
    }
    
    static func date(dateString: String, format: String, locale: Locale = Locale.current, timeZone: TimeZone = TimeZone.current) -> Date? {
        guard dateString.count > 0 else { return nil }
        Date.gx_dateFormatter.dateFormat = format
        Date.gx_dateFormatter.locale = locale
        Date.gx_dateFormatter.timeZone = timeZone
        return Date.gx_dateFormatter.date(from: dateString)
    }
    
    static func dateWithISOFormat(dateString: String, timeZone: TimeZone = TimeZone.current) -> Date? {
        guard dateString.count > 0 else { return nil }
        Date.gx_dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        Date.gx_dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        Date.gx_dateFormatter.timeZone = timeZone
        return Date.gx_dateFormatter.date(from: dateString)
    }
}
