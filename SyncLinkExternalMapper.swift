//
//  SyncLinkRetriver.swift
//  MessageProcessor
//
//  Created by M. David Minnigerode on 9/26/14.
//  Copyright (c) 2014 M. David Minnigerode. All rights reserved.
//

import Foundation


/**

Partner class with the LinkDetector that knows how to 'map' the LinkDetector output array into an array of dictionaries.

*/
class SyncLinkExternalMapper {
    
    /**
    Get the titles for the given links.  Returns an array of link,title arrays
    
    If there is any error or the title cannot be found then set the result to ""
    
    Does this sync, one at a time.
    
    Notice the requirement for this output is:
    
    "links": [
        {"url": "https://twitter.com/jdorfman/status/430511497475670016","title": "Twitter / jdorfman: nice @littlebigdetail from ..."}
    ]
    
    That is equivilent to... [[String:String]] - An array of dictionaries, each one has two keys, url and title.
    
    Spec is undefined what to do if we can't get a title.  For now we set the title value to "" and keep the key
    
    */
    class func mapLinksToTitles(links:[String]!)->[[String:String]]!{
        // Use the fun map method with a closure to do the work... we are doing this sync anyway... not worring about perf
        return links.map(){ (link:String) -> [String:String] in
            // avoid capturing a ref to the class
            let urlKey = "url"
            let titleKey = "title"
            
            // Now return the dictionary to complete the [[String:String]] type in the output of the map
            let url = NSURL(string:link)
            if url == nil{
                return [urlKey:link, titleKey:""]
            }
            var page =  NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error: nil)  // Note we are guessing at encoding here.
            if page == nil {
                return [urlKey:link, titleKey:""]
            }
            
            return [urlKey:link,titleKey:HtmlPageParser.titleFromPage(page)]
            
        }
    }
    
    
}
