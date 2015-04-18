//
//  NAsyncOperation.h
//  Pods
//
//  Created by Naithar on 18.04.15.
//
//

#import <Foundation/Foundation.h>


@class NAsyncOperation;

typedef void(^NAsyncBlock)(NAsyncOperation *operation, id value);
typedef id(^NAsyncReturnBlock)(NAsyncOperation *operation, id value);

@interface NAsyncBaseOperation : NSOperation

- (instancetype)init;
- (instancetype)initWithPriority:(NSOperationQueuePriority)priority;

@end

@interface NAsyncDelayOperation : NAsyncBaseOperation

- (instancetype)initWithDelay:(NSTimeInterval)delay;
+ (instancetype)withDelay:(NSTimeInterval)delay;
- (void)perform;

@end

@interface NAsyncOperation : NAsyncBaseOperation

@property (nonatomic, readonly, strong) NAsyncOperation* parentOperation;
@property (nonatomic, copy) id value;

- (instancetype)initWithDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NAsyncOperation*)operation
               andReturnBlock:(NAsyncReturnBlock)block;

- (instancetype)initWithDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NAsyncOperation*)operation
                     andBlock:(NAsyncBlock)block;

- (id)wait;
- (void)performOnQueue:(NSOperationQueue*)queue;
- (void)cancelWithPrevious:(BOOL)cancePrevious;

@end