//
//  UITextView+Util.swift
//  ReadBook
//
//  Created by JOE on 2017/9/11.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

extension UITextView {
    
    convenience init(backgroundColor: UIColor?=nil, textAlignment: NSTextAlignment?=nil, textColor: UIColor?=nil, font: UIFont?=nil, isEditable: Bool?=nil, isScrollEnabled: Bool?=nil, isUserInteractionEnabled: Bool?=nil) {
        
        self.init()
        
        if let tmpBackgroundColor = backgroundColor {
            self.backgroundColor = tmpBackgroundColor
        }
        
        if let tmpTextAlignment = textAlignment {
            self.textAlignment = tmpTextAlignment
        }
        
        if let tmpTextColor = textColor {
            self.textColor = tmpTextColor
        }
        
        if let tmpFont = font {
            self.font = tmpFont
        }
        
        if let tmpIsEditable = isEditable {
            self.isEditable = tmpIsEditable
        }
        
        if let tmpIsScrollEnable = isScrollEnabled {
            self.isScrollEnabled = tmpIsScrollEnable
        }
        
        if let tmpIsUserInteractionEnabled = isUserInteractionEnabled {
            self.isUserInteractionEnabled = tmpIsUserInteractionEnabled
        }
    }
}














