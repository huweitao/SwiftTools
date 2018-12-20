//
//  Date+Extension.swift
//  HSwiftTools
//
//  Created by huweitao on 2018/11/1.
//  Copyright © 2018 huweitao. All rights reserved.
//

import Foundation

private let dateformatter = DateFormatter()

extension Date {
    /// s timestamp - 10位
    var g_timeStamp : Int {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }
    
    /// ms timestamp - 13位
    var g_milliStamp : Int64 {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return millisecond
    }
    
    static func currentZoneDate() -> Date {
        // 得到当前时间（世界标准时间 UTC/GMT）
        var date:Date = Date()
        // 设置系统时区为本地时区
        let zone:TimeZone = NSTimeZone.local
        // 计算本地时区与 GMT 时区的时间差
        let second:Int = zone.secondsFromGMT()
        // 在 GMT 时间基础上追加时间差值，得到本地时间
        date = date.addingTimeInterval(TimeInterval(second))
        return date
    }
    
    static func timestampToDateFormat(_ timestamp:UInt) -> String? {
        let timeInterval:TimeInterval = TimeInterval(timestamp)
        let date = Date(timeIntervalSince1970: timeInterval)
        dateformatter.dateFormat = "dd MMM yyyy | h:mm a"
        dateformatter.locale = NSLocale.current
        let time = dateformatter.string(from: date)
        return time
    }
}
