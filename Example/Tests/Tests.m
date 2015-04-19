//
//  NAsyncTests.m
//  NAsyncTests
//
//  Created by Naithar on 04/18/2015.
//  Copyright (c) 2014 Naithar. All rights reserved.
//


//@import NAsync;
SpecBegin(InitialSpecs)

//describe(@"these will fail", ^{
//
//    it(@"can do maths", ^{
//        expect(1).beLessThan(23);
//    });
//
//    it(@"can read", ^{
//        expect(@"team").toNot.contain(@"I");
//    });
//
//    it(@"will wait for 10 seconds and fail", ^{
//        waitUntil(^(DoneCallback done) {
//            done();
//        });
//    });
//});
//
//describe(@"operation without return type", ^{
//    it(@"will run", ^{
//        __block NSInteger index = 0;
//        waitUntil(^(DoneCallback done) {
//            [[[NAsyncOperation alloc] initWithDelay:0
//                                          priority:NSOperationQueuePriorityNormal
//                                 previousOperation:nil
//                                          andBlock:^(NAsyncOperation *operation, id value) {
//                                              index = [value integerValue];
//                                              done();
//                                          }] performOnQueue:[NSOperationQueue mainQueue] withValue:@10];
//        });
//
//        expect(index).to.equal(10);
//    });
//});

SpecEnd
