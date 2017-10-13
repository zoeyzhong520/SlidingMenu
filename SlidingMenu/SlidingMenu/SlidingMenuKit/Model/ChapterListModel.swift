//
//  ChapterListModel.swift
//  SlidingMenu
//
//  Created by JOE on 2017/10/12.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChapterListModel: NSObject {

    var bookPicture:String?
    var bookName:String?
    var author:String?
    
    var chapters:Array<String>?
    
    class func parseData(data:Data) -> ChapterListModel {
        
        do {
            let json = try JSON(data: data)
            
            let model = ChapterListModel()
            model.bookPicture = json["bookPicture"].string
            model.bookName = json["bookName"].string
            model.author = json["author"].string
            
            var array = [String]()
            for (_, subjson) in json["chapters"] {
                array.append(subjson.string!)
            }
            model.chapters = array
            
            return model
        } catch let e {
            printLog(message: "error: \(e)")
        }
        
        return ChapterListModel()
    }
}










