//
//  ViewController.swift
//  LSPush
//
//  Created by zrf on 06/16/2021.
//  Copyright (c) 2021 zrf. All rights reserved.
//

import UIKit
import LSPush

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        LSPush.shared.setup("3353f291f1400", secret: "c7beb66fffaa42c7eb5ca8da24c3dac0", isDebug: true)
        LSPush.shared.privacyStatus(true) { succ in
            print("上报到mob结果为:\(succ)")
        }
        //测试，实际暂使用不到
        LSPush.shared.getRegisterID { rid, error in
            print("得到的rid:" + rid)
        }
        //获取到推送通知时回调
        LSPush.shared.callback = { (info: Dictionary) -> Void in
           print("获取到推送内容:\(info["body"]!)")
            return
        }
        LSPush.shared.foregroundType([])
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

