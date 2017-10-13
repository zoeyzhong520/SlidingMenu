//
//  ChapterListView.swift
//  SlidingMenu
//
//  Created by JOE on 2017/10/12.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class ChapterListView: UIView {

    ///UITableView
    fileprivate var tableView:UITableView!
    
    ///HeaderViewHeight
    fileprivate let HeaderViewHeight:CGFloat = fontSizeScale(100)
    
    ///ChapterList JumpClosure.
    var jumpClosure:StringJumpClosure?
    
    var model:ChapterListModel? {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ChapterListView {
    ///UI
    fileprivate func createView() {
        backgroundColor = UIColor.white
        
        tableView = UITableView(frame: zzj_CGRectZero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.separatorStyle = .none
        tableView.register(ChapterListTableViewCell.self, forCellReuseIdentifier: "ChapterListCellId")
        tableView.register(SlidingMenuHeaderViewCell.self, forCellReuseIdentifier: "SlidingMenuHeaderViewCellId")
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ChapterListView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cnt = model?.chapters?.count {
            return cnt + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return fontSizeScale(100)
        }else{
            return CGFloat(navigationBarHeight)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = SlidingMenuHeaderViewCell.createSlidingMenuCell(tableView: tableView, atIndexPath: indexPath, model: model)
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = ChapterListTableViewCell.createChapterListCell(tableView: tableView, atIndexPath: indexPath, title: model?.chapters?[indexPath.row-1])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row > 0 {
            guard let chapter = model?.chapters?[indexPath.row-1] else { return }
            if self.jumpClosure != nil {
                jumpClosure!(chapter)
            }
        }
    }
}




