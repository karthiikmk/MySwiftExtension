//
//  Number-Extension.swift
//  DateHelper
//
//  Created by Karthik on 18/11/15.
//  Copyright © 2015 Karthik. All rights reserved.
//

import UIKit


// MARK: int number long  to

public extension NSNumber{
    
    var toInt : Int{
        return self.longValue
    }
    
    var toInt64 : Int64{
        return self.longLongValue
    }
    
    var toString : String {
        return self.stringValue
    }
    
    
}

//MARK:TimeInterval Converison

public extension NSTimeInterval{
    
    var toDouble : Double{
        return Double(self)
    }
    var toInt64 : Int64{
        return Int64(self)
    }
    var toInt : Int{
        return Int(self)
    }
}
