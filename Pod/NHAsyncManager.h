//
//  NHAsyncManager.h
//  Pods
//
//  Created by Naithar on 18.04.15.
//
//

#import <Foundation/Foundation.h>
#import <NAsync/NHAsyncOperation.h>

@class NHAsyncManager;

typedef NHAsyncManager NAsync;

typedef dispatch_once_t NHAsyncOnceToken;

@interface NHAsyncManager : NSObject

@property (nonatomic, readonly, strong) NSOperationQueue *queue;
@property (nonatomic, readonly, strong) NHAsyncOperation *operation;

- (instancetype)initWithQueue:(NSOperationQueue*)queue withDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NHAsyncOperation*)operation
                     andBlock:(NHAsyncBlock)block;

- (instancetype)initWithQueue:(NSOperationQueue*)queue
                    withDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NHAsyncOperation*)operation
               andReturnBlock:(NHAsyncReturnBlock)block;

- (NSOperationQueue*)chainAsyncQueue;

- (instancetype)perform;
- (instancetype)performWithValue:(id)value;

- (id)wait;

- (instancetype)cancel;
- (instancetype)cancelAll:(BOOL)cancelPrevious;
@end

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