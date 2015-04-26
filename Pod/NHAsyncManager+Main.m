//
//  NHAsyncManager+Main.m
//  Pods
//
//  Created by Naithar on 26.04.15.
//
//

#import "NHAsyncManager+Main.h"

#pragma mark - Main non return

@implementation NHAsyncManager (StartMainNonReturn)

+ (instancetype)promiseMain:(NHAsyncBlock)block {
    return [self promiseMain:block
                   withDelay:0];
}
+ (instancetype)promiseMain:(NHAsyncBlock)block
                  withDelay:(NSTimeInterval)delay {
    return [self promiseMain:block
                   withDelay:delay
                withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)promiseMain:(NHAsyncBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueue:[NSOperationQueue mainQueue]
                        block:block
                    withDelay:delay
                 withPriority:priority];
}

+ (instancetype)main:(NHAsyncBlock)block {
    return [self main:block
            withDelay:0];
}
+ (instancetype)main:(NHAsyncBlock)block
           withDelay:(NSTimeInterval)delay {
    return [self main:block
            withDelay:delay
         withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)main:(NHAsyncBlock)block
           withDelay:(NSTimeInterval)delay
        withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[NSOperationQueue mainQueue]
                 block:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NHAsyncManager (StartMainOnceNonReturn)

+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NHAsyncBlock)block {
    return [self promiseMainOnce:token
                           block:block
                       withDelay:0];
}
+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NHAsyncBlock)block
                      withDelay:(NSTimeInterval)delay {
    return [self promiseMainOnce:token
                           block:block
                       withDelay:delay
                    withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NHAsyncBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[NSOperationQueue mainQueue]
                            token:token
                            block:block
                        withDelay:delay
                     withPriority:priority];
}

+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NHAsyncBlock)block {
    return [self mainOnce:token
                    block:block
                withDelay:0];
}
+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NHAsyncBlock)block
               withDelay:(NSTimeInterval)delay {
    return [self mainOnce:token
                    block:block
                withDelay:delay
             withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NHAsyncBlock)block
               withDelay:(NSTimeInterval)delay
            withPriority:(NSOperationQueuePriority)priority {
    return [self queueOnce:[NSOperationQueue mainQueue]
                     token:token
                     block:block
                 withDelay:delay
              withPriority:priority];
}

@end

@implementation NHAsyncManager (ChainMainNonReturn)

- (instancetype)promiseMain:(NHAsyncBlock)block {
    return [self promiseMain:block
                   withDelay:0];
}
- (instancetype)promiseMain:(NHAsyncBlock)block
                  withDelay:(NSTimeInterval)delay {
    return [self promiseMain:block
                   withDelay:delay
                withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseMain:(NHAsyncBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueue:[NSOperationQueue mainQueue]
                        block:block
                    withDelay:delay
                 withPriority:priority];
}

- (instancetype)main:(NHAsyncBlock)block {
    return [self main:block
            withDelay:0];
}
- (instancetype)main:(NHAsyncBlock)block
           withDelay:(NSTimeInterval)delay {
    return [self main:block
            withDelay:delay
         withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)main:(NHAsyncBlock)block
           withDelay:(NSTimeInterval)delay
        withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[NSOperationQueue mainQueue]
                 block:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NHAsyncManager (ChainMainOnceNonReturn)

- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NHAsyncBlock)block {
    return [self promiseMainOnce:token
                           block:block
                       withDelay:0];
}
- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NHAsyncBlock)block
                      withDelay:(NSTimeInterval)delay {
    return [self promiseMainOnce:token
                           block:block
                       withDelay:delay
                    withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NHAsyncBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[NSOperationQueue mainQueue]
                            token:token
                            block:block
                        withDelay:delay
                     withPriority:priority];
}

- (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NHAsyncBlock)block {
    return [self mainOnce:token
                    block:block
                withDelay:0];
}
- (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NHAsyncBlock)block
               withDelay:(NSTimeInterval)delay {
    return [self mainOnce:token
                    block:block
                withDelay:delay
             withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NHAsyncBlock)block
               withDelay:(NSTimeInterval)delay
            withPriority:(NSOperationQueuePriority)priority {
    return [self queueOnce:[NSOperationQueue mainQueue]
                     token:token
                     block:block
                 withDelay:delay
              withPriority:priority];
}

@end

#pragma mark - Main return value

@implementation NHAsyncManager (StartMainReturn)

+ (instancetype)promiseMainReturn:(NHAsyncReturnBlock)block {
    return [self promiseMainReturn:block
                         withDelay:0];
}
+ (instancetype)promiseMainReturn:(NHAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay {
    return [self promiseMainReturn:block
                         withDelay:delay
                      withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)promiseMainReturn:(NHAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay
                     withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueue:[NSOperationQueue mainQueue]
                  returnBlock:block
                    withDelay:delay
                 withPriority:priority];
}

+ (instancetype)mainReturn:(NHAsyncReturnBlock)block {
    return [self mainReturn:block
                  withDelay:0];
}
+ (instancetype)mainReturn:(NHAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay {
    return [self mainReturn:block
                  withDelay:delay
               withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)mainReturn:(NHAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay
              withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[NSOperationQueue mainQueue]
           returnBlock:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NHAsyncManager (StartMainOnceReturn)

+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                    returnBlock:(NHAsyncReturnBlock)block {
    return [self promiseMainOnce:token
                     returnBlock:block
                       withDelay:0];
}
+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                    returnBlock:(NHAsyncReturnBlock)block
                      withDelay:(NSTimeInterval)delay {
    return [self promiseMainOnce:token
                     returnBlock:block
                       withDelay:delay
                    withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                    returnBlock:(NHAsyncReturnBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[NSOperationQueue mainQueue]
                            token:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:priority];
}

+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
             returnBlock:(NHAsyncReturnBlock)block {
    return [self mainOnce:token
              returnBlock:block
                withDelay:0];
}
+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
             returnBlock:(NHAsyncReturnBlock)block
               withDelay:(NSTimeInterval)delay {
    return [self mainOnce:token
              returnBlock:block
                withDelay:delay
             withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
             returnBlock:(NHAsyncReturnBlock)block
               withDelay:(NSTimeInterval)delay
            withPriority:(NSOperationQueuePriority)priority {
    return [self queueOnce:[NSOperationQueue mainQueue]
                     token:token
               returnBlock:block
                 withDelay:delay
              withPriority:priority];
}

@end

@implementation NHAsyncManager (ChainMainReturn)

- (instancetype)promiseMainReturn:(NHAsyncReturnBlock)block {
    return [self promiseMainReturn:block
                         withDelay:0];
}
- (instancetype)promiseMainReturn:(NHAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay {
    return [self promiseMainReturn:block
                         withDelay:delay
                      withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseMainReturn:(NHAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay
                     withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueue:[NSOperationQueue mainQueue]
                  returnBlock:block
                    withDelay:delay
                 withPriority:priority];
}

- (instancetype)mainReturn:(NHAsyncReturnBlock)block {
    return [self mainReturn:block
                  withDelay:0];
}
- (instancetype)mainReturn:(NHAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay {
    return [self mainReturn:block
                  withDelay:delay
               withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)mainReturn:(NHAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay
              withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[NSOperationQueue mainQueue]
           returnBlock:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NHAsyncManager (ChainMainOnceReturn)

- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                    returnBlock:(NHAsyncReturnBlock)block {
    return [self promiseMainOnce:token
                     returnBlock:block
                       withDelay:0];
}
- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                    returnBlock:(NHAsyncReturnBlock)block
                      withDelay:(NSTimeInterval)delay {
    return [self promiseMainOnce:token
                     returnBlock:block
                       withDelay:delay
                    withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                    returnBlock:(NHAsyncReturnBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[NSOperationQueue mainQueue]
                            token:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:priority];
}

- (instancetype)mainOnce:(NHAsyncOnceToken*)token
             returnBlock:(NHAsyncReturnBlock)block {
    return [self mainOnce:token
              returnBlock:block
                withDelay:0];
}
- (instancetype)mainOnce:(NHAsyncOnceToken*)token
             returnBlock:(NHAsyncReturnBlock)block
               withDelay:(NSTimeInterval)delay {
    return [self mainOnce:token
              returnBlock:block
                withDelay:delay
             withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)mainOnce:(NHAsyncOnceToken*)token
             returnBlock:(NHAsyncReturnBlock)block
               withDelay:(NSTimeInterval)delay
            withPriority:(NSOperationQueuePriority)priority {
    return [self queueOnce:[NSOperationQueue mainQueue]
                     token:token
               returnBlock:block
                 withDelay:delay
              withPriority:priority];
}

@end