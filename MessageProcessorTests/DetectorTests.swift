//
//  DetectorTests.swift
//  MessageProcessor
//
//  Created by M. David Minnigerode on 9/26/14.
//  Copyright (c) 2014 M. David Minnigerode. All rights reserved.
//

import UIKit
import XCTest

class DetectorTests: XCTestCase {
    
    var testEmotes:Dictionary<String,[String]> =
    [   "nothing":[],
        "(test)":["test"],
        "(test) (best) (nope ) ( northis) ( andnotthis ) (1) (thisisjustwaytoolong":["test","best","1"],
        "@(test)(bill)(@stuff)":["test","bill"]
    ]
    
    var testMents:Dictionary<String,[String]> =
    [   "nothing":[],
        "@test":["test"],
        "@test @best @ nope  @1 @thisisjustfineaswell":["test","best","1","thisisjustfineaswell"],
        "@test92929(":["test92929"],
        "(test),(@stuff),@(bill)":["stuff"]
        
    ]
    
    
    var testURLs:Dictionary<String,[String]> =
    [   "nothing to be found":[],
        "stuff http://hi  more stuff":["http://hi"],
        "more than http://something:8080/for/this.html just one https://else   ":["http://something:8080/for/this.html","https://else"]
        
    ]

    
    func testEmoticons() {
        
        var detector = MPRegDetector.createEmoticonDetector()
        
        for key in testEmotes.keys {
            let result = detector.detect(key)
            println("Result for key \(key) are: \(result)")
            XCTAssert(result == testEmotes[key]!, "Same values")
            
        }
        
    }
    
    func testMentions() {
        
        var detector = MPRegDetector.createMentionDetector()
        
        for key in testMents.keys {
            let result = detector.detect(key)
            println("Result for key \(key) are: \(result)")
            XCTAssert(result == testMents[key]!, "Same values")
            
        }
        
    }
    
    func testURLDetector(){
        var detector = LinkDetector()
        
        for key in testURLs.keys {
            let result = detector.detect(key)
            println("Result for key \(key) are: \(result)")
            XCTAssert(result == testURLs[key]!, "Same values")
            
        }
        
    }
    
  
    
    
    
    
  
}
