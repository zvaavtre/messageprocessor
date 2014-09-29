# MessageProcessor #

Example code/app that will consume a chat message string and emit a json string containing info about specific content of the app.

It looks for 

* mentions - Of the form @{userid}
* emoticons - Of the form ({emoticonname})
* http links - http://cnn.com

Output of `MessageProcessorTests`

	Input: @bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016
	Output:
	{
	  "emoticons": [
	    "success"
	  ],
	  "links": [
	    {
	      "title": "Justin Dorfman on Twitter: &quot;nice @l",
	      "url": "https://twitter.com/jdorfman/status/430511497475670016"
	    }
	  ],
	  "mentions": [
	    "bob",
	    "john"
	  ]
	}


## Architecture ##

* `MessageProcessor` - Main entry point.  Uses a list of detectors to locate the items of interest.
* `MPRegDetector` - Base detector class, factory for creating simple regex detectors. Defines `Detector` protocol.
* `LinkDetector` - Special detector that uses the built in `NSTextCheckingTypeLink` detector. Conforms to our Detector protocol.
* `String+MPUtils` - Utils for the String class.
* `HtmlPageParser` - Only looks for titles. Not very fancy.
* `SyncLinkExternalMapper` - Partner class for the link detector that maps a list of links to link, title pairs.

Please see the source code for more detail.  A good starting place is [MessageProcessor.swift](https://bitbucket.org/minniger/messageprocessor/src/e51c42050537c24f07b4a9e6eba9b5060f00dc13/MessageProcessor.swift?at=master).



## Building  ##

1. install the latest version of cocoa pods that can handle `Swift` projects  (currently this is `0.34.1`). 
2. install then into the project.

	 > pod install

3. open the workspace (not the project).
4. run the tests.
5. run the app.


## App ##

The app is a universal iOS 8 project.  

![App Screenshot](https://bitbucket.org/repo/5oLEBp/images/2499147738-app-screen.png)

Note that the results come in at the top of the view.



## Spec Notes ##

- All errors are suppressed and result in empty strings and arrays rather than nils.
- URLs with no title are returned with an empty string for the title.
- Titles are trimmed at 40 chars. Was not clear how to handle this from the spec so picked something.
- All json object entries are sorted.
- Close to i18n ready, but no tests for it, therefore likely bugs to be found.


## Spec ##

	Take a chat message string and returns a JSON string containing information about its contents. Special content to look for includes:
	1. @mentions - A way to mention a user. Always starts with an '@' and ends when hitting a non-word character. (http://help.hipchat.com/knowledgebase/articles/64429-how-do-mentions-work-)
	2. Emoticons - For this exercise, you only need to consider 'custom' emoticons which are ASCII strings, no longer than 15 characters, contained in parenthesis. You can assume that anything matching this format is an emoticon. (http://hipchat-emoticons.nyh.name)
	3. Links - Any URLs contained in the message, along with the page's title.
 
	For example, calling your function with the following inputs should result in the corresponding return values.
	Input: "@chris you around?"
	Return (string):
	{
	  "mentions": [
	    "chris"
	  ]
	}

	Input: "Good morning! (megusta) (coffee)"
	Return (string):
	{
	  "emoticons": [
	    "megusta",
	    "coffee"
	  ]
	}


	Input: "Olympics are starting soon; http://www.nbcolympics.com"
	Return (string):
	{
	  "links": [
	    {
	      "url": "http://www.nbcolympics.com",
	      "title": "NBC Olympics | 2014 NBC Olympics in Sochi Russia"
	    }
	  ]
	}


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
	    {
	      "url": "https://twitter.com/jdorfman/status/430511497475670016",
	      "title": "Twitter / jdorfman: nice @littlebigdetail from ..."
	    }
	  ]
	}