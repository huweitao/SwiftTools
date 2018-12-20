//
//  UIView+TapGesture.swift
//  HSwiftTools
//
//  Created by huweitao on 2018/12/18.
//  Copyright © 2018年 huweitao. All rights reserved.
//

import Foundation
import UIKit

private var kViewTapGesture = "kViewTapGesture"
private var kTapBlock = "kViewTapBlock"

typealias HTapHandler = (UITapGestureRecognizer)->()

extension UIView {
    
    // MARK: - Tap gesture
    func addTapGestureOnHandler(_ handler:HTapHandler?) {
        self.tapHandler = handler
        self.isUserInteractionEnabled = true
        if let gesture = self.tapGestureMultiply {
            self.addGestureRecognizer(gesture)
            return
        }
        
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector (tapGestureClick (_:)))
        self.tapGestureMultiply = gesture
        self.addGestureRecognizer(gesture)
    }
    
    @objc func tapGestureClick(_ sender:UITapGestureRecognizer) {
        // add block
        self.tapHandler?(sender)
    }
    
    // MARK: - Runtime Properties
    
    private var tapGestureMultiply: UITapGestureRecognizer? {
        get {
            guard let aValue = objc_getAssociatedObject(self, &kViewTapGesture) as? UITapGestureRecognizer else {
                return nil
            }
            return aValue
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kViewTapGesture, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var tapHandler: HTapHandler? {
        get {
            guard let aValue = objc_getAssociatedObject(self, &kTapBlock) as? HTapHandler else {
                return nil
            }
            return aValue
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kTapBlock, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
