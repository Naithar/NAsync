//
//  NAsyncTests.m
//  NAsyncTests
//
//  Created by Naithar on 04/18/2015.
//  Copyright (c) 2014 Naithar. All rights reserved.
//

@import NAsync;

SpecBegin(NHAsyncOperationBlock)

describe(@"operation without return type", ^{
    it(@"will run", ^{
        waitUntil(^(DoneCallback done) {
            [[[NHAsyncOperation alloc] initWithDelay:0
                                           priority:NSOperationQueuePriorityNormal
                                  previousOperation:nil
                                           andBlock:^(NHAsyncOperation *operation, id value) {
                                               done();
                                           }] performInQueue:[NSOperationQueue mainQueue]];
        });
    });

    it(@"will run and receive value", ^{
        __block NSInteger index = 0;
        waitUntil(^(DoneCallback done) {
            [[[NHAsyncOperation alloc] initWithDelay:0
                                           priority:NSOperationQueuePriorityNormal
                                  previousOperation:nil
                                           andBlock:^(NHAsyncOperation *operation, id value) {
                                               index = [value integerValue];
                                               done();
                                           }] performInQueue:[NSOperationQueue mainQueue] withValue:@10];
        });

        expect(index).to.equal(10);
    });
});

SpecEnd


SpecBegin(NHAsyncOperationReturnBlock)

describe(@"operation with return value", ^{
    it(@"will run and return value", ^{
        __block NHAsyncOperation *operation;

        waitUntil(^(DoneCallback done) {
            operation = [[NHAsyncOperation alloc] initWithDelay:0
                                                      priority:NSOperationQueuePriorityNormal
                                             previousOperation:nil
                                                andReturnBlock:^(NHAsyncOperation *operation, id value) {
                                                    done();
                                                    return @20;
                                                }];
            [operation performInQueue:[NSOperationQueue mainQueue]];
        });

        expect([operation wait]).to.equal(@20);
    });

    it(@"will run, receive value and return value", ^{
        __block NSInteger index = 0;
        __block NHAsyncOperation *operation;

        waitUntil(^(DoneCallback done) {
            operation = [[NHAsyncOperation alloc] initWithDelay:0
                                                      priority:NSOperationQueuePriorityNormal
                                             previousOperation:nil
                                                andReturnBlock:^(NHAsyncOperation *operation, id value) {
                                                    index = [value integerValue];
                                                    done();
                                                    return @20;
                                                }];
            [operation performInQueue:[NSOperationQueue mainQueue] withValue:@10];
        });

        expect(index).to.equal(10);

        expect([operation wait]).to.equal(@20);
    });
});

SpecEnd


SpecBegin(NHAsyncManagerQueue)

describe(@"start operation", ^{
    it(@"will promise", ^{

        waitUntil(^(DoneCallback done) {
            NHAsyncManager *manager = [NHAsyncManager promiseQueue:nil
                                                           block:^(id _0, id _1){
                                                               done();
                                                           }];

            [manager perform];
        });

    });

    it(@"will promise and receive value", ^{

        __block NSInteger index = 0;
        waitUntil(^(DoneCallback done) {
            NHAsyncManager *manager = [NHAsyncManager promiseQueue:nil
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
            [NHAsyncManager queue:nil
                           block:^(id _0, id _1){
                               done();
                           }];
        });
    });
});


describe(@"operation chaining", ^{
    it(@"will run chain task", ^{
        waitUntil(^(DoneCallback done) {
            [[NHAsyncManager queue:nil
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
            NHAsyncManager *promise = [NHAsyncManager promiseQueue:nil
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
            NHAsyncManager *promise = [NHAsyncManager promiseQueue:nil
                                                           block:^(id _0, id _1){

                                                           }];

            NHAsyncManager *chainedPromise = [promise promiseQueue:nil
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
            NHAsyncManager *promise = [NHAsyncManager promiseQueue:nil
                                                           block:^(id _0, id _1){

                                                           }];

            NHAsyncManager *chainedPromise = [promise promiseQueue:nil
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


SpecBegin(NHAsyncManagerReturnQueue)

describe(@"start return manager", ^{
    it(@"will start and return value", ^{

        __block NSUInteger index = 0;

        waitUntil(^(DoneCallback done) {
            index = [[[NHAsyncManager queue:nil
                               returnBlock:^(NHAsyncOperation *operation,
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
            taskReturnValue = [[[[NHAsyncManager queue:nil
                      returnBlock:^(NHAsyncOperation *operation,
                                    id value) {
                          return @10;
                      }]
             queue:nil
             returnBlock:^(NHAsyncOperation *_, id value){

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