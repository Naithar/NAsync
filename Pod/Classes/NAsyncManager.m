//
//  NAsyncManager.m
//  Pods
//
//  Created by Naithar on 18.04.15.
//
//

#import "NAsyncManager.h"

@interface NAsyncManager ()

@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NAsyncOperation *operation;

@end

@implementation NAsyncManager

- (instancetype)initWithQueue:(NSOperationQueue*)queue
                    withDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NAsyncOperation*)operation
                     andBlock:(NAsyncBlock)block {

    self = [super init];


    if (self) {
        NAsyncOperation *tempOperation = [[NAsyncOperation alloc] initWithDelay:delay
                                                                       priority:priority
                                                              previousOperation:operation
                                                                       andBlock:block];
        [self commonInitWithQueue:queue
                     andOperation:tempOperation];
    }

    return self;
}

- (instancetype)initWithQueue:(NSOperationQueue*)queue
                    withDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NAsyncOperation*)operation
               andReturnBlock:(NAsyncReturnBlock)block {
    self = [super init];

    if (self) {
        NAsyncOperation *tempOperation = [[NAsyncOperation alloc] initWithDelay:delay
                                                                       priority:priority
                                                              previousOperation:operation
                                                                 andReturnBlock:block];
        [self commonInitWithQueue:queue
                     andOperation:tempOperation];
    }

    return self;
}

- (void)commonInitWithQueue:(NSOperationQueue*)queue
               andOperation:(NAsyncOperation*)operation {
    self.queue = queue ?: [[NSOperationQueue alloc] init];
    self.operation = operation;
}

- (instancetype)perform {
    [self.operation performOnQueue:self.queue];
    return self;
}

- (instancetype)performWithValue:(id)value {
    [self.operation performOnQueue:self.queue withValue:value];
    return self;
}

- (id)wait {
    return [self.operation wait];
}

- (instancetype)cancel {
    return [self cancelAll:NO];
}

- (instancetype)cancelAll:(BOOL)cancelPrevious {
    [self.operation cancelWithPrevious:cancelPrevious];
    return self;
}

- (void)dealloc {
    self.queue = nil;
    self.operation = nil;

#ifdef DEBUG
    NSLog(@"dealloc async manager");
#endif
}

@end

@implementation NAsyncManager (StartQueuedNonReturn)

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block {
    return [self promiseQueue:queue block:block withDelay:0];
}

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self promiseQueue:queue block:block withDelay:delay withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    return [[self alloc] initWithQueue:queue
                             withDelay:delay
                              priority:priority
                     previousOperation:nil
                              andBlock:block];
}

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block {
    return [self queue:queue block:block withDelay:0];
}

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self queue:queue block:block withDelay:delay withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {

    NAsyncManager *manager = [self promiseQueue:queue
                                          block:block
                                      withDelay:delay
                                   withPriority:priority];

    [manager perform];
    
    return manager;
}

@end


//}
//
//+ (instancetype)queueOnce:(NSOperationQueue*)queue
//                    block:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token {
//    return [self queueOnce:queue block:block withToken:token withDelay:0];
//}
//
//+ (instancetype)queueOnce:(NSOperationQueue*)queue
//                    block:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay {
//    return [self queueOnce:queue block:block withToken:token withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//+ (instancetype)queueOnce:(NSOperationQueue*)queue
//                    block:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay
//             withPriority:(NSOperationQueuePriority)priority {
//
//    __block __weak NAsyncOperation *operation;
//
//    NAsyncBlock operationBlock = ^(NAsyncOperation *operation, id value) {
//        if (block) {
//            dispatch_once(token, ^{
//                block(operation, value);
//            });
//        }
//    };
//
//    NAsyncManager *manager = [self queue:queue block:operationBlock withDelay:delay withPriority:priority];
//
//    operation = manager.operation;
//
//    return manager;
//}
//
//+ (instancetype)main:(NAsyncBlock)block {
//    return [self main:block withDelay:0];
//}
//
//+ (instancetype)main:(NAsyncBlock)block
//           withDelay:(NSTimeInterval)delay {
//    return [self main:block withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//+ (instancetype)main:(NAsyncBlock)block
//           withDelay:(NSTimeInterval)delay
//        withPriority:(NSOperationQueuePriority)priority {
//    return [self queue:[NSOperationQueue mainQueue]
//                 block:block
//             withDelay:delay
//          withPriority:priority];
//}
//
//+ (instancetype)mainOnce:(NAsyncBlock)block
//               withToken:(NAsyncOnceToken*)token {
//    return [self mainOnce:block withToken:token withDelayOnce:0];
//}
//
//+ (instancetype)mainOnce:(NAsyncBlock)block
//               withToken:(NAsyncOnceToken*)token
//           withDelayOnce:(NSTimeInterval)delay {
//    return [self mainOnce:block withToken:token withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//+ (instancetype)mainOnce:(NAsyncBlock)block
//               withToken:(NAsyncOnceToken*)token
//               withDelay:(NSTimeInterval)delay
//            withPriority:(NSOperationQueuePriority)priority {
//
//    __block __weak NAsyncOperation *operation;
//
//    NAsyncBlock operationBlock = ^(NAsyncOperation *operation, id value) {
//        if (block) {
//            dispatch_once(token, ^{
//                block(operation, value);
//            });
//        }
//    };
//
//    NAsyncManager *manager = [self main:operationBlock withDelay:delay withPriority:priority];
//
//    operation = manager.operation;
//
//    return manager;
//}
//
//+ (instancetype)async:(NAsyncBlock)block {
//    return [self async:block withDelay:0];
//}
//
//+ (instancetype)async:(NAsyncBlock)block
//            withDelay:(NSTimeInterval)delay {
//    return [self async:block withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//+ (instancetype)async:(NAsyncBlock)block
//            withDelay:(NSTimeInterval)delay
//         withPriority:(NSOperationQueuePriority)priority {
//    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
//    operationQueue.name = @"NAsync.asyncOperationQueue";
//
//    return [self queue:operationQueue
//                 block:block
//             withDelay:delay
//          withPriority:priority];
//}
//
//+ (instancetype)asyncOnce:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token {
//    return [self asyncOnce:block withToken:token withDelay:0];
//}
//
//+ (instancetype)asyncOnce:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay {
//    return [self asyncOnce:block withToken:token withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//+ (instancetype)asyncOnce:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay
//             withPriority:(NSOperationQueuePriority)priority {
//
//    __block __weak NAsyncOperation *operation;
//
//    NAsyncBlock operationBlock = ^(NAsyncOperation *operation, id value) {
//        if (block) {
//            dispatch_once(token, ^{
//                block(operation, value);
//            });
//        }
//    };
//
//    NAsyncManager *manager = [self async:operationBlock withDelay:delay withPriority:priority];
//
//    operation = manager.operation;
//
//    return manager;
//}
//
//+ (instancetype)queue:(NSOperationQueue*)queue
//          returnBlock:(NAsyncReturnBlock)block {
//    return [self queue:queue returnBlock:block withDelay:0];
//}
//
//+ (instancetype)queue:(NSOperationQueue*)queue
//          returnBlock:(NAsyncReturnBlock)block
//            withDelay:(NSTimeInterval)delay {
//    return [self queue:queue
//           returnBlock:block
//             withDelay:delay
//          withPriority:NSOperationQueuePriorityNormal];
//}
//
//+ (instancetype)queue:(NSOperationQueue*)queue
//          returnBlock:(NAsyncReturnBlock)block
//            withDelay:(NSTimeInterval)delay
//         withPriority:(NSOperationQueuePriority)priority {
//    return [[self alloc] initWithQueue:queue
//                             withDelay:delay
//                              priority:priority
//                     previousOperation:nil
//                        andReturnBlock:block];
//}
//
//+ (instancetype)queueOnce:(NSOperationQueue*)queue
//              returnBlock:(NAsyncReturnBlock)block
//                withToken:(NAsyncOnceToken*)token {
//    return [self queueOnce:queue returnBlock:block withToken:token withDelay:0];
//}
//
//+ (instancetype)queueOnce:(NSOperationQueue*)queue
//              returnBlock:(NAsyncReturnBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay {
//    return [self queueOnce:queue returnBlock:block withToken:token withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//+ (instancetype)queueOnce:(NSOperationQueue*)queue
//              returnBlock:(NAsyncReturnBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay
//             withPriority:(NSOperationQueuePriority)priority {
//
//    __block __weak NAsyncOperation *operation;
//
//    NAsyncReturnBlock operationBlock = ^id(NAsyncOperation *operation, id value) {
//        __block id returnValue = nil;
//        if (block) {
//            dispatch_once(token, ^{
//                returnValue = block(operation, value);
//            });
//        }
//        return returnValue;
//    };
//
//    NAsyncManager *manager = [self queue:queue returnBlock:operationBlock withDelay:delay withPriority:priority];
//
//    operation = manager.operation;
//
//    return manager;
//}
//
//+ (instancetype)mainReturn:(NAsyncReturnBlock)block {
//    return [self mainReturn:block withDelay:0];
//}
//
//+ (instancetype)mainReturn:(NAsyncReturnBlock)block
//                 withDelay:(NSTimeInterval)delay {
//    return [self mainReturn:block withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//+ (instancetype)mainReturn:(NAsyncReturnBlock)block
//                 withDelay:(NSTimeInterval)delay
//              withPriority:(NSOperationQueuePriority)priority {
//    return [self queue:[NSOperationQueue mainQueue]
//           returnBlock:block
//             withDelay:delay
//          withPriority:priority];
//}
//
//+ (instancetype)mainReturnOnce:(NAsyncReturnBlock)block
//                     withToken:(NAsyncOnceToken*)token {
//    return [self mainReturnOnce:block withToken:token withDelay:0];
//}
//
//+ (instancetype)mainReturnOnce:(NAsyncReturnBlock)block
//                     withToken:(NAsyncOnceToken*)token
//                     withDelay:(NSTimeInterval)delay {
//    return [self mainReturnOnce:block withToken:token withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//+ (instancetype)mainReturnOnce:(NAsyncReturnBlock)block
//                     withToken:(NAsyncOnceToken*)token
//                     withDelay:(NSTimeInterval)delay
//                  withPriority:(NSOperationQueuePriority)priority {
//
//    __block __weak NAsyncOperation *operation;
//
//    NAsyncReturnBlock operationBlock = ^id(NAsyncOperation *operation, id value) {
//        __block id returnValue = nil;
//        if (block) {
//            dispatch_once(token, ^{
//                returnValue = block(operation, value);
//            });
//        }
//        return returnValue;
//    };
//
//    NAsyncManager *manager = [self mainReturn:operationBlock withDelay:delay withPriority:priority];
//
//    operation = manager.operation;
//
//
//    return manager;
//}
//
//+ (instancetype)asyncReturn:(NAsyncReturnBlock)block {
//    return [self asyncReturn:block withDelay:0];
//}
//
//+ (instancetype)asyncReturn:(NAsyncReturnBlock)block
//                  withDelay:(NSTimeInterval)delay {
//    return [self asyncReturn:block withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//+ (instancetype)asyncReturn:(NAsyncReturnBlock)block
//                  withDelay:(NSTimeInterval)delay
//               withPriority:(NSOperationQueuePriority)priority {
//    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
//    operationQueue.name = @"NAsync.asyncReturnOperationQueue";
//
//    return [self queue:operationQueue
//           returnBlock:block
//             withDelay:delay
//          withPriority:priority];
//}
//
//+ (instancetype)asyncReturnOnce:(NAsyncReturnBlock)block
//                      withToken:(NAsyncOnceToken*)token {
//    return [self asyncReturnOnce:block withToken:token withDelay:0];
//}
//
//+ (instancetype)asyncReturnOnce:(NAsyncReturnBlock)block
//                      withToken:(NAsyncOnceToken*)token
//                      withDelay:(NSTimeInterval)delay {
//    return [self asyncReturnOnce:block withToken:token withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//+ (instancetype)asyncReturnOnce:(NAsyncReturnBlock)block
//                      withToken:(NAsyncOnceToken*)token
//                      withDelay:(NSTimeInterval)delay
//                   withPriority:(NSOperationQueuePriority)priority {
//
//    __block __weak NAsyncOperation *operation;
//
//    NAsyncReturnBlock operationBlock = ^id(NAsyncOperation *operation, id value) {
//        __block id returnValue = nil;
//        if (block) {
//            dispatch_once(token, ^{
//                returnValue = block(operation, value);
//            });
//        }
//        return returnValue;
//    };
//
//    NAsyncManager *manager = [self asyncReturn:operationBlock withDelay:delay withPriority:priority];
//
//    operation = manager.operation;
//
//    return manager;
//}
//
//@end
//
//@implementation NAsyncManager (Chain)
//
//- (instancetype)queue:(NSOperationQueue*)queue
//                block:(NAsyncBlock)block {
//    return [self queue:queue block:block withDelay:0];
//}
//
//- (instancetype)queue:(NSOperationQueue*)queue
//                block:(NAsyncBlock)block
//            withDelay:(NSTimeInterval)delay {
//    return [self queue:queue block:block withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//- (instancetype)queue:(NSOperationQueue*)queue
//                block:(NAsyncBlock)block
//            withDelay:(NSTimeInterval)delay
//         withPriority:(NSOperationQueuePriority)priority {
//    return [[[self class] alloc] initWithQueue:queue
//                                     withDelay:delay
//                                      priority:priority
//                             previousOperation:self.operation
//                                      andBlock:block];
//}
//
//- (instancetype)queueOnce:(NSOperationQueue*)queue
//                    block:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token {
//    return [self queueOnce:queue block:block withToken:token withDelay:0];
//}
//
//- (instancetype)queueOnce:(NSOperationQueue*)queue
//                    block:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay {
//    return [self queueOnce:queue block:block withToken:token withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//- (instancetype)queueOnce:(NSOperationQueue*)queue
//                    block:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay
//             withPriority:(NSOperationQueuePriority)priority {
//
//    __block __weak NAsyncOperation *operation;
//
//    NAsyncBlock operationBlock = ^(NAsyncOperation *operation, id value) {
//        if (block) {
//            dispatch_once(token, ^{
//                block(operation, value);
//            });
//        }
//    };
//
//    NAsyncManager *manager = [self queue:queue block:operationBlock withDelay:delay withPriority:priority];
//
//    operation = manager.operation;
//
//    return manager;
//}
//
//- (instancetype)main:(NAsyncBlock)block {
//    return [self main:block withDelay:0];
//}
//
//- (instancetype)main:(NAsyncBlock)block
//           withDelay:(NSTimeInterval)delay {
//    return [self main:block withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//- (instancetype)main:(NAsyncBlock)block
//           withDelay:(NSTimeInterval)delay
//        withPriority:(NSOperationQueuePriority)priority {
//    return [self queue:[NSOperationQueue mainQueue]
//                 block:block
//             withDelay:delay
//          withPriority:priority];
//}
//
//- (instancetype)mainOnce:(NAsyncBlock)block
//               withToken:(NAsyncOnceToken*)token {
//    return [self mainOnce:block withToken:token withDelayOnce:0];
//}
//
//- (instancetype)mainOnce:(NAsyncBlock)block
//               withToken:(NAsyncOnceToken*)token
//           withDelayOnce:(NSTimeInterval)delay {
//    return [self mainOnce:block withToken:token withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//- (instancetype)mainOnce:(NAsyncBlock)block
//               withToken:(NAsyncOnceToken*)token
//               withDelay:(NSTimeInterval)delay
//            withPriority:(NSOperationQueuePriority)priority {
//
//    __block __weak NAsyncOperation *operation;
//
//    NAsyncBlock operationBlock = ^(NAsyncOperation *operation, id value) {
//        if (block) {
//            dispatch_once(token, ^{
//                block(operation, value);
//            });
//        }
//    };
//
//    NAsyncManager *manager = [self main:operationBlock withDelay:delay withPriority:priority];
//
//    operation = manager.operation;
//
//    return manager;
//}
//
//- (instancetype)async:(NAsyncBlock)block {
//    return [self async:block withDelay:0];
//}
//
//- (instancetype)async:(NAsyncBlock)block
//            withDelay:(NSTimeInterval)delay {
//    return [self async:block withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//- (instancetype)async:(NAsyncBlock)block
//            withDelay:(NSTimeInterval)delay
//         withPriority:(NSOperationQueuePriority)priority {
//    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
//    operationQueue.name = @"NAsync.chain.asyncOperationQueue";
//    return [self queue:operationQueue
//                 block:block
//             withDelay:delay
//          withPriority:priority];
//}
//
//- (instancetype)asyncOnce:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token {
//    return [self asyncOnce:block withToken:token withDelay:0];
//}
//
//- (instancetype)asyncOnce:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay {
//    return [self asyncOnce:block withToken:token withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//- (instancetype)asyncOnce:(NAsyncBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay
//             withPriority:(NSOperationQueuePriority)priority {
//
//    __block __weak NAsyncOperation *operation;
//
//    NAsyncBlock operationBlock = ^(NAsyncOperation *operation, id value) {
//        if (block) {
//            dispatch_once(token, ^{
//                block(operation, value);
//            });
//        }
//    };
//
//    NAsyncManager *manager = [self async:operationBlock withDelay:delay withPriority:priority];
//
//    operation = manager.operation;
//
//    return manager;
//}
//
//- (instancetype)queue:(NSOperationQueue*)queue
//          returnBlock:(NAsyncReturnBlock)block {
//    return [self queue:queue returnBlock:block withDelay:0];
//}
//
//- (instancetype)queue:(NSOperationQueue*)queue
//          returnBlock:(NAsyncReturnBlock)block
//            withDelay:(NSTimeInterval)delay {
//    return [self queue:queue
//           returnBlock:block
//             withDelay:delay
//          withPriority:NSOperationQueuePriorityNormal];
//}
//
//- (instancetype)queue:(NSOperationQueue*)queue
//          returnBlock:(NAsyncReturnBlock)block
//            withDelay:(NSTimeInterval)delay
//         withPriority:(NSOperationQueuePriority)priority {
//    return [[[self class] alloc] initWithQueue:queue
//                                     withDelay:delay
//                                      priority:priority
//                             previousOperation:self.operation
//                                andReturnBlock:block];
//}
//
//- (instancetype)queueOnce:(NSOperationQueue*)queue
//              returnBlock:(NAsyncReturnBlock)block
//                withToken:(NAsyncOnceToken*)token {
//    return [self queueOnce:queue returnBlock:block withToken:token withDelay:0];
//}
//
//- (instancetype)queueOnce:(NSOperationQueue*)queue
//              returnBlock:(NAsyncReturnBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay {
//    return [self queueOnce:queue returnBlock:block withToken:token withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//- (instancetype)queueOnce:(NSOperationQueue*)queue
//              returnBlock:(NAsyncReturnBlock)block
//                withToken:(NAsyncOnceToken*)token
//                withDelay:(NSTimeInterval)delay
//             withPriority:(NSOperationQueuePriority)priority {
//
//    __block __weak NAsyncOperation *operation;
//
//    NAsyncReturnBlock operationBlock = ^id(NAsyncOperation *operation, id value) {
//        __block id returnValue = nil;
//        if (block) {
//            dispatch_once(token, ^{
//                returnValue = block(operation, value);
//            });
//        }
//        return returnValue;
//    };
//
//    NAsyncManager *manager = [self queue:queue returnBlock:operationBlock withDelay:delay withPriority:priority];
//
//    operation = manager.operation;
//
//    return manager;
//}
//
//- (instancetype)mainReturn:(NAsyncReturnBlock)block {
//    return [self mainReturn:block withDelay:0];
//}
//
//- (instancetype)mainReturn:(NAsyncReturnBlock)block
//                 withDelay:(NSTimeInterval)delay {
//    return [self mainReturn:block withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//- (instancetype)mainReturn:(NAsyncReturnBlock)block
//                 withDelay:(NSTimeInterval)delay
//              withPriority:(NSOperationQueuePriority)priority {
//    return [self queue:[NSOperationQueue mainQueue]
//           returnBlock:block
//             withDelay:delay
//          withPriority:priority];
//}
//
//- (instancetype)mainReturnOnce:(NAsyncReturnBlock)block
//                     withToken:(NAsyncOnceToken*)token {
//    return [self mainReturnOnce:block withToken:token withDelay:0];
//}
//
//- (instancetype)mainReturnOnce:(NAsyncReturnBlock)block
//                     withToken:(NAsyncOnceToken*)token
//                     withDelay:(NSTimeInterval)delay {
//    return [self mainReturnOnce:block withToken:token withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//- (instancetype)mainReturnOnce:(NAsyncReturnBlock)block
//                     withToken:(NAsyncOnceToken*)token
//                     withDelay:(NSTimeInterval)delay
//                  withPriority:(NSOperationQueuePriority)priority {
//
//    __block __weak NAsyncOperation *operation;
//
//    NAsyncReturnBlock operationBlock = ^id(NAsyncOperation *operation, id value) {
//        __block id returnValue = nil;
//        if (block) {
//            dispatch_once(token, ^{
//                returnValue = block(operation, value);
//            });
//        }
//        return returnValue;
//    };
//
//    NAsyncManager *manager = [self mainReturn:operationBlock withDelay:delay withPriority:priority];
//
//    operation = manager.operation;
//
//
//    return manager;
//}
//
//- (instancetype)asyncReturn:(NAsyncReturnBlock)block {
//    return [self asyncReturn:block withDelay:0];
//}
//
//- (instancetype)asyncReturn:(NAsyncReturnBlock)block
//                  withDelay:(NSTimeInterval)delay {
//    return [self asyncReturn:block withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//- (instancetype)asyncReturn:(NAsyncReturnBlock)block
//                  withDelay:(NSTimeInterval)delay
//               withPriority:(NSOperationQueuePriority)priority {
//    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
//    operationQueue.name = @"NAsync.asyncReturnOperationQueue";
//
//    return [self queue:operationQueue
//           returnBlock:block
//             withDelay:delay
//          withPriority:priority];
//}
//
//- (instancetype)asyncReturnOnce:(NAsyncReturnBlock)block
//                      withToken:(NAsyncOnceToken*)token {
//    return [self asyncReturnOnce:block withToken:token withDelay:0];
//}
//
//- (instancetype)asyncReturnOnce:(NAsyncReturnBlock)block
//                      withToken:(NAsyncOnceToken*)token
//                      withDelay:(NSTimeInterval)delay {
//    return [self asyncReturnOnce:block withToken:token withDelay:delay withPriority:NSOperationQueuePriorityNormal];
//}
//
//- (instancetype)asyncReturnOnce:(NAsyncReturnBlock)block
//                      withToken:(NAsyncOnceToken*)token
//                      withDelay:(NSTimeInterval)delay
//                   withPriority:(NSOperationQueuePriority)priority {
//
//    __block __weak NAsyncOperation *operation;
//
//    NAsyncReturnBlock operationBlock = ^id(NAsyncOperation *operation, id value) {
//        __block id returnValue = nil;
//        if (block) {
//            dispatch_once(token, ^{
//                returnValue = block(operation, value);
//            });
//        }
//        return returnValue;
//    };
//    
//    NAsyncManager *manager = [self asyncReturn:operationBlock withDelay:delay withPriority:priority];
//    
//    operation = manager.operation;
//    
//    return manager;
//}
//
//@end