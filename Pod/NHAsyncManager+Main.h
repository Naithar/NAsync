//
//  NHAsyncManager+Main.h
//  Pods
//
//  Created by Naithar on 26.04.15.
//
//

#import "NHAsyncManager+Queue.h"

#pragma mark - Main non return

@interface NHAsyncManager (StartMainNonReturn)

+ (instancetype)promiseMain:(NHAsyncBlock)block;
+ (instancetype)promiseMain:(NHAsyncBlock)block
                  withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseMain:(NHAsyncBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)main:(NHAsyncBlock)block;
+ (instancetype)main:(NHAsyncBlock)block
           withDelay:(NSTimeInterval)delay;
+ (instancetype)main:(NHAsyncBlock)block
           withDelay:(NSTimeInterval)delay
        withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (StartMainOnceNonReturn)

+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NHAsyncBlock)block;
+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NHAsyncBlock)block
                      withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NHAsyncBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NHAsyncBlock)block;
+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NHAsyncBlock)block
               withDelay:(NSTimeInterval)delay;
+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NHAsyncBlock)block
               withDelay:(NSTimeInterval)delay
            withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (ChainMainNonReturn)

- (instancetype)promiseMain:(NHAsyncBlock)block;
- (instancetype)promiseMain:(NHAsyncBlock)block
                  withDelay:(NSTimeInterval)delay;
- (instancetype)promiseMain:(NHAsyncBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority;

- (instancetype)main:(NHAsyncBlock)block;
- (instancetype)main:(NHAsyncBlock)block
           withDelay:(NSTimeInterval)delay;
- (instancetype)main:(NHAsyncBlock)block
           withDelay:(NSTimeInterval)delay
        withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (ChainMainOnceNonReturn)

- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NHAsyncBlock)block;
- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NHAsyncBlock)block
                      withDelay:(NSTimeInterval)delay;
- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NHAsyncBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority;

- (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NHAsyncBlock)block;
- (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NHAsyncBlock)block
               withDelay:(NSTimeInterval)delay;
- (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NHAsyncBlock)block
               withDelay:(NSTimeInterval)delay
            withPriority:(NSOperationQueuePriority)priority;

@end

#pragma mark - Main return value

@interface NHAsyncManager (StartMainReturn)

+ (instancetype)promiseMainReturn:(NHAsyncReturnBlock)block;
+ (instancetype)promiseMainReturn:(NHAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseMainReturn:(NHAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay
                     withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)mainReturn:(NHAsyncReturnBlock)block;
+ (instancetype)mainReturn:(NHAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay;
+ (instancetype)mainReturn:(NHAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay
              withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (StartMainOnceReturn)

+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                    returnBlock:(NHAsyncReturnBlock)block;
+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                    returnBlock:(NHAsyncReturnBlock)block
                      withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                    returnBlock:(NHAsyncReturnBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
             returnBlock:(NHAsyncReturnBlock)block;
+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
             returnBlock:(NHAsyncReturnBlock)block
               withDelay:(NSTimeInterval)delay;
+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
             returnBlock:(NHAsyncReturnBlock)block
               withDelay:(NSTimeInterval)delay
            withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (ChainMainReturn)

- (instancetype)promiseMainReturn:(NHAsyncReturnBlock)block;
- (instancetype)promiseMainReturn:(NHAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay;
- (instancetype)promiseMainReturn:(NHAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay
                     withPriority:(NSOperationQueuePriority)priority;

- (instancetype)mainReturn:(NHAsyncReturnBlock)block;
- (instancetype)mainReturn:(NHAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay;
- (instancetype)mainReturn:(NHAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay
              withPriority:(NSOperationQueuePriority)priority;
@end

@interface NHAsyncManager (ChainMainOnceReturn)

- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                    returnBlock:(NHAsyncReturnBlock)block;
- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                    returnBlock:(NHAsyncReturnBlock)block
                      withDelay:(NSTimeInterval)delay;
- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                    returnBlock:(NHAsyncReturnBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority;

- (instancetype)mainOnce:(NHAsyncOnceToken*)token
             returnBlock:(NHAsyncReturnBlock)block;
- (instancetype)mainOnce:(NHAsyncOnceToken*)token
             returnBlock:(NHAsyncReturnBlock)block
               withDelay:(NSTimeInterval)delay;
- (instancetype)mainOnce:(NHAsyncOnceToken*)token
             returnBlock:(NHAsyncReturnBlock)block
               withDelay:(NSTimeInterval)delay
            withPriority:(NSOperationQueuePriority)priority;

@end