//
//  NHAsyncOperation.m
//  Pods
//
//  Created by Naithar on 18.04.15.
//
//

#import "NHAsyncOperation.h"

#ifndef __NHASYNC_NO_FRAMEWORK
#import <NAsync/NAsync-Swift.h>
#else
#import "NAsync-Swift.h"
#endif

@interface NHAsyncBaseOperation ()
@property (nonatomic, assign) BOOL operationReady;
@property (nonatomic, assign) BOOL operationExecuting;
@property (nonatomic, assign) BOOL operationFinished;
@property (nonatomic, assign) BOOL operationCancelled;

@property (nonatomic, assign) BOOL inQueue;
@end

@implementation NHAsyncBaseOperation

- (instancetype)init {
    return [self initWithPriority:NSOperationQueuePriorityNormal];
}
- (instancetype)initWithPriority:(NSOperationQueuePriority)priority {
    self = [super init];

    if (self) {
        _operationReady = YES;
        _operationExecuting = YES;
        _operationFinished = YES;
        _operationCancelled = NO;
        _inQueue = NO;

        self.queuePriority = priority;

        if ([self respondsToSelector:@selector(setName:)]) {
            self.name = @"NAsync.BaseOperation";
        }
    }

    return self;
}

- (BOOL)isReady {
    return [super isReady]
    && self.operationReady;
}

- (BOOL)isExecuting {
    return [super isExecuting]
    && self.operationExecuting;
}

- (BOOL)isFinished {
    return [super isFinished]
    && self.operationFinished;
}

- (BOOL)isCancelled {
    return [super isCancelled]
    && self.operationCancelled;
}

- (void)cancel {
    self.operationCancelled = YES;
    [super cancel];
}

- (void)setOperationReady:(BOOL)operationReady {
    [self willChangeValueForKey:@"isReady"];
    _operationReady = operationReady;
    [self didChangeValueForKey:@"isReady"];
}

- (void)setOperationExecuting:(BOOL)operationExecuting {
    [self willChangeValueForKey:@"isExecuting"];
    _operationExecuting = operationExecuting;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setOperationFinished:(BOOL)operationFinished {
    [self willChangeValueForKey:@"isFinished"];
    _operationFinished = operationFinished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setOperationCancelled:(BOOL)operationCancelled {
    [self willChangeValueForKey:@"isCancelled"];
    _operationCancelled = operationCancelled;
    [self didChangeValueForKey:@"isCancelled"];
}
@end


@interface NHAsyncDelayOperation ()
@property (nonatomic, assign) NSTimeInterval delay;

@end

@implementation NHAsyncDelayOperation

+ (NSOperationQueue*)delayQueue {
    static NSOperationQueue* delayQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        delayQueue = [[NSOperationQueue alloc] init];
        delayQueue.name = @"NAsync.DelayQueue";
        delayQueue.maxConcurrentOperationCount = 10;
    });

    return delayQueue;
}

- (instancetype)init {
    return [self initWithDelay:0];
}

- (instancetype)initWithDelay:(NSTimeInterval)delay {
    return [self initWithDelay:delay
                   andPriority:NSOperationQueuePriorityNormal];
}

- (instancetype)initWithDelay:(NSTimeInterval)delay
                  andPriority:(NSOperationQueuePriority)priority {
    self = [super initWithPriority:priority];

    if (self) {
        _delay = delay;

                if ([self respondsToSelector:@selector(setName:)]) {
        self.name = [NSString
                     stringWithFormat:@"NAsync.DelayOperation.%@",
                     @(_delay)];
                }
    }

    return self;
}


+ (instancetype)withDelay:(NSTimeInterval)delay {
    return [self withDelay:delay
               andPriority:NSOperationQueuePriorityNormal];
}

+ (instancetype)withDelay:(NSTimeInterval)delay
              andPriority:(NSOperationQueuePriority)priority {
    return [[self alloc] initWithDelay:delay
                           andPriority:priority];
}


- (void)main {
    if (self.delay > 0) {
//        self.operationExecuting = YES;
        self.operationFinished = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, self.delay * NSEC_PER_SEC),
                       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            self.operationExecuting = YES;
            self.operationFinished = YES;
        });
    }
}

- (void)perform {
    if (self.inQueue) {
        return;
    }

    self.inQueue = YES;
    [[[self class] delayQueue] addOperation:self];

}

- (void)dealloc {
}

@end


@interface NHAsyncOperation ()

@property (nonatomic, strong) NHAsyncDelayOperation* delayOperation;
@property (nonatomic, strong) NHAsyncOperation* parentOperation;
@property (nonatomic, copy) NHAsyncReturnBlock operationBlock;

@property (nonatomic, copy) id returnValue;
@property (nonatomic, copy) id inputValue;
@end

@implementation NHAsyncOperation

- (instancetype)initWithDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NHAsyncOperation*)operation
                     andBlock:(NHAsyncBlock)block {
    return [self initWithDelay:delay
                      priority:priority
             previousOperation:operation
                andReturnBlock:^id(NHAsyncOperation *operation, id value) {
                    if (block) {
                        block(operation, value);
                    }
                    return nil;
                }];
}

- (instancetype)initWithDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NHAsyncOperation*)operation
               andReturnBlock:(NHAsyncReturnBlock)block {
    self = [super initWithPriority:priority];

    if (self) {
        _operationBlock = block;

        if (delay > 0) {
            NHAsyncDelayOperation *delayOperation = [NHAsyncDelayOperation withDelay:delay
                                                                       andPriority:priority];

            [self addDependency:delayOperation];

            _delayOperation = delayOperation;
        }

        if (operation != nil) {
            [_delayOperation addDependency:operation];
            [self addDependency:operation];
            _parentOperation = operation;
        }

                if ([self respondsToSelector:@selector(setName:)]) {
        self.name = @"NAsync.Operation";
                }
    }

    return self;
}

- (void)main {
    if (!self.inputValue) {
        self.inputValue = self.parentOperation.returnValue;
        [self prepareSwiftInputValues];
    }
    [self removeDependency:self.delayOperation];
    self.delayOperation = nil;

    [self removeDependency:self.parentOperation];
    self.parentOperation = nil;

    __weak typeof(self) weakSelf = self;
    if (self.operationBlock) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.returnValue = strongSelf.operationBlock(strongSelf, strongSelf.inputValue);
    }
    else {
        self.returnValue = nil;
    }

    [self prepareSwiftReturnValues];
}

-(void)waitUntilFinished {
    [super waitUntilFinished];
}

- (id)wait {
    [self waitUntilFinished];
    return self.returnValue;
}

- (void)performInQueue:(NSOperationQueue*)queue {
    [self performInQueue:queue
               withValue:nil];
}

- (void)performInQueue:(NSOperationQueue *)queue
             withValue:(id)inputValue {
    if (self.inQueue) {
        return;
    }

    self.inQueue = YES;
    self.inputValue = inputValue;
    [self.delayOperation perform];
    [queue addOperation:self];
}

- (void)cancelWithPrevious:(BOOL)cancePrevious {
    [self.delayOperation cancel];
    [self cancel];

    if (cancePrevious) {
        [self.parentOperation cancelWithPrevious:cancePrevious];
    }
}

- (void)dealloc {
    self.operationBlock = nil;
    self.parentOperation = nil;
    self.delayOperation = nil;
}

@end