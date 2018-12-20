//
//  String+JSON.swift
//  GCash
//
//  Created by huweitao on 2018/10/11.
//  Copyright © 2018年 GXI. All rights reserved.
//

import Foundation

extension String {
    func jsonStringToDictionary() -> Dictionary<String,Any>? {
        do {
            let anyObj = try JSONSerialization.jsonObject(with: self.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.allowFragments)
            let dict = anyObj as? [String:Any]
            return dict
        } catch {
            print("\(error)")
            return nil
        }
    }
}
