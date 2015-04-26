//
//  NHAsyncManager+Async.m
//  Pods
//
//  Created by Naithar on 26.04.15.
//
//

#import "NHAsyncManager+Async.h"

#pragma mark - Async non return

@implementation NHAsyncManager (StartAsyncNonReturn)

+ (instancetype)promiseAsync:(NHAsyncBlock)block {
    return [self promiseAsync:block
                    withDelay:0];
}
+ (instancetype)promiseAsync:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseAsync:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)promiseAsync:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueue:[[NSOperationQueue alloc] init]
                        block:block
                    withDelay:delay
                 withPriority:priority];
}

+ (instancetype)async:(NHAsyncBlock)block {
    return [self async:block
             withDelay:0];
}
+ (instancetype)async:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self async:block
             withDelay:delay
          withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)async:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[[NSOperationQueue alloc] init]
                 block:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NHAsyncManager (StartAsyncOnceNonReturn)

+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block {
    return [self promiseAsyncOnce:token
                            block:block
                        withDelay:0];
}
+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseAsyncOnce:token
                            block:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[[NSOperationQueue alloc] init]
                            token:token
                            block:block
                        withDelay:delay
                     withPriority:priority];
}

+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block {
    return [self asyncOnce:token
                     block:block
                 withDelay:0];
}
+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self asyncOnce:token
                     block:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    return [self queueOnce:[[NSOperationQueue alloc] init]
                     token:token
                     block:block
                 withDelay:delay
              withPriority:priority];
}

@end

@implementation NHAsyncManager (ChainAsyncNonReturn)

- (instancetype)promiseAsync:(NHAsyncBlock)block {
    return [self promiseAsync:block
                    withDelay:0];
}
- (instancetype)promiseAsync:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseAsync:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseAsync:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[self chainAsyncQueue]
                 block:block
             withDelay:delay
          withPriority:priority];
}

- (instancetype)async:(NHAsyncBlock)block {
    return [self async:block
             withDelay:0];
}
- (instancetype)async:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self async:block
             withDelay:delay
          withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)async:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[self chainAsyncQueue]
                 block:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NHAsyncManager (ChainAsyncOnceNonReturn)

- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block {
    return [self promiseAsyncOnce:token
                            block:block
                        withDelay:0];
}
- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseAsyncOnce:token
                            block:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[self chainAsyncQueue]
                            token:token
                            block:block
                        withDelay:delay
                     withPriority:priority];
}

- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block {
    return [self asyncOnce:token
                     block:block
                 withDelay:0];
}
- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self asyncOnce:token
                     block:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    return [self queueOnce:[self chainAsyncQueue]
                     token:token
                     block:block
                 withDelay:delay
              withPriority:priority];
}

@end

#pragma mark - Async return value

@implementation NHAsyncManager (StartAsyncReturn)

+ (instancetype)promiseAsyncReturn:(NHAsyncReturnBlock)block {
    return [self promiseAsyncReturn:block
                          withDelay:0];
}
+ (instancetype)promiseAsyncReturn:(NHAsyncReturnBlock)block
                         withDelay:(NSTimeInterval)delay {
    return [self promiseAsyncReturn:block
                          withDelay:delay
                       withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)promiseAsyncReturn:(NHAsyncReturnBlock)block
                         withDelay:(NSTimeInterval)delay
                      withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueue:[[NSOperationQueue alloc] init]
                  returnBlock:block
                    withDelay:delay
                 withPriority:priority];
}

+ (instancetype)asyncReturn:(NHAsyncReturnBlock)block {
    return [self asyncReturn:block
                   withDelay:0];
}
+ (instancetype)asyncReturn:(NHAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay {
    return [self asyncReturn:block
                   withDelay:delay
                withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)asyncReturn:(NHAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[[NSOperationQueue alloc] init]
           returnBlock:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NHAsyncManager (StartAsyncOnceReturn)

+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block {
    return [self promiseAsyncOnce:token
                      returnBlock:block
                        withDelay:0];
}
+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseAsyncOnce:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[[NSOperationQueue alloc] init]
                            token:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:priority];
}

+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block {
    return [self asyncOnce:token
               returnBlock:block
                 withDelay:0];
}
+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self asyncOnce:token
               returnBlock:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    return [self queueOnce:[[NSOperationQueue alloc] init]
                     token:token
               returnBlock:block
                 withDelay:delay
              withPriority:priority];
}

@end

@implementation NHAsyncManager (ChainAsyncReturn)

- (instancetype)promiseAsyncReturn:(NHAsyncReturnBlock)block {
    return [self promiseAsyncReturn:block
                          withDelay:0];
}
- (instancetype)promiseAsyncReturn:(NHAsyncReturnBlock)block
                         withDelay:(NSTimeInterval)delay {
    return [self promiseAsyncReturn:block
                          withDelay:delay
                       withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseAsyncReturn:(NHAsyncReturnBlock)block
                         withDelay:(NSTimeInterval)delay
                      withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueue:[self chainAsyncQueue]
                  returnBlock:block
                    withDelay:delay
                 withPriority:priority];
}

- (instancetype)asyncReturn:(NHAsyncReturnBlock)block {
    return [self asyncReturn:block
                   withDelay:0];
}
- (instancetype)asyncReturn:(NHAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay {
    return [self asyncReturn:block
                   withDelay:delay
                withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)asyncReturn:(NHAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[self chainAsyncQueue]
           returnBlock:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NHAsyncManager (ChainAsyncOnceReturn)

- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block {
    return [self promiseAsyncOnce:token
                      returnBlock:block
                        withDelay:0];
}
- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseAsyncOnce:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[self chainAsyncQueue]
                            token:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:priority];
}

- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block {
    return [self asyncOnce:token
               returnBlock:block
                 withDelay:0];
}
- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self asyncOnce:token
               returnBlock:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    return [self queueOnce:[self chainAsyncQueue]
                     token:token
               returnBlock:block
                 withDelay:delay
              withPriority:priority];
}

@end