//
//  BottomMenuView.swift
//  SlidingMenu
//
//  Created by JOE on 2017/10/11.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class BottomMenuView: UIView {

    ///点击菜单按钮的闭包
    var menuJumpClosure:JumpClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension BottomMenuView {
    ///UI
    fileprivate func createView() {
        backgroundColor = .white
        //边框
        let lineView = UIView()
        lineView.backgroundColor = .gray
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(fontSizeScale(1))
        }
        
        //菜单按钮
        let menuBtn = UIButton()
        menuBtn.setTitle("菜单", for: .normal)
        menuBtn.backgroundColor = .orange
        menuBtn.tag = 0
        menuBtn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        addSubview(menuBtn)
        menuBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.width.height.equalTo(fontSizeScale(40))
            make.left.equalTo(self).offset(fontSizeScale(10))
        }
        
        //亮度按钮
        let lightBtn = UIButton()
        lightBtn.setTitle("亮度", for: .normal)
        lightBtn.backgroundColor = .cyan
        lightBtn.tag = 1
        lightBtn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        addSubview(lightBtn)
        lightBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.width.height.equalTo(fontSizeScale(40))
            make.right.equalTo(self).offset(-fontSizeScale(100))
        }
        
        //字体按钮
        let fontBtn = UIButton()
        fontBtn.setTitle("字体", for: .normal)
        fontBtn.backgroundColor = .green
        fontBtn.tag = 2
        fontBtn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        addSubview(fontBtn)
        fontBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.width.height.equalTo(fontSizeScale(40))
            make.right.equalTo(self).offset(-fontSizeScale(10))
        }
    }
    
    @objc fileprivate func btnClick(btn: UIButton) {
        if btn.tag == 0 {
            if self.menuJumpClosure != nil {
                menuJumpClosure!()
            }
        }else if btn.tag == 1 {
            
        }else if btn.tag == 2 {
            
        }
    }
}










