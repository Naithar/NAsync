//
//  NHAsyncManager+Async.h
//  Pods
//
//  Created by Naithar on 26.04.15.
//
//

#import "NHAsyncManager+Queue.h"

#pragma mark - Async non return

@interface NHAsyncManager (StartAsyncNonReturn)

+ (instancetype)promiseAsync:(NHAsyncBlock)block;
+ (instancetype)promiseAsync:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseAsync:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)async:(NHAsyncBlock)block;
+ (instancetype)async:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay;
+ (instancetype)async:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority;
@end

@interface NHAsyncManager (StartAsyncOnceNonReturn)

+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block;
+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block;
+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay;
+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (ChainAsyncNonReturn)

- (instancetype)promiseAsync:(NHAsyncBlock)block;
- (instancetype)promiseAsync:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay;
- (instancetype)promiseAsync:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority;

- (instancetype)async:(NHAsyncBlock)block;
- (instancetype)async:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay;
- (instancetype)async:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (ChainAsyncOnceNonReturn)

- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block;
- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay;
- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block;
- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay;
- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;


@end

#pragma mark - Async return value

@interface NHAsyncManager (StartAsyncReturn)

+ (instancetype)promiseAsyncReturn:(NHAsyncReturnBlock)block;
+ (instancetype)promiseAsyncReturn:(NHAsyncReturnBlock)block
                         withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseAsyncReturn:(NHAsyncReturnBlock)block
                         withDelay:(NSTimeInterval)delay
                      withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)asyncReturn:(NHAsyncReturnBlock)block;
+ (instancetype)asyncReturn:(NHAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay;
+ (instancetype)asyncReturn:(NHAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (StartAsyncOnceReturn)

+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block;
+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block;
+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay;
+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (ChainAsyncReturn)

- (instancetype)promiseAsyncReturn:(NHAsyncReturnBlock)block;
- (instancetype)promiseAsyncReturn:(NHAsyncReturnBlock)block
                         withDelay:(NSTimeInterval)delay;
- (instancetype)promiseAsyncReturn:(NHAsyncReturnBlock)block
                         withDelay:(NSTimeInterval)delay
                      withPriority:(NSOperationQueuePriority)priority;

- (instancetype)asyncReturn:(NHAsyncReturnBlock)block;
- (instancetype)asyncReturn:(NHAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay;
- (instancetype)asyncReturn:(NHAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority;


@end

@interface NHAsyncManager (ChainAsyncOnceReturn)

- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block;
- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay;
- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block;
- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay;
- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;

@end