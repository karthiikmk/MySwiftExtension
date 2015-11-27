//
//  Int-Extension.swift
//  Pods
//
//  Created by Karthik on 27/11/15.
//
//

import UIKit
import Foundation

public extension Int{
    
    var toNumber : NSNumber{
        return NSNumber(integer: self)
    }
    
    var toString : String{
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

public extension Int64{
    
    var toNumber_64Bit : NSNumber{
        return NSNumber(longLong: self)
    }
    
    var toString : String{
        return String(self)
    }
    
    var toDate : NSDate{
        let interval : NSTimeInterval = Double(self) / 1000
        return NSDate(timeIntervalSince1970:interval)
    }
}