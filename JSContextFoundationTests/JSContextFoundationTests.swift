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
        super.tearDown()
    }
    
    func testVariablesAreDefined() {
        jsContext!.evaluateScript("global")
        jsContext!.evaluateScript("window")
        jsContext!.evaluateScript("console")
        jsContext!.evaluateScript("global.console")
        jsContext!.evaluateScript("window.console")
    }
    
    func testConsole() {
        jsContext!.evaluateScript("console.log('test console.log');")
        jsContext!.evaluateScript("console.info('test console.info');")
        jsContext!.evaluateScript("console.warn('test console.warn');")
        jsContext!.evaluateScript("console.error('test console.error');")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
