//
//  Global.swift
//  JSContextFoundation
//
//  Created by Zheng-Xiang Ke on 2016/5/13.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import Foundation
import JavaScriptCore

@objc protocol GlobalJSExport : JSExport {
}

@objc class Global : NSObject, GlobalJSExport, JSInsert {
    func insert(jsContext: JSContext) {
        jsContext.setObject(self, forKeyedSubscript:"global")
        jsContext.evaluateScript("var window = global;")
    }
}