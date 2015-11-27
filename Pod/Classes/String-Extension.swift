//
//  String-Extension.swift
//  Created by Karthik on 18/11/15.
//
//

import UIKit


//MARK: BASIC STRING EXTENSION
public extension String{
    
    var length: Int {
        return self.characters.count
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
    }
    
    func trimNewLine() -> String {
        return self.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    
    func contains(str:String?)->Bool{
        return (self.rangeOfString(str!) != nil) ? true : false
    }
    
    func replaceCharacterWith(characters: String, toSeparator: String) -> String {
        let characterSet = NSCharacterSet(charactersInString: characters)
        let components = self.componentsSeparatedByCharactersInSet(characterSet)
        let result = components.joinWithSeparator(toSeparator)
        return result
    }
    
    func wipeCharacters(characters: String) -> String {
        return self.replaceCharacterWith(characters, toSeparator: "")
    }
    
    func replace(find findStr: String, replaceStr: String) -> String{
        return self.stringByReplacingOccurrencesOfString(findStr, withString: replaceStr, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    func splitStringWithLimit(delimiter:String?="", limit:Int=0) -> [String]{
        let arr = self.componentsSeparatedByString((delimiter != nil ? delimiter! : ""))
        return Array(arr[0..<(limit > 0 ? min(limit, arr.count) : arr.count)])
        
        // use : print(s.split(",", limit:2))  //->["part1","part2"]
    }
    
    func createURL() -> NSURL{
        return NSURL(string: self)!
    }
 
    func isEmailValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(email)
        
        return result
    }
}


//MARK: STRING to CONVERSION
public extension String{
    
    var toFloat : Float{
        return Float(self)!
    }
    
    var toDouble : Double{
        return Double(self)!
    }
    
    var toInt : Int{
        return Int(self)!
    }
    
    var toInt32 : Int32{
        return Int32(self)!
    }
    
    var toInt64 : Int64{
        // 32 bit check needed
        return (Int(self) != nil) ? Int64(self)! : ((self as NSString).longLongValue)
    }
    
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    
    var toNumber : NSNumber{
        return NSNumber(integer: self.toInt)
    }
    
    var toNumber_32Bit : NSNumber{
        return NSNumber(int: self.toInt32)
    }
    
    var toNumber_64Bit : NSNumber{
        return NSNumber(longLong: self.toInt64)
    }
}


//MARK:STRING PROTOCOL EXTENSION

protocol StringType{
    var characters: String.CharacterView { get }
}

extension String : StringType{
    
}


//MARK:STRING SUB_SCTRIPT

extension String{
    
    subscript (i: Int) -> Character{
        let index = startIndex.advancedBy(i)
        return self[index]
        // Use : "abcde"[0] === "a"
    }
    subscript (i: Int) -> String {
        return String(self[i] as Character)
        // Use : "abcde"[0...2] === "abc"
    }
    
    subscript (range: Range<Int>) -> String{
        let startIndex = self.startIndex.advancedBy(range.startIndex)
        let endIndex = self.startIndex.advancedBy(range.endIndex - 1)
        return self[Range(start: startIndex, end: endIndex)]
        // Use : "abcde"[2..<4] === "cd"
    }
}


//MARK:STIRNG COMPARISION
extension String{
    
    public func rangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
        let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
        if let from = String.Index(from16, within: self),let to = String.Index(to16, within: self) {
            return from ..< to
        }
        return nil
    }
    
    public func subString(startIndex: Int, length: Int) -> String{
        let start = self.startIndex.advancedBy(startIndex)
        
        let end = self.startIndex.advancedBy(startIndex + length)
        return self.substringWithRange(Range<String.Index>(start: start, end: end))
    }
    
    public func indexOf(target: String) -> Int{
        let range = self.rangeOfString(target)
        if let tempRange = range {
            return self.startIndex.distanceTo(tempRange.startIndex)
        } else {
            return -1
        }
    }
    
    public func indexOf(target: String, startIndex: Int) -> Int{
        let startRange = self.startIndex.advancedBy(startIndex)
        
        let range = self.rangeOfString(target, options: NSStringCompareOptions.LiteralSearch, range: Range<String.Index>(start: startRange, end: self.endIndex))
        
        if let range = range {
            return self.startIndex.distanceTo( range.startIndex)
        }
        else {
            return -1
        }
    }
    
    public func lastIndexOf(target: String) -> Int{
        var index = -1
        var stepIndex = self.indexOf(target)
        while stepIndex > -1
        {
            index = stepIndex
            if stepIndex + target.length < self.length {
                stepIndex = indexOf(target, startIndex: stepIndex + target.length)
            } else {
                stepIndex = -1
            }
        }
        return index
    }
    
    public func isMatch(regex: String, options: NSRegularExpressionOptions) -> Bool{
        var exp : NSRegularExpression?
        
        do{
            exp = try NSRegularExpression(pattern: regex, options: options)
            
        }catch let error as NSError{
            print("\(error.localizedDescription)")
        }
        
        let matchCount = exp!.numberOfMatchesInString(self, options: [], range: NSMakeRange(0, self.length))
        return matchCount > 0
    }
    
    public func getMatches(regex: String, options: NSRegularExpressionOptions) -> [NSTextCheckingResult]{
        
        var exp : NSRegularExpression?
        
        do{
            exp = try NSRegularExpression(pattern: regex, options: options)
            
        }catch let error as NSError{
            print("\(error.localizedDescription)")
        }
        let matches = exp!.matchesInString(self, options: [], range: NSMakeRange(0, self.length))
        return matches as [NSTextCheckingResult]
    }
    
    private var vowels: [String]{
        return ["a", "e", "i", "o", "u"]
    }
    
    private var consonants: [String]{
        return ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z"]
    }
    
    public func pluralize(count: Int) -> String
    {
        if count == 1 {
            return self
        } else {
            let lastChar = self.subString(self.length - 1, length: 1)
            let secondToLastChar = self.subString(self.length - 2, length: 1)
            var prefix = "", suffix = ""
            
            if lastChar.lowercaseString == "y" && vowels.filter({x in x == secondToLastChar}).count == 0 {
                prefix = self[0...self.length - 1]
                suffix = "ies"
            } else if lastChar.lowercaseString == "s" || (lastChar.lowercaseString == "o" && consonants.filter({x in x == secondToLastChar}).count > 0) {
                prefix = self[0...self.length]
                suffix = "es"
            } else {
                prefix = self[0...self.length]
                suffix = "s"
            }
            
            return prefix + (lastChar != lastChar.uppercaseString ? suffix : suffix.uppercaseString)
        }
    }
    
    public func regexMatchesInString(regexString:String) -> [String] {
        
        var arr :[String] = []
        var rang = Range(start: self.startIndex, end: self.endIndex)
        var foundRange:Range<String.Index>?
        
        repeat{
            
            foundRange = self.rangeOfString(regexString, options: NSStringCompareOptions.RegularExpressionSearch, range: rang, locale: nil)
            
            if let a = foundRange {
                arr.append(self.substringWithRange(a))
                rang.startIndex = a.endIndex
            }
        }
            while foundRange != nil
        
        
        return arr
        //"Hello".regexMatchesInString("[^Hh]{1,}")
    }
    
}


