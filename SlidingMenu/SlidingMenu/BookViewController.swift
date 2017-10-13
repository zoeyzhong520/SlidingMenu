//
//  BookViewController.swift
//  SlidingMenu
//
//  Created by JOE on 2017/10/11.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    /// 底部菜单栏
    var bottomMenuView:BottomMenuView?
    
    /// 侧滑菜单
    var slidingMenuView:SlidingMenuView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createView()
    }
    
    fileprivate func createView() {
        view.backgroundColor = UIColor.white
        let descLabel = UILabel()
        descLabel.text = "灰姑娘👸"
        view.addSubview(descLabel)
        descLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.height.equalTo(50)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func singleTap() {
        setupBottomMenuView()
        handleClosure()
    }
    
    ///底部菜单栏
    fileprivate func setupBottomMenuView() {
        let bottomMenuView = BottomMenuView(frame: zzj_CGRectZero)
        bottomMenuView.showInView(view: zzj_KeyWindow)
        self.bottomMenuView = bottomMenuView
    }
    
    ///Handle closure.
    fileprivate func handleClosure() {
        self.bottomMenuView?.menuJumpClosure = {
            self.slidingMenuView = SlidingMenuView(frame: zzj_CGRectZero, buttonTitles: ["目录", "笔记"])
            self.slidingMenuView?.showInView(view: zzj_KeyWindow)
            self.downloadData()
            
            self.slidingMenuView?.chapterListView.jumpClosure = { [weak self] chapter in
                self?.slidingMenuView?.disMissView()
                self?.bottomMenuView?.disMissView()
                printLog(message: chapter)
            }
            
            self.slidingMenuView?.noteListView.jumpClosure = { [weak self] note in
                self?.slidingMenuView?.disMissView()
                self?.bottomMenuView?.disMissView()
                printLog(message: note)
                
                let vc = CreateImaginationViewController()
                
                let model = CreateImaginationModel()
                model.bookName = "灰姑娘"
                model.selectedContent = note
                vc.model = model
                
                self?.present(vc, animated: true, completion: nil)
            }
        }
        
        self.bottomMenuView?.createImaginationClosure = {
            let vc = CreateImaginationViewController()
            
            let model = CreateImaginationModel()
            model.bookName = "灰姑娘"
            model.note = ""
            //model.selectedContent = "尽管遭受残忍的折磨，艾拉还是决心坚持母亲的遗言，“勇敢而善良地活下去”，因此她不向绝望投降，也不仇恨虐待她的人。"
            model.selectedContent = "勇敢而善良地活下去"
            vc.model = model
            
            self.present(vc, animated: true, completion: nil)
        }
        
        self.bottomMenuView?.exitClosure = {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    ///Download Data.
    fileprivate func downloadData() {
        let model = ChapterListModel.parseData(data: parseJSONData(resource: "ChaptersData"))
        self.slidingMenuView?.chapterListView.model = model
        
        let model1 = NoteListModel.parseData(data: parseJSONData(resource: "NotesData"))
        self.slidingMenuView?.noteListView.model = model1
    }
    
    ///Parse Data.
    fileprivate func parseJSONData(resource: String) -> Data {
        guard let path = Bundle.main.path(forResource: resource, ofType: "json") else { return Data() }
        let data = NSData(contentsOfFile: path)
        return data! as Data
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

