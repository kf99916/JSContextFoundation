//
//  JSContextFoundation.swift
//  JSContextFoundation
//
//  Created by Zheng-Xiang Ke on 2016/5/13.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import Foundation
import JavaScriptCore

public enum JSContextFoundationError: ErrorType {
    case FileNotFound
    case FileNotLoaded
    case FileNotDownloaded
}

public class JSContextFoundation : JSContext {
    public override init!(virtualMachine: JSVirtualMachine!) {
        super.init(virtualMachine: virtualMachine)
        
        exceptionHandler = { context, exception in
            print("[JSCotextFoundation][Exception] \(exception)")
        }
        
        insert()
    }
    
    public convenience override init!() {
        self.init(virtualMachine: JSVirtualMachine())
    }
    
    public func requireWithPath(path: String) throws {
        guard NSFileManager.defaultManager().fileExistsAtPath(path) else {
            throw JSContextFoundationError.FileNotFound
        }
        guard let script = try? String(contentsOfFile: path, encoding: NSUTF8StringEncoding) else {
            throw JSContextFoundationError.FileNotLoaded
        }
        
        evaluateScript(script)
    }
    
    public func requireWithUrl(url: NSURL, completionHandler: (ErrorType?) -> Void) {
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let error = error {
                completionHandler(error)
            }
            else {
                guard let httpResponse = response as? NSHTTPURLResponse else {
                    completionHandler(JSContextFoundationError.FileNotDownloaded)
                    return
                }
                
                switch httpResponse.statusCode {
                case 404:
                    completionHandler(JSContextFoundationError.FileNotFound)
                default:
                    guard let data = data, let script = String(data: data, encoding: NSUTF8StringEncoding) as String? else {
                        completionHandler(JSContextFoundationError.FileNotDownloaded)
                        return
                    }
                    
                    self.evaluateScript(script)
                    completionHandler(nil)
                }
            }
        }
        
        task.resume()
    }
    
    private func insert() {
        let jsInsertArray: [JSInsert] = [Global(), Console()]
        for jsInsert in jsInsertArray {
            jsInsert.insert(self)
        }
    }
}