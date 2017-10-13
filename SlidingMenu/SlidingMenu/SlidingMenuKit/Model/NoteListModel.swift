//
//  NoteListModel.swift
//  SlidingMenu
//
//  Created by JOE on 2017/10/12.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class NoteListModel: NSObject {

    var bookPicture:String?
    var bookName:String?
    var author:String?
    
    var notes:Array<NoteData>?
    
    class func parseData(data:Data) -> NoteListModel {
        
        do {
            let json = try JSON(data: data)
            
            let model = NoteListModel()
            model.bookPicture = json["bookPicture"].string
            model.bookName = json["bookName"].string
            model.author = json["author"].string
            
            var array = [NoteData]()
            for (_, subjson) in json["notes"] {
                let noteModel = NoteData.parse(json: subjson)
                array.append(noteModel)
            }
            model.notes = array
            
            return model
        } catch let e {
            printLog(message: "error: \(e)")
        }
        
        return NoteListModel()
    }
}


class NoteData: NSObject {
    
    var createTime:String?
    var note:String?
    
    class func parse(json:JSON) -> NoteData {
        
        let model = NoteData()
        model.createTime = json["createTime"].string
        model.note = json["note"].string
        return model
    }
}








