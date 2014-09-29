//
//  ViewController.swift
//  MessageProcessor
//
//  Created by M. David Minnigerode on 9/26/14.
//  Copyright (c) 2014 M. David Minnigerode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Our set of test messages
    var messages = [ "@chris you around?", "Good morning! (megusta) (coffee)","Olympics are starting soon; http://www.nbcolympics.com","@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"]

    
    @IBOutlet weak var outputLog: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Init the log text
        outputLog.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doExamples(sender: AnyObject) {
        // KISS
        for m in messages {
            self.dispatchForMessage(m)
        }
        
        
    }

    @IBAction func doYourOwn(sender: AnyObject) {
        
        var inputDialog = UIAlertController(title: "Input Your Own", message: nil , preferredStyle:.Alert)
        inputDialog.addTextFieldWithConfigurationHandler { (textField:UITextField!) -> Void in
            textField.placeholder = "Your Message"
        }
        inputDialog.addAction(UIAlertAction(title: "Cancel", style: .Cancel){ (action) in // nothing 
            
        })
        inputDialog.addAction(UIAlertAction(title: "OK", style: .Default){ [unowned self](action) in
            var tf:UITextField = inputDialog.textFields!.first as UITextField
            if var m = tf.text {
                self.dispatchForMessage(m)
            }
        })

        self.presentViewController(inputDialog, animated: true, completion:nil)
    }
    
    func dispatchForMessage(m:String!){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), {[unowned self]  in
            let p = MessageProcessor()
            let result = p.jsonStringFromMessage(m)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.printIt(m, result: result)
            })
        })

    }
    
    @IBAction func clearLog(sender: AnyObject) {
        outputLog.text = ""
    }
    
    func printIt(message:String!, result:String!){
        var str = "*********************************\nInput: \(message)\n\n"
        str += "Output: \n\(result)\n\n\n"
        let final =  str + outputLog.text
        outputLog.text = final
      
    }
}

