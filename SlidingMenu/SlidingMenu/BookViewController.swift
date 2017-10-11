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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createView()
        handleClosure()
    }

    fileprivate func createView() {
        view.backgroundColor = .white
        title = "BookViewController"
        
        setupBottomMenuView()
    }
    
    ///底部菜单栏
    fileprivate func setupBottomMenuView() {
        let bottomMenuView = BottomMenuView(frame: zzj_CGRectZero)
        view.addSubview(bottomMenuView)
        self.bottomMenuView = bottomMenuView
        bottomMenuView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(tabbarHeight)
        }
    }
    
    ///Handle closure.
    fileprivate func handleClosure() {
        self.bottomMenuView?.menuJumpClosure = { [weak self] in
            printLog(message: "侧滑按钮")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
