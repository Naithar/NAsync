//
//  NHAsyncManager.m
//  Pods
//
//  Created by Naithar on 18.04.15.
//
//

#import "NHAsyncManager.h"

@interface NHAsyncManager ()

@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NHAsyncOperation *operation;

@end

@implementation NHAsyncManager

- (instancetype)initWithQueue:(NSOperationQueue*)queue
                    withDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NHAsyncOperation*)operation
                     andBlock:(NHAsyncBlock)block {

    self = [super init];


    if (self) {
        NHAsyncOperation *tempOperation = [[NHAsyncOperation alloc] initWithDelay:delay
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
            previousOperation:(NHAsyncOperation*)operation
               andReturnBlock:(NHAsyncReturnBlock)block {
    self = [super init];

    if (self) {
        NHAsyncOperation *tempOperation = [[NHAsyncOperation alloc] initWithDelay:delay
                                                                       priority:priority
                                                              previousOperation:operation
                                                                 andReturnBlock:block];
        [self commonInitWithQueue:queue
                     andOperation:tempOperation];
    }

    return self;
}

- (void)commonInitWithQueue:(NSOperationQueue*)queue
               andOperation:(NHAsyncOperation*)operation {
    self.queue = queue ?: [[NSOperationQueue alloc] init];
    self.operation = operation;
}

- (instancetype)perform {
    [self.operation performInQueue:self.queue];
    return self;
}

- (instancetype)performWithValue:(id)value {
    [self.operation performInQueue:self.queue
                         withValue:value];
    return self;
}

- (NSOperationQueue*)chainAsyncQueue {
    if (self.queue.maxConcurrentOperationCount == 1) {
        return [[NSOperationQueue alloc] init];
    }

    return self.queue;
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

#pragma mark - Queue non return

@implementation NHAsyncManager (StartQueuedNonReturn)

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block {
    return [self promiseQueue:queue
                        block:block
                    withDelay:0];
}

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseQueue:queue
                        block:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority {
    return [[self alloc] initWithQueue:queue
                             withDelay:delay
                              priority:priority
                     previousOperation:nil
                              andBlock:block];
}

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block {
    return [self queue:queue
                 block:block
             withDelay:0];
}

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self queue:queue
                 block:block
             withDelay:delay
          withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueue:queue
                                          block:block
                                      withDelay:delay
                                   withPriority:priority];
    return [manager perform];
}

@end

@implementation NHAsyncManager (StartQueuedOnceNonReturn)

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block {
    return [self promiseQueueOnce:queue
                            token:token
                            block:block
                        withDelay:0];
}

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseQueueOnce:queue
                            token:token
                            block:block
                        withDelay:0
                     withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {

    NHAsyncBlock operationOnceBlock = ^(NHAsyncOperation *operation,
                                       id value) {
        if (block) {
            dispatch_once(token, ^{
                block(operation, value);
            });
        }
    };

    return [self promiseQueue:queue
                        block:operationOnceBlock
                    withDelay:delay
                 withPriority:priority];
}

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block {
    return [self queueOnce:queue
                     token:token
                     block:block
                 withDelay:0];
}

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self queueOnce:queue
                     token:token
                     block:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}


+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueueOnce:queue
                                              token:token
                                              block:block
                                          withDelay:delay
                                       withPriority:priority];

    return [manager perform];
}

@end

@implementation NHAsyncManager (ChainQueuedNonReturn)

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block {
    return [self promiseQueue:queue
                        block:block
                    withDelay:0];
}

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseQueue:queue
                        block:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NHAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority {
    return [[[self class] alloc] initWithQueue:queue
                                     withDelay:delay
                                      priority:priority
                             previousOperation:self.operation
                                      andBlock:block];
}

- (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block {
    return [self queue:queue
                 block:block
             withDelay:0];
}

- (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self queue:queue
                 block:block
             withDelay:delay
          withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)queue:(NSOperationQueue*)queue
                block:(NHAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueue:queue
                                          block:block
                                      withDelay:delay
                                   withPriority:priority];

    return [manager perform];
}

@end

@implementation NHAsyncManager (ChainQueuedOnceNonReturn)

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block {
    return [self promiseQueueOnce:queue
                            token:token
                            block:block
                        withDelay:0];
}

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseQueueOnce:queue
                            token:token
                            block:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                           block:(NHAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {
    NHAsyncBlock operationOnceBlock = ^(NHAsyncOperation *operation,
                                       id value) {
        if (block) {
            dispatch_once(token, ^{
                block(operation, value);
            });
        }
    };

    return [self promiseQueue:queue
                        block:operationOnceBlock
                    withDelay:delay
                 withPriority:priority];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block {
    return [self queueOnce:queue
                     token:token
                     block:block
                 withDelay:0];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self queueOnce:queue
                     token:token
                     block:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
                    block:(NHAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueueOnce:queue
                                               token:token
                                          block:block
                                      withDelay:delay
                                   withPriority:priority];

    return [manager perform];
}
@end

#pragma mark - Queue return value

@implementation NHAsyncManager (StartQueuedReturn)

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block {
    return [self promiseQueue:queue
                  returnBlock:block
                    withDelay:0];
}

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseQueue:queue
                  returnBlock:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority {
    return [[self alloc] initWithQueue:queue
                             withDelay:delay
                              priority:priority
                     previousOperation:nil
                        andReturnBlock:block];
}

+ (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block {
    return [self queue:queue
           returnBlock:block
             withDelay:0];
}

+ (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self queue:queue
           returnBlock:block
             withDelay:0
          withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueue:queue
                                    returnBlock:block
                                      withDelay:delay
                                   withPriority:priority];

    return [manager perform];
}

@end

@implementation NHAsyncManager (StartQueuedOnceReturn)

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block {
    return [self promiseQueueOnce:queue
                            token:token
                      returnBlock:block
                        withDelay:0];
}

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseQueueOnce:queue
                            token:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {

    NHAsyncReturnBlock operationOnceBlock = ^id(NHAsyncOperation *operation,
                                               id value) {
        __block id returnValue = nil;

        if (block) {
            dispatch_once(token, ^{
                returnValue = block(operation, value);
            });
        }

        return returnValue;
    };

    return [self promiseQueue:queue
                  returnBlock:operationOnceBlock
                    withDelay:delay
                 withPriority:priority];
}

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block {
    return [self queueOnce:queue
                     token:token
               returnBlock:block
                 withDelay:0];
}

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self queueOnce:queue
                     token:token
               returnBlock:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueueOnce:queue
                                              token:token
                                        returnBlock:block
                                          withDelay:delay
                                       withPriority:priority];

    return [manager perform];
}

@end

@implementation NHAsyncManager (ChainQueuedReturn)

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block {
    return [self promiseQueue:queue
                  returnBlock:block
                    withDelay:0];
}

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseQueue:queue
                  returnBlock:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NHAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority {
    return [[[self class] alloc] initWithQueue:queue
                                     withDelay:delay
                                      priority:priority
                             previousOperation:self.operation
                                andReturnBlock:block];
}

- (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block {
    return [self queue:queue
           returnBlock:block
             withDelay:0];
}

- (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self queue:queue
           returnBlock:block
             withDelay:delay
          withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NHAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueue:queue
                                    returnBlock:block
                                      withDelay:delay
                                   withPriority:priority];

    return [manager perform];
}
@end

@implementation NHAsyncManager (ChainQueuedOnceReturn)

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block {
    return [self promiseQueueOnce:queue
                            token:token
                      returnBlock:block
                        withDelay:0];
}

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseQueueOnce:queue
                            token:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NHAsyncOnceToken*)token
                     returnBlock:(NHAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {

    NHAsyncReturnBlock operationOnceBlock = ^id(NHAsyncOperation *operation,
                                               id value) {
        __block id returnValue = nil;

        if (block) {
            dispatch_once(token, ^{
                returnValue = block(operation, value);
            });
        }

        return returnValue;
    };

    return [self promiseQueue:queue
                  returnBlock:operationOnceBlock
                    withDelay:delay
                 withPriority:priority];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block {
    return [self queueOnce:queue
                     token:token
               returnBlock:block
                 withDelay:0];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self queueOnce:queue
                     token:token
               returnBlock:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NHAsyncOnceToken*)token
              returnBlock:(NHAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    NHAsyncManager *manager = [self promiseQueueOnce:queue
                                              token:token
                                        returnBlock:block
                                          withDelay:delay
                                       withPriority:priority];

    return [manager perform];
}

@end

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