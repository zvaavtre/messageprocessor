//
//  MessageProcessorTests.swift
//  MessageProcessorTests
//
//  Created by M. David Minnigerode on 9/26/14.
//  Copyright (c) 2014 M. David Minnigerode. All rights reserved.
//

import UIKit
import XCTest

class MapperTests: XCTestCase {
    
    // This model is exactly what should exist under the "links" key in the desired output for the exercise
    let testTitles = [
                      ["url":"http://google.com","title":"Google"],
        
                      ["url":"http://cnn.com","title":"CNN.com - Breaking News, U.S., World, We"],
        
                      ["url":"https://twitter.com/altonbrown/status/515267102408978432","title":"Alton Brown on Twitter: &quot;RT @B_Mon:"],
        
                      ["url":"http://www.nbcolympics.com","title":"NBC Olympics | Home of the 2016 Olympic "],
        
                      ["url":"httpp://badurl","title":""],
        
                      ["url":"http://adslfjawerwer.gov","title":""]
    ]
  
    /*
       NOTE: Also an integration test.  Better to test with live html than not.
     */
    func testSyncLinkMapper(){
        // Extract the urls from the test data
        let links = testTitles.map(){(input:[String:String]) -> String in
            return input["url"]!
        }
        
        //
        let out:[[String:String]] = SyncLinkExternalMapper.mapLinksToTitles(links)
        println("\(out)")
        XCTAssert(testTitles == out, "Should have all the correct titles for the pages. Test titles MAY NEED UPDATING if this fails. Source pages may change")
        
    }
    
    
   
    
}
