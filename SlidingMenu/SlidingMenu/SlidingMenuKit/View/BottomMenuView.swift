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
    
    var contentView:UIView?
    ///ContentViewHeight
    var ContentViewHeight:CGFloat = CGFloat(tabbarHeight)
    
    ///写想法💡
    var createImaginationBtn:UIButton!
    var createImaginationClosure:JumpClosure?
    
    ///退出 Exit
    var exitBtn:UIButton!
    var exitClosure:JumpClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension BottomMenuView {
    ///UI
    fileprivate func setupContent() {
        self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        self.backgroundColor = RGBAColor(0, 0, 0, 0.4)
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(disMissView)))
        
        if contentView == nil {
            contentView = UIView(frame: CGRect(x: 0, y: screenHeight - ContentViewHeight, width: screenWidth, height: ContentViewHeight))
            contentView?.backgroundColor = UIColor.white
            addSubview(contentView!)
            
            configContent()
            setupExitBtn()
            setupCreateImaginationBtn()
        }
    }
    
    fileprivate func configContent() {
        //边框
        let lineView = UIView()
        lineView.backgroundColor = .gray
        contentView?.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView!)
            make.height.equalTo(fontSizeScale(1))
        }
        
        //菜单按钮
        let menuBtn = UIButton()
        menuBtn.setTitle("菜单", for: .normal)
        menuBtn.backgroundColor = .orange
        menuBtn.tag = 0
        menuBtn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        contentView?.addSubview(menuBtn)
        menuBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView!)
            make.width.height.equalTo(fontSizeScale(40))
            make.left.equalTo(contentView!).offset(fontSizeScale(10))
        }
        
        //亮度按钮
        let lightBtn = UIButton()
        lightBtn.setTitle("亮度", for: .normal)
        lightBtn.backgroundColor = .cyan
        lightBtn.tag = 1
        lightBtn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        contentView?.addSubview(lightBtn)
        lightBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView!)
            make.width.height.equalTo(fontSizeScale(40))
            make.right.equalTo(contentView!).offset(-fontSizeScale(100))
        }
        
        //字体按钮
        let fontBtn = UIButton()
        fontBtn.setTitle("字体", for: .normal)
        fontBtn.backgroundColor = .green
        fontBtn.tag = 2
        fontBtn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        contentView?.addSubview(fontBtn)
        fontBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView!)
            make.width.height.equalTo(fontSizeScale(40))
            make.right.equalTo(contentView!).offset(-fontSizeScale(10))
        }
    }
    
    ///Setup CreateImaginationBtn.
    fileprivate func setupCreateImaginationBtn() {
        //写想法💡
        createImaginationBtn = UIButton()
        createImaginationBtn.backgroundColor = UIColor.white
        createImaginationBtn.alpha = 0.0
        createImaginationBtn.layer.masksToBounds = true
        createImaginationBtn.layer.cornerRadius = ContentViewHeight/2
        
        //Set Shadow.
        createImaginationBtn.layer.shadowOffset = zzj_ShadowOffset
        createImaginationBtn.layer.shadowColor = zzj_ShadowColor.cgColor
        createImaginationBtn.layer.shadowRadius = zzj_ShadowRadius
        
        createImaginationBtn.setTitle("✎", for: .normal)
        createImaginationBtn.setTitleColor(UIColor.black, for: .normal)
        createImaginationBtn.addTarget(self, action: #selector(createImaginationBtnPressed), for: .touchUpInside)
        addSubview(createImaginationBtn)
        createImaginationBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-fontSizeScale(20))
            make.bottom.equalTo(self).offset(-(fontSizeScale(20)+ContentViewHeight))
            make.width.height.equalTo(ContentViewHeight)
        }
    }
    
    ///Setup ExitBtn.
    fileprivate func setupExitBtn() {
        exitBtn = UIButton()
        exitBtn.backgroundColor = UIColor.white
        exitBtn.alpha = 0.0
        exitBtn.layer.masksToBounds = true
        exitBtn.layer.cornerRadius = ContentViewHeight/2
        
        //Set Shadow.
        exitBtn.layer.shadowOffset = zzj_ShadowOffset
        exitBtn.layer.shadowColor = zzj_ShadowColor.cgColor
        exitBtn.layer.shadowRadius = zzj_ShadowRadius
        
        exitBtn.setTitle("⬅︎", for: .normal)
        exitBtn.setTitleColor(UIColor.black, for: .normal)
        exitBtn.addTarget(self, action: #selector(exitBtnPressed), for: .touchUpInside)
        addSubview(exitBtn)
        exitBtn.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(fontSizeScale(20))
            make.width.height.equalTo(ContentViewHeight)
        }
    }
    
    @objc fileprivate func createImaginationBtnPressed() {
        if self.createImaginationClosure != nil {
            createImaginationClosure!()
        }
        disMissView()
    }
    
    @objc fileprivate func exitBtnPressed() {
        if self.exitClosure != nil {
            exitClosure!()
        }
        disMissView()
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
    
    //MARK: 展示从底部向上弹出的UIView（包含遮罩）
    func showInView(view:UIView?) {
        if view == nil {
            return
        }
        
        view?.addSubview(self)
        view?.addSubview(contentView!)
        
        
        contentView?.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: ContentViewHeight)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1.0
            self.contentView?.frame = CGRect(x: 0, y: screenHeight - self.ContentViewHeight, width: screenWidth, height: self.ContentViewHeight)
            
            self.createImaginationBtn.alpha = 1.0
            self.exitBtn.alpha = 1.0
        }, completion: nil)
    }
    
    //MARK: 移除从上向底部弹下去的UIView（包含遮罩）
    @objc fileprivate func disMissView() {
        
        contentView?.frame = CGRect(x: 0, y: screenHeight - ContentViewHeight, width: screenWidth, height: ContentViewHeight)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
            self.contentView?.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: self.ContentViewHeight)
            
            self.createImaginationBtn.alpha = 0.0
            self.exitBtn.alpha = 0.0
        }) { (finished) in
            self.removeFromSuperview()
            self.contentView?.removeFromSuperview()
            self.createImaginationBtn.removeFromSuperview()
            self.exitBtn.removeFromSuperview()
        }
    }
}










