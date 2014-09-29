# MessageProcessor #

Example code/app that will consume a chat message string and emit a json string containing info about specific content of the app.

It looks for 

* mentions - Of the form @{userid}
* emoticons - Of the form ({emoticonname})
* http links - http://cnn.com


# Docs #

Please see the source code.  A good starting place is the [MessageProcessor.swift](https://bitbucket.org/minniger/messageprocessor/src/f0b85e201ddda0de898b0cc11909446b656a09de/MessageProcessor.swift?at=master) class.



## Building  ##

1. install the latest version of cocoa pods
2. get the pods
```
#!bash

 pod install
```
3. open the workspace file
4. run the tests
5. run the app


## Original Spec ##

