//
//  UnSeedConfiguration.swift
//  GCash
//
//  Created by huweitao on 2018/12/13.
//  Copyright © 2018年 GXI. All rights reserved.
//

import Foundation

class UnSeedConfiguration: NSObject {
    static let shared:UnSeedConfiguration = UnSeedConfiguration()
    private override init() {
        super.init()
    }
    
    func configure() {
        // page monitor
        UnSeedManager.shared().registerPageMonitor{ pageKey, isAppear in
            self.tracePageMonitor(pageKey, isAppear)
        }
        UnSeedManager.shared().registerClickTrace{ clickKey in
            self.traceClick(clickKey)
        }
        UnSeedManager.shared().registerTableViewSelect { (selectKey, indexPath, tableview) in
            self.traceTableViewClick(selectKey: selectKey, tableView: tableview, IndexPath: indexPath)
        }
        UnSeedManager.shared().registerCollectionViewSelect{ (selectKey, indexPath, collectionView) in
            self.traceCollectionViewClick(selectKey:selectKey,collectionView:collectionView,IndexPath:indexPath)
        }
    }
    
    func tracePageMonitor(_ pageKey:String,_ isAppear:Bool) {
        guard let seedID = PageMonitorKeyValues[pageKey] else {
            return
        }
        if isAppear {
            // willAppear
            print("PageMonitor Appear:\(pageKey)->\(seedID)")
        }
        else {
            // didDisappear
            print("PageMonitor Disappear:\(pageKey)->\(seedID)")
        }
    }
    
    func traceClick(_ clickKey:String) {
        print("Trace Click:\(clickKey)")
    }
    
    func traceTableViewClick(selectKey:String,tableView:UITableView,IndexPath:IndexPath) {
        print("Trace TableView:\(selectKey), indexPath:\(IndexPath)")
    }
    
    func traceCollectionViewClick(selectKey:String,collectionView:UICollectionView,IndexPath:IndexPath) {
        print("Trace CollectionView:\(selectKey), indexPath:\(IndexPath)")
    }
}
