//
//  SlidingMenuView.swift
//  SlidingMenu
//
//  Created by JOE on 2017/10/11.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class SlidingMenuView: UIView {

    var contentView:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension SlidingMenuView {
    ///UI
    fileprivate func setupContent() {
        frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        backgroundColor = RGBAColor(0, 0, 0, 0.4)
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(disMissView)))
        
        if contentView == nil {
            contentView = UIView(frame: CGRect(x: screenWidth - screenWidth/3*2, y: 0, width: screenWidth/3*2, height: screenHeight))
            contentView?.backgroundColor = UIColor.white
            contentView?.layer.cornerRadius = fontSizeScale(6)
            addSubview(contentView!)
            
            configContent()
        }
    }
    
    fileprivate func configContent() {
        
    }
    
    @objc fileprivate func disMissView() {
        
    }
    
    //MARK: 展示侧滑出的UIView（包含遮罩）
}









