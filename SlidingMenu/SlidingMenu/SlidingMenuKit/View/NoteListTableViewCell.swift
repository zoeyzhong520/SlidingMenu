//
//  NoteListTableViewCell.swift
//  SlidingMenu
//
//  Created by JOE on 2017/10/12.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class NoteListTableViewCell: UITableViewCell {

    var model:NoteData? {
        didSet {
            showData()
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
        
        let noteLabel = UILabel()
        noteLabel.text = model?.note
        noteLabel.font = zzj_SystemFontWithSize(14)
        noteLabel.textColor = UIColor.black
        noteLabel.textAlignment = .left
        noteLabel.numberOfLines = 0
        detailView.addSubview(noteLabel)
        noteLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(detailView).offset(fontSizeScale(10))
            make.bottom.right.equalTo(detailView).offset(-fontSizeScale(10))
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


extension NoteListTableViewCell {
    
    ///创建cell的方法
    class func createNoteListCell(tableView: UITableView, atIndexPath indexPath: IndexPath, model: NoteData?) -> NoteListTableViewCell {
        
        let cellId = "NoteListCellId"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? NoteListTableViewCell
        if cell == nil {
            printLog(message: "创建cell失败")
        }
        cell?.model = model
        return cell!
    }
    
    ///返回cell的高度
    class func heightForCell(model: NoteData?) -> CGFloat {
        let height = UILabel.getHeightByWidth(title: model?.note, width: screenWidth/8*7 - fontSizeScale(20), font: zzj_SystemFontWithSize(14))
        return height + fontSizeScale(40)
    }
}






