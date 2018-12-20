//
//  UIView+RedDot.swift
//  GCash
//
//  Created by huweitao on 2018/10/10.
//  Copyright © 2018年 GXI. All rights reserved.
//

import Foundation
import UIKit

private var kViewRedDot = "kViewRedDot"

private let redDotH:CGFloat = 12.0
private let redDotW:CGFloat = 12.0

extension UIView {
    func showRedDot(_ toShow:Bool) {
        let redDot = self.fetchInnerRedDot()
        let parentFrame = self.frame
        let redDotFrame = CGRect(x: parentFrame.size.width - redDotW * 1.5, y: 0, width: redDotW, height: redDotH)
        redDot.frame = redDotFrame
        redDot.isHidden = !toShow
    }
    private func fetchInnerRedDot() -> UIView {
        if self.rightTopDot == nil {
            self.rightTopDot = UIView()
            self.rightTopDot!.frame = CGRect(x: 10, y: 10, width: redDotW, height: redDotH)
            self.rightTopDot!.backgroundColor =
                UIColor.init(hexStr: "0xe51313")
            self.rightTopDot!.layer.cornerRadius = redDotW/2
            self.rightTopDot!.layer.borderWidth = 1.0
            self.rightTopDot!.layer.borderColor =
                UIColor.init(hexStr: "0x101243").cgColor
            self.rightTopDot!.layer.masksToBounds = true
            self.addSubview(self.rightTopDot!)
            self.rightTopDot!.isHidden = true
        }
        return self.rightTopDot!
    }
    // for Red dot
    private var rightTopDot: UIView? {
        get {
            guard let aValue = objc_getAssociatedObject(self, &kViewRedDot) as? UIView else {
                return nil
            }
            return aValue
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kViewRedDot, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
