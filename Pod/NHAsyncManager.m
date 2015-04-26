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
}

@end