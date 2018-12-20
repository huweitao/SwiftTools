//
//  LogTools.swift
//  HSwiftTools
//
//  Created by huweitao on 2018/11/1.
//  Copyright © 2018 huweitao. All rights reserved.
//

import Foundation

let GPrefixKey = "🍏"
let needMethod = false
let isModeOn = true

// MARK: - Public
func DLLog<T>(_ message: T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    DLogWithType(message,0,file, funcName, lineNum)
}

func DLLogInfo<T>(_ message: T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    DLogWithType(message,1,file, funcName, lineNum)
}

func DLLogWarn<T>(_ message: T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    DLogWithType(message,2,file, funcName, lineNum)
}

func DLLogError<T>(_ message: T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    DLogWithType(message,3,file, funcName, lineNum)
}

// MARK: - Main logger
func DLogWithType<T>(_ message:T, _ type:Int = 0,_ file:String?, _ funcName:String?, _ lineNum:Int?) {
    
    if !isModeOn {
        return;
    }
    
    var typeMsg = "default"
    //    "📒📕📗📙"
    
    var preEmoji = ""
    switch type {
    case 0:
        break;
    case 1:
        preEmoji = "📗"
        typeMsg = "info"
    case 2:
        preEmoji = "📒"
        typeMsg = "warn"
    case 3:
        preEmoji = "📕"
        typeMsg = "error"
    default:
        break;
    }
    
    let fileName = (file! as NSString).lastPathComponent
    let pre = needMethod ? "\(fileName)-\(funcName!)":"\(fileName)"
    let msg = "[[\(pre)(line:\(lineNum!))][\(preEmoji)\(typeMsg)]:\(message)";
    print(msg)
}
