//
//  NAsyncPerformanceTest.m
//  NAsync
//
//  Created by Naithar on 24.04.15.
//  Copyright (c) 2015 Naithar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
@import NAsync;

@interface NAsyncPerformanceTest : XCTestCase

@property NSInteger loopRepeatCount;
@property NSInteger loopCount;
@end

@implementation NAsyncPerformanceTest

- (void)setUp {
    [super setUp];
    self.loopCount = 10;
    self.loopRepeatCount = 1000000;
}

- (void)tearDown {
    [super tearDown];
}

- (void)testPerformanceDispatch {
    [self measureBlock:^{
        XCTestExpectation *expectation = [self expectationWithDescription:@"single async loop expectation"];
        __block NSInteger sum = 0;
        dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
            for (int i = 0; i < self.loopRepeatCount; i++) {
                sum += i * 2;
            }

            [expectation fulfill];
        });

        [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
            if (error) {
                NSLog(@"timeout error %@", error);
            }
        }];
    }];
}

- (void)testPerformanceNSOperation {
    [self measureBlock:^{
        XCTestExpectation *expectation = [self expectationWithDescription:@"single async loop expectation"];
        __block NSInteger sum = 0;
        [[[NSOperationQueue alloc] init] addOperation:[NSBlockOperation blockOperationWithBlock:^{
            for (int i = 0; i < self.loopRepeatCount; i++) {
                sum += i * 2;
            }
            
            [expectation fulfill];
        }]];
        
        
        
        [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
            if (error) {
                NSLog(@"timeout error %@", error);
            }
        }];
    }];
}

- (void)testPerformanceNAsync {
    // This is an example of a performance test case.


    [self measureBlock:^{
        XCTestExpectation *expectation = [self expectationWithDescription:@"single async loop expectation"];
        __block NSInteger sum = 0;
        [NHAsyncManager queue:nil block:^(NHAsyncOperation *operation, id value) {
            for (int i = 0; i < self.loopRepeatCount; i++) {
                sum += i * 2;
            }

            [expectation fulfill];
        }];

        [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
            if (error) {
                NSLog(@"timeout error %@", error);
            }
        }];
    }];
}


- (void)testPerformanceDispatchChainValue {
    [self measureBlock:^{
        XCTestExpectation *expectation = [self expectationWithDescription:@"single async loop expectation"];
        __block NSInteger sum0 = 0;
        dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
            
            NSInteger sum = 0;
            for (int i = 0; i < self.loopRepeatCount; i++) {
                sum += i * 2;
            }
            
            dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
                
                sum0 = sum;
                for (int i = 0; i < self.loopRepeatCount; i++) {
                    sum0 += i * 2;
                }
            [expectation fulfill];
            });
        });
        
        [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
            if (error) {
                NSLog(@"timeout error %@", error);
            }
        }];
    }];
}

- (void)testPerformanceNSOperationChainValue {
    [self measureBlock:^{
        XCTestExpectation *expectation = [self expectationWithDescription:@"single async loop expectation"];
        __block NSInteger sum0 = 0;
        __block NSInteger sum1 = 0;
        
        
        NSOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            for (int i = 0; i < self.loopRepeatCount; i++) {
                sum0 += i * 2;
            }
        }];
        
        NSOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
            sum1 = sum0;
            for (int i = 0; i < self.loopRepeatCount; i++) {
                sum1 += i * 2;
            }
            
            [expectation fulfill];
        }];
        [op1 addDependency:op];
        
        [[[NSOperationQueue alloc] init] addOperation:op1];
        [[[NSOperationQueue alloc] init] addOperation:op];
        
        [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
            if (error) {
                NSLog(@"timeout error %@", error);
            }
        }];
    }];
}

- (void)testPerformanceNAsyncChainValue {
    // This is an example of a performance test case.
    
    
    [self measureBlock:^{
        XCTestExpectation *expectation = [self expectationWithDescription:@"single async loop expectation"];
        __block NSInteger sum0 = 0;
        [[NHAsyncManager queue:nil returnBlock:^id(NHAsyncOperation *operation, id value) {
            
            NSInteger sum = 0;
            for (int i = 0; i < self.loopRepeatCount; i++) {
                sum += i * 2;
            }
            
            return @(sum);
        }] async:^(NHAsyncOperation *operation, id value) {
            sum0 = [value integerValue];
            
            for (int i = 0; i < self.loopRepeatCount; i++) {
                sum0 += i * 2;
            }
            
            [expectation fulfill];
        }];
        
        [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
            if (error) {
                NSLog(@"timeout error %@", error);
            }
        }];
    }];
}

- (void)testPerformanceMultipleDispatch {
    // This is an example of a performance test case.


    [self measureBlock:^{
        NSArray *expectations = @[
                                  [self expectationWithDescription:@"single async loop expectation 0"],
                                  [self expectationWithDescription:@"single async loop expectation 1"],
                                  [self expectationWithDescription:@"single async loop expectation 2"],
                                  [self expectationWithDescription:@"single async loop expectation 3"],
                                  [self expectationWithDescription:@"single async loop expectation 4"],
                                  [self expectationWithDescription:@"single async loop expectation 5"],
                                  [self expectationWithDescription:@"single async loop expectation 6"],
                                  [self expectationWithDescription:@"single async loop expectation 7"],
                                  [self expectationWithDescription:@"single async loop expectation 8"],
                                  [self expectationWithDescription:@"single async loop expectation 9"]
                                  ];


        for (int index = 0; index < self.loopCount; index++) {
            __block NSInteger sum = 0;
            dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
                for (int i = 0; i < self.loopRepeatCount; i++) {
                    sum += i * 2;
                }

                [expectations[index] fulfill];
            });
        }

        [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
            if (error) {
                NSLog(@"timeout error %@", error);
            }
        }];
    }];
}
- (void)testPerformanceMultipleNAsync {
    // This is an example of a performance test case.


    [self measureBlock:^{
        NSArray *expectations = @[
                                  [self expectationWithDescription:@"single async loop expectation 0"],
                                  [self expectationWithDescription:@"single async loop expectation 1"],
                                  [self expectationWithDescription:@"single async loop expectation 2"],
                                  [self expectationWithDescription:@"single async loop expectation 3"],
                                  [self expectationWithDescription:@"single async loop expectation 4"],
                                  [self expectationWithDescription:@"single async loop expectation 5"],
                                  [self expectationWithDescription:@"single async loop expectation 6"],
                                  [self expectationWithDescription:@"single async loop expectation 7"],
                                  [self expectationWithDescription:@"single async loop expectation 8"],
                                  [self expectationWithDescription:@"single async loop expectation 9"]
                                  ];


        for (int index = 0; index < self.loopCount; index++) {
            __block NSInteger sum = 0;
        [NHAsyncManager queue:nil block:^(NHAsyncOperation *operation, id value) {
            for (int i = 0; i < self.loopRepeatCount; i++) {
                sum += i * 2;
            }

            [expectations[index] fulfill];
        }];
        }

        [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
            if (error) {
                NSLog(@"timeout error %@", error);
            }
        }];
    }];
}

- (void)testPerfomanceChainDispatch {
    [self measureBlock:^{
        XCTestExpectation *expectation = [self expectationWithDescription:@"single async loop expectation 0"];
        XCTestExpectation *expectationChain = [self expectationWithDescription:@"single async loop expectation 1"];
        //        __block
        dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
            NSInteger sum = 0;
            for (int i = 0; i < self.loopRepeatCount; i++) {
                sum += i * 2;
            }

            [expectation fulfill];
            dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
                NSInteger sum1 = sum;

                for (int i = 0; i < self.loopRepeatCount; i++) {
                    sum1 += i * 2;
                }

                [expectationChain fulfill];
            });
        });

        [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
            if (error) {
                NSLog(@"timeout error %@", error);
            }
        }];
    }];
    
}

- (void)testPerfomanceChainNAsync {
    [self measureBlock:^{
        XCTestExpectation *expectation = [self expectationWithDescription:@"single async loop expectation 0"];
        XCTestExpectation *expectationChain = [self expectationWithDescription:@"single async loop expectation 1"];
//        __block 
        [[NHAsyncManager queue:nil returnBlock:^id(NHAsyncOperation *operation, id value) {
            NSInteger sum = 0;
            for (int i = 0; i < self.loopRepeatCount; i++) {
                sum += i * 2;
            }

            [expectation fulfill];
            return @(sum);
        }] queue:nil block:^(NHAsyncOperation *operation, id value) {
            NSInteger sum = [value integerValue];

            for (int i = 0; i < self.loopRepeatCount; i++) {
                sum += i * 2;
            }

            [expectationChain fulfill];
        }];

        [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
            if (error) {
                NSLog(@"timeout error %@", error);
            }
        }];
    }];

}

@end
