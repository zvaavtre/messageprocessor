//
//  RegExExtention.swift
//  MessageProcessor
//
//  Created by M. David Minnigerode on 9/26/14.
//  Copyright (c) 2014 M. David Minnigerode. All rights reserved.
//

import Foundation

/**

Enhance Swift Strings with some useful util functions.

Typically we'd be more careful about doing this to a core class, but ok for this exercise.

*/

extension String{
    
    /**
    
    Helper for matching the various regexes we use.
    
    If there is a capture group in the regex we'll use that to extract the match.  But only for the first one.
    
    */
    func mpMatchStringsForRegex(regex:String) -> Array<String>{
        var output = Array<String>()
        
        // return empty if empty
        if self.isEmpty {
            return output
        }
        
        // Ignore the error, just check that we got a pattern.  TODO: Would be ideal to log this error case.
        if let pat = NSRegularExpression(pattern: regex, options: .CaseInsensitive, error: nil){
            pat.enumerateMatchesInString(self, options: nil, range:  NSMakeRange(0,countElements(self)), usingBlock: { (match, statusFlags, stop) -> Void in
                // if we have a capture group defined in the regex it'll be the match at index 1.
                let r = match.numberOfRanges > 1 ? match.rangeAtIndex(1):match.rangeAtIndex(0)
                output.append(self .mpSubstringWithRange(r))
            })
        }
        
        
        return output
        
    }
    
    /**
    
    Returns he substring in the given range.
    
    NOTE: This does no more bounds checking than the NSString version!
    NOTE: Swift needs a String.substringWithRange func.
    
    */
    func mpSubstringWithRange(range:NSRange!) -> String{
        let nsString = self as NSString
        return nsString.substringWithRange(range) as String
    }
    
}
