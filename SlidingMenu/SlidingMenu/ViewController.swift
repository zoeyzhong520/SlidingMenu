//
//  ViewController.swift
//  SlidingMenu
//
//  Created by JOE on 2017/10/11.
//  Copyright © 2017年 Hongyear Information Technology (Shanghai) Co.,Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        title = "ViewController"
        
        ///pushBtn
        let pushBtn = UIButton(type: .system)
        pushBtn.setTitle("Present ViewController", for: .normal)
        pushBtn.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 50)
        pushBtn.addTarget(self, action: #selector(pushBtnPressed), for: .touchUpInside)
        view.addSubview(pushBtn)
    }

    @objc fileprivate func pushBtnPressed() {
        self.present(BookViewController(), animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

