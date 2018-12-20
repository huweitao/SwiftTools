//
//  UIViewController+Extension.swift
//  HSwiftTools
//
//  Created by huweitao on 2018/11/1.
//  Copyright © 2018 huweitao. All rights reserved.
//

import Foundation
import UIKit

private var kProperty = "kPageProperty"

extension UIViewController {
    func hasValidPageParams() -> Bool {
        if self.pageParams == nil {
            return false
        }
        return true
    }
    
    // for UIViewController init with params
    public var pageParams: Dictionary<String, Any>? {
        get {
            guard let aValue = objc_getAssociatedObject(self, &kProperty) as? Dictionary<String, Any> else {
                return nil
            }
            return aValue
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kProperty, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // System Alert shown
    func showSystemAlert(title:String, message:String, actionsDict:Dictionary<String,Any>) {
        
        weak var weakSelf:UIViewController? = self
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        for (key, value) in actionsDict {
            guard let actionHandler = value as? SystemAlertActionHanlder else {
                continue
            }
            let action:UIAlertAction = UIAlertAction.init(title: key, style: UIAlertAction.Style.default, handler: actionHandler)
            alert.addAction(action)
        }
        
        weakSelf?.present(alert, animated: true, completion: nil)
    }
    
    static func showSystemAlertshowSystemAlertOnTopVC(title:String, message:String, actionsDict:Dictionary<String,Any>) {
        guard let vc:UIViewController = HGetMostTopViewController() else {
            return
        }
        vc.showSystemAlert(title: title, message: message, actionsDict: actionsDict)
    }
}
