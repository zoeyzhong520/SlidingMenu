//
//  CreateImaginationViewController.swift
//  SlidingMenu
//
//  Created by JOE on 2017/10/12.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

///CreateImaginationType, default is create with no selected content.
enum CreateImaginationType: Int {
    case WithNoSelectedContent = 0
    case WithSelectedContent
}

class CreateImaginationViewController: UIViewController {
    
    fileprivate var createImaginationType:CreateImaginationType?
    var model:CreateImaginationModel?
    
    ///Create imaginationTextView
    fileprivate var imaginationTextView:UITextView!
    ///ImaginationTextViewHeight
    fileprivate var ImaginationTextViewHeight = fontSizeScale(200)
    
    ///PlaceHolderLabel
    fileprivate var placeHolderLabel:UILabel?
    
    ///ContentLabel
    fileprivate var contentLabel:UILabel!
    
    ///bottomMenuView
    fileprivate var bottomMenuView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: - UI
extension CreateImaginationViewController {
    ///UI
    fileprivate func createView() {
        view.backgroundColor = UIColor.white
        
        //Exit 退出.
        let exitBtn = UIButton()
        exitBtn.setTitle("⬅︎", for: .normal)
        exitBtn.setTitleColor(UIColor.black, for: .normal)
        exitBtn.addTarget(self, action: #selector(exit), for: .touchUpInside)
        view.addSubview(exitBtn)
        exitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(fontSizeScale(20))
            make.left.equalTo(self.view)
            make.width.height.equalTo(tabbarHeight)
        }
        
        //Line View.
        let lineViewOne = UIView()
        lineViewOne.backgroundColor = UIColor.lightGray
        view.addSubview(lineViewOne)
        lineViewOne.snp.makeConstraints { (make) in
            make.top.equalTo(exitBtn.snp.bottom)
            make.left.right.equalTo(self.view)
            make.height.equalTo(fontSizeScale(1))
        }
        
        //ImaginationTextView
        imaginationTextView = UITextView(backgroundColor: UIColor.white, textAlignment: .left, textColor: UIColor.black, font: zzj_SystemFontWithSize(13), isEditable: true, isScrollEnabled: true, isUserInteractionEnabled: true)
        imaginationTextView.delegate = self
        imaginationTextView.becomeFirstResponder()
        view.addSubview(imaginationTextView)
        imaginationTextView.snp.makeConstraints { (make) in
            make.top.equalTo(lineViewOne.snp.bottom)
            make.left.right.equalTo(self.view)
            make.height.equalTo(ImaginationTextViewHeight)
        }
        
        //placeHolder
        let placeHolderLabel = UILabel(text: "写下你这一刻的想法", font: zzj_SystemFontWithSize(13), textColor: RGB(218, 218, 218), textAlignment: .left)
        if imaginationTextView.text.isEmpty == false {
            placeHolderLabel.isHidden = true
        }
        imaginationTextView.addSubview(placeHolderLabel)
        self.placeHolderLabel = placeHolderLabel
        placeHolderLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(imaginationTextView).offset((fontSizeScale(12)))
            make.right.equalTo(imaginationTextView)
        }
        
        //LineViewTwo.
        let lineViewTwo = UIView()
        lineViewTwo.backgroundColor = UIColor.lightGray
        view.addSubview(lineViewTwo)
        lineViewTwo.snp.makeConstraints { (make) in
            make.top.equalTo(imaginationTextView.snp.bottom)
            make.height.equalTo(fontSizeScale(1))
            make.left.right.equalTo(self.view)
        }
        
        setupContentLabel()
        setupQuoteLabel()
        setupBottomMenuView()
    }
    
    ///Setup ContentLabel.
    fileprivate func setupContentLabel() {
        let contentLabel = UILabel()
        contentLabel.text = model?.selectedContent
        contentLabel.font = zzj_SystemFontWithSize(13)
        contentLabel.textColor = UIColor.lightGray
        contentLabel.textAlignment = .left
        contentLabel.numberOfLines = 2
        view.addSubview(contentLabel)
        self.contentLabel = contentLabel
        contentLabel.snp.makeConstraints { (make) in
            if self.model == nil {
                make.top.equalTo(imaginationTextView.snp.bottom).offset(fontSizeScale(1))
            }else if self.model?.selectedContent?.isEmpty == false {
                make.top.equalTo(imaginationTextView.snp.bottom).offset(fontSizeScale(6))
            }else{
                make.top.equalTo(imaginationTextView.snp.bottom).offset(fontSizeScale(1))
            }
            
            make.left.equalTo(self.view).offset(fontSizeScale(10))
            make.right.equalTo(self.view).offset(-fontSizeScale(10))
            
            let height = UILabel.getHeightByWidth(title: contentLabel.text, width: view.bounds.size.width - fontSizeScale(20), font: zzj_SystemFontWithSize(13))
            print(height)
            if height >= 47.0 {
                make.height.equalTo(47.0)
            }else{
                make.height.equalTo(height)
            }
        }
    }
    
    ///Setup quoteLabel.
    fileprivate func setupQuoteLabel() {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        view.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            if self.model == nil {
                make.top.equalTo(self.contentLabel.snp.bottom)
                lineView.backgroundColor = UIColor.clear
            }else if self.model?.bookName?.isEmpty == false {
                make.top.equalTo(self.contentLabel.snp.bottom).offset(fontSizeScale(5))
            }else{
                make.top.equalTo(self.contentLabel.snp.bottom)
                lineView.backgroundColor = UIColor.clear
            }
            make.left.right.equalTo(self.view)
            make.height.equalTo(fontSizeScale(1))
        }
        
        let quoteLabel = UILabel()
        if self.model == nil {
            quoteLabel.text = "引自"
        }else if self.model?.bookName?.isEmpty == false {
            guard let bookName = model?.bookName else { return }
            quoteLabel.text = "引自" + " " + bookName
        }else{
            quoteLabel.text = "引自"
        }
        quoteLabel.textColor = UIColor.gray
        quoteLabel.font = zzj_SystemFontWithSize(14)
        quoteLabel.textAlignment = .left
        view.addSubview(quoteLabel)
        quoteLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(fontSizeScale(10))
            make.right.equalTo(self.view).offset(-fontSizeScale(10))
            make.height.equalTo(fontSizeScale(14))
            make.top.equalTo(lineView.snp.bottom).offset(fontSizeScale(10))
        }
    }
    
    @objc fileprivate func exit() {
        dismiss()
    }
    
    ///Setup bottomMenuView.
    fileprivate func setupBottomMenuView() {
        bottomMenuView = UIView()
        bottomMenuView.backgroundColor = UIColor.white
        view.addSubview(bottomMenuView)
        bottomMenuView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(tabbarHeight)
        }
        
        ///Line view.
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        bottomMenuView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(bottomMenuView)
            make.height.equalTo(fontSizeScale(1))
        }
        
        ///Close btn.
        let closeBtn = UIButton()
        closeBtn.setTitle("×", for: .normal)
        closeBtn.setTitleColor(UIColor.black, for: .normal)
        closeBtn.tag = 100
        closeBtn.addTarget(self, action: #selector(bottomMenuViewClick(btn:)), for: .touchUpInside)
        bottomMenuView.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(bottomMenuView)
            make.left.equalTo(bottomMenuView).offset(fontSizeScale(10))
            make.width.height.equalTo(navigationBarHeight)
        }
        
        ///Reaease btn.
        let releaseBtn = UIButton()
        releaseBtn.setTitle("发布", for: .normal)
        releaseBtn.setTitleColor(UIColor.black, for: .normal)
        releaseBtn.tag = 101
        releaseBtn.addTarget(self, action: #selector(bottomMenuViewClick(btn:)), for: .touchUpInside)
        bottomMenuView.addSubview(releaseBtn)
        releaseBtn.snp.makeConstraints { (make) in
            make.center.equalTo(bottomMenuView)
            make.width.height.equalTo(navigationBarHeight)
        }
        
        ///Confirm btn.
        let confirmBtn = UIButton()
        confirmBtn.setTitle("√", for: .normal)
        confirmBtn.setTitleColor(UIColor.black, for: .normal)
        confirmBtn.tag = 102
        confirmBtn.addTarget(self, action: #selector(bottomMenuViewClick(btn:)), for: .touchUpInside)
        bottomMenuView.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(bottomMenuView)
            make.right.equalTo(bottomMenuView).offset(-fontSizeScale(10))
            make.width.height.equalTo(navigationBarHeight)
        }
    }
    
    @objc fileprivate func bottomMenuViewClick(btn: UIButton) {
        if btn.tag == 100 {
            setupAlertController()
        }else if btn.tag == 101 {
            dismiss()
        }else if btn.tag == 102 {
            dismiss()
        }
    }
    
    ///Setup AlertController.
    fileprivate func setupAlertController() {
        let alertCtrl = UIAlertController(title: "提示", message: "确定退出编辑吗？", preferredStyle: .alert)
        alertCtrl.addAction(UIAlertAction(title: "是", style: .default, handler: { (action) in
            self.dismiss()
        }))
        alertCtrl.addAction(UIAlertAction(title: "否", style: .default, handler: nil))
        self.present(alertCtrl, animated: true, completion: nil)
    }
    
    ///Dissmiss void.
    fileprivate func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITextViewDelegate
extension CreateImaginationViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeHolderLabel?.isHidden = true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 回车时退出编辑
        if text == "\n" {
            textView.resignFirstResponder()
            return true
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeHolderLabel?.isHidden = false
        }else{
            placeHolderLabel?.isHidden = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}









