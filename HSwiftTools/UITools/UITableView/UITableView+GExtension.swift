//
//  UITableView+GExtension.swift
//  GCash
//
//  Created by huweitao on 2018/11/2.
//  Copyright © 2018 GXI. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    // MARK: - nibName Should be the same as ReuseIdentifier
    func registerNibCell(cellClassName:String) {
        let cellNib = UINib.init(nibName: cellClassName, bundle: nil)
        self.register(cellNib, forCellReuseIdentifier: cellClassName)
    }
    
    func registerNibCells(cellNames:Array<String>) {
        if cellNames.count == 0 {
            return
        }
        for cellName in cellNames {
            registerNibCell(cellClassName: cellName)
        }
    }
    
    func safeRelaodData() {
        weak var weakSelf:UITableView? = self
        HSafeAsyncMainThread {
            weakSelf?.reloadData()
        }
    }
}
