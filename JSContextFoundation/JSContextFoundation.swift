//
//  JSContextFoundation.swift
//  JSContextFoundation
//
//  Created by Zheng-Xiang Ke on 2016/5/13.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import Foundation
import JavaScriptCore

public class JSContextFoundation : JSContext {
    public override init!(virtualMachine: JSVirtualMachine!) {
        super.init(virtualMachine: virtualMachine)
        
        let global = Global()
        global.insert(self)
        
        let console = Console()
        console.insert(self)
    }
    
    public convenience override init!() {
        self.init(virtualMachine: JSVirtualMachine())
    }
}