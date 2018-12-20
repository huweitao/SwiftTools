//
//  UIView+Extension.swift
//  HSwiftTools
//
//  Created by huweitao on 2018/10/31.
//  Copyright © 2018 huweitao. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // MARK: - Load view from nib
    class func loadViewFromMainBundle(nibName: String) -> UIView? {
        return loadViewFromNibName(nibName: nibName, bundle: Bundle.main)
    }
    class func loadViewFromNibName(nibName: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibName,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}
