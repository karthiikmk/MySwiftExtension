//
//  Dictionary-Extension.swift
//  DateHelper
//
//  Created by Karthik on 18/11/15.
//  Copyright © 2015 Karthik. All rights reserved.
//

import UIKit
import Foundation


//MARK:My Extension

extension Dictionary where Value:Comparable {
    
    public var valuesOrderedByAscending:[Value] {
        return self.values.sort()
    }
    
    public var valuesOrderedbyDescending:[Value] {
        return self.values.sort().reverse()
    }
    
}

extension Dictionary where Key:Comparable {
    
    // applicable for int
    public var keysOrderedByAscending:[Key] {
        return self.keys.sort()
    }
    public var keysOrderedByDescending:[Key] {
        return self.keys.sort().reverse()
    }
    
}



//MARK:Github Extension

public extension Dictionary {
    
    /// Filter dictionary, deleting all key-value pairs, that do not match provided block.
    ///
    /// - parameter block: matching block
    mutating func ck_performSelect( block: (Key,Value) -> Bool)
    {
        var keysToRemove = [Key]()
        
        for (key,value) in self {
            if !block(key,value) {
                keysToRemove.append(key)
            }
        }
        
        for key in keysToRemove {
            self.removeValueForKey(key)
        }
    }
    
    /// Filter dictionary, deleting all key-value pairs, that match provided block. This is reverse for ck_performSelect method.
    ///
    /// - parameter block: matching block
    mutating func ck_performReject( block: (Key,Value) -> Bool)
    {
        self.ck_performSelect { (key, value) -> Bool in
            return !block(key,value)
        }
    }
    
    /// Find key-value pairs, that do not match provided block. This is reverse of ck_select method
    ///
    /// - parameter block: matching block
    /// - returns: Dictionary, containing key-value pairs, that do not match block
    func ck_reject( block: (Key,Value) -> Bool) -> [Key:Value]
    {
        return self.ck_select({ (key,value) -> Bool in
            return !block(key,value)
        })
    }
    
    /// Find all key-value pairs, that match provided block
    ///
    /// - parameter block: matching block
    /// - returns: Dictionary, containing key-value pairs, that match block
    func ck_select( block: (Element) -> Bool) -> [Key:Value]
    {
        var result: [Key:Value] = Dictionary()
        
        for (key,value) in self {
            if block(key,value)
            {
                result[key] = value
            }
        }
        return result
    }
}