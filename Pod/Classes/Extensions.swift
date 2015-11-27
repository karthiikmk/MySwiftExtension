//
//  Extensions.swift
//  DateHelper
//
//  Created by Karthik on 10/29/15.
//  Copyright © 2015 Karthik. All rights reserved.
//

import UIKit
import Foundation


class Utils {
        
    class func getRandom(lower: Int = 0, _ upper: Int = 100) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    class func generateUniqueIdentifier() -> String {
        
        // will return E621E1F8-C36C-495A-93FC-0C247A3E6E5F
        return NSUUID().UUIDString
    }
}

extension UITableView{
    
    public func scrollToTop(animated animated: Bool){
        scrollRectToVisible(CGRectMake(0, 0, 1, 0), animated: animated)
    }
}



public extension NSObject {
    
    /**
     This will run closure after delay. Invokation will be on main_queue.
     
     - parameter delay: is number of seconds to delay
     */
    func delay(delay: Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
}


class CachedDateFormatter {
    
    /* 
    1.Will store the Value in Dict
    2.search for key in next call
    3.Returns if exist,
    4.else create new one 

    .. call by
    let dateFormatter = CachedDateFormatter.sharedInstance.formatterWith(format: "yyyy-MM-dd'-'HHmm", timeZone: NSTimeZone.localTimeZone(), locale: NSLocale(localeIdentifier: "en_US"))
    */

    static let sharedInstance = CachedDateFormatter()
    
    var cachedDateFormatters :[String: NSDateFormatter] = [:]
    
    func formatterWith(format format: String, timeZone: NSTimeZone = NSTimeZone.localTimeZone(), locale: NSLocale = NSLocale(localeIdentifier: "en_US")) -> NSDateFormatter {
        
        let key = "\(format.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
        
        if let cachedDateFormatter = cachedDateFormatters[key] {
            return cachedDateFormatter
        }
        else {
            let newDateFormatter = NSDateFormatter()
            newDateFormatter.dateFormat = format
            newDateFormatter.timeZone = timeZone
            newDateFormatter.locale = locale
            cachedDateFormatters[key] = newDateFormatter
            return newDateFormatter
        }
    }
    
}

extension UIViewController{
    
    public var isModal: Bool {
        return self.presentingViewController?.presentedViewController == self
            || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
            || self.tabBarController?.presentingViewController is UITabBarController
    }
    
}


//MARK: Bool Extension

extension Bool{
    
    public func toInt() -> Int{
        switch self {
        case true:
            return 1
        case false:
            return 0
        }
    }

    public func toString() -> String{
        return String(self)
    }
}


//MARK: NSUserDefaults setter
extension NSUserDefaults{
    
    public func setLong(value: Int64, forKey key: String){
        
        NSUserDefaults.standardUserDefaults().setObject(value.toNumber_64Bit, forKey: key)
        NSUserDefaults().synchronize()
    }
    
    public func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            colorData = NSKeyedArchiver.archivedDataWithRootObject(color)
        }
        setObject(colorData, forKey: key)
    }
    
    
}

//MARK: NSUserDefaults getter

extension NSUserDefaults{
    
    
    public func longForKey(key: String) -> Int64?{
        
        if let tempNum = NSUserDefaults.standardUserDefaults().objectForKey(key) as? NSNumber{
            return tempNum.toInt64
        }
        
        return nil
    }
    
    public func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = dataForKey(key) {
            color = NSKeyedUnarchiver.unarchiveObjectWithData(colorData) as? UIColor
        }
        return color
    }
}


extension NSCalendar{
    
     class func gregorianCalendar() -> NSCalendar {
        return NSCalendar(identifier: NSCalendarIdentifierGregorian)!
    }

}


extension NSTimeInterval {
    
    public var second: NSTimeInterval {
        return self.seconds
    }
    
    public var seconds: NSTimeInterval {
        return self
    }
    
    public var minute: NSTimeInterval {
        return self.minutes
    }
    
    public var minutes: NSTimeInterval {
        let secondsInAMinute = 60 as NSTimeInterval
        return self * secondsInAMinute
    }
    
    public var day: NSTimeInterval {
        return self.days
    }
    
    public var days: NSTimeInterval {
        let secondsInADay = 86_400 as NSTimeInterval
        return self * secondsInADay
    }
    
    public var before: NSDate {
        let timeInterval = self
        return NSDate().dateByAddingTimeInterval(-timeInterval)
    }
    
    public var after : NSDate{
        
        let timeInterval = self
        return NSDate().dateByAddingTimeInterval(+timeInterval)
    }
}