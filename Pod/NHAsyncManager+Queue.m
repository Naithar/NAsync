//
//  NHAsyncManager+Queue.m
//  Pods
//
//  Created by Naithar on 26.04.15.
//
//

#import "NHAsyncManager+Queue.h"

#pragma mark - Queue non return

@implementation NHAsyncManager (StartQueuedNonReturn)

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block {
    return [self promiseQueue:queue
                        block:block
                    withDelay:0];
}

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseQueue:queue
                        block:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority {
    return [[self alloc] initWithQueue:queue
                             withDelay:delay
                              priority:priority
                     previousOperation:nil
                              andBlock:block];
}

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block {
    return [self queue:queue
                 block:block
             withDelay:0];
}

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self queue:queue
                 block:block
             withDelay:delay
          withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueue:queue
                                           block:block
                                       withDelay:delay
                                    withPriority:priority];
    return [manager perform];
}

@end

@implementation NHAsyncManager (StartQueuedOnceNonReturn)

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block {
    return [self promiseQueueOnce:queue
                            token:token
                            block:block
                        withDelay:0];
}

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseQueueOnce:queue
                            token:token
                            block:block
                        withDelay:0
                     withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {

    NHAsyncBlock operationOnceBlock = ^(NHAsyncOperation *operation,
                                        id value) {
        if (block) {
            dispatch_once(token, ^{
                block(operation, value);
            });
        }
    };

    return [self promiseQueue:queue
                        block:operationOnceBlock
                    withDelay:delay
                 withPriority:priority];
}

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block {
    return [self queueOnce:queue
                     token:token
                     block:block
                 withDelay:0];
}

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self queueOnce:queue
                     token:token
                     block:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}


+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueueOnce:queue
                                               token:token
                                               block:block
                                           withDelay:delay
                                        withPriority:priority];

    return [manager perform];
}

@end

@implementation NHAsyncManager (ChainQueuedNonReturn)

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block {
    return [self promiseQueue:queue
                        block:block
                    withDelay:0];
}

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseQueue:queue
                        block:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority {
    return [[[self class] alloc] initWithQueue:queue
                                     withDelay:delay
                                      priority:priority
                             previousOperation:self.operation
                                      andBlock:block];
}

- (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block {
    return [self queue:queue
                 block:block
             withDelay:0];
}

- (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self queue:queue
                 block:block
             withDelay:delay
          withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueue:queue
                                           block:block
                                       withDelay:delay
                                    withPriority:priority];

    return [manager perform];
}

@end

@implementation NHAsyncManager (ChainQueuedOnceNonReturn)

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block {
    return [self promiseQueueOnce:queue
                            token:token
                            block:block
                        withDelay:0];
}

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseQueueOnce:queue
                            token:token
                            block:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {
    NHAsyncBlock operationOnceBlock = ^(NHAsyncOperation *operation,
                                        id value) {
        if (block) {
            dispatch_once(token, ^{
                block(operation, value);
            });
        }
    };

    return [self promiseQueue:queue
                        block:operationOnceBlock
                    withDelay:delay
                 withPriority:priority];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block {
    return [self queueOnce:queue
                     token:token
                     block:block
                 withDelay:0];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self queueOnce:queue
                     token:token
                     block:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueueOnce:queue
                                               token:token
                                               block:block
                                           withDelay:delay
                                        withPriority:priority];

    return [manager perform];
}
@end

#pragma mark - Queue return value

@implementation NHAsyncManager (StartQueuedReturn)

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block {
    return [self promiseQueue:queue
                  returnBlock:block
                    withDelay:0];
}

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseQueue:queue
                  returnBlock:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority {
    return [[self alloc] initWithQueue:queue
                             withDelay:delay
                              priority:priority
                     previousOperation:nil
                        andReturnBlock:block];
}

+ (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block {
    return [self queue:queue
           returnBlock:block
             withDelay:0];
}

+ (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self queue:queue
           returnBlock:block
             withDelay:0
          withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueue:queue
                                     returnBlock:block
                                       withDelay:delay
                                    withPriority:priority];

    return [manager perform];
}

@end

@implementation NHAsyncManager (StartQueuedOnceReturn)

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block {
    return [self promiseQueueOnce:queue
                            token:token
                      returnBlock:block
                        withDelay:0];
}

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseQueueOnce:queue
                            token:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {

    NHAsyncReturnBlock operationOnceBlock = ^id(NHAsyncOperation *operation,
                                                id value) {
        __block id returnValue = nil;

        if (block) {
            dispatch_once(token, ^{
                returnValue = block(operation, value);
            });
        }

        return returnValue;
    };

    return [self promiseQueue:queue
                  returnBlock:operationOnceBlock
                    withDelay:delay
                 withPriority:priority];
}

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block {
    return [self queueOnce:queue
                     token:token
               returnBlock:block
                 withDelay:0];
}

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self queueOnce:queue
                     token:token
               returnBlock:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueueOnce:queue
                                               token:token
                                         returnBlock:block
                                           withDelay:delay
                                        withPriority:priority];

    return [manager perform];
}

@end

@implementation NHAsyncManager (ChainQueuedReturn)

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block {
    return [self promiseQueue:queue
                  returnBlock:block
                    withDelay:0];
}

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseQueue:queue
                  returnBlock:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority {
    return [[[self class] alloc] initWithQueue:queue
                                     withDelay:delay
                                      priority:priority
                             previousOperation:self.operation
                                andReturnBlock:block];
}

- (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block {
    return [self queue:queue
           returnBlock:block
             withDelay:0];
}

- (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self queue:queue
           returnBlock:block
             withDelay:delay
          withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueue:queue
                                     returnBlock:block
                                       withDelay:delay
                                    withPriority:priority];

    return [manager perform];
}
@end

@implementation NHAsyncManager (ChainQueuedOnceReturn)

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block {
    return [self promiseQueueOnce:queue
                            token:token
                      returnBlock:block
                        withDelay:0];
}

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseQueueOnce:queue
                            token:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {

    NHAsyncReturnBlock operationOnceBlock = ^id(NHAsyncOperation *operation,
                                                id value) {
        __block id returnValue = nil;

        if (block) {
            dispatch_once(token, ^{
                returnValue = block(operation, value);
            });
        }

        return returnValue;
    };

    return [self promiseQueue:queue
                  returnBlock:operationOnceBlock
                    withDelay:delay
                 withPriority:priority];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block {
    return [self queueOnce:queue
                     token:token
               returnBlock:block
                 withDelay:0];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self queueOnce:queue
                     token:token
               returnBlock:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueueOnce:queue
                                               token:token
                                         returnBlock:block
                                           withDelay:delay
                                        withPriority:priority];
    
    return [manager perform];
}

@end