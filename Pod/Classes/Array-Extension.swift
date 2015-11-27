//
//  Array-Extension.swift
//  DateHelper
//
//  Created by Karthik on 18/11/15.
//  Copyright © 2015 Karthik. All rights reserved.
//

import UIKit

//MARK:My Extension

extension Array{
    
    
    var isEmpty : Bool{
        return self.isEmpty
    }
    
    mutating func addElements(new : Element){
        self.append(new)
    }
    
    mutating func removeLastObj() -> Element{
        return self.removeLast()
    }
    
    mutating func removeFirstObj() ->Element{
        return self.removeFirst()
    }
    
    public mutating func flushArray(){
        // will give empty Arr
        return self.removeAll()
    }
    
    func joinArrayBySeperator(separator:String) -> String {
        return self.map({ String($0) }).joinWithSeparator(separator)
    }
    
    
    
}


// MARK:ARRAY protocol extension

public extension Array where Element: Equatable {
    
     func removeObject(object: Element) -> [Element] {
        return filter { $0 != object }
    }
    
     func removeObjectsInArray(objects : [Element]){
        for obj in objects{
            self.removeObject(obj)
        }
    }
    
     func containsObj(obj : Element)-> Bool{
        return self.contains(obj) == true
    }
    
     func findObj (obj: Element) -> Bool {
        return (indexOf(obj) != nil) ? true : false
    }
    
    func contains<T where T : Equatable>(object: T) -> Bool {
        return self.filter({$0 as? T == object}).count > 0
    }
    
}

extension Array where Element : StringType{
    
    // ["test","123"] -> "test123"
    func combineAllStrInArr() -> String  {
        return String(self.map{$0.characters}.reduce(String.CharacterView(), combine: {$0 + $1}))
    }
}


//MARK:Github Extension

public extension Array {
    
    /// Filter array, deleting all objects, that do not match block
    ///
    /// - parameter block: matching block.
    mutating func ck_performSelect(block: (Element) -> Bool) {
        var indexes = [Int]()
        for (index,element) in self.enumerate() {
            if !block(element) { indexes.append(index)}
        }
        
        self.removeAtIndexes(indexes)
    }
    
    /// Filter array, deleting all objects, that match block
    ///
    /// - parameter block: matching block
    mutating func ck_performReject(block: (Element) -> Bool) {
        return self.ck_performSelect({ (element) -> Bool in
            return !block(element)
        })
    }
}

private extension Array
{
    mutating func removeAtIndexes( indexes: [Int]) {
        for index in indexes.sort(>) {
            self.removeAtIndex(index)
        }
    }
}
