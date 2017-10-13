//
//  NoteListView.swift
//  SlidingMenu
//
//  Created by JOE on 2017/10/12.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class NoteListView: UIView {

    ///UITableView
    fileprivate var tableView:UITableView!
    
    ///HeaderViewHeight
    fileprivate let HeaderViewHeight:CGFloat = fontSizeScale(100)
    
    ///NoteList JumpClosure.
    var jumpClosure:StringJumpClosure?
    
    var model:NoteListModel? {
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

extension NoteListView {
    ///UI
    fileprivate func createView() {
        backgroundColor = UIColor.white
        
        tableView = UITableView(frame: zzj_CGRectZero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.separatorStyle = .none
        tableView.register(NoteListTableViewCell.self, forCellReuseIdentifier: "NoteListCellId")
        tableView.register(SlidingMenuHeaderViewCell.self, forCellReuseIdentifier: "SlidingMenuHeaderViewCellId")
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension NoteListView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cnt = model?.notes?.count {
            return cnt + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return fontSizeScale(100)
        }else{
            return NoteListTableViewCell.heightForCell(model: model?.notes?[indexPath.row-1])
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = SlidingMenuHeaderViewCell.createSlidingMenuCell(tableView: tableView, atIndexPath: indexPath, model: model)
            return cell
        }else{
            let cell = NoteListTableViewCell.createNoteListCell(tableView: tableView, atIndexPath: indexPath, model: model?.notes?[indexPath.row-1])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row > 0 {
            guard let note = model?.notes?[indexPath.row-1].note else { return }
            if self.jumpClosure != nil {
                jumpClosure!(note)
            }
        }
    }
}









