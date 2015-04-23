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
    [self.operation performOnQueue:self.queue
                         withValue:value];
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

#pragma mark - Queue non return

@implementation NAsyncManager (StartQueuedNonReturn)

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NAsyncBlock)block {
    return [self promiseQueue:queue
                        block:block
                    withDelay:0];
}

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NAsyncBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseQueue:queue
                        block:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
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
    return [self queue:queue
                 block:block
             withDelay:0];
}

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self queue:queue
                 block:block
             withDelay:delay
          withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)queue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    NAsyncManager *manager = [self promiseQueue:queue
                                          block:block
                                      withDelay:delay
                                   withPriority:priority];
    return [manager perform];
}

@end

@implementation NAsyncManager (StartQueuedOnceNonReturn)

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block {
    return [self promiseQueueOnce:queue
                            token:token
                            block:block
                        withDelay:0];
}

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseQueueOnce:queue
                            token:token
                            block:block
                        withDelay:0
                     withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {

    NAsyncBlock operationOnceBlock = ^(NAsyncOperation *operation,
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
                    token:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block {
    return [self queueOnce:queue
                     token:token
                     block:block
                 withDelay:0];
}

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self queueOnce:queue
                     token:token
                     block:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}


+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    NAsyncManager *manager = [self promiseQueueOnce:queue
                                              token:token
                                              block:block
                                          withDelay:delay
                                       withPriority:priority];

    return [manager perform];
}

@end

@implementation NAsyncManager (ChainQueuedNonReturn)

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NAsyncBlock)block {
    return [self promiseQueue:queue
                        block:block
                    withDelay:0];
}

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NAsyncBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseQueue:queue
                        block:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                       block:(NAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority {
    return [[[self class] alloc] initWithQueue:queue
                                     withDelay:delay
                                      priority:priority
                             previousOperation:self.operation
                                      andBlock:block];
}

- (instancetype)queue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block {
    return [self queue:queue
                 block:block
             withDelay:0];
}

- (instancetype)queue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self queue:queue
                 block:block
             withDelay:delay
          withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)queue:(NSOperationQueue*)queue
                block:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    NAsyncManager *manager = [self promiseQueue:queue
                                          block:block
                                      withDelay:delay
                                   withPriority:priority];

    return [manager perform];
}

@end

@implementation NAsyncManager (ChainQueuedOnceNonReturn)

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block {
    return [self promiseQueueOnce:queue
                            token:token
                            block:block
                        withDelay:0];
}

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseQueueOnce:queue
                            token:token
                            block:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {
    NAsyncBlock operationOnceBlock = ^(NAsyncOperation *operation,
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
                    token:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block {
    return [self queueOnce:queue
                     token:token
                     block:block
                 withDelay:0];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self queueOnce:queue
                     token:token
                     block:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    NAsyncManager *manager = [self promiseQueue:queue
                                          block:block
                                      withDelay:delay
                                   withPriority:priority];

    return [manager perform];
}
@end

#pragma mark - Queue return value

@implementation NAsyncManager (StartQueuedReturn)

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NAsyncReturnBlock)block {
    return [self promiseQueue:queue
                  returnBlock:block
                    withDelay:0];
}

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseQueue:queue
                  returnBlock:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority {
    return [[self alloc] initWithQueue:queue
                             withDelay:delay
                              priority:priority
                     previousOperation:nil
                        andReturnBlock:block];
}

+ (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NAsyncReturnBlock)block {
    return [self queue:queue
           returnBlock:block
             withDelay:0];
}

+ (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self queue:queue
           returnBlock:block
             withDelay:0
          withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    NAsyncManager *manager = [self promiseQueue:queue
                                    returnBlock:block
                                      withDelay:delay
                                   withPriority:priority];

    return [manager perform];
}

@end

@implementation NAsyncManager (StartQueuedOnceReturn)

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block {
    return [self promiseQueueOnce:queue
                            token:token
                      returnBlock:block
                        withDelay:0];
}

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseQueueOnce:queue
                            token:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {

    NAsyncReturnBlock operationOnceBlock = ^id(NAsyncOperation *operation,
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
                    token:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block {
    return [self queueOnce:queue
                     token:token
               returnBlock:block
                 withDelay:0];
}

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self queueOnce:queue
                     token:token
               returnBlock:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    NAsyncManager *manager = [self promiseQueueOnce:queue
                                              token:token
                                        returnBlock:block
                                          withDelay:delay
                                       withPriority:priority];

    return [manager perform];
}

@end

@implementation NAsyncManager (ChainQueuedReturn)

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NAsyncReturnBlock)block {
    return [self promiseQueue:queue
                  returnBlock:block
                    withDelay:0];
}

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseQueue:queue
                  returnBlock:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)promiseQueue:(NSOperationQueue*)queue
                 returnBlock:(NAsyncReturnBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority {
    return [[[self class] alloc] initWithQueue:queue
                                     withDelay:delay
                                      priority:priority
                             previousOperation:self.operation
                                andReturnBlock:block];
}

- (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NAsyncReturnBlock)block {
    return [self queue:queue
           returnBlock:block
             withDelay:0];
}

- (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self queue:queue
           returnBlock:block
             withDelay:delay
          withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)queue:(NSOperationQueue*)queue
          returnBlock:(NAsyncReturnBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    NAsyncManager *manager = [self promiseQueue:queue
                                    returnBlock:block
                                      withDelay:delay
                                   withPriority:priority];

    return [manager perform];
}
@end

@implementation NAsyncManager (ChainQueuedOnceReturn)

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block {
    return [self promiseQueueOnce:queue
                            token:token
                      returnBlock:block
                        withDelay:0];
}

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseQueueOnce:queue
                            token:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)promiseQueueOnce:(NSOperationQueue*)queue
                           token:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {

    NAsyncReturnBlock operationOnceBlock = ^id(NAsyncOperation *operation,
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
                    token:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block {
    return [self queueOnce:queue
                     token:token
               returnBlock:block
                 withDelay:0];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self queueOnce:queue
                     token:token
               returnBlock:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)queueOnce:(NSOperationQueue*)queue
                    token:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    NAsyncManager *manager = [self promiseQueueOnce:queue
                                              token:token
                                        returnBlock:block
                                          withDelay:delay
                                       withPriority:priority];

    return [manager perform];
}

@end

#pragma mark - Main non return

@implementation NAsyncManager (StartMainNonReturn)

+ (instancetype)promiseMain:(NAsyncBlock)block {
    return [self promiseMain:block
                   withDelay:0];
}
+ (instancetype)promiseMain:(NAsyncBlock)block
                  withDelay:(NSTimeInterval)delay {
    return [self promiseMain:block
                   withDelay:delay
                withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)promiseMain:(NAsyncBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueue:[NSOperationQueue mainQueue]
                        block:block
                    withDelay:delay
                 withPriority:priority];
}

+ (instancetype)main:(NAsyncBlock)block {
    return [self main:block
            withDelay:0];
}
+ (instancetype)main:(NAsyncBlock)block
           withDelay:(NSTimeInterval)delay {
    return [self main:block
            withDelay:delay
         withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)main:(NAsyncBlock)block
           withDelay:(NSTimeInterval)delay
        withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[NSOperationQueue mainQueue]
                 block:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NAsyncManager (StartMainOnceNonReturn)

+ (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                          block:(NAsyncBlock)block {
    return [self promiseMainOnce:token
                           block:block
                       withDelay:0];
}
+ (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                          block:(NAsyncBlock)block
                      withDelay:(NSTimeInterval)delay {
    return [self promiseMainOnce:token
                           block:block
                       withDelay:delay
                    withPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                          block:(NAsyncBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[NSOperationQueue mainQueue]
                            token:token
                            block:block
                        withDelay:delay
                     withPriority:priority];
}

+ (instancetype)mainOnce:(NAsyncOnceToken*)token
                   block:(NAsyncBlock)block {
    return [self mainOnce:token
                    block:block
                withDelay:0];
}
+ (instancetype)mainOnce:(NAsyncOnceToken*)token
                   block:(NAsyncBlock)block
               withDelay:(NSTimeInterval)delay {
    return [self mainOnce:token
                    block:block
                withDelay:delay
             withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)mainOnce:(NAsyncOnceToken*)token
                   block:(NAsyncBlock)block
               withDelay:(NSTimeInterval)delay
            withPriority:(NSOperationQueuePriority)priority {
    return [self queueOnce:[NSOperationQueue mainQueue]
                     token:token
                     block:block
                 withDelay:delay
              withPriority:priority];
}

@end

@implementation NAsyncManager (ChainMainNonReturn)

- (instancetype)promiseMain:(NAsyncBlock)block {
    return [self promiseMain:block
                   withDelay:0];
}
- (instancetype)promiseMain:(NAsyncBlock)block
                  withDelay:(NSTimeInterval)delay {
    return [self promiseMain:block
                   withDelay:delay
                withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseMain:(NAsyncBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueue:[NSOperationQueue mainQueue]
                        block:block
                    withDelay:delay
                 withPriority:priority];
}

- (instancetype)main:(NAsyncBlock)block {
    return [self main:block
            withDelay:0];
}
- (instancetype)main:(NAsyncBlock)block
           withDelay:(NSTimeInterval)delay {
    return [self main:block
            withDelay:delay
         withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)main:(NAsyncBlock)block
           withDelay:(NSTimeInterval)delay
        withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[NSOperationQueue mainQueue]
                 block:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NAsyncManager (ChainMainOnceNonReturn)

- (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                          block:(NAsyncBlock)block {
    return [self promiseMainOnce:token
                           block:block
                       withDelay:0];
}
- (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                          block:(NAsyncBlock)block
                      withDelay:(NSTimeInterval)delay {
    return [self promiseMainOnce:token
                           block:block
                       withDelay:delay
                    withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                          block:(NAsyncBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[NSOperationQueue mainQueue]
                            token:token
                            block:block
                        withDelay:delay
                     withPriority:priority];
}

- (instancetype)mainOnce:(NAsyncOnceToken*)token
                   block:(NAsyncBlock)block {
    return [self mainOnce:token
                    block:block
                withDelay:0];
}
- (instancetype)mainOnce:(NAsyncOnceToken*)token
                   block:(NAsyncBlock)block
               withDelay:(NSTimeInterval)delay {
    return [self mainOnce:token
                    block:block
                withDelay:delay
             withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)mainOnce:(NAsyncOnceToken*)token
                   block:(NAsyncBlock)block
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

@implementation NAsyncManager (StartMainReturn)

+ (instancetype)promiseMainReturn:(NAsyncReturnBlock)block {
    return [self promiseMainReturn:block
                         withDelay:0];
}
+ (instancetype)promiseMainReturn:(NAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay {
    return [self promiseMainReturn:block
                         withDelay:delay
                      withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)promiseMainReturn:(NAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay
                     withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueue:[NSOperationQueue mainQueue]
                  returnBlock:block
                    withDelay:delay
                 withPriority:priority];
}

+ (instancetype)mainReturn:(NAsyncReturnBlock)block {
    return [self mainReturn:block
                  withDelay:0];
}
+ (instancetype)mainReturn:(NAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay {
    return [self mainReturn:block
                  withDelay:delay
               withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)mainReturn:(NAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay
              withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[NSOperationQueue mainQueue]
           returnBlock:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NAsyncManager (StartMainOnceReturn)

+ (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                          returnBlock:(NAsyncReturnBlock)block {
    return [self promiseMainOnce:token
                           returnBlock:block
                             withDelay:0];
}
+ (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                          returnBlock:(NAsyncReturnBlock)block
                            withDelay:(NSTimeInterval)delay {
    return [self promiseMainOnce:token
                           returnBlock:block
                             withDelay:delay
                          withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                          returnBlock:(NAsyncReturnBlock)block
                            withDelay:(NSTimeInterval)delay
                         withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[NSOperationQueue mainQueue]
                            token:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:priority];
}

+ (instancetype)mainOnce:(NAsyncOnceToken*)token
                   returnBlock:(NAsyncReturnBlock)block {
    return [self mainOnce:token
                    returnBlock:block
                      withDelay:0];
}
+ (instancetype)mainOnce:(NAsyncOnceToken*)token
                   returnBlock:(NAsyncReturnBlock)block
                     withDelay:(NSTimeInterval)delay {
    return [self mainOnce:token
                    returnBlock:block
                      withDelay:delay
                   withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)mainOnce:(NAsyncOnceToken*)token
                   returnBlock:(NAsyncReturnBlock)block
                     withDelay:(NSTimeInterval)delay
                  withPriority:(NSOperationQueuePriority)priority {
    return [self queueOnce:[NSOperationQueue mainQueue]
                     token:token
               returnBlock:block
                 withDelay:delay
              withPriority:priority];
}

@end

@implementation NAsyncManager (ChainMainReturn)

- (instancetype)promiseMainReturn:(NAsyncReturnBlock)block {
    return [self promiseMainReturn:block
                         withDelay:0];
}
- (instancetype)promiseMainReturn:(NAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay {
    return [self promiseMainReturn:block
                         withDelay:delay
                      withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseMainReturn:(NAsyncReturnBlock)block
                        withDelay:(NSTimeInterval)delay
                     withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueue:[NSOperationQueue mainQueue]
                  returnBlock:block
                    withDelay:delay
                 withPriority:priority];
}

- (instancetype)mainReturn:(NAsyncReturnBlock)block {
    return [self mainReturn:block
                  withDelay:0];
}
- (instancetype)mainReturn:(NAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay {
    return [self mainReturn:block
                  withDelay:delay
               withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)mainReturn:(NAsyncReturnBlock)block
                 withDelay:(NSTimeInterval)delay
              withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[NSOperationQueue mainQueue]
           returnBlock:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NAsyncManager (ChainMainOnceReturn)

- (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                    returnBlock:(NAsyncReturnBlock)block {
    return [self promiseMainOnce:token
                     returnBlock:block
                       withDelay:0];
}
- (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                    returnBlock:(NAsyncReturnBlock)block
                      withDelay:(NSTimeInterval)delay {
    return [self promiseMainOnce:token
                     returnBlock:block
                       withDelay:delay
                    withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseMainOnce:(NAsyncOnceToken*)token
                    returnBlock:(NAsyncReturnBlock)block
                      withDelay:(NSTimeInterval)delay
                   withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[NSOperationQueue mainQueue]
                            token:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:priority];
}

- (instancetype)mainOnce:(NAsyncOnceToken*)token
             returnBlock:(NAsyncReturnBlock)block {
    return [self mainOnce:token
              returnBlock:block
                withDelay:0];
}
- (instancetype)mainOnce:(NAsyncOnceToken*)token
             returnBlock:(NAsyncReturnBlock)block
               withDelay:(NSTimeInterval)delay {
    return [self mainOnce:token
              returnBlock:block
                withDelay:delay
             withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)mainOnce:(NAsyncOnceToken*)token
             returnBlock:(NAsyncReturnBlock)block
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

@implementation NAsyncManager (StartAsyncNonReturn)

+ (instancetype)promiseAsync:(NAsyncBlock)block {
    return [self promiseAsync:block
                    withDelay:0];
}
+ (instancetype)promiseAsync:(NAsyncBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseAsync:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)promiseAsync:(NAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueue:[[NSOperationQueue alloc] init]
                        block:block
                    withDelay:delay
                 withPriority:priority];
}

+ (instancetype)async:(NAsyncBlock)block {
    return [self async:block
             withDelay:0];
}
+ (instancetype)async:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self async:block
             withDelay:delay
          withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)async:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[[NSOperationQueue alloc] init]
                 block:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NAsyncManager (StartAsyncOnceNonReturn)

+ (instancetype)promiseAsyncOnce:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block {
    return [self promiseAsyncOnce:token
                            block:block
                        withDelay:0];
}
+ (instancetype)promiseAsyncOnce:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseAsyncOnce:token
                            block:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)promiseAsyncOnce:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[[NSOperationQueue alloc] init]
                     token:token
                     block:block
                 withDelay:delay
              withPriority:priority];
}

+ (instancetype)asyncOnce:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block {
    return [self asyncOnce:token
                     block:block
                 withDelay:0];
}
+ (instancetype)asyncOnce:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self asyncOnce:token
                     block:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)asyncOnce:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    return [self queueOnce:[[NSOperationQueue alloc] init]
                     token:token
                     block:block
                 withDelay:delay
              withPriority:priority];
}

@end

@implementation NAsyncManager (ChainAsyncNonReturn)

- (instancetype)promiseAsync:(NAsyncBlock)block {
    return [self promiseAsync:block
                    withDelay:0];
}
- (instancetype)promiseAsync:(NAsyncBlock)block
                   withDelay:(NSTimeInterval)delay {
    return [self promiseAsync:block
                    withDelay:delay
                 withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseAsync:(NAsyncBlock)block
                   withDelay:(NSTimeInterval)delay
                withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[[NSOperationQueue alloc] init]
                 block:block
             withDelay:delay
          withPriority:priority];
}

- (instancetype)async:(NAsyncBlock)block {
    return [self async:block
             withDelay:0];
}
- (instancetype)async:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay {
    return [self async:block
             withDelay:delay
          withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)async:(NAsyncBlock)block
            withDelay:(NSTimeInterval)delay
         withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[[NSOperationQueue alloc] init]
                 block:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NAsyncManager (ChainAsyncOnceNonReturn)

- (instancetype)promiseAsyncOnce:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block {
    return [self promiseAsyncOnce:token
                            block:block
                        withDelay:0];
}
- (instancetype)promiseAsyncOnce:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseAsyncOnce:token
                            block:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseAsyncOnce:(NAsyncOnceToken*)token
                           block:(NAsyncBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[[NSOperationQueue alloc] init]
                            token:token
                            block:block
                        withDelay:delay
                     withPriority:priority];
}

- (instancetype)asyncOnce:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block {
    return [self asyncOnce:token
                     block:block
                 withDelay:0];
}
- (instancetype)asyncOnce:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self asyncOnce:token
                     block:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)asyncOnce:(NAsyncOnceToken*)token
                    block:(NAsyncBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    return [self queueOnce:[[NSOperationQueue alloc] init]
                     token:token
                     block:block
                 withDelay:delay
              withPriority:priority];
}

@end

#pragma mark - Async return value

@implementation NAsyncManager (StartAsyncReturn)

+ (instancetype)promiseAsyncReturn:(NAsyncReturnBlock)block {
    return [self promiseAsyncReturn:block
                          withDelay:0];
}
+ (instancetype)promiseAsyncReturn:(NAsyncReturnBlock)block
                         withDelay:(NSTimeInterval)delay {
    return [self promiseAsyncReturn:block
                          withDelay:delay
                       withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)promiseAsyncReturn:(NAsyncReturnBlock)block
                         withDelay:(NSTimeInterval)delay
                      withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueue:[[NSOperationQueue alloc] init]
                  returnBlock:block
                    withDelay:delay
                 withPriority:priority];
}

+ (instancetype)asyncReturn:(NAsyncReturnBlock)block {
    return [self asyncReturn:block
                   withDelay:0];
}
+ (instancetype)asyncReturn:(NAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay {
    return [self asyncReturn:block
                   withDelay:delay
                withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)asyncReturn:(NAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[[NSOperationQueue alloc] init]
           returnBlock:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NAsyncManager (StartAsyncOnceReturn)

+ (instancetype)promiseAsyncOnce:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block {
    return [self promiseAsyncOnce:token
                      returnBlock:block
                        withDelay:0];
}
+ (instancetype)promiseAsyncOnce:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseAsyncOnce:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)promiseAsyncOnce:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[[NSOperationQueue alloc] init]
                            token:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:priority];
}

+ (instancetype)asyncOnce:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block {
    return [self asyncOnce:token
               returnBlock:block
                 withDelay:0];
}
+ (instancetype)asyncOnce:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self asyncOnce:token
               returnBlock:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}
+ (instancetype)asyncOnce:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    return [self queueOnce:[[NSOperationQueue alloc] init]
                     token:token
               returnBlock:block
                 withDelay:delay
              withPriority:priority];
}

@end

@implementation NAsyncManager (ChainAsyncReturn)

- (instancetype)promiseAsyncReturn:(NAsyncReturnBlock)block {
    return [self promiseAsyncReturn:block
                          withDelay:0];
}
- (instancetype)promiseAsyncReturn:(NAsyncReturnBlock)block
                         withDelay:(NSTimeInterval)delay {
    return [self promiseAsyncReturn:block
                          withDelay:delay
                       withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseAsyncReturn:(NAsyncReturnBlock)block
                         withDelay:(NSTimeInterval)delay
                      withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueue:[[NSOperationQueue alloc] init]
                  returnBlock:block
                    withDelay:delay
                 withPriority:priority];
}

- (instancetype)asyncReturn:(NAsyncReturnBlock)block {
    return [self asyncReturn:block
                   withDelay:0];
}
- (instancetype)asyncReturn:(NAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay {
    return [self asyncReturn:block
                   withDelay:delay
                withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)asyncReturn:(NAsyncReturnBlock)block
                  withDelay:(NSTimeInterval)delay
               withPriority:(NSOperationQueuePriority)priority {
    return [self queue:[[NSOperationQueue alloc] init]
           returnBlock:block
             withDelay:delay
          withPriority:priority];
}

@end

@implementation NAsyncManager (ChainAsyncOnceReturn)

- (instancetype)promiseAsyncOnce:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block {
    return [self promiseAsyncOnce:token
                      returnBlock:block
                        withDelay:0];
}
- (instancetype)promiseAsyncOnce:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay {
    return [self promiseAsyncOnce:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)promiseAsyncOnce:(NAsyncOnceToken*)token
                     returnBlock:(NAsyncReturnBlock)block
                       withDelay:(NSTimeInterval)delay
                    withPriority:(NSOperationQueuePriority)priority {
    return [self promiseQueueOnce:[[NSOperationQueue alloc] init]
                            token:token
                      returnBlock:block
                        withDelay:delay
                     withPriority:priority];
}

- (instancetype)asyncOnce:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block {
    return [self asyncOnce:token
               returnBlock:block
                 withDelay:0];
}
- (instancetype)asyncOnce:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay {
    return [self asyncOnce:token
               returnBlock:block
                 withDelay:delay
              withPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)asyncOnce:(NAsyncOnceToken*)token
              returnBlock:(NAsyncReturnBlock)block
                withDelay:(NSTimeInterval)delay
             withPriority:(NSOperationQueuePriority)priority {
    return [self queueOnce:[[NSOperationQueue alloc] init]
                     token:token
               returnBlock:block
                 withDelay:delay
              withPriority:priority];
}

@end