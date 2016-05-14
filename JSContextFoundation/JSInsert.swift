//
//  JSInsert.swift
//  JSContextFoundation
//
//  Created by Zheng-Xiang Ke on 2016/5/13.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import Foundation
import JavaScriptCore

@objc protocol JSInsert {
    func insert(jsContext: JSContext)
}