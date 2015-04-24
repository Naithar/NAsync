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
                     andBlock:(NAsyncBlock)block;

- (instancetype)initWithQueue:(NSOperationQueue*)queue
                    withDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NHAsyncOperation*)operation
               andReturnBlock:(NAsyncReturnBlock)block;

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
                       block:(NAsyncBlock)block;

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NAsyncBlock)block
                   withDelay:(NSTimeInterval)delay;

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block;

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay;

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority;
@end

@interface NHAsyncManager (StartQueuedOnceNonReturn)

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NAsyncBlock)block;

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay;

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NAsyncBlock)block;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;
@end

@interface NHAsyncManager (ChainQueuedNonReturn)

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NAsyncBlock)block;

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NAsyncBlock)block
                   withDelay:(NSTimeInterval)delay;

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority;

- (instancetype)queue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block;

- (instancetype)queue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay;

- (instancetype)queue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (ChainQueuedOnceNonReturn)

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NAsyncBlock)block;

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay;

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NAsyncBlock)block;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;
@end

#pragma mark - Queue return value

@interface NHAsyncManager (StartQueuedReturn)

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NAsyncReturnBlock)block;

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay;

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NAsyncReturnBlock)block;

+ (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay;

+ (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority;
@end

@interface NHAsyncManager (StartQueuedOnceReturn)

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block;

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay;

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;
@end

@interface NHAsyncManager (ChainQueuedReturn)

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NAsyncReturnBlock)block;

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay;

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority;

- (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NAsyncReturnBlock)block;

- (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay;

- (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority;
@end

@interface NHAsyncManager (ChainQueuedOnceReturn)

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block;

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay;

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;
@end

#pragma mark - Main non return

@interface NHAsyncManager (StartMainNonReturn)

+ (instancetype)promiseMain:(NAsyncBlock)block;
+ (instancetype)promiseMain:(NAsyncBlock)block
                  withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseMain:(NAsyncBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)main:(NAsyncBlock)block;
+ (instancetype)main:(NAsyncBlock)block
           withDelay:(NSTimeInterval)delay;
+ (instancetype)main:(NAsyncBlock)block
           withDelay:(NSTimeInterval)delay
        withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (StartMainOnceNonReturn)

+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NAsyncBlock)block;
+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NAsyncBlock)block
                      withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NAsyncBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NAsyncBlock)block;
+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NAsyncBlock)block
               withDelay:(NSTimeInterval)delay;
+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NAsyncBlock)block
               withDelay:(NSTimeInterval)delay
            withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (ChainMainNonReturn)

- (instancetype)promiseMain:(NAsyncBlock)block;
- (instancetype)promiseMain:(NAsyncBlock)block
                  withDelay:(NSTimeInterval)delay;
- (instancetype)promiseMain:(NAsyncBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority;

- (instancetype)main:(NAsyncBlock)block;
- (instancetype)main:(NAsyncBlock)block
           withDelay:(NSTimeInterval)delay;
- (instancetype)main:(NAsyncBlock)block
           withDelay:(NSTimeInterval)delay
        withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (ChainMainOnceNonReturn)

- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NAsyncBlock)block;
- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NAsyncBlock)block
                      withDelay:(NSTimeInterval)delay;
- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          block:(NAsyncBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority;

- (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NAsyncBlock)block;
- (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NAsyncBlock)block
               withDelay:(NSTimeInterval)delay;
- (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   block:(NAsyncBlock)block
               withDelay:(NSTimeInterval)delay
            withPriority:(NSOperationQueuePriority)priority;

@end

#pragma mark - Main return value

@interface NHAsyncManager (StartMainReturn)

+ (instancetype)promiseMainReturn:(NAsyncReturnBlock)block;
+ (instancetype)promiseMainReturn:(NAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseMainReturn:(NAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay
                     withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)mainReturn:(NAsyncReturnBlock)block;
+ (instancetype)mainReturn:(NAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay;
+ (instancetype)mainReturn:(NAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay
              withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (StartMainOnceReturn)

+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          returnBlock:(NAsyncReturnBlock)block;
+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          returnBlock:(NAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                          returnBlock:(NAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay
                     withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   returnBlock:(NAsyncReturnBlock)block;
+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   returnBlock:(NAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay;
+ (instancetype)mainOnce:(NHAsyncOnceToken*)token
                   returnBlock:(NAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay
              withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (ChainMainReturn)

- (instancetype)promiseMainReturn:(NAsyncReturnBlock)block;
- (instancetype)promiseMainReturn:(NAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay;
- (instancetype)promiseMainReturn:(NAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay
                     withPriority:(NSOperationQueuePriority)priority;

- (instancetype)mainReturn:(NAsyncReturnBlock)block;
- (instancetype)mainReturn:(NAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay;
- (instancetype)mainReturn:(NAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay
              withPriority:(NSOperationQueuePriority)priority;
@end

@interface NHAsyncManager (ChainMainOnceReturn)

- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                    returnBlock:(NAsyncReturnBlock)block;
- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                    returnBlock:(NAsyncReturnBlock)block
                      withDelay:(NSTimeInterval)delay;
- (instancetype)promiseMainOnce:(NHAsyncOnceToken*)token
                    returnBlock:(NAsyncReturnBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority;

- (instancetype)mainOnce:(NHAsyncOnceToken*)token
             returnBlock:(NAsyncReturnBlock)block;
- (instancetype)mainOnce:(NHAsyncOnceToken*)token
             returnBlock:(NAsyncReturnBlock)block
               withDelay:(NSTimeInterval)delay;
- (instancetype)mainOnce:(NHAsyncOnceToken*)token
             returnBlock:(NAsyncReturnBlock)block
               withDelay:(NSTimeInterval)delay
            withPriority:(NSOperationQueuePriority)priority;

@end

#pragma mark - Async non return

@interface NHAsyncManager (StartAsyncNonReturn)

+ (instancetype)promiseAsync:(NAsyncBlock)block;
+ (instancetype)promiseAsync:(NAsyncBlock)block
                   withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseAsync:(NAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)async:(NAsyncBlock)block;
+ (instancetype)async:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay;
+ (instancetype)async:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority;
@end

@interface NHAsyncManager (StartAsyncOnceNonReturn)

+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NAsyncBlock)block;
+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NAsyncBlock)block;
+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay;
+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (ChainAsyncNonReturn)

- (instancetype)promiseAsync:(NAsyncBlock)block;
- (instancetype)promiseAsync:(NAsyncBlock)block
                   withDelay:(NSTimeInterval)delay;
- (instancetype)promiseAsync:(NAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority;

- (instancetype)async:(NAsyncBlock)block;
- (instancetype)async:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay;
- (instancetype)async:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (ChainAsyncOnceNonReturn)

- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NAsyncBlock)block;
- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay;
- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NAsyncBlock)block;
- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay;
- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;


@end

#pragma mark - Async return value

@interface NHAsyncManager (StartAsyncReturn)

+ (instancetype)promiseAsyncReturn:(NAsyncReturnBlock)block;
+ (instancetype)promiseAsyncReturn:(NAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseAsyncReturn:(NAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)asyncReturn:(NAsyncReturnBlock)block;
+ (instancetype)asyncReturn:(NAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay;
+ (instancetype)asyncReturn:(NAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (StartAsyncOnceReturn)

+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block;
+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block;
+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay;
+ (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncManager (ChainAsyncReturn)

- (instancetype)promiseAsyncReturn:(NAsyncReturnBlock)block;
- (instancetype)promiseAsyncReturn:(NAsyncReturnBlock)block
                         withDelay:(NSTimeInterval)delay;
- (instancetype)promiseAsyncReturn:(NAsyncReturnBlock)block
                         withDelay:(NSTimeInterval)delay
                      withPriority:(NSOperationQueuePriority)priority;

- (instancetype)asyncReturn:(NAsyncReturnBlock)block;
- (instancetype)asyncReturn:(NAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay;
- (instancetype)asyncReturn:(NAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority;


@end

@interface NHAsyncManager (ChainAsyncOnceReturn)

- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block;
- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay;
- (instancetype)promiseAsyncOnce:(NHAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block;
- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay;
- (instancetype)asyncOnce:(NHAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;

@end