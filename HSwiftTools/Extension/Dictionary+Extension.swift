//
//  Dictionary+JSON.swift
//  GCash
//
//  Created by huweitao on 2018/11/27.
//  Copyright © 2018 GXI. All rights reserved.
//

import Foundation

extension Dictionary {
    func dictionary2JSONString() -> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [])
            let str = String(data: data, encoding: String.Encoding.utf8)
            return str
        } catch {
            print("\(error)")
            return nil
        }
    }
}
