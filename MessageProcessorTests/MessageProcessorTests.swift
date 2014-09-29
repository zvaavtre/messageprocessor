//
//  MessageProcessorTests.swift
//  MessageProcessor
//
//  Created by M. David Minnigerode on 9/27/14.
//  Copyright (c) 2014 M. David Minnigerode. All rights reserved.
//

import UIKit
import XCTest

class MessageProcessorTests: XCTestCase {

    
    
    
    /**
        
    Ideally we would have these inputs and the correct outputs externalized in a testing resource directory. For this example project that's a bit much.
    
    Instead you can run the app and play with the input and observe the output.

    */
   
    func testExamples() {
        let mp = MessageProcessor();
        var messages = [ "@chris you around?", "Good morning! (megusta) (coffee)","Olympics are starting soon; http://www.nbcolympics.com","@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"]
        for message in messages {
            printIt(message,result:mp.jsonStringFromMessage(message))
        }
    
    }
    
    
    func printIt(message:String, result:String){
        println("Input: \(message)")
        println("Output:\n\(result)\n\n\n")
        
        
    }


}
