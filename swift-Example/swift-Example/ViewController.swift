//
//  ViewController.swift
//  swift-Example
//
//  Created by Naithar on 19.04.15.
//  Copyright (c) 2015 Naithar. All rights reserved.
//

import UIKit
import NAsync
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let operation = NAsyncOperation(delay: 0, priority: .Normal, previousOperation: nil, andReturnBlock: { _, value in
            NSLog("value = \(value)")

            for i in 0..<100 {
                NSLog("\(100 + i)")
            }

            return 10
            })

        operation.perform(NSOperationQueue(), value: 20)

        NSLog("\(operation.wait())")

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

