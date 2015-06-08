//
//  NAsyncSwiftPerformanceTest.swift
//  NAsync
//
//  Created by Sergey Minakov on 08.06.15.
//  Copyright (c) 2015 Naithar. All rights reserved.
//

import UIKit
import XCTest
import NAsync

class NAsyncSwiftPerformanceTest: XCTestCase {
    let loopCount = 10
    let loopRepeatCount = 1000000
    
    func testSwiftPerformanceDispatch() {
        self.measureBlock() {
            let expectation = self.expectationWithDescription("single async loop expectation")
            
            var sum = 0
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                for (var i = 0; i < self.loopRepeatCount; i++) {
                    sum += i * 2;
                }
                
                expectation.fulfill()
                return
            }
            
            self.waitForExpectationsWithTimeout(10, handler: { error in
                if (error != nil) {
                    NSLog("timeout error \(error)")
                }
                return
            })
        }
    }
    
    func testSwiftPerformanceNSOPeration() {
        self.measureBlock() {
        let expectation = self.expectationWithDescription("single async loop expectation")
        
        var sum = 0
        
        NSOperationQueue().addOperation(NSBlockOperation {
            for (var i = 0; i < self.loopRepeatCount; i++) {
                sum += i * 2;
            }
            
            expectation.fulfill()
            return
            })
        
        self.waitForExpectationsWithTimeout(10, handler: { error in
            if (error != nil) {
                NSLog("timeout error \(error)")
            }
            return
        })
        }
    }
    
    func testSwiftPerformanceNAsync() {
        self.measureBlock() {
            let expectation = self.expectationWithDescription("single async loop expectation")
            
            var sum = 0
            
            NAsync.async { _ in
                for (var i = 0; i < self.loopRepeatCount; i++) {
                    sum += i * 2;
                }
                
                expectation.fulfill()
                return
            }
            
            self.waitForExpectationsWithTimeout(10, handler: { error in
                if (error != nil) {
                    NSLog("timeout error \(error)")
                }
                return
            })
        }
    }
    
    
    func testSwiftPerformanceDispatchChainValue() {
        self.measureBlock() {
            let expectation = self.expectationWithDescription("single async loop expectation")
            
            var sum0 = 0
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                
                var sum = 0;
                for (var i = 0; i < self.loopRepeatCount; i++) {
                    sum += i * 2;
                }
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    
                    sum0 = sum;
                    for (var i = 0; i < self.loopRepeatCount; i++) {
                        sum0 += i * 2;
                    }
                    
                    expectation.fulfill()
                    return
                }
                return
            }
            
            self.waitForExpectationsWithTimeout(10, handler: { error in
                if (error != nil) {
                    NSLog("timeout error \(error)")
                }
                return
            })
        }
    }
    
    func testSwiftPerformanceNSOPerationChainValue() {
        self.measureBlock() {
            let expectation = self.expectationWithDescription("single async loop expectation")
            
            var sum0 = 0
            var sum1 = 0
            
            
            let op = NSBlockOperation {
                for (var i = 0; i < self.loopRepeatCount; i++) {
                    sum0 += i * 2;
                }
            
                return
            }
            
            let op1 = NSBlockOperation {
                sum1 = sum0
                for (var i = 0; i < self.loopRepeatCount; i++) {
                    sum1 += i * 2;
                }
                
                expectation.fulfill()
                return
            }
            
            op1.addDependency(op)
            
            let queue = NSOperationQueue()
            queue.addOperation(op1)
            queue.addOperation(op)
            
            self.waitForExpectationsWithTimeout(10, handler: { error in
                if (error != nil) {
                    NSLog("timeout error \(error)")
                }
                return
            })
        }
    }
    
    func testSwiftPerformanceNAsyncChainValue() {
        self.measureBlock() {
            let expectation = self.expectationWithDescription("single async loop expectation")
            
            var sum0 = 0
            
            NAsync.queue(nil) { _ -> (Int, String)! in
                
                var sum = 0
                for (var i = 0; i < self.loopRepeatCount; i++) {
                    sum += i * 2;
                }
                
                return (sum, "hello")
                }.queue(nil) { (_, value: (Int, String)!) in
                    sum0 = value.0
                    for (var i = 0; i < self.loopRepeatCount; i++) {
                        sum0 += i * 2;
                    }
                    
                    expectation.fulfill()
            }
            
            self.waitForExpectationsWithTimeout(10, handler: { error in
                if (error != nil) {
                    NSLog("timeout error \(error)")
                }
                return
            })
        }
    }

}
