//
//  Common.swift
//  ReadBook
//
//  Created by JOE on 2017/7/12.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit
import SnapKit

//MARK: - 设备信息

///当前app信息
let GetAppInfo = Bundle.main.infoDictionary

///当前app版本号
let GetAppCurrentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")

///获取设备系统号
let GetSystemVersion = UIDevice.current.systemVersion

///iPhone设备
let isIphone = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? true : false)

///iPad设备
let isIpad = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? true : false)

///iPhone4设备
let isIphone4s = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) < 568.0 ? true : false)

///iPhone5设备
let isIphone5 = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 568.0 ? true : false)

///iPhone6设备
let isIphone6 = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 667.0 ? true : false)

///iPhone6Plus设备
let isIphone6P = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 736.0 ? true : false)

///iPhoneSE设备
let isIphoneSE = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 568.0 ? true : false)

///iPhone7设备
let isIphone7 = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 667.0 ? true : false)

///iPhone7P设备
let isIphone7P = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 736.0 ? true : false)



//MARK: - 尺寸信息

///全屏宽度
let screenWidth = UIScreen.main.bounds.size.width

///全屏高度，不含状态栏高度
let screenHeight = UIScreen.main.bounds.size.height

///tabbar切换视图控制器高度
let tabbarHeight = 49.0

///搜索视图高度
let searchBarHeight = 45.0

///状态栏高度
let statusBarHeight = 20.0

///导航栏高度
let navigationBarHeight = 44.0

///通过方法获取屏幕的宽
func zzj_GetScreenWidth() -> CGFloat {
    return UIScreen.main.bounds.size.width
}

///通过方法获取屏幕的高
func zzj_GetScreenHeight() -> CGFloat {
    return UIScreen.main.bounds.size.height
}



//MARK: - 时间格式

enum TimeFormat:String {
    case format_default            = "yyyy-MM-dd HH:mm:ss"
    case format_yyMdHm             = "yy-MM-dd HH:mm"
    case format_yyyyMdHm           = "yyyy-MM-dd HH:mm"
    case format_yMd                = "yyyy-MM-dd"
    case format_MdHms              = "MM-dd HH:mm:ss"
    case format_MdHm               = "MM-dd HH:mm"
    case format_Hms                = "HH:mm:ss"
    case format_Hm                 = "HH:mm"
    case format_Md                 = "MM-dd"
    case format_yyMd               = "yy-MM-dd"
    case format_YYMMdd             = "yyyyMMdd"
    case format_yyyyMdHms          = "yyyyMMddHHmmss"
    case format_yyyyMdHmsS         = "yyyy-MM-dd HH:mm:ss.SSS"
    case format_yyyyMMddHHmmssSSS  = "yyyyMMddHHmmssSSS"
    case format_yMdWithSlash       = "yyyy/MM/dd"
    case format_yM                 = "yyyy-MM"
    case format_yMdChangeSeparator = "yyyy.MM.dd"
}



//MARK: - 刷新格式
enum RefreshFormat {
    case tableView
    case collectionView
}


//MARK: - 常用字体

///自适应字体大小
var fontSizeScale:(CGFloat) -> CGFloat = {size in
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.fontSizeScale(scale: size)
}

///系统普通字体
var zzj_SystemFontWithSize:(CGFloat) -> UIFont = {size in
    return UIFont.systemFont(ofSize: fontSizeScale(size))
}

///系统加粗字体
var zzj_BoldFontWithSize:(CGFloat) -> UIFont = {size in
    return UIFont.boldSystemFont(ofSize: fontSizeScale(size))
}

///仅用于标题栏上，大标题字号
let navFont = zzj_SystemFontWithSize(18)

///标题字号
let titleFont = zzj_SystemFontWithSize(18)

///正文字号
let bodyFont = zzj_SystemFontWithSize(16)

///辅助字号
let assistFont = zzj_SystemFontWithSize(14)



//MARK: - 常用颜色

///根据RGBA生成颜色(格式为：22,22,22,0.5)
var RGBAColor:(CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue, alpha in
    
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
}

///根据RGB生成颜色(格式为：22,22,22)
var RGB:(CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue in
    
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
}

///根据色值生成颜色(无透明度)(格式为0xffffff)
var zzj_ColorWithHex:(NSInteger) -> UIColor = {hex in
    
    let red = ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0
    let green = ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0
    let blue = ((CGFloat)((hex & 0xFF))) / 255.0
    
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

///输入框提示语的颜色
let placeHolderTipColor = zzj_ColorWithHex(0xafafaf)

///三大色调
let essentialColor = zzj_ColorWithHex(0x46a0f0)//蓝色
let assistOrangeColor = zzj_ColorWithHex(0xff8c28)//橙色
let assistGreenColor = zzj_ColorWithHex(0x5abe00)//绿色

/// 导航栏背景色
let zzj_NavigationBarBackgroundColor = RGB(58, 139, 255)

/// 书本详情导航栏背景色
let zzj_BookDetailNavigationBarBackgroundColor = RGB(22, 17, 66)

/// shadowOpacity
let zzj_ShadowOpacity:Float = 0.2

/// shadowColor
let zzj_ShadowColor = UIColor.lightGray

/// shadowOffset
let zzj_ShadowOffset = CGSize(width: 3, height: 3 )

/// cornerRadius
let zzj_CornerRadius = fontSizeScale(2)

/// shadowRadius
let zzj_ShadowRadius = fontSizeScale(4)


//MARK: - 常用变量／方法定义

///打印日志 - parameter message: 日志消息内容
func printLog<T>(message:T) {
    #if DEBUG
        print("\(message)")
    #endif
}

///根据图片名称获取图片
let zzj_ImageWithName:(String) -> UIImage? = {imageName in
    return UIImage(named: imageName)
}

///URL
let zzj_URLWithString:(String) -> URL? = { urlString in
    return URL(string: urlString)
}

///CGRectZero
let zzj_CGRectZero = CGRect(x: 0, y: 0, width: 0, height: 0)



//MARK: - 线程队列

///主线程队列
let zzj_MainThread = DispatchQueue.main


///Global队列
let zzj_GlobalThread = DispatchQueue.global(qos: .default)


///DispatchTime.now()
let zzj_DispatchTimeNow = DispatchTime.now()



//MARK: - 闭包closure
typealias JumpClosure = () -> () //JumpClosure Default

typealias IndexPathJumpClosure = (_ indexPath: IndexPath) -> () //JumpClosure with IndexPath

typealias IntJumpClosure = (_ subIndex: Int) -> () //JumpClosure with Int

typealias NSNumberJumpClosure = (_ subIndex: NSNumber) -> () //JumpClosure with NSNumber

typealias CGFloatJumpClosure = (_ height: CGFloat) -> () //JumpClosure with CGFloat

typealias RequestSuccessJumpClosure = (_ model: NSObject) -> ()

typealias RequestFailureJumpClosure = (_ error: NSError) -> ()

typealias StringJumpClosure = (_ string: String) -> () //JumpClosure with String

typealias BoolJumpClosure = (_ bool: Bool) -> () //JumpClosure with Bool

typealias IntWithIndexPathJumpClosure = (_ subIndex: Int, _ indexPath: IndexPath) -> () //JumpClosure with Int,IndexPath

typealias StringWithStringJumpClosure = (_ string1: String, _ string2: String) -> () //JumpClosure with String,String

typealias FloatJumpClosure = (_ float: Float) -> () //JumpClosure with Float

typealias IntWithStringWithStringJumpClosure = (_ int: Int, _ string1: String, _ string2: String) -> () //JumpClosure with Int,String,String





//MARK:  - KeyWindow

let zzj_KeyWindow = UIApplication.shared.keyWindow



//MARK: - 文件路径

/// tmp目录路径
let zzj_TmpPath = NSTemporaryDirectory() as NSString

/// Documents目录路径
let zzj_DocumentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString

/// Library/Caches目录路径
let zzj_CachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! as NSString

/// Library/Application Support目录路径
let zzj_SupportPath = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first! as NSString

/// 沙盒主目录路径
let zzj_HomePath = NSHomeDirectory() as NSString



//MARK: - 网络请求

//Host
//let Host = "wap.seedu.me"
//let BaseURL = "http://s3.cn-north-1.amazonaws.com.cn/seedu"

let Host = "phone.seedu.me"
let BaseURL = "http://s3.cn-north-1.amazonaws.com.cn/seedutest"


/// UserInfomation
var UserIconImageUrl:String? = nil
var UserName:String? = nil
var UserSid:Int? = nil

/// 班级登陆 POST
let ClassLoginUrl = "http://\(Host)/class/login"

/// 学生列表 GET
let StudentsUrl:(String) -> String = { gradeId in
    return "http://\(Host)/students?gradeId=\(gradeId)"
}

/// 学生登录 POST
let StudentsLoginUrl = "http://\(Host)/student/login"


/*以下需要加入HTTPHeader验证信息*/

/// 书架标签 GET
let BookshelfTagsUrl = "http://\(Host)/tags"

/// 标签书本  GET
let BooksUrl = "http://\(Host)/books"

let AllBooksUrl = "http://\(Host)/books/all"

/// 书本详情  GET
let BookDetailUrl:(String) -> String = { bid in
    return "http://\(Host)/book?bid=\(bid)"
}

/// 个人详情 GET
let PersonInfoUrl = "http://\(Host)/person/info"

/// 客观题-获取客观题题目 GET
let ObjectiveQuestionsUrl:(String) -> String = { bid in
    return "http://\(Host)/objects/\(bid)"
}

/// 主观题-获取主观题以及主观题答案 GET
let SubjectiveQuestionsUrl:(String) -> String = { bid in
    return "http://\(Host)/subjects/\(bid)"
}

/// 任务-设置阅读,客观,主观完成 state的范围(reading,object,subject) POST
let TaskEndingUrl:(String) -> String = { state in
    return "http://\(Host)/task/\(state)/ending"
}

/// 任务-主观题单题提交 POST
let SubjectiveSubmitUrl = "http://\(Host)/subject"

/// 任务列表 GET
let MissionUrl = "http://\(Host)/tasks"

/// 阅读记录 GET
let ReadingRecordUrl = "http://\(Host)/history"

/// 收藏列表 GET | POST:收藏，param: bid书本ID | delete:取消收藏，param: {id}:收藏Id int(>0)
let MyCollectionUrl = "http://\(Host)/collection"

/// 我的积分列表 GET
let MyScoreUrl = "http://\(Host)/score"

/// 意见反馈 POST
let FeedBackUrl = "http://\(Host)/feedback"

/// 下载epub
let Epub_DownloadUrl = "http://54.223.77.112/epubs/3.epub"

/// 任务情况 GET
let MissionSituationUrl = "http://\(Host)/class/tasks"

/// 阅读计时 POST
let BookTimeUrl = "http://\(Host)/book/time"

/// 广告链接 GET
let BannerUrl = "http://\(Host)/getNews"



/// 网络请求错误信息
let zzj_ErrorMessage = "网络请求失败，请重新访问"


























