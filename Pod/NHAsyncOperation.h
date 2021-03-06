//
//  NHAsyncOperation.h
//  Pods
//
//  Created by Naithar on 18.04.15.
//
//

#import <Foundation/Foundation.h>

@class NHAsyncOperation;
typedef void(^NHAsyncBlock)(NHAsyncOperation *operation, id value);
typedef id(^NHAsyncReturnBlock)(NHAsyncOperation *operation, id value);

@interface NHAsyncBaseOperation: NSOperation

- (instancetype)init;
- (instancetype)initWithPriority:(NSOperationQueuePriority)priority;

@end

@interface NHAsyncDelayOperation: NHAsyncBaseOperation

- (instancetype)initWithDelay:(NSTimeInterval)delay;
- (instancetype)initWithDelay:(NSTimeInterval)delay
                  andPriority:(NSOperationQueuePriority)priority;

+ (instancetype)withDelay:(NSTimeInterval)delay;
+ (instancetype)withDelay:(NSTimeInterval)delay
              andPriority:(NSOperationQueuePriority)priority;

- (void)perform;
@end

@interface NHAsyncOperation: NHAsyncBaseOperation

@property (nonatomic, readonly, strong) NHAsyncOperation* parentOperation;
@property (nonatomic, readonly, strong) NHAsyncDelayOperation* delayOperation;
@property (nonatomic, readonly, copy) id returnValue;

- (instancetype)initWithDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NHAsyncOperation*)operation
               andReturnBlock:(NHAsyncReturnBlock)block;

- (instancetype)initWithDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NHAsyncOperation*)operation
                     andBlock:(NHAsyncBlock)block;

- (void)performInQueue:(NSOperationQueue*)queue;
- (void)performInQueue:(NSOperationQueue*)queue
             withValue:(id)inputValue;

- (id)wait;

- (void)cancelWithPrevious:(BOOL)cancePrevious;

@end