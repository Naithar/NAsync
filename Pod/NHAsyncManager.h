//
//  NHAsyncManager.h
//  Pods
//
//  Created by Naithar on 18.04.15.
//
//

#import <Foundation/Foundation.h>
#import <NAsync/NHAsyncOperation.h>

@class NHAsyncManager;

typedef NHAsyncManager NAsync;

typedef dispatch_once_t NHAsyncOnceToken;

@interface NHAsyncManager : NSObject

@property (nonatomic, readonly, strong) NSOperationQueue *queue;
@property (nonatomic, readonly, strong) NHAsyncOperation *operation;

- (instancetype)initWithQueue:(NSOperationQueue*)queue withDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NHAsyncOperation*)operation
                     andBlock:(NHAsyncBlock)block;

- (instancetype)initWithQueue:(NSOperationQueue*)queue
                    withDelay:(NSTimeInterval)delay
                     priority:(NSOperationQueuePriority)priority
            previousOperation:(NHAsyncOperation*)operation
               andReturnBlock:(NHAsyncReturnBlock)block;

- (NSOperationQueue*)chainAsyncQueue;

- (instancetype)perform;
- (instancetype)performWithValue:(id)value;

- (id)wait;

- (instancetype)cancel;
- (instancetype)cancelAll:(BOOL)cancelPrevious;
@end




