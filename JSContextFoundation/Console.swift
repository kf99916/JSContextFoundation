//
//  Console.swift
//  JSContextFoundation
//
//  Created by Zheng-Xiang Ke on 2016/5/13.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import Foundation
import JavaScriptCore

@objc enum ConsoleLevel : Int {
    case log, info, warn, error
}
@objc protocol ConsoleJSExport : JSExport {
    func output(_ level: ConsoleLevel, arguments: [AnyObject])
}

@objc class Console : NSObject, ConsoleJSExport, JSInsert {
    let levelDictionary : [ConsoleLevel : String] = [
        .log: "",
        .info: "[info]",
        .warn: "[WARN]",
        .error: "[ERROR]"
    ]
    
    func output(_ level: ConsoleLevel, arguments: [AnyObject]) {
        var levelOutput = levelDictionary[level]
        if levelOutput == nil {
            levelOutput = ""
        }

        print("[JSCotextFoundation]" + levelOutput!, terminator: " ")
        for argument in arguments {
            print(argument, terminator: " ")
        }
        
        
        // new line
        print("")
    }
    
    func insert(_ jsContext: JSContext) {
        jsContext.setObject(self, forKeyedSubscript:"$console" as (NSCopying & NSObjectProtocol)!)
        jsContext.evaluateScript(
            "var console = {" +
                "log: function() { $console.outputArguments(0, arguments); }," +
                "info: function() { $console.outputArguments(1, arguments); }," +
                "warn: function() { $console.outputArguments(2, arguments); }," +
                "error: function() { $console.outputArguments(3, arguments); }" +
            "};" +
            "if (global) { global.console = console; }"
        )
    }
}
