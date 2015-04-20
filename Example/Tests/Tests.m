//
//  NAsyncTests.m
//  NAsyncTests
//
//  Created by Naithar on 04/18/2015.
//  Copyright (c) 2014 Naithar. All rights reserved.
//

@import NAsync;


SpecBegin(InitialSpecs)


describe(@"operation without return type", ^{
    it(@"will run", ^{
        __block NSInteger index = 0;
        waitUntil(^(DoneCallback done) {
            [[[NAsyncOperation alloc] initWithDelay:0
                                          priority:NSOperationQueuePriorityNormal
                                 previousOperation:nil
                                          andBlock:^(NAsyncOperation *operation, id value) {
                                              index = [value integerValue];
                                              done();
                                          }] performOnQueue:[NSOperationQueue mainQueue] withValue:@10];
        });

        expect(index).to.equal(10);
    });
});

describe(@"operation with return value", ^{
    it(@"will run", ^{
        __block NSInteger index = 0;
        __block NAsyncOperation *operation;

        waitUntil(^(DoneCallback done) {
            operation = [[NAsyncOperation alloc] initWithDelay:0
                                           priority:NSOperationQueuePriorityNormal
                                  previousOperation:nil
                                           andReturnBlock:^(NAsyncOperation *operation, id value) {
                                               index = [value integerValue];
                                               done();
                                               return @20;
                                           }];
            [operation performOnQueue:[NSOperationQueue mainQueue] withValue:@10];
        });

        expect(index).to.equal(10);

        expect([operation wait]).to.equal(@20);
    });
});

SpecEnd
