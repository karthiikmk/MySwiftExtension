//
//  Number-Extension.swift
//  DateHelper
//
//  Created by Karthik on 18/11/15.
//  Copyright © 2015 Karthik. All rights reserved.
//

import UIKit


// MARK: int number long  to

extension Int{
    
    public var toNumber : NSNumber{
        return NSNumber(integer: self)
    }
    
    public var toString : String{
        return String(self)
    }
    
    func toBool () ->Bool? {
        switch self {
        case 0:
            return false
        case 1:
            return true
        default:
            return nil
        }
    }
    
    func times(closure: () -> ()) {
        for _ in 0 ..< self {
            closure()
        }
    }
    
}

extension Int64{
    
    public var toNumber_64Bit : NSNumber{
        return NSNumber(longLong: self)
    }
    
    public var toString : String{
        return String(self)
    }
    
    public var toDate : NSDate{
        let interval : NSTimeInterval = Double(self) / 1000
        return NSDate(timeIntervalSince1970:interval)
    }
}

extension NSNumber{
    
    public var toInt : Int{
        return self.longValue
    }
    
    public var toInt64 : Int64{
        return self.longLongValue
    }
    
    public var toString : String {
        return self.stringValue
    }
    
    
}

//MARK:TimeInterval Converison

extension NSTimeInterval{
    
    public var toDouble : Double{
        return Double(self)
    }
    public var toInt64 : Int64{
        return Int64(self)
    }
    public var toInt : Int{
        return Int(self)
    }
}
