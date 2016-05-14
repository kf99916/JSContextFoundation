//
//  JSContextFoundationTests.swift
//  JSContextFoundationTests
//
//  Created by Zheng-Xiang Ke on 2016/5/14.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import XCTest
@testable import JSContextFoundation

class JSContextFoundationTests: XCTestCase {
    var jsContext : JSContextFoundation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        jsContext = JSContextFoundation()
        jsContext!.exceptionHandler = { context, exception in
            XCTFail(exception.toString())
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        jsContext = nil
        super.tearDown()
    }
    
    func testVariablesAreDefined() {
        jsContext!.evaluateScript("global;")
        jsContext!.evaluateScript("window;")
        jsContext!.evaluateScript("console;")
        jsContext!.evaluateScript("global.console;")
        jsContext!.evaluateScript("window.console;")
    }
    
    func testConsole() {
        jsContext!.evaluateScript("console.log('test console.log');")
        jsContext!.evaluateScript("console.info('test console.info');")
        jsContext!.evaluateScript("console.warn('test console.warn');")
        jsContext!.evaluateScript("console.error('test console.error');")
    }
    
    func testRequireWithPath() {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("MyClass", ofType: "js")!
        
        do {
            try jsContext!.requireWithPath(path)
        } catch JSContextFoundationError.FileNotFound {
            XCTFail(path + " is not found")
        } catch JSContextFoundationError.FileNotLoaded {
            XCTFail(path + " cannot be loaded")
        } catch {
            XCTFail("Unknow Exception")
        }
        
        jsContext!.evaluateScript(
            "var myClass = new window.MyClass();" +
            "window.console.log(myClass.value);"
        )
    }
    
    func testRequireWithUrl() {
        guard let url = NSURL(string: "https://raw.githubusercontent.com/kf99916/JSContextFoundation/master/JSContextFoundationTests/MyClass.js") else {
            XCTFail("Invalid Url")
            return
        }
        
        let asyncExpectation = expectationWithDescription("asyncExpectation")
        
        jsContext!.requireWithUrl(url, completionHandler: {error in
            if let error = error {
                switch error {
                case JSContextFoundationError.FileNotFound:
                    XCTFail(url.absoluteString + " is not found")
                case JSContextFoundationError.FileNotDownloaded:
                    XCTFail(url.absoluteString + " is not downloaded")
                default:
                    XCTFail("Unknown Error")
                }
                
                return
            }
            
            self.jsContext!.evaluateScript(
                "var myClass = new window.MyClass();" +
                "window.console.log(myClass.value);"
            )
            asyncExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error, "Timeout")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
