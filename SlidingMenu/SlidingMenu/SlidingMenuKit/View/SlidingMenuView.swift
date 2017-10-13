//
//  SlidingMenuView.swift
//  SlidingMenu
//
//  Created by JOE on 2017/10/11.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class SlidingMenuView: UIView {
    
    fileprivate var ZButtonTag:Int = 888
    fileprivate var completeBlock:IntJumpClosure?
    fileprivate var buttonTitles:[String] = []
    fileprivate var chapterBtn:UIButton?
    fileprivate var noteBtn:UIButton?
    
    ///侧滑菜单
    fileprivate var contentView:UIView?
    
    ///侧滑菜单的宽度
    fileprivate var contentViewWidth:CGFloat = screenWidth/8*7
    
    ///底部操作栏
    fileprivate var bottomMenuView:UIView?
    
    ///滚动视图
    fileprivate var scrollView:UIScrollView!
    
    ///目录 View
    var chapterListView:ChapterListView!
    
    ///笔记 View
    var noteListView:NoteListView!
    
    init(frame: CGRect, buttonTitles: [String]) {
        super.init(frame: frame)
        self.buttonTitles = buttonTitles
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
            contentView = UIView(frame: CGRect(x: 0, y: 0, width: contentViewWidth, height: screenHeight))
            contentView?.backgroundColor = UIColor.white
            addSubview(contentView!)
            
            configContent()
            setupScrollView()
        }
    }
    
    fileprivate func configContent() {
        let bottomMenuView = UIView()
        contentView?.addSubview(bottomMenuView)
        self.bottomMenuView = bottomMenuView
        bottomMenuView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(contentView!)
            make.height.equalTo(searchBarHeight)
        }
        
        //目录、笔记
        if self.buttonTitles.isEmpty == false {
            for i in 0..<buttonTitles.count {
                let btnW = (contentViewWidth - 1) / 2
                let btn = UIButton()
                btn.setTitle(buttonTitles[i], for: .normal)
                btn.setTitleColor(i == 0 ? UIColor.black : UIColor.gray, for: .normal)
                btn.tag = ZButtonTag + i
                btn.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
                bottomMenuView.addSubview(btn)
                if i == 0 {
                    self.chapterBtn = btn
                }else{
                    self.noteBtn = btn
                }
                btn.snp.makeConstraints({ (make) in
                    make.bottom.equalTo(bottomMenuView)
                    make.width.equalTo(btnW)
                    make.top.equalTo(bottomMenuView).offset(fontSizeScale(1))
                    make.left.equalTo(bottomMenuView).offset(btnW*CGFloat(i))
                })
            }
        }
        
        let horizontalLineView = UIView()
        horizontalLineView.backgroundColor = UIColor.gray
        bottomMenuView.addSubview(horizontalLineView)
        horizontalLineView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(bottomMenuView)
            make.height.equalTo(fontSizeScale(1))
        }
        
        let verticalLineView = UIView()
        verticalLineView.backgroundColor = UIColor.gray
        bottomMenuView.addSubview(verticalLineView)
        verticalLineView.snp.makeConstraints { (make) in
            make.centerX.equalTo(bottomMenuView)
            make.width.equalTo(fontSizeScale(1))
            make.top.equalTo(horizontalLineView.snp.bottom)
            make.bottom.equalTo(bottomMenuView)
        }
    }
    
    ///Setup ScrollView
    fileprivate func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = false
        
        //设置代理
        scrollView.delegate = self
        contentView?.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView!).inset(UIEdgeInsetsMake(CGFloat(statusBarHeight), 0, CGFloat(tabbarHeight), 0))
        }
        
        //容器视图
        let containerView = UIView()
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.height.equalTo(scrollView)
        }
        
        //添加子视图
        //1.目录
        chapterListView = ChapterListView()
        containerView.addSubview(chapterListView)
        chapterListView.snp.makeConstraints { (make) in
            make.top.bottom.left.equalTo(containerView)
            make.width.equalTo(contentViewWidth)
        }
        
        //2.笔记
        noteListView = NoteListView()
        containerView.addSubview(noteListView)
        noteListView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(containerView)
            make.left.equalTo(chapterListView.snp.right)
            make.width.equalTo(contentViewWidth)
        }
        
        //修改容器视图的大小
        containerView.snp.makeConstraints { (make) in
            make.right.equalTo(noteListView)
        }
    }
    
    //MARK: 按钮点击事件
    @objc fileprivate func buttonAction(button:UIButton) {
        if self.completeBlock != nil {
            completeBlock!(button.tag - ZButtonTag)
        }
        
        if button.tag - ZButtonTag == 0 {
            self.chapterBtn?.setTitleColor(UIColor.black, for: .normal)
            self.noteBtn?.setTitleColor(UIColor.gray, for: .normal)
        }else{
            self.chapterBtn?.setTitleColor(UIColor.gray, for: .normal)
            self.noteBtn?.setTitleColor(UIColor.black, for: .normal)
        }
        
        scrollView.setContentOffset(CGPoint(x: CGFloat((button.tag - ZButtonTag))*contentViewWidth, y: 0), animated: true)
    }
    
    //MARK: 显示视图
    fileprivate func showWithBlock(completeBlock: @escaping IntJumpClosure) {
        self.completeBlock = completeBlock
    }
    
    //MARK: 展示侧滑出的UIView（包含遮罩）
    func showInView(view:UIView?) {
        if view == nil {
            return
        }
        
        view?.addSubview(self)
        view?.addSubview(contentView!)
        
        contentView?.frame = CGRect(x: -contentViewWidth, y: 0, width: contentViewWidth, height: screenHeight)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1.0
            self.contentView?.frame = CGRect(x: 0, y: 0, width: self.contentViewWidth, height: screenHeight)
        }, completion: nil)
    }
    
    //MARK: 移除侧滑出的UIView（包含遮罩）
    @objc func disMissView() {
        contentView?.frame = CGRect(x: 0, y: 0, width: contentViewWidth, height: screenHeight)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
            self.contentView?.frame = CGRect(x: -self.contentViewWidth, y: 0, width: self.contentViewWidth, height: screenHeight)
        }) { (finished) in
            self.removeFromSuperview()
            self.contentView?.removeFromSuperview()
        }
    }
}


//MARK: - UIScrollViewDelegate
extension SlidingMenuView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
}


