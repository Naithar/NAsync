//
//  NAsyncTests.m
//  NAsyncTests
//
//  Created by Naithar on 04/18/2015.
//  Copyright (c) 2014 Naithar. All rights reserved.
//

@import NAsync;

SpecBegin(NAsyncOperationBlock)

describe(@"operation without return type", ^{
    it(@"will run", ^{
        waitUntil(^(DoneCallback done) {
            [[[NAsyncOperation alloc] initWithDelay:0
                                           priority:NSOperationQueuePriorityNormal
                                  previousOperation:nil
                                           andBlock:^(NAsyncOperation *operation, id value) {
                                               done();
                                           }] performOnQueue:[NSOperationQueue mainQueue]];
        });
    });

    it(@"will run and receive value", ^{
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

SpecEnd


SpecBegin(NAsyncOperationReturnBlock)

describe(@"operation with return value", ^{
    it(@"will run and return value", ^{
        __block NAsyncOperation *operation;

        waitUntil(^(DoneCallback done) {
            operation = [[NAsyncOperation alloc] initWithDelay:0
                                                      priority:NSOperationQueuePriorityNormal
                                             previousOperation:nil
                                                andReturnBlock:^(NAsyncOperation *operation, id value) {
                                                    done();
                                                    return @20;
                                                }];
            [operation performOnQueue:[NSOperationQueue mainQueue]];
        });

        expect([operation wait]).to.equal(@20);
    });

    it(@"will run, receive value and return value", ^{
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


SpecBegin(NAsyncManagerQueue)

describe(@"start operation", ^{
    it(@"will promise", ^{

        waitUntil(^(DoneCallback done) {
            NAsyncManager *manager = [NAsyncManager promiseQueue:nil
                                                           block:^(id _0, id _1){
                                                               done();
                                                           }];

            [manager perform];
        });

    });

    it(@"will promise and receive value", ^{

        __block NSInteger index = 0;
        waitUntil(^(DoneCallback done) {
            NAsyncManager *manager = [NAsyncManager promiseQueue:nil
                                                           block:^(id _0, NSNumber* value){
                                                               index = [value integerValue];
                                                               done();
                                                           }];

            [manager performWithValue:@10];
        });

        expect(index).to.equal(10);
    });

    it(@"will run task", ^{
        waitUntil(^(DoneCallback done) {
            [NAsyncManager queue:nil
                           block:^(id _0, id _1){
                               done();
                           }];
        });
    });
});


describe(@"operation chaining", ^{
    it(@"will run chain task", ^{
        waitUntil(^(DoneCallback done) {
            [[NAsyncManager queue:nil
                            block:^(id _0, id _1){

                            }]
             queue:nil
             block:^(id _0, id _1){
                 done();
             }];
        });
    });

    it(@"will run chain task on promise", ^{
        waitUntil(^(DoneCallback done) {
            NAsyncManager *promise = [NAsyncManager promiseQueue:nil
                                                           block:^(id _0, id _1){

                                                           }];

            [promise queue:nil
                     block:^(id _0, id _1){
                         done();
                     }];

            [promise perform];
        });
    });

    it(@"will run promise chain task on promise", ^{
        waitUntil(^(DoneCallback done) {
            NAsyncManager *promise = [NAsyncManager promiseQueue:nil
                                                           block:^(id _0, id _1){

                                                           }];

            NAsyncManager *chainedPromise = [promise promiseQueue:nil
                                                            block:^(id _0, id _1){
                                                                done();
                                                            }];

            [promise perform];
            [chainedPromise perform];
        });
    });

    it(@"will run promise chain task with value on promise", ^{
        __block NSInteger index = 0;
        waitUntil(^(DoneCallback done) {
            NAsyncManager *promise = [NAsyncManager promiseQueue:nil
                                                           block:^(id _0, id _1){

                                                           }];

            NAsyncManager *chainedPromise = [promise promiseQueue:nil
                                                            block:^(id _0, id value){
                                                                index = [value integerValue];
                                                                done();
                                                            }];

            [promise perform];
            [chainedPromise performWithValue:@10];
        });

        expect(index).to.equal(10);
    });
});

SpecEnd


SpecBegin(NAsyncManagerReturnQueue)

describe(@"start return manager", ^{
    it(@"will start and return value", ^{

        __block NSUInteger index = 0;

        waitUntil(^(DoneCallback done) {
            index = [[[NAsyncManager queue:nil
                               returnBlock:^(NAsyncOperation *operation,
                                             id value) {
                                   done();
                                   return @10;
                               }] wait] integerValue];
        });
        
        expect(index).to.equal(10);
    });
});

describe(@"сhain return manager", ^{
    it(@"will start and return value to chain task", ^{

        __block NSUInteger returnValue = 0;
        __block NSUInteger taskReturnValue = 0;

        waitUntil(^(DoneCallback done) {
            taskReturnValue = [[[[NAsyncManager queue:nil
                      returnBlock:^(NAsyncOperation *operation,
                                    id value) {
                          return @10;
                      }]
             queue:nil
             returnBlock:^(NAsyncOperation *_, id value){

                 returnValue = [value integerValue];
                 done();
                 return @20;
             }] wait] integerValue];
        });

        expect(returnValue).to.equal(10);
        expect(taskReturnValue).to.equal(20);
    });
});

SpecEnd