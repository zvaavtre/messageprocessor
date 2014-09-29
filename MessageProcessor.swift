//
//  MessageProcessor.swift
//  MessageProcessor
//
//  Created by M. David Minnigerode on 9/26/14.
//  Copyright (c) 2014 M. David Minnigerode. All rights reserved.
//

import Foundation


/**

MessageProcessor will take a message string and return a json string with info about key content of the message.

Currently we look for the content:

- Mentions in the form of "@<someid>"
- Emoticons in the form of "(<emoticonname>)"
- Links in the form of an http url

Output data will be in the form

Input: "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
Return (string):
    {
    "mentions": [
            "bob",
            "john"
        ],
    "emoticons": [
            "success"
        ]
    "links": [
            {"url": "https://twitter.com/jdorfman/status/430511497475670016","title": "Twitter / jdorfman: nice @littlebigdetail from ..."}
        ]
    }

If the input does not have a particular type we are looking for then the output dict will not contain that key. 

Errors are generally ignored.

Usage:

    var processor = MessageProcessor()
    let outputJsonString = processor.jsonStringFromMessage(message)


*/



class MessageProcessor {
    
    
    
    /**
    
    Detectors that will be used to process the message.
    
    */
    let detectors = [MPRegDetector.createEmoticonDetector(),MPRegDetector.createMentionDetector(),LinkDetector()]
    
    
    /**
    
    Entry point for this whole exercise.  External users should use this one.
    
    */
    func jsonStringFromMessage(message:String)->String{
        
        var model = process(message);
        cleanupModelForPresentation(&model)
        return jsonStringFrom(model)
    }
    
    
    /**
    
    Process the given message and return a complete result model.
    
    Model is a dictionary where the keys are the names of each detector and the values are the output of that detector, which is typically
    an array of strings.
    
    The output of a detector MAY be enhanced such that the value under it's key is more than an array of strings. In our current implementation
    the "links" value will be an array of dictionaries.  See class docs for details.
    
    Further the output model will always have detector keys and an array value even if there are no results in that array.  Use the
    cleanupForPresentation() method to clear these out.
    
    */
    internal func process(message:String!) -> [String:AnyObject]!{
        
        // start with a dictionary that has just the found strings
        var resultCollector = [String:[AnyObject]]()
        
        // loop over the detectors and gather up the found strings
        for detector in detectors {
            resultCollector[detector.name] = detector.detect(message)
        }
        
        // We happen to know that the link detector results need a bit more processing. At this point
        // the 'links' key contains to an array of strings.  We can use the SyncExternalMapper to convert that array
        // into the correct output format
        //
        // TODO: In the future we could enhance this so the processors could provide a more general ResourceMapper class that we would then
        //       use to process their particular data
        
        
        if let links = resultCollector["links"]{
            resultCollector["links"] = SyncLinkExternalMapper.mapLinksToTitles(links as [String])
        }
        
        
        return resultCollector
        
    }
    
    
    
    
    /**
    
    The process() method returns a complete result model even if there are no items for a particular
    detector.  That is, keys pointing to empty lists instead of nils (or missing keys).  
    
    However the spec is asking for those to go away. Rather than do that internally (where the model is more consistant with empty arrays)
    we do that processing here so we can alter at a later time when required.
    
    */
    internal func cleanupModelForPresentation(inout model:[String:AnyObject]!){
        var keysToRemove = [String]()
        for detector in detectors {
            if let v:AnyObject = model[detector.name]{
                if let a = v as? Array<AnyObject> {
                    if a.isEmpty {
                        // remove only if it's an empty array
                        keysToRemove.append(detector.name)
                    }else{
                        // keep these
                    }
                }else{
                    // don't currently do anything with non array
                }
            }else {  // nothing under key...
                keysToRemove.append(detector.name)
            }
        }
        
        for key in keysToRemove{
            model.removeValueForKey(key)
        }
    }
    
    
    /**
    
    In real life would likely pull this out of here.  For this exercise this location makes sense.
    
    */
    internal func jsonStringFrom(dict:[String:AnyObject]!) -> String{
        
        var writer = SBJson4Writer()
        writer.humanReadable = true
        writer.sortKeys = true
        return writer.stringWithObject(dict)
        
        
    }
    
}