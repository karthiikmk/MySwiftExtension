//
//  Date-Extension.swift
//  DateHelper
//
//  Created by Karthik on 18/11/15.
//  Copyright © 2015 Karthik. All rights reserved.
//

import UIKit

//MARK: DATE EXTENSIONS
extension NSDate{
    
    // Addings
    public func daysBetweenDate(date:NSDate) -> Int {
        return NSCalendar.gregorianCalendar().components(.Day, fromDate: self, toDate: date, options: []).day
    }
    public func dateByAddingDays(days: Int) -> NSDate {
        return NSCalendar.gregorianCalendar().dateByAddingUnit(.Day, value: days, toDate: self, options: [])!
    }
    public func dateByAddingWeeks(weeks: Int) -> NSDate {
        return NSCalendar.gregorianCalendar().dateByAddingUnit(.WeekOfYear, value: weeks, toDate: self, options: [])!
    }
    public func dateByAddingMonths(months: Int) -> NSDate {
        return NSCalendar.gregorianCalendar().dateByAddingUnit(.Month, value: months, toDate: self, options: [])!
    }
    public func dateBySubtractingDays(days: Int) -> NSDate {
        return NSCalendar.gregorianCalendar().dateByAddingUnit(.Day, value: -days, toDate: self, options: [])!
    }
    public func dateBySubtractingWeeks(weeks: Int) -> NSDate {
        return NSCalendar.gregorianCalendar().dateByAddingUnit(.WeekOfYear, value: -weeks, toDate: self, options: [])!
    }
    public func dateBySubtractingMonths(months: Int) -> NSDate {
        return NSCalendar.gregorianCalendar().dateByAddingUnit(.Month, value: -months, toDate: self, options: [])!
    }
    
    
    // counts Bw dats  (days,weeks,monts,years)
    public func hoursFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Hour, fromDate: date, toDate: self, options: []).hour
    }
    public func minutesFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Minute, fromDate: date, toDate: self, options: []).minute
    }
    public func secondsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Second, fromDate: date, toDate: self, options: []).second
    }
    public func yearsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Year, fromDate: date, toDate: self, options: []).year
    }
    public func monthsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Month, fromDate: date, toDate: self, options: []).month
    }
    public func weeksFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: date, toDate: self, options: []).weekOfYear
    }
    public func daysFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Day, fromDate: date, toDate: self, options: []).day
    }
    
    public func offsetFrom(date:NSDate) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
    
    //comparisions
    public func isEqualsTo(date: NSDate) -> Bool {
        return self.compare(date) == NSComparisonResult.OrderedSame
    }
    public func isGreaterThan(date: NSDate) -> Bool {
        // today.isGreaterThan(yesterday)
        return self.compare(date) == NSComparisonResult.OrderedDescending
    }
    public func isLessThan(date: NSDate) -> Bool {
        // today.isLessThan(Tomorrow)
        return self.compare(date) == NSComparisonResult.OrderedAscending
    }
    // date => String
    public func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(self)
    }
    // String => date
    class func dateFromString(dateString: String, format: String = "yyyy-MM-dd HH:mm:ss") -> NSDate{
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.dateFromString(dateString)!
    }
    class func daysBetweenDate(startDate: NSDate, endDate: NSDate) -> Int {
        return NSCalendar.gregorianCalendar().components(.Day, fromDate: startDate, toDate: endDate, options: []).day
    }
    
    class func getMilliSecondsLongFromSecondsLong(secondsLong : Int64) -> Int64{
        return (secondsLong * 1000)
    }
    
}

extension NSDate : Comparable{
    
}

func + (date: NSDate, timeInterval: NSTimeInterval) -> NSDate {
    return date.dateByAddingTimeInterval(timeInterval)
}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    if lhs.compare(rhs) == .OrderedSame {
        return true
    }
    return false
}
// dateOne is older than dateTwo
public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    if lhs.compare(rhs) == .OrderedAscending {
        return true
    }
    return false
}
// dateOne is more recent(new) than dateTwo(old or past)
public func >(lhs: NSDate, rhs: NSDate) -> Bool {
    if lhs.compare(rhs) == .OrderedDescending {
        return true
    }
    return false
}
