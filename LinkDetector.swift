//
//  LinkDetector.swift
//  MessageProcessor
//
//  Created by M. David Minnigerode on 9/26/14.
//  Copyright (c) 2014 M. David Minnigerode. All rights reserved.
//

import Foundation

/**

Detector style class for locating URLs in a message string

Notice this is a bit different than our MPRegDetector class.  Apple has a good URL data detector we can just reuse.

Has the added benefit that users are already familiar with the types of urls that the built in apps will match.

// 3. Links - Any URLs contained in the message, along with the page's title.

Also notice that we are NOT getting the titles here. Just locating the urls. The *LinkExternalMapper classes know now to add in the titles.

*/
class LinkDetector:Detector{
    
    let name = "links"
    
    /**
    
    Locate any URLs in the input..
    
    */
    func detect(inputString:String) -> Array<String>{
        let detector = NSDataDetector.dataDetectorWithTypes(NSTextCheckingType.Link.toRaw(), error:nil)
        let matches = detector?.matchesInString(inputString, options:nil, range: NSMakeRange(0,countElements(inputString)))
        var out = [String]()
        if matches != nil {
            for match in matches as Array<NSTextCheckingResult> {
                out.append(inputString.mpSubstringWithRange(match.range))
            }
        }
        return out
    }
    
    
    
}