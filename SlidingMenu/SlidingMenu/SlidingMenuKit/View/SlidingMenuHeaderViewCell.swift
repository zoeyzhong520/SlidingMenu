//
//  SlidingMenuHeaderViewCell.swift
//  SlidingMenu
//
//  Created by JOE on 2017/10/12.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class SlidingMenuHeaderViewCell: UITableViewCell {

    var model:ChapterListModel? {
        didSet {
            showData()
        }
    }
    
    var noteModel:NoteListModel? {
        didSet {
            showNoteData()
        }
    }
    
    fileprivate func showNoteData() {
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let detailView = UIView()
        self.contentView.addSubview(detailView)
        detailView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        let bookImgView = UIImageView()
        guard let imageUrl = noteModel?.bookPicture else { return }
        bookImgView.kf.setImage(with: zzj_URLWithString(BaseURL + imageUrl))
        detailView.addSubview(bookImgView)
        bookImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(detailView)
            make.left.equalTo(detailView).offset(fontSizeScale(20))
            make.width.equalTo(fontSizeScale(60))
            make.height.equalTo(fontSizeScale(80))
        }
        
        let bookNameLabel = UILabel()
        bookNameLabel.text = noteModel?.bookName
        bookNameLabel.font = zzj_SystemFontWithSize(15)
        bookNameLabel.textColor = UIColor.black
        bookNameLabel.textAlignment = .left
        detailView.addSubview(bookNameLabel)
        bookNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bookImgView.snp.right).offset(fontSizeScale(10))
            make.top.equalTo(detailView).offset(fontSizeScale(20))
            make.right.equalTo(detailView)
        }
        
        let authorLabel = UILabel()
        authorLabel.text = noteModel?.author
        authorLabel.font = zzj_SystemFontWithSize(13)
        authorLabel.textColor = UIColor.gray
        authorLabel.textAlignment = .left
        detailView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bookImgView.snp.right).offset(fontSizeScale(10))
            make.top.equalTo(bookNameLabel.snp.bottom).offset(fontSizeScale(20))
            make.right.equalTo(detailView)
        }
    }
    
    fileprivate func showData() {
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let detailView = UIView()
        self.contentView.addSubview(detailView)
        detailView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        let bookImgView = UIImageView()
        guard let imageUrl = model?.bookPicture else { return }
        bookImgView.kf.setImage(with: zzj_URLWithString(BaseURL + imageUrl))
        detailView.addSubview(bookImgView)
        bookImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(detailView)
            make.left.equalTo(detailView).offset(fontSizeScale(20))
            make.width.equalTo(fontSizeScale(60))
            make.height.equalTo(fontSizeScale(80))
        }
        
        let bookNameLabel = UILabel()
        bookNameLabel.text = model?.bookName
        bookNameLabel.font = zzj_SystemFontWithSize(15)
        bookNameLabel.textColor = UIColor.black
        bookNameLabel.textAlignment = .left
        detailView.addSubview(bookNameLabel)
        bookNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bookImgView.snp.right).offset(fontSizeScale(10))
            make.top.equalTo(detailView).offset(fontSizeScale(20))
            make.right.equalTo(detailView)
        }
        
        let authorLabel = UILabel()
        authorLabel.text = model?.author
        authorLabel.font = zzj_SystemFontWithSize(13)
        authorLabel.textColor = UIColor.gray
        authorLabel.textAlignment = .left
        detailView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bookImgView.snp.right).offset(fontSizeScale(10))
            make.top.equalTo(bookNameLabel.snp.bottom).offset(fontSizeScale(20))
            make.right.equalTo(detailView)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension SlidingMenuHeaderViewCell {
    
    ///创建cell的方法
    class func createSlidingMenuCell(tableView: UITableView, atIndexPath indexPath: IndexPath, model: ChapterListModel?) -> SlidingMenuHeaderViewCell {
        
        let cellId = "SlidingMenuHeaderViewCellId"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SlidingMenuHeaderViewCell
        if cell == nil {
            printLog(message: "创建cell失败")
        }
        cell?.model = model
        return cell!
    }
    
    //NoteListModel
    class func createSlidingMenuCell(tableView: UITableView, atIndexPath indexPath: IndexPath, model: NoteListModel?) -> SlidingMenuHeaderViewCell {
        
        let cellId = "SlidingMenuHeaderViewCellId"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SlidingMenuHeaderViewCell
        if cell == nil {
            printLog(message: "创建cell失败")
        }
        cell?.noteModel = model
        return cell!
    }
}






