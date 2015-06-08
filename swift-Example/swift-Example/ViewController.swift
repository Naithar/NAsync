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

        let operation = NHAsyncOperation(delay: 0, priority: .Normal, previousOperation: nil, andReturnBlock: { _, value in
            NSLog("value = \(value)")

            for i in 0..<100 {
                NSLog("\(100 + i)")
            }

            return 10
            })

        operation.perform(NSOperationQueue(), value: 20)

        NSLog("operation = \(operation.wait())")

        NHAsyncManager.queue(nil) { _ in
                NSLog("operation")
                return
        }

        let promise = NHAsyncManager.promiseQueue(nil) { (_, value: (Int, String)!) in
            NSLog("operation promise returned = \(value)")
            return
        }

        var returnValuePromise = NHAsyncManager.promiseQueue(nil) { (_, value: (Int, Int, Int)!) -> Int! in
            NSLog("return queue input = \(value)")
            return 10
        }

        returnValuePromise.queue(nil) { o in
            NSLog("returned value = \(o)")
            return
        }


        promise.perform((10, "ds"))

//        returnValuePromise.perform(10)

        NSLog("return value promise = \(returnValuePromise.perform((10, 10, 15)).waitAny())")


        NAsync.queue(nil) { _ -> Int! in
            return 0
        }
        
        
        NHAsyncManager.queue(nil) { _ -> Int! in
            return 10
            }.queue(nil) { (_, value: Int!) -> (Int, Int)! in
                return (20 + value, 30 + value * 2)
            }.queue(nil) { (_, value: (Int, Int)!) in
                NSLog("\(value)")
                return
        }

        struct onceToken {
            static var token: NHAsyncOnceToken = 0
            static var token1: NHAsyncOnceToken = 0
        }


        NHAsyncManager.queue(nil, onceToken: &onceToken.token) { _ in
            NSLog("ONCE 0")
            return
        }
//
        let v = NHAsyncManager.queue(nil, onceToken: &onceToken.token) { _ in
            NSLog("ONCE 1")
//            onceToken.token = 0
            return
            }.queue(nil, onceToken: &onceToken.token) { _ in
                NSLog("ONCE 2")
                return
            }.queue(nil, onceToken: &onceToken.token1) { _ -> (Int, Int)! in
                return (100500, 10)
        }

        v.queue(nil) { _ -> UIColor! in
            return UIColor.redColor()
            }.main { (_, value: UIColor!) in
                self.view.backgroundColor = value;
                return
            }.async { _ in
                NSLog("async")
            }.async { _ in
                NSLog("async 1")
        }

        NSLog("once return = \(v.waitAny())")

        NAsync.queue(nil) { _ in
            return
        }
        
        NAsync.async { _ -> Int! in
            return 0
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

