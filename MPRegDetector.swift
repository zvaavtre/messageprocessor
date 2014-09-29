//
//  MPDetector.swift
//  MessageProcessor
//
//  Created by M. David Minnigerode on 9/27/14.
//  Copyright (c) 2014 M. David Minnigerode. All rights reserved.
//

import Foundation


/**

Our basic detector protocol.  Other Detector classes may not be subclasses of MPRegDetector.

*/
protocol Detector{
    /**
    
    The name of the detector. Should be suitable for use as a json key
    
    */
    var name:String {get}

    /**

    The detector will process the input string and return an array of strings that match what it is detecting.

    */
    func detect(inputString:String) -> Array<String>

    // TODO: Eventually detectors may host their own Mapper class for post processing
}


/**

Base Detector class that uses a simple regex matcher to detect desired strings.

Use factory methods to create currently supported detectors.

*/

class MPRegDetector: Detector{
    
    let name:String
    
    let regex:String!
    
    init(name:String, regex:String){
        self.name = name
        self.regex = regex
    }
    
    /**
     
    Create your own RegEx based detector instance.  If your regex has a capture group defined it will be used.  But only the first one.

    */
    class func createDetector(named:String, regex:String) -> Detector{
        return MPRegDetector(name: named, regex: regex)
    }
    
    
    /**
    
    Creates a detector for locating emoticons in a message string.
    
    // 2. Emoticons - For this exercise, you only need to consider 'custom' emoticons which are ASCII strings, no longer than 15 characters, contained in parenthesis. You can assume that anything matching this format is an emoticon. (http://hipchat-emoticons.nyh.name)
    
    */
    
    class func createEmoticonDetector()->Detector{
        return MPRegDetector(name: "emoticons", regex: "\\(([\\w]{1,15}+)\\)")
    }
    
    
    /**
    
    Creates a detector  for locating mentions in a message string.
    
    
    // 1. @mentions - A way to mention a user. Always starts with an '@' and ends when hitting a non-word character. (http://help.hipchat.com/knowledgebase/articles/64429-how-do-mentions-work-)
    
    
    */
    class func createMentionDetector()->Detector{
        return MPRegDetector(name: "mentions", regex: "@([\\w]+)")
       
    }
    
   


    /**
    
    Basic impl of the detect method that uses the String extention.  
    
    */
    func detect(inputString:String) -> Array<String>{
        return inputString.mpMatchStringsForRegex(self.regex)
    }

    
}
