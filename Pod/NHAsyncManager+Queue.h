//
//  NHAsyncManager+Queue.h
//  Pods
//
//  Created by Naithar on 26.04.15.
//
//

#import "NHAsyncManager.h"

#pragma mark - Queue non return

@interface NHAsyncManager (StartQueuedNonReturn)

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block;

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay;

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block;

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay;

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority;
@end

@interface NHAsyncManager (StartQueuedOnceNonReturn)

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block;

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay;

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;
@end

@interface NHAsyncManager (ChainQueuedNonReturn)

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block;

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay;

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority;

- (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block;

- (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay;

- (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (ChainQueuedOnceNonReturn)

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block;

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay;

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;
@end

#pragma mark - Queue return value

@interface NHAsyncManager (StartQueuedReturn)

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block;

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay;

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block;

+ (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay;

+ (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority;
@end

@interface NHAsyncManager (StartQueuedOnceReturn)

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block;

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay;

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;
@end

@interface NHAsyncManager (ChainQueuedReturn)

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block;

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay;

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority;

- (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block;

- (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay;

- (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority;
@end

@interface NHAsyncManager (ChainQueuedOnceReturn)

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block;

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay;

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;
@end

