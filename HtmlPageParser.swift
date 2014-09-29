//
//  HtmlPageParser.swift
//  MessageProcessor
//
//  Created by M. David Minnigerode on 9/26/14.
//  Copyright (c) 2014 M. David Minnigerode. All rights reserved.
//

import Foundation

/**

Anything relating to parsing of html pages.

*/
class HtmlPageParser{
    
    
    /**
    
    Simply get the title from the given page string.  By default we truncate at 40 chars.
    
    NOTE: Length is not detailed in spec but the titles can get out of hand so want to set some limit.
    
    */
    class func titleFromPage(page:NSString!, truncateAt:Int = 40) -> String!{
        if page == nil {
            return ""
        }
        
        // input will typically be from NSData.
        let p = page as String
        
        // this regex is always case insensitive and we don't have class vars yet... so just drop in here.
        // Also this regex isn't perfect... If we want to be more robust probably be better to try an xml/html parser then fall back to regex. But overkill now.
        let titles:[String] = p.mpMatchStringsForRegex("<title\\b[^>]*>(.*?)</title>")
        if titles.count >= 1 {
            if countElements(titles[0]) > truncateAt {
                return titles[0].mpSubstringWithRange(NSMakeRange(0, truncateAt))       // TODO would be nice to trim this too
            }else{
                return titles[0]
            }
        }
        return ""
    }
    
    
}