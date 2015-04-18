//
//  NAsyncOperation.m
//  Pods
//
//  Created by Naithar on 18.04.15.
//
//

#import "NAsyncOperation.h"
#import <NAsync/NAsync-Swift.h>

@interface NAsyncBaseOperation ()
@property (nonatomic, assign) BOOL operationReady;
@property (nonatomic, assign) BOOL operationExecuting;
@property (nonatomic, assign) BOOL operationFinished;
@property (nonatomic, assign) BOOL operationCancelled;
@end

@implementation NAsyncBaseOperation

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

        self.queuePriority = priority;
        self.name = @"NAsync.BaseOperation";
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


@interface NAsyncDelayOperation ()
@property (nonatomic, assign) NSTimeInterval delay;

@end

@implementation NAsyncDelayOperation

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

        self.name = [NSString
                     stringWithFormat:@"NAsync.DelayOperation.%@",
                     @(_delay)];
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
        self.operationExecuting = NO;
        self.operationFinished = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, self.delay * NSEC_PER_SEC),
                       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.operationExecuting = YES;
            self.operationFinished = YES;
        });
    }
}

- (void)perform {
    [[[self class] delayQueue] addOperation:self];
}

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"NAsync: delay operation deallocated");
#endif
}

@end


@interface NAsyncOperation ()

@property (nonatomic, strong) NAsyncDelayOperation* delayOperation;
@property (nonatomic, strong) NAsyncOperation* parentOperation;
@property (nonatomic, copy) NAsyncReturnBlock operationBlock;

@property (nonatomic, copy) id returnValue;
@property (nonatomic, copy) id inputValue;
@end

@implementation NAsyncOperation

- (instancetype)initWithDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NAsyncOperation*)operation
                     andBlock:(NAsyncBlock)block {
    return [self initWithDelay:delay
                      priority:priority
             previousOperation:operation
                andReturnBlock:^id(NAsyncOperation *operation, id value) {
                    if (block) {
                        block(operation, value);
                    }
                    return nil;
                }];
}

- (instancetype)initWithDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NAsyncOperation*)operation
               andReturnBlock:(NAsyncReturnBlock)block {
    self = [super initWithPriority:priority];

    if (self) {
        _operationBlock = block;

        if (delay > 0) {
            NAsyncDelayOperation *delayOperation = [NAsyncDelayOperation withDelay:delay
                                                                       andPriority:priority];

            [self addDependency:delayOperation];

            _delayOperation = delayOperation;
        }

        if (operation != nil) {
            [_delayOperation addDependency:operation];
            [self addDependency:operation];
            _parentOperation = operation;
        }

        self.name = @"NAsync.Operation";
    }

    return self;
}

- (void)main {
    if (!self.inputValue) {
        self.inputValue = self.parentOperation.returnValue;
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
}

-(void)waitUntilFinished {
    [super waitUntilFinished];
}

- (id)wait {
    [self waitUntilFinished];
    return self.returnValue;
}

- (void)performOnQueue:(NSOperationQueue*)queue {
    [self performOnQueue:queue
               withValue:nil];
}

- (void)performOnQueue:(NSOperationQueue *)queue
             withValue:(id)inputValue {
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

#ifdef DEBUG
    NSLog(@"operation dealloc");
#endif
}

@end