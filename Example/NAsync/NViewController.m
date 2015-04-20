//
//  NViewController.m
//  NAsync
//
//  Created by Naithar on 04/18/2015.
//  Copyright (c) 2014 Naithar. All rights reserved.
//

#import "NViewController.h"
@import NAsync;

@interface NViewController ()

@end

@implementation NViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    @autoreleasepool {
    NAsyncOperation *operation = [[NAsyncOperation alloc] initWithDelay:0
                                                               priority:NSOperationQueuePriorityNormal previousOperation:nil
                                                               andReturnBlock:^(NAsyncOperation *operation, id value) {
                                                                   NSLog(@"value = %@", value);
                                                                   for (int i = 0; i < 100; i++) {
                                                                       NSLog(@"%d", i);
                                                                   }

                                                                   return @90;
                                                               }];

    [operation performOnQueue:[[NSOperationQueue alloc] init] withValue:@101];

    NSLog(@"result = %@", [operation wait]);
    }


    @autoreleasepool {
    NAsyncManager *asyncManager = [[NAsyncManager alloc] initWithQueue:nil withDelay:0 priority:NSOperationQueuePriorityNormal previousOperation:nil andReturnBlock:^id(NAsyncOperation *operation, id value) {
        NSLog(@"value 2 = %@", value);
        return @10;
    }];


    NSLog(@"result 2 = %@", [[asyncManager performWithValue:@50] wait]);
    }

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
