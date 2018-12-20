//
//  EmotionView.swift
//  GCash
//
//  Created by huweitao on 2018/10/30.
//  Copyright © 2018 GXI. All rights reserved.
//

import Foundation
import UIKit

class EmotionView: UIView {
    class func loadEmotionView() -> UIView? {
        return UIView.loadViewFromNibName(nibName: "EmotionView") ?? nil
    }
}
