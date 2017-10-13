//
//  ChapterListTableViewCell.swift
//  SlidingMenu
//
//  Created by JOE on 2017/10/12.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class ChapterListTableViewCell: UITableViewCell {

    var title:String? {
        didSet {
            showData()
        }
    }
    
    fileprivate func showData() {
        
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .left
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(fontSizeScale(20))
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


extension ChapterListTableViewCell {
    
    ///创建cell的方法
    class func createChapterListCell(tableView: UITableView, atIndexPath indexPath: IndexPath, title: String?) -> ChapterListTableViewCell {
        
        let cellId = "ChapterListCellId"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ChapterListTableViewCell
        if cell == nil {
            printLog(message: "创建cell失败")
        }
        cell?.title = title
        return cell!
    }
}



