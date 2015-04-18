//
//  NAsyncManager.h
//  Pods
//
//  Created by Naithar on 18.04.15.
//
//

#import <Foundation/Foundation.h>


//@class NAsyncManager;
//
//typedef NAsyncManager NAsync;
//
//typedef dispatch_once_t NAsyncOnceToken;
//
//@interface NAsyncManager : NSObject
//
//@property (nonatomic, readonly, weak) NAsyncOperation *operation;
//
//- (instancetype)initWithQueue:(NSOperationQueue*)queue withDelay:(NSTimeInterval)delay
//                     priority:(NSOperationQueuePriority)priority
//            previousOperation:(NAsyncOperation*)operation
//                     andBlock:(NAsyncBlock)block;
//
//- (instancetype)initWithQueue:(NSOperationQueue*)queue
//                    withDelay:(NSTimeInterval)delay
//                     priority:(NSOperationQueuePriority)priority
//            previousOperation:(NAsyncOperation*)operation
//               andReturnBlock:(NAsyncReturnBlock)block;
//
//- (id)wait;
//- (instancetype)cancel;
//- (instancetype)cancelAll:(BOOL)cancelPrevious;
//@end
//
//
//
//
//@interface NAsyncManager (Start)
//
//+ (instancetype)queue:(NSOperationQueue*)queue
//                block:(NAsyncBlock)block;
//
//+ (instancetype)queue:(NSOperationQueue*)queue
//                block:(NAsyncBlock)block
//            withDelay:(NSTimeInterval)delay;
//
//+ (instancetype)queue:(NSOperationQueue*)queue
//                block:(NAsyncBlock)block
//            withDelay:(NSTimeInterval)delay
//         withPriority:(NSOperationQueuePriority)priority;
//
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