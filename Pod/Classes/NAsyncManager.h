//
//  NAsyncManager.h
//  Pods
//
//  Created by Naithar on 18.04.15.
//
//

#import <Foundation/Foundation.h>
#import <NAsync/NAsyncOperation.h>

@class NAsyncManager;
//
//typedef NAsyncManager NAsync;
//
typedef dispatch_once_t NAsyncOnceToken;

@interface NAsyncManager : NSObject

@property (nonatomic, readonly, strong) NSOperationQueue *queue;
@property (nonatomic, readonly, strong) NAsyncOperation *operation;

- (instancetype)initWithQueue:(NSOperationQueue*)queue withDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NAsyncOperation*)operation
                     andBlock:(NAsyncBlock)block;

- (instancetype)initWithQueue:(NSOperationQueue*)queue
                    withDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NAsyncOperation*)operation
               andReturnBlock:(NAsyncReturnBlock)block;

- (instancetype)perform;
- (instancetype)performWithValue:(id)value;

- (id)wait;

- (instancetype)cancel;
- (instancetype)cancelAll:(BOOL)cancelPrevious;
@end


#pragma mark - Queue non return

@interface NAsyncManager (StartQueuedNonReturn)

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

@interface NAsyncManager (StartQueuedOnceNonReturn)

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block;

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay;

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;
@end

@interface NAsyncManager (ChainQueuedNonReturn)

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

@interface NAsyncManager (ChainQueuedOnceNonReturn)

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block;

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay;

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;
@end

#pragma mark - Queue return value

@interface NAsyncManager (StartQueuedReturn)

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

@interface NAsyncManager (StartQueuedOnceReturn)

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block;

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay;

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay;

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;
@end

@interface NAsyncManager (ChainQueuedReturn)

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

@interface NAsyncManager (ChainQueuedOnceReturn)

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block;

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay;

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay;

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority;
@end

#pragma mark - Main non return

@interface NAsyncManager (StartMainNonReturn)

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

@interface NAsyncManager (StartMainOnceNonReturn)

+ (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                          block:(NAsyncBlock)block;
+ (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                          block:(NAsyncBlock)block
                      withDelay:(NSTimeInterval)delay;
+ (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                          block:(NAsyncBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority;

+ (instancetype)mainOnce:(NAsyncOnceToken*)token
                   block:(NAsyncBlock)block;
+ (instancetype)mainOnce:(NAsyncOnceToken*)token
                   block:(NAsyncBlock)block
               withDelay:(NSTimeInterval)delay;
+ (instancetype)mainOnce:(NAsyncOnceToken*)token
                   block:(NAsyncBlock)block
               withDelay:(NSTimeInterval)delay
            withPriority:(NSOperationQueuePriority)priority;

@end

@interface NAsyncManager (ChainMainNonReturn)

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

@interface NAsyncManager (ChainMainOnceNonReturn)

- (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                          block:(NAsyncBlock)block;
- (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                          block:(NAsyncBlock)block
                      withDelay:(NSTimeInterval)delay;
- (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                          block:(NAsyncBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority;

- (instancetype)mainOnce:(NAsyncOnceToken*)token
                   block:(NAsyncBlock)block;
- (instancetype)mainOnce:(NAsyncOnceToken*)token
                   block:(NAsyncBlock)block
               withDelay:(NSTimeInterval)delay;
- (instancetype)mainOnce:(NAsyncOnceToken*)token
                   block:(NAsyncBlock)block
               withDelay:(NSTimeInterval)delay
            withPriority:(NSOperationQueuePriority)priority;

@end

#pragma mark - Main return value

@interface NAsyncManager (StartMainReturn)
@end

@interface NAsyncManager (StartMainOnceReturn)
@end

@interface NAsyncManager (ChainMainReturn)
@end

@interface NAsyncManager (ChainMainOnceReturn)
@end


//+ (instancetype)queueOnce:(NSOperationQueue*)queue
//                    block:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token;
//
//+ (instancetype)queueOnce:(NSOperationQueue*)queue
//                    block:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay;
//
//+ (instancetype)queueOnce:(NSOperationQueue*)queue
//                    block:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay
//             withPriority:(NSOperationQueuePriority)priority;
//
//+ (instancetype)main:(NAsyncBlock)block;
//
//+ (instancetype)main:(NAsyncBlock)block
//           withDelay:(NSTimeInterval)delay;
//
//+ (instancetype)main:(NAsyncBlock)block
//           withDelay:(NSTimeInterval)delay
//        withPriority:(NSOperationQueuePriority)priority;
//
//+ (instancetype)mainOnce:(NAsyncBlock)block
//               withToken:(NAsyncOnceToken*)token;
//
//+ (instancetype)mainOnce:(NAsyncBlock)block
//               withToken:(NAsyncOnceToken*)token
//           withDelayOnce:(NSTimeInterval)delay;
//
//+ (instancetype)mainOnce:(NAsyncBlock)block
//               withToken:(NAsyncOnceToken*)token
//               withDelay:(NSTimeInterval)delay
//            withPriority:(NSOperationQueuePriority)priority;
//
//+ (instancetype)async:(NAsyncBlock)block;
//
//+ (instancetype)async:(NAsyncBlock)block
//            withDelay:(NSTimeInterval)delay;
//
//+ (instancetype)async:(NAsyncBlock)block
//            withDelay:(NSTimeInterval)delay
//         withPriority:(NSOperationQueuePriority)priority;
//
//+ (instancetype)asyncOnce:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token;
//
//+ (instancetype)asyncOnce:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay;
//
//+ (instancetype)asyncOnce:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay
//             withPriority:(NSOperationQueuePriority)priority;
//
//+ (instancetype)queue:(NSOperationQueue*)queue
//          returnBlock:(NAsyncReturnBlock)block;
//
//+ (instancetype)queue:(NSOperationQueue*)queue
//          returnBlock:(NAsyncReturnBlock)block
//            withDelay:(NSTimeInterval)delay;
//
//+ (instancetype)queue:(NSOperationQueue*)queue
//          returnBlock:(NAsyncReturnBlock)block
//            withDelay:(NSTimeInterval)delay
//         withPriority:(NSOperationQueuePriority)priority;
//
//+ (instancetype)queueOnce:(NSOperationQueue*)queue
//              returnBlock:(NAsyncReturnBlock)block
//                withToken:(NAsyncOnceToken*)token;
//
//+ (instancetype)queueOnce:(NSOperationQueue*)queue
//              returnBlock:(NAsyncReturnBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay;
//
//+ (instancetype)queueOnce:(NSOperationQueue*)queue
//              returnBlock:(NAsyncReturnBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay
//             withPriority:(NSOperationQueuePriority)priority;
//
//+ (instancetype)mainReturn:(NAsyncReturnBlock)block;
//
//+ (instancetype)mainReturn:(NAsyncReturnBlock)block
//                 withDelay:(NSTimeInterval)delay;
//
//+ (instancetype)mainReturn:(NAsyncReturnBlock)block
//                 withDelay:(NSTimeInterval)delay
//              withPriority:(NSOperationQueuePriority)priority;
//
//+ (instancetype)mainReturnOnce:(NAsyncReturnBlock)block
//                     withToken:(NAsyncOnceToken*)token;
//
//+ (instancetype)mainReturnOnce:(NAsyncReturnBlock)block
//                     withToken:(NAsyncOnceToken*)token
//                     withDelay:(NSTimeInterval)delay;
//
//+ (instancetype)mainReturnOnce:(NAsyncReturnBlock)block
//                     withToken:(NAsyncOnceToken*)token
//                     withDelay:(NSTimeInterval)delay
//                  withPriority:(NSOperationQueuePriority)priority;
//
//+ (instancetype)asyncReturn:(NAsyncReturnBlock)block;
//
//+ (instancetype)asyncReturn:(NAsyncReturnBlock)block
//                  withDelay:(NSTimeInterval)delay;
//
//+ (instancetype)asyncReturn:(NAsyncReturnBlock)block
//                  withDelay:(NSTimeInterval)delay
//               withPriority:(NSOperationQueuePriority)priority;
//
//+ (instancetype)asyncReturnOnce:(NAsyncReturnBlock)block
//                      withToken:(NAsyncOnceToken*)token;
//
//+ (instancetype)asyncReturnOnce:(NAsyncReturnBlock)block
//                      withToken:(NAsyncOnceToken*)token
//                      withDelay:(NSTimeInterval)delay;
//
//+ (instancetype)asyncReturnOnce:(NAsyncReturnBlock)block
//                      withToken:(NAsyncOnceToken*)token
//                      withDelay:(NSTimeInterval)delay
//                   withPriority:(NSOperationQueuePriority)priority;
//
//@end
//
//@interface NAsyncManager (Chain)
//
//- (instancetype)queue:(NSOperationQueue*)queue
//                block:(NAsyncBlock)block;
//
//- (instancetype)queue:(NSOperationQueue*)queue
//                block:(NAsyncBlock)block
//            withDelay:(NSTimeInterval)delay;
//
//- (instancetype)queue:(NSOperationQueue*)queue
//                block:(NAsyncBlock)block
//            withDelay:(NSTimeInterval)delay
//         withPriority:(NSOperationQueuePriority)priority;
//
//- (instancetype)queueOnce:(NSOperationQueue*)queue
//                    block:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token;
//
//- (instancetype)queueOnce:(NSOperationQueue*)queue
//                    block:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay;
//
//- (instancetype)queueOnce:(NSOperationQueue*)queue
//                    block:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay
//             withPriority:(NSOperationQueuePriority)priority;
//
//- (instancetype)main:(NAsyncBlock)block;
//
//- (instancetype)main:(NAsyncBlock)block
//           withDelay:(NSTimeInterval)delay;
//
//- (instancetype)main:(NAsyncBlock)block
//           withDelay:(NSTimeInterval)delay
//        withPriority:(NSOperationQueuePriority)priority;
//
//- (instancetype)mainOnce:(NAsyncBlock)block
//               withToken:(NAsyncOnceToken*)token;
//
//- (instancetype)mainOnce:(NAsyncBlock)block
//               withToken:(NAsyncOnceToken*)token
//           withDelayOnce:(NSTimeInterval)delay;
//
//- (instancetype)mainOnce:(NAsyncBlock)block
//               withToken:(NAsyncOnceToken*)token
//               withDelay:(NSTimeInterval)delay
//            withPriority:(NSOperationQueuePriority)priority;
//
//- (instancetype)async:(NAsyncBlock)block;
//
//- (instancetype)async:(NAsyncBlock)block
//            withDelay:(NSTimeInterval)delay;
//
//- (instancetype)async:(NAsyncBlock)block
//            withDelay:(NSTimeInterval)delay
//         withPriority:(NSOperationQueuePriority)priority;
//
//- (instancetype)asyncOnce:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token;
//
//- (instancetype)asyncOnce:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay;
//
//- (instancetype)asyncOnce:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay
//             withPriority:(NSOperationQueuePriority)priority;
//
//- (instancetype)queue:(NSOperationQueue*)queue
//          returnBlock:(NAsyncReturnBlock)block;
//
//- (instancetype)queue:(NSOperationQueue*)queue
//          returnBlock:(NAsyncReturnBlock)block
//            withDelay:(NSTimeInterval)delay;
//
//- (instancetype)queue:(NSOperationQueue*)queue
//          returnBlock:(NAsyncReturnBlock)block
//            withDelay:(NSTimeInterval)delay
//         withPriority:(NSOperationQueuePriority)priority;
//
//- (instancetype)queueOnce:(NSOperationQueue*)queue
//              returnBlock:(NAsyncReturnBlock)block
//                withToken:(NAsyncOnceToken*)token;
//
//- (instancetype)queueOnce:(NSOperationQueue*)queue
//              returnBlock:(NAsyncReturnBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay;
//
//- (instancetype)queueOnce:(NSOperationQueue*)queue
//              returnBlock:(NAsyncReturnBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay
//             withPriority:(NSOperationQueuePriority)priority;
//
//- (instancetype)mainReturn:(NAsyncReturnBlock)block;
//
//- (instancetype)mainReturn:(NAsyncReturnBlock)block
//                 withDelay:(NSTimeInterval)delay;
//
//- (instancetype)mainReturn:(NAsyncReturnBlock)block
//                 withDelay:(NSTimeInterval)delay
//              withPriority:(NSOperationQueuePriority)priority;
//
//- (instancetype)mainReturnOnce:(NAsyncReturnBlock)block
//                     withToken:(NAsyncOnceToken*)token;
//
//- (instancetype)mainReturnOnce:(NAsyncReturnBlock)block
//                     withToken:(NAsyncOnceToken*)token
//                     withDelay:(NSTimeInterval)delay;
//
//- (instancetype)mainReturnOnce:(NAsyncReturnBlock)block
//                     withToken:(NAsyncOnceToken*)token
//                     withDelay:(NSTimeInterval)delay
//                  withPriority:(NSOperationQueuePriority)priority;
//
//- (instancetype)asyncReturn:(NAsyncReturnBlock)block;
//
//- (instancetype)asyncReturn:(NAsyncReturnBlock)block
//                  withDelay:(NSTimeInterval)delay;
//
//- (instancetype)asyncReturn:(NAsyncReturnBlock)block
//                  withDelay:(NSTimeInterval)delay
//               withPriority:(NSOperationQueuePriority)priority;
//
//- (instancetype)asyncReturnOnce:(NAsyncReturnBlock)block
//                      withToken:(NAsyncOnceToken*)token;
//
//- (instancetype)asyncReturnOnce:(NAsyncReturnBlock)block
//                      withToken:(NAsyncOnceToken*)token
//                      withDelay:(NSTimeInterval)delay;
//
//- (instancetype)asyncReturnOnce:(NAsyncReturnBlock)block
//                      withToken:(NAsyncOnceToken*)token
//                      withDelay:(NSTimeInterval)delay
//                   withPriority:(NSOperationQueuePriority)priority;
//@end