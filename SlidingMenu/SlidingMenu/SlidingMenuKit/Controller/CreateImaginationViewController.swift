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
    
    var createImaginationType:CreateImaginationType?
    var model:CreateImaginationModel?
    
    ///Create imaginationTextView
    var imaginationTextView:UITextView!
    ///ImaginationTextViewHeight
    var ImaginationTextViewHeight = fontSizeScale(200)
    
    ///PlaceHolderLabel
    var placeHolderLabel:UILabel?
    
    ///ContentLabel
    var contentLabel:UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


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
        
        
    }
    
    ///Setup ContentLabel.
    fileprivate func setupContentLabel() {
        let contentLabel = UILabel()
        contentLabel.text = model?.selectedContent
        contentLabel.font = zzj_SystemFontWithSize(12)
        contentLabel.textColor = UIColor.lightGray
        contentLabel.textAlignment = .left
        contentLabel.numberOfLines = 2
        view.addSubview(contentLabel)
        self.contentLabel = contentLabel
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imaginationTextView.snp.bottom).offset(fontSizeScale(1))
            make.left.equalTo(self.view).offset(fontSizeScale(10))
            make.right.equalTo(self.view).offset(-fontSizeScale(10))
            
            let height = UILabel.getHeightByWidth(title: contentLabel.text, width: view.bounds.size.width - fontSizeScale(20), font: zzj_SystemFontWithSize(12))
            
            printLog(message: height)
            
            make.height.equalTo(height)
        }
    }
    
    ///Setup quoteLabel.
    fileprivate func setupQuoteLabel() {
        let quoteLabel = UILabel()
        guard let bookName = model?.bookName else { return }
        quoteLabel.text = "引自" + " " + bookName
        quoteLabel.textColor = UIColor.gray
        quoteLabel.font = zzj_SystemFontWithSize(14)
        quoteLabel.textAlignment = .left
        view.addSubview(quoteLabel)
        quoteLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(fontSizeScale(10))
            make.right.equalTo(self.view).offset(-fontSizeScale(10))
            make.height.equalTo(fontSizeScale(14))
            
            if (model?.selectedContent?.isEmpty)! || self.createImaginationType == .WithNoSelectedContent {
                //没有选中的文字
                make.top.equalTo(imaginationTextView.snp.bottom).offset(fontSizeScale(1))
            }else{
                
                
            }
        }
    }
    
    @objc fileprivate func exit() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: UITextViewDelegate
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









