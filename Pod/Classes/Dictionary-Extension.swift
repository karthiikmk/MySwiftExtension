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

public extension Dictionary where Value:Comparable {
    
    var valuesOrderedByAscending:[Value] {
        return self.values.sort()
    }
    
    var valuesOrderedbyDescending:[Value] {
        return self.values.sort().reverse()
    }
    
}

public extension Dictionary where Key:Comparable {
    
    // applicable for int
    var keysOrderedByAscending:[Key] {
        return self.keys.sort()
    }
    var keysOrderedByDescending:[Key] {
        return self.keys.sort().reverse()
    }
    
}


public extension Dictionary {
    
    /// Filter dictionary, deleting all key-value pairs, that do not match provided block.
    /// - parameter block: matching block
    mutating func performSelect( block: (Key,Value) -> Bool){
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
    mutating func performReject( block: (Key,Value) -> Bool){
        self.performSelect { (key, value) -> Bool in
            return !block(key,value)
        }
    }
    
    /// Find key-value pairs, that do not match provided block. This is reverse of ck_select method
    /// - returns: Dictionary, containing key-value pairs, that do not match block
    func reject( block: (Key,Value) -> Bool) -> [Key:Value]
    {
        return self.select({ (key,value) -> Bool in
            return !block(key,value)
        })
    }
    
    /// Find all key-value pairs, that match provided block
    /// - returns: Dictionary, containing key-value pairs, that match block
    func select( block: (Element) -> Bool) -> [Key:Value]
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