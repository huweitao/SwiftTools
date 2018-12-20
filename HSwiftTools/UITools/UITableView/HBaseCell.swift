//
//  GBaseCell.swift
//  GCash
//
//  Created by huweitao on 2018/11/2.
//  Copyright © 2018 GXI. All rights reserved.
//

import Foundation
import UIKit

class HBaseCell: UITableViewCell {
    class func cellHeight() -> CGFloat {
        return 44
    }
    
    class func cellReuseID() -> String {
        return String.init(describing: self.classForCoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
