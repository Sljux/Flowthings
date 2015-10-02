//
//  isLongerThen.swift
//  Flowthings
//
//  Created by Ceco on 8/11/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation

//CheckString: easier to find available checks in file structure
typealias CheckString = String

extension CheckString {
    
    var length: Int {
        get {
            return self.characters.count
        }
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }

    var integerValue: Int {
        return (self as NSString).integerValue
    }

    func isLongerThen(minCount: Int) -> Bool {
        return self.length > minCount
    }
    
    func isShorterThen(maxCount: Int) -> Bool {
        return self.length < maxCount
    }
    
    func isFloat() -> Bool {
        
        return isMatch("[-+]?(\\d*[.])?\\d+")
    }
    
    func isPhoneNumber() -> Bool {
        
        return isMatch("^\\d{10}$")
    }
    
    func isEmail() -> Bool {
        return isMatch("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$")
    }
    
    func isFullName() -> Bool {
        let nameArray: [String] = self.componentsSeparatedByString(" ")
        return nameArray.count >= 2
    }
    
    func isMatch(pattern: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern,
            options: [.CaseInsensitive])
        
        return regex.firstMatchInString(self, options:[],
            range: NSMakeRange(0, utf16.count)) != nil
    }
    
    func contains(s: String) -> Bool {
        return self.rangeOfString(s) != nil
    }
    
    func replace(target: String, withString: String) -> String {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    subscript (i: Int) -> Character {
        get {
            let index = startIndex.advancedBy(i)
            return self[index]
        }
    }
    
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = self.startIndex.advancedBy(r.endIndex - 1)
            
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
    
    func subString(startIndex: Int, length: Int) -> String {
        let start = self.startIndex.advancedBy(startIndex)
        let end = self.startIndex.advancedBy(startIndex + length)
        return self.substringWithRange(Range<String.Index>(start: start, end: end))
    }
    
    func indexOf(target: String) -> Int {
        let range = self.rangeOfString(target)
        if let range = range {
            return self.startIndex.distanceTo(range.startIndex)
        } else {
            return -1
        }
    }
    
    func indexOf(target: String, startIndex: Int) -> Int {
        let startRange = self.startIndex.advancedBy(startIndex)
        
        let range = self.rangeOfString(target, options: NSStringCompareOptions.LiteralSearch, range: Range<String.Index>(start: startRange, end: self.endIndex))
        
        if let range = range {
            return self.startIndex.distanceTo(range.startIndex)
        } else {
            return -1
        }
    }
    
    func lastIndexOf(target: String) -> Int {
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
    
    private var vowels: [String] {
        get {
            return ["a", "e", "i", "o", "u"]
        }
    }
    
    private var consonants: [String] {
        get {
            return ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z"]
        }
    }
}