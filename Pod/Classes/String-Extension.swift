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
    
}