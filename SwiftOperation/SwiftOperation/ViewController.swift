//
//  ViewController.swift
//  SwiftOperation
//
//  Created by jins on 14/12/13.
//  Copyright (c) 2014年 BlackWater. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var count = 0
    var operation = Operation()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerDidFire:", userInfo: nil, repeats: true)
        operation.begin()
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
            self.operation.pause()
        })
    }
    
    func timerDidFire(timer: NSTimer) {
        operation.progress(count)
        count++
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

